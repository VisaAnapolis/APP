unit exportar_paradox_csv;

{
  Exporta uma tabela Paradox (alias wcvs) para arquivo CSV.
  Compatível com Delphi 6. Saída em ANSI (codepage do sistema);
  se precisar UTF-8, abra o CSV no Excel e Salvar como CSV UTF-8.

  Exemplo de uso (em um botão ou menu):
    ExportarTabelaParaCSV('CONTRIB.DB', 'C:\export\contrib.csv');
    ExportarTabelaParaCSV('bairro.DB', 'C:\export\bairro.csv');
}

interface

uses
  SysUtils, Classes, DB, DBTables;

procedure ExportarTabelaParaCSV(const TableName, ArquivoCSV: string;
  const DatabaseName: string = 'wcvs'; Separador: Char = ',');

implementation

procedure ExportarTabelaParaCSV(const TableName, ArquivoCSV: string;
  const DatabaseName: string = 'wcvs'; Separador: Char = ',');
var
  T: TTable;
  L: TStringList;
  i: Integer;
  s, linha: string;
  Fld: TField;
begin
  L := TStringList.Create;
  try
    T := TTable.Create(nil);
    try
      T.DatabaseName := DatabaseName;
      T.TableName := TableName;
      T.Open;

      // Cabeçalho: nomes das colunas em minúsculo (Supabase)
      linha := '';
      for i := 0 to T.FieldCount - 1 do
      begin
        if i > 0 then linha := linha + Separador;
        linha := linha + LowerCase(T.Fields[i].FieldName);
      end;
      L.Add(linha);

      // Dados
      T.First;
      while not T.Eof do
      begin
        linha := '';
        for i := 0 to T.FieldCount - 1 do
        begin
          Fld := T.Fields[i];
          if i > 0 then linha := linha + Separador;
          if Fld.IsNull then
            s := ''
          else if Fld.DataType in [ftDate, ftDateTime] then
            s := FormatDateTime('yyyy-mm-dd', Fld.AsDateTime)
          else if Fld.DataType = ftTime then
            s := FormatDateTime('hh:nn:ss', Fld.AsDateTime)
          else if Fld.DataType = ftBoolean then
            if Fld.AsBoolean then s := 'true' else s := 'false'
          else
            s := Fld.AsString;
          if (Pos(Separador, s) > 0) or (Pos('"', s) > 0) or (Pos(#10, s) > 0) or (Pos(#13, s) > 0) then
            s := '"' + StringReplace(StringReplace(s, '"', '""', [rfReplaceAll]), #13#10, ' ', [rfReplaceAll]) + '"';
          linha := linha + s;
        end;
        L.Add(linha);
        T.Next;
      end;
    finally
      T.Free;
    end;
    L.SaveToFile(ArquivoCSV);
  finally
    L.Free;
  end;
end;

end.
