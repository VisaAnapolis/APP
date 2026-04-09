unit uExportCSV;

interface

uses
  SysUtils, Classes, DB, DBTables;

function ExportarCSVsCVS(const PastaRepo: string;
  DSContrib, DSVisitas, DSCnae, DSLogin: TDataSet;
  var Erro: string): Boolean;

implementation

// Sempre coloca o conteúdo entre aspas e escapa aspas internas.
// Delimitador (;) será montado no loop.
function CsvQuoteAll(const S: string): string;
var
  T: string;
begin
  T := StringReplace(S, '"', '""', [rfReplaceAll]);
  Result := '"' + T + '"';
end;

// Converte texto (ANSI) para UTF-8 (bytes) e grava com BOM (EF BB BF).
// Delphi 6: Utf8Encode recebe WideString e devolve UTF8String (AnsiString).
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
    // UTF-8 BOM
    BOM[0] := $EF; BOM[1] := $BB; BOM[2] := $BF;
    FS.WriteBuffer(BOM, SizeOf(BOM));

    U8 := Utf8EncodeD6(Text);
    if Length(U8) > 0 then
      FS.WriteBuffer(U8[1], Length(U8));
  finally
    FS.Free;
  end;
end;

procedure SaveDataSetToCSV(ADataSet: TDataSet; const FileName: string; WriteHeader: Boolean);
var
  SL: TStringList;
  i: Integer;
  Line: string;

  OldAfterScroll: TDataSetNotifyEvent;
  OldBeforeScroll: TDataSetNotifyEvent;
  OldOnCalcFields: TDataSetNotifyEvent;

  Conteudo: string;
begin
  if ADataSet = nil then Exit;

  // evita eventos/alertas em loop durante exportação
  OldAfterScroll  := ADataSet.AfterScroll;
  OldBeforeScroll := ADataSet.BeforeScroll;
  OldOnCalcFields := ADataSet.OnCalcFields;

  ADataSet.AfterScroll  := nil;
  ADataSet.BeforeScroll := nil;
  ADataSet.OnCalcFields := nil;

  SL := TStringList.Create;
  try
    ADataSet.DisableControls;
    try
      if not ADataSet.Active then
        ADataSet.Open;

      // Cabeçalho: todos os campos entre aspas
      if WriteHeader then
      begin
        Line := '';
        for i := 0 to ADataSet.FieldCount - 1 do
        begin
          if i > 0 then Line := Line + ';';
          Line := Line + CsvQuoteAll(ADataSet.Fields[i].FieldName);
        end;
        SL.Add(Line);
      end;

      // Dados: todos os campos entre aspas (inclusive numéricos e datas)
      ADataSet.First;
      while not ADataSet.Eof do
      begin
        Line := '';
        for i := 0 to ADataSet.FieldCount - 1 do
        begin
          if i > 0 then Line := Line + ';';
          if ADataSet.Fields[i].IsNull then
            Line := Line + '""'
          else
            Line := Line + CsvQuoteAll(ADataSet.Fields[i].AsString);
        end;
        SL.Add(Line);
        ADataSet.Next;
      end;

    finally
      ADataSet.EnableControls;
    end;

    // Grava em UTF-8 com BOM
    Conteudo := SL.Text; // CRLF padrão Windows
    SaveTextAsUtf8Bom(FileName, Conteudo);

  finally
    SL.Free;

    // restaura eventos
    ADataSet.AfterScroll  := OldAfterScroll;
    ADataSet.BeforeScroll := OldBeforeScroll;
    ADataSet.OnCalcFields := OldOnCalcFields;
  end;
end;

// Remove filtro e Master/Detail só enquanto exporta INSPEÇÕES
procedure PrepararParaExportarVisitas(DS: TDataSet;
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

    // Delphi 6: tenta cancelar range, se houver
    try
      TTable(DS).CancelRange;
    except
      // ignora se não houver range ativo
    end;
  end;
end;

procedure RestaurarPosExportarVisitas(DS: TDataSet;
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
    Arq := Base + NomeArq;
    SaveDataSetToCSV(DS, Arq, True);
    if not FileExists(Arq) then
      raise Exception.Create('Arquivo não foi criado: ' + Arq);
  end;

begin
  Result := False;
  Erro := '';

  try
    Base := IncludeTrailingPathDelimiter(PastaRepo);

    ForceDirectories(Base);
    if not DirectoryExists(Base) then
      raise Exception.Create('Pasta destino inacessível/não criada: ' + Base);

    // 1) Regulados
    SalvarEConferir(DSContrib, 'regulados.csv');

    // 2) Inspeções (desacopla master/detail e filtros)
    PrepararParaExportarVisitas(DSVisitas, OldMS, OldMF, OldFiltered, OldFilter);
    try
      SalvarEConferir(DSVisitas, 'inspecoes.csv');
    finally
      RestaurarPosExportarVisitas(DSVisitas, OldMS, OldMF, OldFiltered, OldFilter);
    end;

    // 3) CNAE
    SalvarEConferir(DSCnae, 'cnae.csv');

    // 4) Login
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

end.
