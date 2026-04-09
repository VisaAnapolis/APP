unit uExportarJsonCVS_Shared;

interface

uses
  Windows, SysUtils, Classes, DB, DBTables;

function ExportarJsonCVS_Shared(const AliasOrPath, OutBaseDir: string; out Erro: string): Boolean;
// Gera somente regulados (index + reg\..json). Não gera his\..json (para reaproveitar o histórico já publicado).
function ExportarJsonCVS_SemHistorico(const AliasOrPath, OutBaseDir: string; out Erro: string): Boolean;

implementation

type
  TBytes = array of Byte;

  // Stats simples (não muda assinatura pública)
  TIncStats = record
    RegWrote: Integer;
    RegSkipped: Integer;
    HisWrote: Integer;
    HisSkipped: Integer;
    IndexWrote: Integer;
    IndexSkipped: Integer;
  end;

var
  GStats: TIncStats;

function EnsureSlash(const S: string): string;
begin
  Result := S;
  if (Result <> '') and (Result[Length(Result)] <> '\') then
    Result := Result + '\';
end;

function NowISO_Brasilia: string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss', Now) + '-03:00';
end;

function DateISO(const D: TDateTime): string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd', D);
end;

// -------- UTF-8 (Delphi 6) --------
function Utf8BytesFromWide(const WS: WideString): TBytes;
var
  Len: Integer;
begin
  SetLength(Result, 0);
  if WS = '' then Exit;
  Len := WideCharToMultiByte(CP_UTF8, 0, PWideChar(WS), Length(WS), nil, 0, nil, nil);
  if Len <= 0 then Exit;
  SetLength(Result, Len);
  WideCharToMultiByte(CP_UTF8, 0, PWideChar(WS), Length(WS), PAnsiChar(@Result[0]), Len, nil, nil);
end;

procedure SaveUtf8ToFile(const FileName: string; const Content: WideString);
var
  FS: TFileStream;
  B: TBytes;
begin
  ForceDirectories(ExtractFileDir(FileName));
  FS := TFileStream.Create(FileName, fmCreate);
  try
    B := Utf8BytesFromWide(Content);
    if Length(B) > 0 then
      FS.WriteBuffer(B[0], Length(B));
  finally
    FS.Free;
  end;
end;

// -------- CRC32 (rápido e determinístico) --------
function CRC32Buf(const Buf; Len: Integer): Cardinal;
const
  POLY = $EDB88320;
var
  i, j: Integer;
  c: Cardinal;
  p: PByte;
begin
  c := $FFFFFFFF;
  p := @Buf;
  for i := 0 to Len - 1 do
  begin
    c := c xor p^;
    for j := 0 to 7 do
      if (c and 1) <> 0 then
        c := (c shr 1) xor POLY
      else
        c := (c shr 1);
    Inc(p);
  end;
  Result := c xor $FFFFFFFF;
end;

function FileSizeInt64(const FileName: string): Int64;
var
  SR: TSearchRec;
begin
  Result := -1;
  if FindFirst(FileName, faAnyFile, SR) = 0 then
  begin
    Result := SR.Size;
    FindClose(SR);
  end;
end;

function ReadFileToBytes(const FileName: string; out B: TBytes): Boolean;
var
  FS: TFileStream;
begin
  Result := False;
  SetLength(B, 0);
  if not FileExists(FileName) then Exit;
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    if FS.Size > 0 then
    begin
      SetLength(B, FS.Size);
      FS.ReadBuffer(B[0], FS.Size);
    end;
    Result := True;
  finally
    FS.Free;
  end;
end;

// -------- INCREMENTAL: só grava se mudou --------
// Observação: compara CRC e tamanho; se igual -> não grava (economiza I/O e Git)
function SaveUtf8ToFileIfChanged(const FileName: string; const Content: WideString; out Wrote: Boolean): Boolean;
var
  NewB, OldB: TBytes;
  NewCRC, OldCRC: Cardinal;
  OldSize, NewSize: Int64;
begin
  Result := False;
  Wrote := False;

  NewB := Utf8BytesFromWide(Content);
  NewSize := Length(NewB);
  if NewSize = 0 then
  begin
    // arquivo vazio ainda é um conteúdo; compara com existente
    OldSize := FileSizeInt64(FileName);
    if (OldSize = 0) and FileExists(FileName) then
    begin
      Wrote := False;
      Result := True;
      Exit;
    end;
    // se não existe ou tamanho diferente, grava vazio
    ForceDirectories(ExtractFileDir(FileName));
    SaveUtf8ToFile(FileName, Content);
    Wrote := True;
    Result := True;
    Exit;
  end;

  // Se existe e tamanho bate, faz CRC do antigo para decidir
  if FileExists(FileName) then
  begin
    OldSize := FileSizeInt64(FileName);
    if OldSize = NewSize then
    begin
      NewCRC := CRC32Buf(NewB[0], NewSize);
      if ReadFileToBytes(FileName, OldB) then
      begin
        if Length(OldB) = NewSize then
        begin
          OldCRC := CRC32Buf(OldB[0], NewSize);
          if OldCRC = NewCRC then
          begin
            Wrote := False;
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;

  // mudou (ou não existe / tamanho difere / falhou leitura) -> grava
  ForceDirectories(ExtractFileDir(FileName));
  SaveUtf8ToFile(FileName, Content);
  Wrote := True;
  Result := True;
end;

procedure ResetStats;
begin
  FillChar(GStats, SizeOf(GStats), 0);
end;

// Grava um arquivo pequeno de stats (não interfere no DPR)
procedure SaveStatsFile(const BaseDir: string);
var
  FN: string;
  W: WideString;
  wrote: Boolean;
begin
  try
    FN := EnsureSlash(BaseDir) + 'json_incremental_stats.txt';
    W :=
      'gerado_em=' + WideString(NowISO_Brasilia) + #13#10 +
      'reg_wrote=' + WideString(IntToStr(GStats.RegWrote)) + #13#10 +
      'reg_skipped=' + WideString(IntToStr(GStats.RegSkipped)) + #13#10 +
      'his_wrote=' + WideString(IntToStr(GStats.HisWrote)) + #13#10 +
      'his_skipped=' + WideString(IntToStr(GStats.HisSkipped)) + #13#10 +
      'index_wrote=' + WideString(IntToStr(GStats.IndexWrote)) + #13#10 +
      'index_skipped=' + WideString(IntToStr(GStats.IndexSkipped)) + #13#10;
    SaveUtf8ToFileIfChanged(FN, W, wrote);
  except
    // stats é best-effort; nunca derruba exportação
  end;
end;

// -------- JSON helpers --------
function JsonEscape(const S: string): WideString;
var
  i: Integer;
  ch: Char;
begin
  Result := '';
  for i := 1 to Length(S) do
  begin
    ch := S[i];
    case ch of
      '"':  Result := Result + '\"';
      '\':  Result := Result + '\\';
      #8:   Result := Result + '\b';
      #9:   Result := Result + '\t';
      #10:  Result := Result + '\n';
      #12:  Result := Result + '\f';
      #13:  Result := Result + '\r';
    else
      Result := Result + WideString(ch);
    end;
  end;
end;

function JStr(const S: string): WideString;
begin
  Result := '"' + JsonEscape(S) + '"';
end;

function JNull: WideString;
begin
  Result := 'null';
end;

function IfThenW(const Cond: Boolean; const A, B: WideString): WideString;
begin
  if Cond then Result := A else Result := B;
end;

function NormalizeCodigo5(const CodigoInt: Integer): string;
begin
  Result := Format('%.5d', [CodigoInt]);
end;

function RegPrefix(const CodigoInt: Integer): string;
begin
  Result := Copy(NormalizeCodigo5(CodigoInt), 1, 2);  // 12345 -> '12'
end;

function HisBucket(const NDoc: Integer): string;
begin
  Result := Format('%.2d', [NDoc mod 100]); // 00..99
end;

function FieldExists(T: TTable; const N: string): Boolean;
begin
  Result := T.FindField(N) <> nil;
end;

// -------- Descobrir campo de vínculo --------
function PickFirstField(T: TTable; const Candidates: array of string): string;
var
  i: Integer;
begin
  Result := '';
  for i := Low(Candidates) to High(Candidates) do
    if FieldExists(T, Candidates[i]) then
    begin
      Result := Candidates[i];
      Exit;
    end;
end;

// -------- filtro robusto (tenta string e numérico) --------
procedure ApplyCodigoFilterSmart(T: TTable; const FieldName: string; const CodigoInt: Integer; const Codigo5: string);
  procedure TrySetFilter(const Expr: string);
  begin
    T.Filtered := False;
    T.Filter := Expr;
    T.Filtered := True;
    T.First; // força avaliação
  end;
var
  F: TField;
begin
  T.Filtered := False;
  T.Filter := '';

  if FieldName = '' then Exit;
  F := T.FieldByName(FieldName);

  // 1) tenta como string '00004'
  try
    TrySetFilter(FieldName + ' = ' + QuotedStr(Codigo5));
    Exit;
  except
  end;

  // 2) tenta como numérico 4
  try
    TrySetFilter(FieldName + ' = ' + IntToStr(CodigoInt));
    Exit;
  except
  end;

  // 3) fallback: decide pelo tipo
  T.Filtered := False;
  T.Filter := '';
  case F.DataType of
    ftString, ftWideString:
      T.Filter := FieldName + ' = ' + QuotedStr(Codigo5);
  else
    T.Filter := FieldName + ' = ' + IntToStr(CodigoInt);
  end;
  T.Filtered := True;
end;

// -------- load maps (bairros e cnae) --------
procedure LoadBairros(const AliasOrPath: string; MapCodigoToNome: TStringList);
var
  T: TTable;
  codigo, nome: string;
begin
  MapCodigoToNome.Clear;
  T := TTable.Create(nil);
  try
    T.DatabaseName := AliasOrPath;
    T.TableName := 'BAIRRO.DB';
    T.Open;
    try
      T.First;
      while not T.Eof do
      begin
        codigo := Trim(T.FieldByName('CODIGO').AsString);
        nome   := Trim(T.FieldByName('NOME').AsString);
        if (codigo <> '') and (MapCodigoToNome.IndexOfName(codigo) < 0) then
          MapCodigoToNome.Values[codigo] := nome;
        T.Next;
      end;
    finally
      T.Close;
    end;
  finally
    T.Free;
  end;
end;

procedure LoadCNAE(const AliasOrPath: string; MapSubToPacked: TStringList);
var
  T: TTable;
  sub, classe, ativ, equipe, comp: string;
begin
  MapSubToPacked.Clear;
  T := TTable.Create(nil);
  try
    T.DatabaseName := AliasOrPath;
    T.TableName := 'CNAE.DB';
    T.Open;
    try
      T.First;
      while not T.Eof do
      begin
        sub    := UpperCase(Trim(T.FieldByName('SUBCLASSE').AsString));
        classe := Trim(T.FieldByName('CLASSE').AsString);
        ativ   := Trim(T.FieldByName('ATIVIDADE').AsString);
        equipe := Trim(T.FieldByName('EQUIPE').AsString);
        comp   := Trim(T.FieldByName('COMPLEXIDADE').AsString);

        if (sub <> '') and (MapSubToPacked.IndexOfName(sub) < 0) then
          MapSubToPacked.Values[sub] := sub + '|' + classe + '|' + ativ + '|' + equipe + '|' + comp;

        T.Next;
      end;
    finally
      T.Close;
    end;
  finally
    T.Free;
  end;
end;

// -------- ALVARÁ: maior DT_VALIDADE, ignora CANCELA=true e DT_VALIDADE nulo; retorna dt_validade + exercicio --------
function UltimoAlvaraValidoJson(const AliasOrPath: string; const CodigoRegulado: Integer): WideString;
var
  T: TTable;
  bestVal: TDateTime;
  has: Boolean;
  exercicio: Integer;
  dtVal: TDateTime;

  function BoolTrue(const N: string): Boolean;
  begin
    Result := FieldExists(T, N) and (not T.FieldByName(N).IsNull) and T.FieldByName(N).AsBoolean;
  end;

begin
  Result := JNull;
  has := False;
  bestVal := 0;
  exercicio := 0;

  T := TTable.Create(nil);
  try
    T.DatabaseName := AliasOrPath;
    T.TableName := 'ALVARA.DB';

    try
      T.IndexName := 'PorCodigo';
    except
    end;

    T.Open;
    try
      if (T.IndexName = 'PorCodigo') and FieldExists(T, 'CODIGO') then
        T.SetRange([CodigoRegulado], [CodigoRegulado])
      else
        ApplyCodigoFilterSmart(T, PickFirstField(T, ['CODIGO','COD','CODCONTRIB','COD_CONTRIB']), CodigoRegulado, NormalizeCodigo5(CodigoRegulado));

      T.First;
      while not T.Eof do
      begin
        if BoolTrue('CANCELA') then
        begin
          T.Next;
          Continue;
        end;

        if (not FieldExists(T,'DT_VALIDADE')) or T.FieldByName('DT_VALIDADE').IsNull then
        begin
          T.Next;
          Continue;
        end;

        dtVal := T.FieldByName('DT_VALIDADE').AsDateTime;

        if (not has) or (dtVal > bestVal) then
        begin
          has := True;
          bestVal := dtVal;

          if FieldExists(T,'EXERCICIO') and (not T.FieldByName('EXERCICIO').IsNull) then
            exercicio := T.FieldByName('EXERCICIO').AsInteger
          else
            exercicio := 0;
        end;

        T.Next;
      end;

      if has then
      begin
        Result :=
          '{' +
            '"dt_validade":' + JStr(DateISO(bestVal)) + ',' +
            '"exercicio":' + IfThenW(exercicio<>0, WideString(IntToStr(exercicio)), JNull) +
          '}';
      end
      else
        Result := JNull;

    finally
      T.Close;
    end;
  finally
    T.Free;
  end;
end;

// -------- INSPEÇÕES: com fiscais --------
 procedure GetInspecoesJson(const AliasOrPath: string; const CodigoRegulado: Integer; out JsonArray: WideString);
type
  TIns = record
    dt: TDateTime;
    pz: Integer;     // dias
    ndoc: Integer;
    tipo: string;
    numer: string;   // NUMERO A(6)
    fiscal1: string;
    fiscal2: string;
    fiscal3: string;
  end;
var
  T: TTable;
  items: array of TIns;
  n: Integer;
  cod5: string;

  procedure AddItem(const ADt: TDateTime; const APz, ANDoc : Integer;
    const ATipo, ANumer, AFiscal1, AFiscal2, AFiscal3: string);
  begin
    Inc(n);
    SetLength(items, n);
    items[n-1].dt := ADt;
    items[n-1].ndoc := ANDoc;
    items[n-1].pz := APz;
    items[n-1].tipo := ATipo;
    items[n-1].numer := ANumer;
    items[n-1].fiscal1 := AFiscal1;
    items[n-1].fiscal2 := AFiscal2;
    items[n-1].fiscal3 := AFiscal3;
  end;

  procedure SortDescByDate;
  var
    i, j: Integer;
    tmp: TIns;
  begin
    for i := 0 to n-2 do
      for j := i+1 to n-1 do
        if items[j].dt > items[i].dt then
        begin
          tmp := items[i]; items[i] := items[j]; items[j] := tmp;
        end;
  end;

var
  i: Integer;
  dtv: TDateTime;
  pzDias: Integer;
  ndoc:integer;
  tipo: string;
  numerStr: string;
  fiscal1: string;
  fiscal2: string;
  fiscal3: string;
begin
  JsonArray := '[]';
  n := 0;

  cod5 := NormalizeCodigo5(CodigoRegulado);

  T := TTable.Create(nil);
  try
    T.DatabaseName := AliasOrPath;
    T.TableName := 'VISITAS.DB';

    try
      T.IndexName := 'PorCodigo';
    except
    end;

    T.Open;
    try
      if (T.IndexName = 'PorCodigo') and FieldExists(T, 'CODIGO') then
        T.SetRange([CodigoRegulado], [CodigoRegulado])
      else
        ApplyCodigoFilterSmart(T, PickFirstField(T, ['CODIGO', 'COD', 'CODCONTRIB', 'COD_CONTRIB']), CodigoRegulado, cod5);

      T.First;
      while not T.Eof do
      begin
        if FieldExists(T, 'DT_VISITA') and (not T.FieldByName('DT_VISITA').IsNull) then
          dtv := T.FieldByName('DT_VISITA').AsDateTime
        else
          dtv := 0;

        if FieldExists(T, 'PZ_RETORNO') and (not T.FieldByName('PZ_RETORNO').IsNull) then
          pzDias := T.FieldByName('PZ_RETORNO').AsInteger
        else
          pzDias := 0;

        if FieldExists(T, 'NDOC') and (not T.FieldByName('NDOC').IsNull) then
          ndoc := T.FieldByName('NDOC').AsInteger
        else
          ndoc := 0;

        if FieldExists(T, 'TIPO') then
          tipo := Trim(T.FieldByName('TIPO').AsString)
        else
          tipo := '';

        if FieldExists(T, 'NUMERO') then
          numerStr := Trim(T.FieldByName('NUMERO').AsString)
        else
          numerStr := '';

        if FieldExists(T, 'FISCAL1') then
          fiscal1 := Trim(T.FieldByName('FISCAL1').AsString)
        else
          fiscal1 := '';

        if FieldExists(T, 'FISCAL2') then
          fiscal2 := Trim(T.FieldByName('FISCAL2').AsString)
        else
          fiscal2 := '';

        if FieldExists(T, 'FISCAL3') then
          fiscal3 := Trim(T.FieldByName('FISCAL3').AsString)
        else
          fiscal3 := '';

        AddItem(dtv, pzDias, ndoc, tipo, numerStr, fiscal1, fiscal2, fiscal3);
        T.Next;
      end;
    finally
      T.Close;
    end;
  finally
    T.Free;
  end;

  if n = 0 then Exit;

  SortDescByDate;

  JsonArray := '[';
  for i := 0 to n-1 do
  begin
    if i > 0 then JsonArray := JsonArray + ',';
    JsonArray := JsonArray +
      '{' +
        '"ndoc":' + IntToStr(items[i].ndoc) + ',' +
        '"dt_visita":' + IfThenW(items[i].dt<>0, JStr(DateISO(items[i].dt)), JNull) + ',' +
        '"tipo":' + IfThenW(items[i].tipo<>'', JStr(items[i].tipo), JNull) + ',' +
        '"numer":' + IfThenW(items[i].numer<>'', JStr(items[i].numer), JNull) + ',' +
        '"Fiscal1":' + IfThenW(items[i].fiscal1<>'', JStr(items[i].fiscal1), JNull) + ',' +
        '"Fiscal2":' + IfThenW(items[i].fiscal2<>'', JStr(items[i].fiscal2), JNull) + ',' +
        '"Fiscal3":' + IfThenW(items[i].fiscal3<>'', JStr(items[i].fiscal3), JNull) + ',' +
        '"pz_retorno":' + IntToStr(items[i].pz) +
      '}';
  end;
  JsonArray := JsonArray + ']';
end;

// -------- ATIVIDADES: RT (Subclasse, Tipo) + CNAE (Atividade, Equipe, Complexidade) --------
procedure GetAtividadesJson(
  const AliasOrPath: string;
  const CodigoRegulado: Integer;
  const MapCnae: TStringList;
  out JsonArray: WideString
);
var
  T: TTable;
  first: Boolean;
  sub, tipo: string;
  cnaePacked: string;
  cnaeAtiv, cnaeEquipe, cnaeComp: string;

  function NormSub(const S: string): string;
  begin
    Result := UpperCase(Trim(S));
  end;

  procedure ParseCnaePacked(const P: string);
    function NextToken(var S: string): string;
    var
      p: Integer;
    begin
      S := Trim(S);
      p := Pos('|', S);
      if p = 0 then
      begin
        Result := S;
        S := '';
      end
      else
      begin
        Result := Copy(S, 1, p-1);
        Delete(S, 1, p);
      end;
      Result := Trim(Result);
    end;
  var
    s, t0, t1, t2, t3, t4: string;
  begin
    cnaeAtiv := '';
    cnaeEquipe := '';
    cnaeComp := '';

    s := Trim(P);
    if s = '' then Exit;

    // esperado: sub|classe|atividade|equipe|complexidade
    t0 := NextToken(s); // sub (ignora)
    t1 := NextToken(s); // classe (ignora)
    t2 := NextToken(s); // atividade
    t3 := NextToken(s); // equipe
    t4 := NextToken(s); // complexidade

    cnaeAtiv := t2;
    cnaeEquipe := t3;
    cnaeComp := t4;
  end;

begin
  JsonArray := '[]';

  T := TTable.Create(nil);
  try
    T.DatabaseName := AliasOrPath;
    T.TableName := 'RT.DB';
    T.IndexName := 'PorCodigo';
    T.Open;
    try
      T.SetRange([CodigoRegulado], [CodigoRegulado]);

      first := True;
      JsonArray := '[';

      T.First;
      while not T.Eof do
      begin
        sub := '';
        if FieldExists(T, 'Subclasse') then sub := NormSub(T.FieldByName('Subclasse').AsString);

        tipo := '';
        if FieldExists(T, 'Tipo') then tipo := Trim(T.FieldByName('Tipo').AsString);

        cnaePacked := '';
        if sub <> '' then
          cnaePacked := MapCnae.Values[sub];

        ParseCnaePacked(cnaePacked);

        if not first then JsonArray := JsonArray + ',';
        first := False;

        JsonArray := JsonArray +
          '{' +
            '"subclasse":' + IfThenW(sub<>'', JStr(sub), JNull) + ',' +
            '"tipo":' + IfThenW(tipo<>'', JStr(tipo), JNull) + ',' +
            '"atividade":' + IfThenW(cnaeAtiv<>'', JStr(cnaeAtiv), JNull) + ',' +
            '"equipe":' + IfThenW(cnaeEquipe<>'', JStr(cnaeEquipe), JNull) + ',' +
            '"complexidade":' + IfThenW(cnaeComp<>'', JStr(cnaeComp), JNull) +
          '}';

        T.Next;
      end;

      JsonArray := JsonArray + ']';
      if first then JsonArray := '[]';

    finally
      T.Close;
    end;
  finally
    T.Free;
  end;
end;

// -------- export: histórico 1:1 por NDOC --------
procedure ExportHistoricoPorNdoc(const AliasOrPath, BaseDir: string);
var
  T: TTable;
  ndoc: Integer;
  descr: string;
  bucket, outFile: string;
  W: WideString;
  wrote: Boolean;
begin
  T := TTable.Create(nil);
  try
    T.DatabaseName := AliasOrPath;
    T.TableName := 'HISTORICO.DB';
    T.Open;
    try
      T.First;
      while not T.Eof do
      begin
        ndoc := T.FieldByName('NDOC').AsInteger;

        if FieldExists(T, 'DECR') then
          descr := T.FieldByName('DECR').AsString
        else
          descr := T.FieldByName('DESCR').AsString;

        bucket := HisBucket(ndoc);
        outFile := BaseDir + 'his\' + bucket + '\' + IntToStr(ndoc) + '.json';

        W := '{' +
              '"ndoc":' + IntToStr(ndoc) + ',' +
              '"decr":' + JStr(descr) +
            '}';

        if not SaveUtf8ToFileIfChanged(outFile, W, wrote) then
          raise Exception.Create('Falha ao gravar: ' + outFile);

        if wrote then Inc(GStats.HisWrote) else Inc(GStats.HisSkipped);

        T.Next;
      end;
    finally
      T.Close;
    end;
  finally
    T.Free;
  end;
end;

// -------- export: índice + arquivo por regulado --------
procedure ExportReguladosPorArquivo(const AliasOrPath, BaseDir: string);
var
  Contrib: TTable;
  MapBairro: TStringList;
  MapCnae: TStringList;

  indexW: WideString;
  firstIndex: Boolean;

  codigo: Integer;
  prefix: string;
  outFile: string;

  razao, fantasia, cnpj, cpf, logradouro, complement, fone, celular: string;
  cdbai: Integer;
  bairroNome: string;

  atividadesJson: WideString;
  inspecoesJson: WideString;
  alvaraUlt: WideString;

  inativo: Boolean;
  doc: string;

  W: WideString;
  wrote: Boolean;
begin
  MapBairro := TStringList.Create;
  MapCnae := TStringList.Create;
  Contrib := TTable.Create(nil);
  try
    LoadBairros(AliasOrPath, MapBairro);
    LoadCNAE(AliasOrPath, MapCnae);

    indexW := '{' +
                '"meta":{"origem":"CVS","gerado_em":' + JStr(NowISO_Brasilia) + '},' +
                '"dados":[';
    firstIndex := True;

    Contrib.DatabaseName := AliasOrPath;
    Contrib.TableName := 'CONTRIB.DB';
    Contrib.Open;
    try
      Contrib.First;
      while not Contrib.Eof do
      begin
        inativo := (not Contrib.FieldByName('INATIVIDADE').IsNull) and Contrib.FieldByName('INATIVIDADE').AsBoolean;
        if inativo then
        begin
          Contrib.Next;
          Continue;
        end;

        codigo := Contrib.FieldByName('CODIGO').AsInteger;
        prefix := RegPrefix(codigo);

        razao := Trim(Contrib.FieldByName('RAZAO').AsString);
        fantasia := Trim(Contrib.FieldByName('FANTASIA').AsString);
        cnpj := Trim(Contrib.FieldByName('CGC').AsString);
        cpf  := Trim(Contrib.FieldByName('CPF').AsString);

        if cnpj <> '' then doc := cnpj
        else if cpf <> '' then doc := cpf
        else doc := '';

        logradouro := Trim(Contrib.FieldByName('LOGRADOURO').AsString);
        complement := Trim(Contrib.FieldByName('COMPLEMENT').AsString);

        fone := '';
        celular := '';

        if FieldExists(Contrib, 'FONE') then
          fone := Trim(Contrib.FieldByName('FONE').AsString);

        if FieldExists(Contrib, 'CELULAR') then
          celular := Trim(Contrib.FieldByName('CELULAR').AsString);

        if Contrib.FieldByName('CDBAI').IsNull then cdbai := 0 else cdbai := Contrib.FieldByName('CDBAI').AsInteger;
        bairroNome := MapBairro.Values[IntToStr(cdbai)];

        GetAtividadesJson(AliasOrPath, codigo, MapCnae, atividadesJson);
        GetInspecoesJson(AliasOrPath, codigo, inspecoesJson);
        alvaraUlt := UltimoAlvaraValidoJson(AliasOrPath, codigo);

        outFile := BaseDir + 'reg\' + prefix + '\' + NormalizeCodigo5(codigo) + '.json';

        W :=
          '{' +
            '"codigo":' + IntToStr(codigo) + ',' +
            '"razao":' + JStr(razao) + ',' +
            '"fantasia":' + JStr(fantasia) + ',' +
            '"cnpj":' + IfThenW(cnpj<>'', JStr(cnpj), JNull) + ',' +
            '"cpf":' + IfThenW(cpf<>'', JStr(cpf), JNull) + ',' +
            '"endereco":{' +
              '"logradouro":' + JStr(logradouro) + ',' +
              '"complemento":' + IfThenW(complement<>'', JStr(complement), JNull) + ',' +
              '"fone":' + IfThenW(fone<>'', JStr(fone), JNull) + ',' +
              '"celular":' + IfThenW(celular<>'', JStr(celular), JNull) +
            '},' +
            '"bairro":{' +
              '"nome":' + IfThenW(bairroNome<>'', JStr(bairroNome), JNull) +
            '},' +
            '"atividades":' + atividadesJson + ',' +
            '"alvara_ultimo":' + alvaraUlt + ',' +
            '"inspecoes":' + inspecoesJson +
          '}';

        if not SaveUtf8ToFileIfChanged(outFile, W, wrote) then
          raise Exception.Create('Falha ao gravar: ' + outFile);

        if wrote then Inc(GStats.RegWrote) else Inc(GStats.RegSkipped);

        if not firstIndex then indexW := indexW + ',';
        firstIndex := False;

        indexW := indexW +
          '{' +
            '"codigo":' + IntToStr(codigo) + ',' +
            '"razao":' + JStr(razao) + ',' +
            '"fantasia":' + JStr(fantasia) + ',' +
            '"documento":' + IfThenW(doc<>'', JStr(doc), JNull) +
          '}';

        Contrib.Next;
      end;
    finally
      Contrib.Close;
    end;

    indexW := indexW + ']}';

    // index também incremental (pra não sujar Git à toa)
    if not SaveUtf8ToFileIfChanged(BaseDir + 'index_regulados.json', indexW, wrote) then
      raise Exception.Create('Falha ao gravar: index_regulados.json');

    if wrote then Inc(GStats.IndexWrote) else Inc(GStats.IndexSkipped);

  finally
    Contrib.Free;
    MapCnae.Free;
    MapBairro.Free;
  end;
end;

function ExportarJsonCVS_Shared(const AliasOrPath, OutBaseDir: string; out Erro: string): Boolean;
var
  BaseDir: string;
begin
  Result := False;
  Erro := '';
  ResetStats;
  try
    BaseDir := EnsureSlash(OutBaseDir);
    ExportReguladosPorArquivo(AliasOrPath, BaseDir);
    ExportHistoricoPorNdoc(AliasOrPath, BaseDir);
    SaveStatsFile(BaseDir);
    Result := True;
  except
    on E: Exception do
    begin
      Erro := E.ClassName + ': ' + E.Message;
      Result := False;
    end;
  end;
end;

function ExportarJsonCVS_SemHistorico(const AliasOrPath, OutBaseDir: string; out Erro: string): Boolean;
var
  BaseDir: string;
begin
  Result := False;
  Erro := '';
  ResetStats;
  try
    BaseDir := EnsureSlash(OutBaseDir);
    ExportReguladosPorArquivo(AliasOrPath, BaseDir);
    SaveStatsFile(BaseDir);
    Result := True;
  except
    on E: Exception do
    begin
      Erro := E.ClassName + ': ' + E.Message;
      Result := False;
    end;
  end;
end;

end.

