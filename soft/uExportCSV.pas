unit uExportCSV;

interface

uses
  SysUtils, Classes, DB, DBTables;

function ExportarCSVsCVS(const PastaRepo: string;
  DSContrib, DSVisitas, DSCnae, DSLogin: TDataSet;
  var Erro: string): Boolean;

// Requerimento/Tramitao/Ofcio/Denncia/Protocolo(PLANTA)
function ExportarCSVsDocsCVS(const PastaRepo: string;
  DSReq, DSTramitacao, DSOficio, DSDenuncia, DSProtocolo: TDataSet;
  var Erro: string): Boolean;

function ExportarCSVsExtrasCVS(const PastaRepo: string;
  DSRdpf, DSBairro: TDataSet;
  var Erro: string): Boolean;

function ExportarCSVsAlvarasCVS(const PastaRepo: string;
  DSAlvara, DSAlvLib: TDataSet;
  var Erro: string): Boolean;


// TRAMITAÇÃO ENXUTA:
// - só DESTINO que exista em LOGIN.Usuario (comparação EXATA, sem normalização)
// - só o ÚLTIMO registro por PROTOCOLO (DATA+HORA mais recente)
// - exporta só 4 campos: PROTOCOLO;DATA;HORA;DESTINO
function ExportarTramitacaoEnxuta(const PastaRepo: string;
  DSTramitacao, DSLogin: TDataSet; var Erro: string): Boolean;

implementation

// ------------------------------------------------------------
// CSV: tudo entre aspas, separador ; e datas no padro dd.mm.aaaa
// ------------------------------------------------------------

function CsvQuoteAll(const S: string): string;
var
  T: string;
begin
  T := StringReplace(S, '"', '""', [rfReplaceAll]);
  Result := '"' + T + '"';
end;

function Utf8EncodeD6(const S: string): AnsiString;
begin
  Result := Utf8Encode(WideString(S));
end;

procedure SaveTextAsUtf8Bom(const FileName: string; const Text: string);
var
  FS: TFileStream;
  BOM: array[0..2] of Byte;
  U8: AnsiString;
begin
  ForceDirectories(ExtractFilePath(FileName));

  FS := TFileStream.Create(FileName, fmCreate);
  try
    BOM[0] := $EF; BOM[1] := $BB; BOM[2] := $BF; // UTF-8 BOM
    FS.WriteBuffer(BOM, SizeOf(BOM));

    U8 := Utf8EncodeD6(Text);
    if Length(U8) > 0 then
      FS.WriteBuffer(U8[1], Length(U8));
  finally
    FS.Free;
  end;
end;

function FieldValueAsCsvText(F: TField): string;
var
  D: TDateTime;
begin
  if (F = nil) or F.IsNull then
  begin
    Result := '""';
    Exit;
  end;

  case F.DataType of
    ftDate, ftDateTime, ftTimeStamp:
      begin
        try
          D := F.AsDateTime;
          Result := CsvQuoteAll(FormatDateTime('dd"."mm"."yyyy', D));
        except
          Result := CsvQuoteAll(F.AsString);
        end;
      end;
  else
    Result := CsvQuoteAll(F.AsString);
  end;
end;

// ------------------------------------------------------------
// Helper para soltar Master/Detail/Filtro/Range (VISITAS, TRAMITACAO, PLANTA)
// ------------------------------------------------------------

procedure PrepararParaExportarMasterDetail(DS: TDataSet;
  var OldMasterSource: TDataSource; var OldMasterFields: string;
  var OldFiltered: Boolean; var OldFilter: string);
begin
  OldMasterSource := nil;
  OldMasterFields := '';
  OldFiltered := DS.Filtered;
  OldFilter := DS.Filter;

  DS.Filtered := False;
  DS.Filter := '';

  if DS is TTable then
  begin
    OldMasterSource := TTable(DS).MasterSource;
    OldMasterFields := TTable(DS).MasterFields;

    TTable(DS).MasterSource := nil;
    TTable(DS).MasterFields := '';

    try
      TTable(DS).CancelRange;
    except
      // ignora
    end;
  end;
end;

procedure RestaurarPosExportarMasterDetail(DS: TDataSet;
  OldMasterSource: TDataSource; OldMasterFields: string;
  OldFiltered: Boolean; OldFilter: string);
begin
  if DS is TTable then
  begin
    TTable(DS).MasterSource := OldMasterSource;
    TTable(DS).MasterFields := OldMasterFields;
  end;

  DS.Filter := OldFilter;
  DS.Filtered := OldFiltered;
end;

// ------------------------------------------------------------
// Dataset seguro para exportar (resolve persistent fields incompletos)
// - NO mexe no dataset do form.
// - Se for TTable e tiver poucos Fields (persistent), cria um TTable temporrio e exporta por ele.
// ------------------------------------------------------------

procedure GetSafeExportDataSet(Orig: TDataSet; var DSOut: TDataSet; var Temp: TTable);
var
  T: TTable;
  NeedTemp: Boolean;
begin
  DSOut := Orig;
  Temp := nil;

  if Orig = nil then Exit;
  if not (Orig is TTable) then Exit;

  T := TTable(Orig);

  // Detecta persistent fields incompletos:
  // FieldDefs.Count (estrutura real) costuma ser maior que Fields.Count quando o form tem poucos campos persistidos
  NeedTemp := False;
  try
    if not Orig.Active then Orig.Open;
    Orig.FieldDefs.Update;
    if Orig.Fields.Count < Orig.FieldDefs.Count then
      NeedTemp := True;
  except
    // se der erro aqui, no fora temp
    NeedTemp := False;
  end;

  if not NeedTemp then Exit;

  // Cria TTable temporrio sem persistent fields
  Temp := TTable.Create(nil);
  Temp.DatabaseName := T.DatabaseName;
  Temp.TableName := T.TableName;
  Temp.ReadOnly := True;

  // sem master/detail/filtro/range
  Temp.MasterSource := nil;
  Temp.MasterFields := '';
  Temp.Filtered := False;
  Temp.Filter := '';

  Temp.Open;

  DSOut := Temp;
end;

// ------------------------------------------------------------
// Exportao CSV
// ------------------------------------------------------------

procedure SaveDataSetToCSV(ADataSet: TDataSet; const FileName: string; WriteHeader: Boolean);
var
  SL: TStringList;
  i: Integer;
  Line: string;

  OldAfterScroll: TDataSetNotifyEvent;
  OldBeforeScroll: TDataSetNotifyEvent;
  OldOnCalcFields: TDataSetNotifyEvent;

  Conteudo: string;

  DS: TDataSet;
  TempTable: TTable;

  function PassaCorteInspecoes2018: Boolean;
  var
    F: TField;
    D: TDateTime;
  begin
    if AnsiSameText(ExtractFileName(FileName), 'inspecoes.csv') then
    begin
      F := DS.FindField('DT_VISITA');
      if (F = nil) or F.IsNull then
      begin
        Result := False;
        Exit;
      end;

      try
        D := F.AsDateTime;
        Result := (D >= EncodeDate(2018, 1, 1));
      except
        Result := False;
      end;
    end
    else
      Result := True;
  end;

begin
  if ADataSet = nil then Exit;

  // garante dataset aberto
  if not ADataSet.Active then
    ADataSet.Open;

  // escolhe um dataset seguro para exportar (resolve tbdenuncia com 3 campos)
  GetSafeExportDataSet(ADataSet, DS, TempTable);

  // guarda eventos do dataset ORIGINAL (no do temporrio)
  OldAfterScroll  := ADataSet.AfterScroll;
  OldBeforeScroll := ADataSet.BeforeScroll;
  OldOnCalcFields := ADataSet.OnCalcFields;

  ADataSet.AfterScroll  := nil;
  ADataSet.BeforeScroll := nil;
  ADataSet.OnCalcFields := nil;

  SL := TStringList.Create;
  try
    DS.DisableControls;
    try
      // cabealho (sempre entre aspas)
// cabealho (sempre entre aspas)
if WriteHeader then
begin
  Line := '';

  if AnsiSameText(ExtractFileName(FileName), 'tramitacao.csv') then
  begin
    // >>> ajuste aqui se os nomes reais forem diferentes <<<
    Line := CsvQuoteAll('PROTOCOLO') + ';' +
            CsvQuoteAll('DATA')      + ';' +
            CsvQuoteAll('HORA')      + ';' +
            CsvQuoteAll('DESTINO');
  end
  else
  begin
    for i := 0 to DS.FieldCount - 1 do
    begin
      if i > 0 then Line := Line + ';';
      Line := Line + CsvQuoteAll(DS.Fields[i].FieldName);
    end;
  end;

  SL.Add(Line);
end;

DS.First;
while not DS.Eof do
begin
  if PassaCorteInspecoes2018 then
  begin
    Line := '';

    if AnsiSameText(ExtractFileName(FileName), 'tramitacao.csv') then
    begin
      Line := FieldValueAsCsvText(DS.FindField('PROTOCOLO')) + ';' +
              FieldValueAsCsvText(DS.FindField('DATA'))      + ';' +
              FieldValueAsCsvText(DS.FindField('HORA'))      + ';' +
              FieldValueAsCsvText(DS.FindField('DESTINO'));
    end
    else
    begin
      for i := 0 to DS.FieldCount - 1 do
      begin
        if i > 0 then Line := Line + ';';
        Line := Line + FieldValueAsCsvText(DS.Fields[i]);
      end;
    end;

    SL.Add(Line);
  end;

  DS.Next;
end;

    finally
      DS.EnableControls;
    end;

    Conteudo := SL.Text;
    SaveTextAsUtf8Bom(FileName, Conteudo);

  finally
    SL.Free;

    // restaura eventos do dataset original
    ADataSet.AfterScroll  := OldAfterScroll;
    ADataSet.BeforeScroll := OldBeforeScroll;
    ADataSet.OnCalcFields := OldOnCalcFields;

    // destri o temporrio se tiver sido criado
    if TempTable <> nil then
    begin
      try TempTable.Close; except end;
      TempTable.Free;
    end;
  end;
end;

// ------------------------------------------------------------
// CSVs principais
// ------------------------------------------------------------

function ExportarCSVsCVS(const PastaRepo: string;
  DSContrib, DSVisitas, DSCnae, DSLogin: TDataSet;
  var Erro: string): Boolean;
var
  Base, Arq: string;

  OldMS: TDataSource;
  OldMF: string;
  OldFiltered: Boolean;
  OldFilter: string;

  procedure SalvarEConferir(DS: TDataSet; const NomeArq: string);
  begin
    if DS = nil then
      raise Exception.Create('Dataset NIL ao gerar: ' + NomeArq);

    Arq := Base + NomeArq;
    SaveDataSetToCSV(DS, Arq, True);

    if not FileExists(Arq) then
      raise Exception.Create('Arquivo no foi criado: ' + Arq);
  end;

begin
  Result := False;
  Erro := '';

  try
    Base := IncludeTrailingPathDelimiter(PastaRepo);
    ForceDirectories(Base);
    if not DirectoryExists(Base) then
      raise Exception.Create('Pasta destino inacessvel/no criada: ' + Base);

    SalvarEConferir(DSContrib, 'regulados.csv');

    PrepararParaExportarMasterDetail(DSVisitas, OldMS, OldMF, OldFiltered, OldFilter);
    try
      SalvarEConferir(DSVisitas, 'inspecoes.csv');
    finally
      RestaurarPosExportarMasterDetail(DSVisitas, OldMS, OldMF, OldFiltered, OldFilter);
    end;

    SalvarEConferir(DSCnae, 'cnae.csv');

    if DSLogin <> nil then
      SalvarEConferir(DSLogin, 'login.csv');

    Result := True;

  except
    on E: Exception do
    begin
      Erro := E.Message;
      Result := False;
    end;
  end;
end;

// ------------------------------------------------------------
// Docs + Protocolo
// ------------------------------------------------------------

function ExportarCSVsDocsCVS(const PastaRepo: string;
  DSReq, DSTramitacao, DSOficio, DSDenuncia, DSProtocolo: TDataSet;
  var Erro: string): Boolean;
var
  Base, Arq: string;

  OldMS: TDataSource;
  OldMF: string;
  OldFiltered: Boolean;
  OldFilter: string;

  procedure SalvarEConferir(DS: TDataSet; const NomeArq: string);
  begin
    if DS = nil then
      raise Exception.Create('Dataset NIL ao gerar: ' + NomeArq);

    Arq := Base + NomeArq;
    SaveDataSetToCSV(DS, Arq, True);

    if not FileExists(Arq) then
      raise Exception.Create('Arquivo no foi criado: ' + Arq);
  end;

begin
  Result := False;
  Erro := '';

  try
    Base := IncludeTrailingPathDelimiter(PastaRepo);
    ForceDirectories(Base);
    if not DirectoryExists(Base) then
      raise Exception.Create('Pasta destino inacessvel/no criada: ' + Base);

    SalvarEConferir(DSReq, 'requerimento.csv');

    PrepararParaExportarMasterDetail(DSTramitacao, OldMS, OldMF, OldFiltered, OldFilter);
    try
      SalvarEConferir(DSTramitacao, 'tramitacao.csv');
    finally
      RestaurarPosExportarMasterDetail(DSTramitacao, OldMS, OldMF, OldFiltered, OldFilter);
    end;

    SalvarEConferir(DSOficio, 'oficio.csv');

    // Aqui  onde normalmente dava 3 campos. Agora exporta por TTable temporrio se precisar.
    SalvarEConferir(DSDenuncia, 'denuncia.csv');

    PrepararParaExportarMasterDetail(DSProtocolo, OldMS, OldMF, OldFiltered, OldFilter);
    try
      SalvarEConferir(DSProtocolo, 'protocolo.csv');
    finally
      RestaurarPosExportarMasterDetail(DSProtocolo, OldMS, OldMF, OldFiltered, OldFilter);
    end;

    Result := True;

  except
    on E: Exception do
    begin
      Erro := E.Message;
      Result := False;
    end;
  end;
end;

function ExportarCSVsExtrasCVS(const PastaRepo: string;
  DSRdpf, DSBairro: TDataSet;
  var Erro: string): Boolean;
var
  Pasta: string;
begin
  Result := False;
  Erro := '';
  Pasta := IncludeTrailingPathDelimiter(PastaRepo);

  try
    if Assigned(DSRdpf) then
      SaveDataSetToCSV(DSRdpf, Pasta + 'rdpf.csv', True);



    if Assigned(DSBairro) then
    SaveDataSetToCSV(DSBairro, Pasta + 'bairros.csv', True);

    Result := True;
  except
    on E: Exception do
    begin
      Erro := E.Message;
      Result := False;
    end;
  end;
end;

function ExportarCSVsAlvarasCVS(const PastaRepo: string;
  DSAlvara, DSAlvLib: TDataSet;
  var Erro: string): Boolean;
var
  Pasta: string;
begin
  Result := False;
  Erro := '';
  Pasta := IncludeTrailingPathDelimiter(PastaRepo);

  try
    // ALVARA.DB -> alvara.csv
    if Assigned(DSAlvara) then
      SaveDataSetToCSV(DSAlvara, Pasta + 'alvara.csv', True);

    // ALVLIB.DB -> alvlib.csv
    if Assigned(DSAlvLib) then
      SaveDataSetToCSV(DSAlvLib, Pasta + 'alvlib.csv', True);

    Result := True;
  except
    on E: Exception do
    begin
      Erro := E.Message;
      Result := False;
    end;
  end;
end;


// ------------------------------------------------------------
// TRAMITAÇÃO ENXUTA (opção A: função nova, não interfere nos demais exports)
// - só DESTINO que exista em LOGIN.Usuario (comparação EXATA, sem normalização)
// - só o ÚLTIMO registro por PROTOCOLO (DATA+HORA mais recente)
// - exporta só 4 campos: PROTOCOLO;DATA;HORA;DESTINO
// ------------------------------------------------------------

type
  TTramItem = class
  public
    DT: TDateTime;
    Protocolo: string;
    DataTxt: string;
    HoraTxt: string;
    Destino: string;
  end;

function ExportarTramitacaoEnxuta(const PastaRepo: string;
  DSTramitacao, DSLogin: TDataSet; var Erro: string): Boolean;
var
  Base, Arq: string;
  Usuarios: TStringList;
  Mapa: TStringList;
  idx: Integer;

  OldMS: TDataSource;
  OldMF: string;
  OldFiltered: Boolean;
  OldFilter: string;

  Bmk: TBookmark;

  function CsvTextOrEmpty(const S: string): string;
  begin
    if S = '' then
      Result := '""'
    else
      Result := CsvQuoteAll(S);
  end;

  function FieldAsStringSafe(DS: TDataSet; const FieldName: string): string;
var
  F: TField;
begin
  F := DS.FindField(FieldName);
  if (F = nil) or F.IsNull then
    Result := ''
  else
    Result := F.AsString;
end;

  function FieldAsDateTextSafe(DS: TDataSet; const FieldName: string): string;
  var
    F: TField;
    D: TDateTime;
  begin
    F := DS.FindField(FieldName);
    if (F = nil) or F.IsNull then
    begin
      Result := '""';
      Exit;
    end;

    try
      D := F.AsDateTime;
      Result := CsvQuoteAll(FormatDateTime('dd"."mm"."yyyy', D));
    except
      Result := CsvQuoteAll(F.AsString);
    end;
  end;

  function FieldAsTimeTextSafe(DS: TDataSet; const FieldName: string): string;
  var
    F: TField;
  begin
    F := DS.FindField(FieldName);
    if (F = nil) or F.IsNull then
      Result := '""'
    else
      Result := CsvQuoteAll(F.AsString);
  end;

  // Obs.: não criei função separada de DATA+HORA para evitar código morto.

  procedure CarregarUsuarios;
  begin
    Usuarios.Clear;
    if DSLogin = nil then Exit;

    DSLogin.DisableControls;
    try
      DSLogin.First;
      while not DSLogin.Eof do
      begin
        // comparação EXATA (sem normalização)
        if FieldAsStringSafe(DSLogin, 'USUARIO') <> '' then
          Usuarios.Add(FieldAsStringSafe(DSLogin, 'USUARIO'));
        DSLogin.Next;
      end;
    finally
      DSLogin.EnableControls;
    end;
  end;


  function UsuarioExisteExato(const U: string): Boolean;
  var
    j: Integer;
  begin
    Result := False;
    for j := 0 to Usuarios.Count - 1 do
    begin
      if U = Usuarios[j] then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  // Combina DATA (ftDate) + HORA (ftTime) para comparar registros mais recentes
  function CalcDataHora(const DS: TDataSet): TDateTime;
  var
    D, H: TDateTime;
    F: TField;
  begin
    D := 0;
    H := 0;

    F := DS.FindField('DATA');
    if (F <> nil) and (not F.IsNull) then
      D := F.AsDateTime;

    F := DS.FindField('HORA');
    if (F <> nil) and (not F.IsNull) then
      H := Frac(F.AsDateTime);

    Result := D + H;
  end;

  procedure GerarMapaTramitacao;
  var
    Prot, Dest: string;
    Item: TTramItem;
    DT: TDateTime;
  begin
    Mapa.Clear;

    DSTramitacao.DisableControls;
    try
      // preserva posição atual
      Bmk := DSTramitacao.GetBookmark;
      try
        DSTramitacao.First;
        while not DSTramitacao.Eof do
        begin
          Dest := FieldAsStringSafe(DSTramitacao, 'DESTINO');
          if (Dest <> '') and UsuarioExisteExato(Dest) then
          begin
            Prot := FieldAsStringSafe(DSTramitacao, 'PROTOCOLO');
            if Prot <> '' then
            begin
              DT := CalcDataHora(DSTramitacao);

              idx := Mapa.IndexOf(Prot);
              if idx < 0 then
              begin
                Item := TTramItem.Create;
                Item.DT := DT;
                Item.Protocolo := Prot;
                Item.DataTxt := FieldAsDateTextSafe(DSTramitacao, 'DATA');
                Item.HoraTxt := FieldAsTimeTextSafe(DSTramitacao, 'HORA');
                Item.Destino := Dest;
                Mapa.AddObject(Prot, Item);
              end
              else
              begin
                Item := TTramItem(Mapa.Objects[idx]);
                if (Item = nil) or (DT > Item.DT) then
                begin
                  if Item <> nil then
                    Item.Free;

                  Item := TTramItem.Create;
                  Item.DT := DT;
                  Item.Protocolo := Prot;
                  Item.DataTxt := FieldAsDateTextSafe(DSTramitacao, 'DATA');
                  Item.HoraTxt := FieldAsTimeTextSafe(DSTramitacao, 'HORA');
                  Item.Destino := Dest;
                  Mapa.Objects[idx] := Item;
                end;
              end;
            end;
          end;

          DSTramitacao.Next;
        end;

      finally
        // restaura posição do dataset
        if DSTramitacao.BookmarkValid(Bmk) then
          DSTramitacao.GotoBookmark(Bmk);
        DSTramitacao.FreeBookmark(Bmk);
      end;

    finally
      DSTramitacao.EnableControls;
    end;
  end;

  procedure EscreverCSV;
  var
    SL: TStringList;
    Line: string;
    Item: TTramItem;
    j: Integer;
  begin
    SL := TStringList.Create;
    try
      // cabeçalho fixo (igual ao tratamento especial existente)
      SL.Add(CsvQuoteAll('PROTOCOLO') + ';' +
             CsvQuoteAll('DATA')      + ';' +
             CsvQuoteAll('HORA')      + ';' +
             CsvQuoteAll('DESTINO'));

      for j := 0 to Mapa.Count - 1 do
      begin
        Item := TTramItem(Mapa.Objects[j]);
        if Item = nil then Continue;

        Line := CsvTextOrEmpty(Item.Protocolo) + ';' +
                Item.DataTxt + ';' +
                Item.HoraTxt + ';' +
                CsvTextOrEmpty(Item.Destino);

        SL.Add(Line);
      end;

      SaveTextAsUtf8Bom(Arq, SL.Text);
    finally
      SL.Free;
    end;
  end;

  procedure LiberarMapa;
  var
    Item: TTramItem;
    j: Integer;
  begin
    for j := 0 to Mapa.Count - 1 do
    begin
      Item := TTramItem(Mapa.Objects[j]);
      if Item <> nil then
        Item.Free;
      Mapa.Objects[j] := nil;
    end;
    Mapa.Clear;
  end;

begin
  Result := False;
  Erro := '';
  try
    if (DSTramitacao = nil) then
      raise Exception.Create('DSTramitacao NIL.');

    if not DirectoryExists(PastaRepo) then
      raise Exception.Create('PastaRepo inexistente: ' + PastaRepo);

    Base := IncludeTrailingPathDelimiter(PastaRepo);
    Arq  := Base + 'tramitacao.csv';

    // lista de usuários (comparação exata)
    Usuarios := TStringList.Create;
    Mapa     := TStringList.Create;
    try
      Usuarios.Sorted := False;
      Usuarios.Duplicates := dupIgnore;

      Mapa.Sorted := True;
      Mapa.Duplicates := dupIgnore; // protocolo repetido será tratado manualmente

      // garante que a tramitação seja varrida inteira (sem filtros master/detail)
      PrepararParaExportarMasterDetail(DSTramitacao, OldMS, OldMF, OldFiltered, OldFilter);
      try
        CarregarUsuarios;
        GerarMapaTramitacao;
      finally
        RestaurarPosExportarMasterDetail(DSTramitacao, OldMS, OldMF, OldFiltered, OldFilter);
      end;

      EscreverCSV;
      Result := True;

    finally
      LiberarMapa;
      Mapa.Free;
      Usuarios.Free;
    end;

  except
    on E: Exception do
    begin
      Erro := E.Message;
      Result := False;
    end;
  end;
end;


end.


