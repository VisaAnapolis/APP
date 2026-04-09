program CVS_Exportador_Daemon;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  Classes,
  DB,
  DBTables,
  IniFiles,
  uExportCSV,
  uExportarJsonCVS_Shared;

const
  // Paradox
  DATA_DIR  = '\\192.168.1.2\WCVS\DATA\';

  // Saída (CSV/JSON)
  OUT_REPO  = 'D:\WCVS\repo\docs\data\';

  // Senha Paradox (se aplicável)
  LOGIN_PWD = 'paradiso';

  // Alias usado pelo ExportarJsonCVS_Shared
  BDE_ALIAS_FOR_JSON = 'WCVS';

  // BAT somente para sync Git (novo)
  SYNC_ONLY_BAT = 'D:\exportador\SyncOnly.bat';

  // Janela de tolerância (min) para rodar após HH:00
  TOLERANCE_MINUTES = 3;

procedure ForceDir(const Dir: string);
begin
  if Dir <> '' then
    ForceDirectories(Dir);
end;

function LogPath: string;
begin
  Result := IncludeTrailingPathDelimiter(OUT_REPO) + 'exportador_daemon.log';
end;

procedure Log(const Msg: string);
var
  F: TextFile;
begin
  ForceDir(OUT_REPO);
  AssignFile(F, LogPath);
  if FileExists(LogPath) then Append(F) else Rewrite(F);
  try
    Writeln(F, FormatDateTime('dd"/"mm"/"yyyy hh":"nn":"ss', Now) + ' - ' + Msg);
  finally
    CloseFile(F);
  end;
end;

procedure PrepararBDE;
var
  PrivateTmp: string;
begin
  // Não força NetFileDir aqui (evita conflito com PDOXUSRS.* do ambiente)
  PrivateTmp := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + '_bde_private';
  ForceDir(PrivateTmp);
  Session.PrivateDir := PrivateTmp;

  Session.AddPassword(LOGIN_PWD);
end;

procedure ConfigTable(T: TTable; const PastaData, Tabela: string);
begin
  T.DatabaseName := IncludeTrailingPathDelimiter(PastaData);
  T.TableName := Tabela;
  T.ReadOnly := True;
  T.Exclusive := False;

  T.Filtered := False;
  T.Filter := '';
  T.MasterSource := nil;
  T.MasterFields := '';
end;

function RunBatHidden(const BatPath: string; out ExitCode: DWORD): Boolean;
var
  SI: TStartupInfo;
  PI: TProcessInformation;
  Cmd: string;
begin
  Result := False;
  ExitCode := 0;

  if not FileExists(BatPath) then
  begin
    Log('SYNC BAT não encontrado: ' + BatPath);
    Exit;
  end;

  ZeroMemory(@SI, SizeOf(SI));
  SI.cb := SizeOf(SI);
  SI.dwFlags := STARTF_USESHOWWINDOW;
  SI.wShowWindow := SW_HIDE;

  ZeroMemory(@PI, SizeOf(PI));

  Cmd := 'cmd.exe /c "' + BatPath + '"';

  if not CreateProcess(nil, PChar(Cmd), nil, nil, False, CREATE_NO_WINDOW, nil, nil, SI, PI) then
  begin
    Log('Falha ao iniciar BAT. WinErr=' + IntToStr(GetLastError));
    Exit;
  end;

  try
    WaitForSingleObject(PI.hProcess, INFINITE);
    if not GetExitCodeProcess(PI.hProcess, ExitCode) then
      ExitCode := 0;
    Result := True;
  finally
    CloseHandle(PI.hThread);
    CloseHandle(PI.hProcess);
  end;
end;

function IniPath: string;
begin
  Result := IncludeTrailingPathDelimiter(OUT_REPO) + 'exportador_daemon.ini';
end;

function TodayKey: string;
begin
  Result := FormatDateTime('yyyymmdd', Date);
end;

function AlreadyRanToday(const Slot: string): Boolean;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(IniPath);
  try
    Result := Ini.ReadBool(TodayKey, Slot, False);
  finally
    Ini.Free;
  end;
end;

procedure MarkRanToday(const Slot: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(IniPath);
  try
    Ini.WriteBool(TodayKey, Slot, True);
    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;

procedure ResetOldDays;
var
  Ini: TIniFile;
  Sections: TStringList;
  I: Integer;
  KeepKey: string;
begin
  Ini := TIniFile.Create(IniPath);
  Sections := TStringList.Create;
  try
    KeepKey := TodayKey;
    Ini.ReadSections(Sections);
    for I := Sections.Count - 1 downto 0 do
      if Sections[I] <> KeepKey then
        Ini.EraseSection(Sections[I]);
    Ini.UpdateFile;
  finally
    Sections.Free;
    Ini.Free;
  end;
end;

function WithinToleranceOfHourStart(const H: Integer): Boolean;
var
  HH, NN, SS, MS: Word;
begin
  DecodeTime(Now, HH, NN, SS, MS);
  Result := (HH = H) and (NN <= TOLERANCE_MINUTES);
end;

function ExportarTudo(var Erro: string): Boolean;
var
  tbContrib, tbVisitas, tbCnae, tbLogin: TTable;
  tbReq, tbTramitacao, tbOficio, tbDenuncia, tbPlanta: TTable;
  tbRDPF, tbBairro: TTable;
  tbAlvara, tbAlvLib: TTable;
begin
  Result := False;
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

  tbRDPF := TTable.Create(nil);
  tbBairro := TTable.Create(nil);

  tbAlvara := TTable.Create(nil);
  tbAlvLib := TTable.Create(nil);

  try
    // Principais
    ConfigTable(tbContrib, DATA_DIR, 'CONTRIB.DB');
    ConfigTable(tbVisitas, DATA_DIR, 'VISITAS.DB');
    ConfigTable(tbCnae,    DATA_DIR, 'CNAE.DB');
    ConfigTable(tbLogin,   DATA_DIR, 'LOGIN.DB');

    // Docs
    ConfigTable(tbReq,        DATA_DIR, 'REQUERIMENTO.DB');
    ConfigTable(tbTramitacao, DATA_DIR, 'TRAMITACAO.DB');
    ConfigTable(tbOficio,     DATA_DIR, 'OFICIO.DB');
    ConfigTable(tbDenuncia,   DATA_DIR, 'DENUNCIA.DB');
    ConfigTable(tbPlanta,     DATA_DIR, 'PLANTA.DB');

    // Extras (RDPF/BAIRRO)
    ConfigTable(tbRDPF,   DATA_DIR, 'RDPF.DB');
    ConfigTable(tbBairro, DATA_DIR, 'BAIRRO.DB');

    // Alvarás (ALVARA/ALVLIB)
    ConfigTable(tbAlvara, DATA_DIR, 'ALVARA.DB');
    ConfigTable(tbAlvLib, DATA_DIR, 'ALVLIB.DB');

    tbContrib.Open; tbVisitas.Open; tbCnae.Open; tbLogin.Open;
    tbReq.Open; tbTramitacao.Open; tbOficio.Open; tbDenuncia.Open; tbPlanta.Open;
    tbRDPF.Open; tbBairro.Open;
    tbAlvara.Open; tbAlvLib.Open;

    // CSVs
    if not ExportarCSVsCVS(OUT_REPO, tbContrib, tbVisitas, tbCnae, tbLogin, Erro) then Exit;
    if not ExportarCSVsDocsCVS(OUT_REPO, tbReq, tbTramitacao, tbOficio, tbDenuncia, tbPlanta, Erro) then Exit;

    // Se você já criou essas funções na unit, deixam tudo padronizado:
    if not ExportarCSVsExtrasCVS(OUT_REPO, tbRDPF, tbBairro, Erro) then Exit;
    if not ExportarCSVsAlvarasCVS(OUT_REPO, tbAlvara, tbAlvLib, Erro) then Exit;

    // JSON
    if not ExportarJsonCVS_Shared(BDE_ALIAS_FOR_JSON, OUT_REPO, Erro) then Exit;

    Result := True;

  finally
    tbAlvLib.Free; tbAlvara.Free;
    tbBairro.Free; tbRDPF.Free;
    tbPlanta.Free; tbDenuncia.Free; tbOficio.Free; tbTramitacao.Free; tbReq.Free;
    tbLogin.Free; tbCnae.Free; tbVisitas.Free; tbContrib.Free;
  end;
end;

function EnsureSingleInstance: Boolean;
var
  H: THandle;
begin
  Result := False;
  H := CreateMutex(nil, True, 'Global\CVS_Exportador_Daemon');
  if H = 0 then Exit;

  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    Log('Já existe uma instância em execução. Encerrando.');
    Exit;
  end;

  Result := True;
end;

function IsWeekend(const ADate: TDateTime): Boolean;
var D: Integer;
begin
  D := DayOfWeek(ADate); // 1=Domingo .. 7=Sábado
  Result := (D = 1) or (D = 7);
end;

function TryParseDateBR(const S: string; out D: TDateTime): Boolean;
var ss: string; dd, mm, yy: Word;
begin
  Result := False;
  ss := Trim(S);
  if ss = '' then Exit;

  // dd/mm/yyyy
  if (Length(ss) >= 10) and (ss[3] = '/') and (ss[6] = '/') then
  begin
    try
      dd := StrToInt(Copy(ss, 1, 2));
      mm := StrToInt(Copy(ss, 4, 2));
      yy := StrToInt(Copy(ss, 7, 4));
      D := EncodeDate(yy, mm, dd);
      Result := True;
      Exit;
    except end;
  end;

  // yyyy-mm-dd (opcional)
  if (Length(ss) >= 10) and (ss[5] = '-') and (ss[8] = '-') then
  begin
    try
      yy := StrToInt(Copy(ss, 1, 4));
      mm := StrToInt(Copy(ss, 6, 2));
      dd := StrToInt(Copy(ss, 9, 2));
      D := EncodeDate(yy, mm, dd);
      Result := True;
      Exit;
    except end;
  end;
end;

function IsHoliday(const ADate: TDateTime): Boolean;
const HOL_FILE = 'D:\exportador\feriados.txt';
var SL: TStringList; i: Integer; line: string; hd: TDateTime;
begin
  Result := False;
  if not FileExists(HOL_FILE) then Exit;

  SL := TStringList.Create;
  try
    SL.LoadFromFile(HOL_FILE);
    for i := 0 to SL.Count - 1 do
    begin
      line := Trim(SL[i]);
      if (line = '') then Continue;
      if (line[1] = '#') then Continue;

      if TryParseDateBR(line, hd) then
        if Trunc(hd) = Trunc(ADate) then
        begin
          Result := True;
          Exit;
        end;
    end;
  finally
    SL.Free;
  end;
end;

function IsBusinessDay(const ADate: TDateTime): Boolean;
begin
  Result := (not IsWeekend(ADate)) and (not IsHoliday(ADate));
end;


procedure MainLoop;
var
  H: Integer;
  Slot: string;
  Erro: string;
  BatExit: DWORD;
begin
  ResetOldDays;
  Log('Daemon iniciado com unit incremental: 07:00 até 18:00, de hora em hora.');

  while True do
  begin

  if not IsBusinessDay(Date) then
begin
  Sleep(60000); // 60s
  Continue;
end;


    try
      // Horas 07..18
      for H := 7 to 18 do
      begin
        Slot := Format('H%.2d', [H]);

        if WithinToleranceOfHourStart(H) and (not AlreadyRanToday(Slot)) then
        begin
          Log('Disparo do slot ' + Slot + '...');

          if ExportarTudo(Erro) then
          begin
            Log('Exportação OK. Rodando SyncOnly.bat...');
            if RunBatHidden(SYNC_ONLY_BAT, BatExit) then
              Log('SyncOnly.bat finalizado. ExitCode=' + IntToStr(BatExit))
            else
              Log('SyncOnly.bat: falha ao executar.');

            MarkRanToday(Slot);
            Log('Slot ' + Slot + ' concluído.');
          end
          else
          begin
            Log('Exportação FALHOU: ' + Erro);
            // Não marca como rodado -> tenta novamente até acabar a tolerância
          end;
        end;
      end;

    except
      on E: Exception do
        Log('EXCEPTION no loop: ' + E.Message);
    end;

    Sleep(15000); // 15s
  end;
end;

begin
  try
    ForceDir(OUT_REPO);
    PrepararBDE;

    if not EnsureSingleInstance then
      Halt(2);

    MainLoop;

  except
    on E: Exception do
    begin
      Log('FATAL: ' + E.Message);
      Halt(1);
    end;
  end;
end.
