program CVS_Exportador_Auto;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  DB,
  DBTables,
  uExportCSV,
  uExportarJsonCVS_Shared;

const
  // Onde ficam as tabelas Paradox
  DATA_DIR  = '\\192.168.1.2\WCVS\DATA\';

  // Saída CSV/JSON
  OUT_REPO  = 'D:\WCVS\repo\docs\data\';

  // Se sua LOGIN.DB usa senha
  LOGIN_PWD = 'paradiso';

  // Só para o JSON (se o uExportarJsonCVS_Shared exigir alias)
  BDE_ALIAS_FOR_JSON = 'WCVS';

procedure ForceDir(const Dir: string);
begin
  if Dir <> '' then ForceDirectories(Dir);
end;

procedure Log(const Msg: string);
var
  F: TextFile;
  Arq: string;
begin
  ForceDir(OUT_REPO);
  Arq := IncludeTrailingPathDelimiter(OUT_REPO) + 'exportador_console.log';

  AssignFile(F, Arq);
  if FileExists(Arq) then Append(F) else Rewrite(F);
  try
    Writeln(F, FormatDateTime('dd"."mm"."yyyy hh":"nn":"ss', Now) + ' - ' + Msg);
  finally
    CloseFile(F);
  end;
end;

procedure FixarLocalePtBR;
begin
  DecimalSeparator  := ',';
  ThousandSeparator := '.';
  DateSeparator     := '/';
  TimeSeparator     := ':';
  ShortDateFormat   := 'dd/mm/yyyy';
end;

procedure PrepararBDE;
var
  PrivateTmp: string;
begin
  // IMPORTANTE:
  // - Não force NetFileDir aqui (pra não criar conflito com o .NET/.LCK do ambiente)
  // - Deixe o NET DIR vir do BDE Admin (o mesmo que o WCS já usa)
  PrivateTmp := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + '_bde_private';
  ForceDir(PrivateTmp);
  Session.PrivateDir := PrivateTmp;

  Session.AddPassword(LOGIN_PWD);
end;

procedure ConfigTable(T: TTable; const PastaData, Tabela: string);
begin
  T.DatabaseName := IncludeTrailingPathDelimiter(PastaData); // UNC
  T.TableName := Tabela;
  T.ReadOnly := True;
  T.Exclusive := False;

  // garante “cru”
  T.Filtered := False;
  T.Filter := '';
  T.MasterSource := nil;
  T.MasterFields := '';
end;

var
  Erro: string;
  DBJson: TDatabase;

  tbContrib, tbVisitas, tbCnae, tbLogin: TTable;
  tbReq, tbTramitacao, tbOficio, tbDenuncia, tbPlanta, tbRdpf, tbBairro, tbAlvara, tbAlvLib : TTable;

begin
  FixarLocalePtBR;
  PrepararBDE;

  Erro := '';

  tbContrib := TTable.Create(nil);
  tbVisitas := TTable.Create(nil);
  tbCnae := TTable.Create(nil);
  tbLogin := TTable.Create(nil);

  tbReq := TTable.Create(nil);
  tbTramitacao := TTable.Create(nil);
  tbOficio := TTable.Create(nil);
  tbDenuncia := TTable.Create(nil);
  tbPlanta := TTable.Create(nil);

  tbRDPF   := TTable.Create(nil);
  tbBairro := TTable.Create(nil);

  tbAlvara := TTable.Create(nil);
  tbAlvLib := TTable.Create(nil);


  DBJson := TDatabase.Create(nil);

  try
    ForceDir(OUT_REPO);
    Log('INICIO');

    // Abre tabelas direto pela pasta DATA (modelo antigo)
    ConfigTable(tbContrib,    DATA_DIR, 'CONTRIB.DB');
    ConfigTable(tbVisitas,    DATA_DIR, 'VISITAS.DB');
    ConfigTable(tbCnae,       DATA_DIR, 'CNAE.DB');
    ConfigTable(tbLogin,      DATA_DIR, 'LOGIN.DB');

    ConfigTable(tbReq,        DATA_DIR, 'REQUERIMENTO.DB');
    ConfigTable(tbTramitacao, DATA_DIR, 'TRAMITACAO.DB');
    ConfigTable(tbOficio,     DATA_DIR, 'OFICIO.DB');
    ConfigTable(tbDenuncia,   DATA_DIR, 'DENUNCIA.DB');
    ConfigTable(tbPlanta,     DATA_DIR, 'PLANTA.DB');

    ConfigTable(tbRDPF,   DATA_DIR, 'RDPF.DB');
    ConfigTable(tbBairro, DATA_DIR, 'BAIRRO.DB');

    ConfigTable(tbAlvara,  DATA_DIR, 'ALVARA.DB');
    ConfigTable(tbAlvLib,  DATA_DIR, 'ALVLIB.DB');

    tbAlvara.Open;
    tbAlvLib.Open;

    tbRDPF.Open;
    tbBairro.Open;

    tbContrib.Open;
    tbVisitas.Open;
    tbCnae.Open;
    tbLogin.Open;

    tbReq.Open;
    tbTramitacao.Open;
    tbOficio.Open;
    tbDenuncia.Open;
    tbPlanta.Open;

    Log('CSV (principais): iniciando...');
    if not ExportarCSVsCVS(OUT_REPO, tbContrib, tbVisitas, tbCnae, tbLogin, Erro) then
      raise Exception.Create('CSV principais: ' + Erro);
    Log('CSV (principais): OK');

    Log('CSV (docs): iniciando...');
    if not ExportarCSVsDocsCVS(OUT_REPO, tbReq, tbTramitacao, tbOficio, tbDenuncia, tbPlanta, Erro) then
      raise Exception.Create('CSV docs: ' + Erro);
    Log('CSV (docs): OK');

    if not ExportarCSVsExtrasCVS(OUT_REPO, tbRDPF, tbBairro, Erro) then
begin
  Log('CSV EXTRAS: ERRO - ' + Erro);
  Halt(6);
end;
Log('CSV EXTRAS: OK');

if not ExportarCSVsAlvarasCVS(OUT_REPO, tbAlvara, tbAlvLib, Erro) then
begin
  Log('CSV ALVARAS: ERRO - ' + Erro);
  Halt(7);
end;
Log('CSV ALVARAS: OK');


 {   // Garantir TRAMITAÇÃO ENXUTA (8k -> ~2k) conforme uExportCSV.pas
    Log('TRAMITACAO ENXUTA: iniciando...');
    if not ExportarTramitacaoEnxuta(OUT_REPO, tbTramitacao, tbLogin, Erro) then
      raise Exception.Create('Tramitacao Enxuta: ' + Erro);
    Log('TRAMITACAO ENXUTA: OK');   }

    // JSON: se sua unit exige alias, mantenha como está (sem mexer em NetFileDir)
    Log('JSON: iniciando...');
    if not ExportarJsonCVS_Shared(BDE_ALIAS_FOR_JSON, OUT_REPO, Erro) then
      raise Exception.Create('JSON: ' + Erro);
    Log('JSON: OK');

    Log('FIM OK');
    Halt(0);

  except
    on E: Exception do
    begin
      Log('ERRO: ' + E.Message);
      Halt(1);
    end;
  end;
end.

