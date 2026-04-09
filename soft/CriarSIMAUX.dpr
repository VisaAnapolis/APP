program CriarSIMAUX;

{ Cria a tabela Paradox SIMAUX.DB vazia no diretório do alias BDE wcvs.
  Execute uma vez se quiser pre-criar a tabela (senão ela é criada na primeira validação SIM). }

{$APPTYPE CONSOLE}

uses
  SysUtils, DB, DBTables, Classes;

const
  LOGIN_PWD = 'paradiso';

function AliasPath(const AliasName: string): string;
var
  SL: TStringList;
  i: Integer;
  S: string;
begin
  Result := '';
  SL := TStringList.Create;
  try
    Session.GetAliasParams(AliasName, SL);
    for i := 0 to SL.Count - 1 do
    begin
      S := UpperCase(Trim(SL[i]));
      if Pos('PATH=', S) = 1 then
      begin
        Result := Copy(SL[i], 6, Length(SL[i]));
        Break;
      end;
    end;
  finally
    SL.Free;
  end;
end;

var
  T: TTable;
  Caminho: string;
begin
  try
    Session.AddPassword(LOGIN_PWD);

    Caminho := IncludeTrailingPathDelimiter(AliasPath('WCVS')) + 'SIMAUX.DB';
    if Caminho = 'SIMAUX.DB' then
    begin
      WriteLn('Erro: não foi possível obter o caminho do alias WCVS. Verifique o BDE Administrator.');
      ExitCode := 1;
      Exit;
    end;

    if FileExists(Caminho) then
    begin
      WriteLn('SIMAUX.DB já existe em: ', Caminho);
      WriteLn('Remova ou renomeie se quiser recriar.');
      Exit;
    end;

    { Garante que o diretório existe (importante em rede \\servidor\wcvs\DATA) }
    ForceDirectories(ExtractFilePath(Caminho));

    T := TTable.Create(nil);
    try
      T.DatabaseName := 'wcvs';
      T.TableName := 'SIMAUX.DB';

      T.FieldDefs.Clear;
      T.FieldDefs.Add('CONTROLE', ftAutoInc, 0, True);
      T.FieldDefs.Add('INSCRICAO', ftString, 20, False);
      T.FieldDefs.Add('DOCUMENTO', ftString, 20, False);
      T.FieldDefs.Add('RAZAO', ftString, 100, False);
      T.FieldDefs.Add('CNAE', ftString, 20, False);
      T.FieldDefs.Add('ATIVIDADE', ftString, 254, False);

      T.IndexDefs.Clear;
      T.IndexDefs.Add('', 'CONTROLE', [ixPrimary, ixUnique]);
      T.IndexDefs.Add('PorInscricao', 'INSCRICAO', []);
      T.IndexDefs.Add('PorDocumento', 'DOCUMENTO', []);

      T.CreateTable;
      WriteLn('Tabela SIMAUX.DB criada com sucesso.');
      WriteLn('Caminho: ', Caminho);
    finally
      T.Free;
    end;
  except
    on E: Exception do
    begin
      WriteLn('Erro: ', E.Message);
      WriteLn('');
      WriteLn('Se o alias aponta para rede (ex.: \\192.168.1.2\wcvs\DATA), verifique:');
      WriteLn('  - O diretório existe e tem permissão de escrita.');
      WriteLn('  - O compartilhamento está acessível nesta máquina.');
      ExitCode := 1;
    end;
  end;
end.
