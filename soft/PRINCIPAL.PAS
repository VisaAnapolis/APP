unit Principal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, jpeg, ComCtrls, Buttons, ToolWin, DB, DBTables, DateUtils;

type
  Tfrmprincipal = class(TForm)
    MainMenu1: TMainMenu;
    A1: TMenuItem;
    Sair1: TMenuItem;
    Estabe1: TMenuItem;
    Relatrios1: TMenuItem;
    StatusBar1: TStatusBar;
    Sobre1: TMenuItem;
    N2: TMenuItem;
    Denncias1: TMenuItem;
    Anotao1: TMenuItem;
    Andamento1: TMenuItem;
    tbsequencia: TTable;
    dssequencia: TDataSource;
    tbsequenciaDisponibilidade: TBooleanField;
    tbsequenciaVersao: TStringField;
    tbsequenciaDt_versao: TStringField;
    Lmarketing: TLabel;
    Image1: TImage;
    Lver: TLabel;
    Whats1: TMenuItem;
    tbsequenciaNumero: TIntegerField;
    tbsequenciaDoc: TIntegerField;
    tbsequenciaDen: TIntegerField;
    tbsequenciaAlvara: TIntegerField;
    tbsequenciaPt: TIntegerField;
    este11: TMenuItem;
    este21: TMenuItem;
    Dennciasporperodo1: TMenuItem;
    Peticionamento1: TMenuItem;
    RelatriodeDistribuio1: TMenuItem;
    abelas1: TMenuItem;
    gestor: TMenuItem;
    bairro: TMenuItem;
    OrdensdeOfcio1: TMenuItem;
    RelatrioOSOfcio1: TMenuItem;
    GeraaoemBloco1: TMenuItem;
    N4: TMenuItem;
    Total: TMenuItem;
    Pro: TMenuItem;
    N1: TMenuItem;
    ProtocolosporFiscal1: TMenuItem;
    Arquivo1: TMenuItem;
    N3: TMenuItem;
    DennciasporFiscal1: TMenuItem;
    RPF1: TMenuItem;
    RelatrioMensaldeProduoFiscal1: TMenuItem;
    cnar: TMenuItem;
    usr: TMenuItem;
    TimerInatividade: TTimer;
    OrdensUrgentes1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Estabe1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure Processos2Click(Sender: TObject);
    procedure Anadamentos1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Anotao1Click(Sender: TObject);
    procedure Andamento1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Estabelecimentosnoclassificados1Click(Sender: TObject);
    procedure Re1Click(Sender: TObject);
    procedure LverClick(Sender: TObject);
    procedure ConsolidadoMensal1Click(Sender: TObject);
    procedure RDPF1Click(Sender: TObject);
    procedure Registro1Click(Sender: TObject);
    procedure Andamento2Click(Sender: TObject);
    procedure Whats1Click(Sender: TObject);
    procedure este11Click(Sender: TObject);
    procedure este21Click(Sender: TObject);
    procedure Dennciasporperodo1Click(Sender: TObject);
    procedure OrdensdeServio1Click(Sender: TObject);
    procedure DennciasEncaminhadas1Click(Sender: TObject);
    procedure RelatriodeDistribuio1Click(Sender: TObject);
    procedure Peticionamento1Click(Sender: TObject);
    procedure gestorClick(Sender: TObject);
    procedure bairroClick(Sender: TObject);
    procedure Setores1Click(Sender: TObject);
    procedure Bairros1Click(Sender: TObject);
    procedure Numerao1Click(Sender: TObject);
    procedure RDPF2Click(Sender: TObject);
    procedure MesesFechados1Click(Sender: TObject);
    procedure OrdensdeOfcio1Click(Sender: TObject);
    procedure OrdesdeOfcios1Click(Sender: TObject);
    procedure Processos1Click(Sender: TObject);
    procedure RelatrioOSOfcio1Click(Sender: TObject);
    procedure GeraaoemBloco1Click(Sender: TObject);
    procedure TotalClick(Sender: TObject);
    procedure OrdensdeRetorno1Click(Sender: TObject);
    procedure ProClick(Sender: TObject);
    procedure ProtocolosporFiscal1Click(Sender: TObject);
    procedure DennciasporFiscal1Click(Sender: TObject);
    procedure RelatrioMensaldeProduoFiscal1Click(Sender: TObject);
    procedure usrClick(Sender: TObject);
    procedure cnarClick(Sender: TObject);
    procedure TimerInatividadeTimer(Sender: TObject);
//     procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OrdensUrgentes1Click(Sender: TObject);
  private
    FLastActivity: TDateTime;
    procedure WMMostraAvisoInatividade(var Msg: TMessage); message WM_USER + 100;
  public
    versao:string;
    nova_data:boolean;
  end;

var
  frmprincipal: Tfrmprincipal;

implementation

uses sobre, ESTABE, alvara, login, denuncia, Locpro,  f_relaespecifica,
  f_relativ, atendimento, what, consolidado, rdpf, protocolo,
  r_retorno, concatena, denpend, os, relarequerimento, reladenuncias,
  r_fiscal, rdpfvelho, oficio, relofpen, relptpen, r_oficio, gera, pendencia,
  relretpen, consultapt, relaoficio, r_protocolo, r_fisden, ParamLogin,
  ParamBairro, ParamCnae, ParamSequencia, AVISOINAT, r_osurg;

const
  INATIVIDADE_PRINCIPAL_SEGUNDOS = 1800;


{$R *.DFM}

function PortugueseDateToDate(const S: string): TDateTime;
var
  partes: TStringList;
  dia, mes, ano: Integer;
  nomeMes: string;
begin
  Result := 0;
  partes := TStringList.Create;
  try
    partes.Delimiter     := ' ';
    partes.DelimitedText := S;
    // espera: "4 de abril de 2026"  ? índices 0..4
    if partes.Count < 5 then Exit;

    dia     := StrToIntDef(partes[0], 0);
    nomeMes := LowerCase(partes[2]);
    ano     := StrToIntDef(partes[4], 0);

    if (dia = 0) or (ano = 0) then Exit;

    if      nomeMes = 'janeiro'   then mes :=  1
    else if nomeMes = 'fevereiro' then mes :=  2
    else if nomeMes = 'março'     then mes :=  3
    else if nomeMes = 'abril'     then mes :=  4
    else if nomeMes = 'maio'      then mes :=  5
    else if nomeMes = 'junho'     then mes :=  6
    else if nomeMes = 'julho'     then mes :=  7
    else if nomeMes = 'agosto'    then mes :=  8
    else if nomeMes = 'setembro'  then mes :=  9
    else if nomeMes = 'outubro'   then mes := 10
    else if nomeMes = 'novembro'  then mes := 11
    else if nomeMes = 'dezembro'  then mes := 12
    else Exit;

    Result := EncodeDate(ano, mes, dia);
  finally
    partes.Free;
  end;
end;

procedure Tfrmprincipal.Sair1Click(Sender: TObject);
begin
tbsequencia.close;
//tbdenuncia.Close;
// tbreq.close;
Application.terminate;
end;

procedure Tfrmprincipal.Estabe1Click(Sender: TObject);
begin
  tbsequencia.Refresh;
  if tbsequenciadisponibilidade.Value = False then
  begin
    ShowMessage('Sistema em manutenção. Tente novamente em instantes.');
    Exit;
  end;
  frmlocpro.ShowModal;
end;

procedure Tfrmprincipal.Sobre1Click(Sender: TObject);
begin
Aboutbox.showmodal;
end;

procedure Tfrmprincipal.Processos2Click(Sender: TObject);
begin
{  frmrelativ.showmodal;}
end;

procedure Tfrmprincipal.Anadamentos1Click(Sender: TObject);
begin
frmretorno.showmodal;
//messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
end;

procedure Tfrmprincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
tbsequencia.close;
//tbdenuncia.close;
// tbreq.close;
Application.terminate;
end;

procedure Tfrmprincipal.Anotao1Click(Sender: TObject);
begin
frmdenuncia.showmodal;
end;

procedure Tfrmprincipal.Andamento1Click(Sender: TObject);
begin
frmatendimento.showmodal;
end;

procedure Tfrmprincipal.FormActivate(Sender: TObject);
begin

//  FLastActivity := Now;
// ? só na primeira vez
    if FLastActivity = 0 then  FLastActivity := Now;
    tbsequencia.Open;
    versao:= '9.29';
    lver.caption:='versão: '+versao;
    if tbsequenciadisponibilidade.value = false then
    begin
      messagedlg('Caro usuário, Sistema em Manutenção. Tente mais tarde!',mtwarning,[mbok],0);
      Sair1Click(sender);
    end;

  if tbsequenciaversao.value <> versao then
    begin
      messagedlg('Voce esta utilizando a versão:  '+versao+' , que está desatualizada. Já está disponível a versão:  '+tbsequenciaversao.value+' desde '+tbsequenciadt_versao.value+'.',mtwarning,[mbok],0);
      Sair1Click(sender);
    end;


   // Exibe novidades por 1 dia após atualização de versão

  if tbsequenciadt_versao.Value <> '' then
  begin
    if DaysBetween(Date, PortugueseDateToDate(tbsequenciadt_versao.Value)) <= 1 then
     LverClick(Sender);
  end;

    if frmlogin.c_grp = 'ADM' then
    begin
//       OrdensdeServio1Click(Sender);
    end;


    if frmlogin.c_grp = 'FIS' then
    begin
//          OrdensdeServio1Click(Sender);
//          DennciasEncaminhadas1Click(sender);
//          messagedlg('Atenção!!! Devido a prestação de contas ao RH, o registro das inspeções deverá ser realizado no máximo em 24 (vinte e quatro) horas e a geração do Relatório de Produçao Fiscal com a entrega da documentação comprobatória em até 72 (setenta e duas) horas.',mtwarning,[mbok],0);
    end;
//=========================
if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then  TotalClick(sender);
//============================




    if frmlogin.c_grp = 'CAD' then
    begin
 //       messagedlg('Caro usuário, é necessário encaminhar à gerência os REQUERIMENTOS/PETIÇÕES não autorizados para seu perfil',mtwarning,[mbok],0);
    end;

//    messagedlg('Caro usuário, lembramos que a cada nova de versão, as novidades/mudanças são descritas no histórico de revisão desde 2018. Para acompanhar, basta clicar no número da versão na tela inicial ',mtwarning,[mbok],0);
end;

procedure Tfrmprincipal.Estabelecimentosnoclassificados1Click(
  Sender: TObject);
begin
messagedlg('Módulo descontinuado',mtwarning,[mbok],0);
// frmrelespecifica.showmodal;
end;

procedure Tfrmprincipal.Re1Click(Sender: TObject);
begin
// frmrelareq.showmodal;
messagedlg('Módulo descontinuado',mtwarning,[mbok],0);
end;
procedure Tfrmprincipal.LverClick(Sender: TObject);
begin
f_what.showmodal;
end;

procedure Tfrmprincipal.ConsolidadoMensal1Click(Sender: TObject);
begin
//frmconso.shoWmodal;
messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
end;

procedure Tfrmprincipal.RDPF1Click(Sender: TObject);
begin
//messagedlg('Módulo descontinuado',mtwarning,[mbok],0);
{    if (frmlogin.c_grp = 'FIS') or  (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO') then
    begin
        nova_data:=true;
        frmrdpf.showmodal;
    end
    else showmessage('Usuário não autorizado');

    }
end;

{    if (frmlogin.c_grp = 'FIS') or  (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO') then
    begin
        nova_data:=true;
        frmrdpf.showmodal;
    end
    else showmessage('Usuário não autorizado');
 }
procedure Tfrmprincipal.Registro1Click(Sender: TObject);
begin
frmproto.showmodal;
end;

procedure Tfrmprincipal.Andamento2Click(Sender: TObject);
begin
messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
end;

procedure Tfrmprincipal.Whats1Click(Sender: TObject);
begin
f_what.showmodal;
end;

procedure Tfrmprincipal.este11Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or  (frmlogin.c_grp = 'ADM') then frmretorno.ShowModal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.este21Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or  (frmlogin.c_grp = 'ADM') then frmrelativ.ShowModal else  showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.Dennciasporperodo1Click(Sender: TObject);
begin
    if frmlogin.c_grp = 'ADM' then frmdenpen.showmodal else
    begin
       showmessage('Usuário não autorizado');
       exit;
    end;
end;

procedure Tfrmprincipal.OrdensdeServio1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or  (frmlogin.c_grp = 'ADM') then
     begin
        rel_req.tbreq.Open;
        rel_req.tbcontrib.Open;
        rel_req.tbbairro.open;
        rel_req.tbcnae.open;
        rel_req.tbalvara.open;
        rel_req.QRLFiscal.Caption  := frmlogin.c_user;
        rel_req.tbreq.Filter       := 'Fiscal_encaminha ='+ quotedstr(frmlogin.c_user)+' and Atendimento <> true'+' and Cancelado <> true';
        rel_req.qrreq.PreviewModal;
        rel_req.tbalvara.close;
        rel_req.tbcnae.close;
        rel_req.tbbairro.close;
        rel_req.tbcontrib.Close;
        rel_req.tbreq.close;
     end
     else showmessage('Usuário não autorizado');


end;

procedure Tfrmprincipal.DennciasEncaminhadas1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then
    begin
         rel_denpen.tbdenuncia.open;
         rel_denpen.tbbairro.open;
         rel_denpen.QRLFiscal.Caption     := frmlogin.c_user;
         rel_denpen.tbdenuncia.Filter     := 'Fiscalencaminha ='+ quotedstr(frmlogin.c_user)+' and Archive <> true';
         rel_denpen.QRDenpen.PreviewModal;
         rel_denpen.tbbairro.close;
         rel_denpen.tbdenuncia.close;
    end
    else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.RelatriodeDistribuio1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then frmfiscal.showmodal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.Peticionamento1Click(Sender: TObject);
begin
frmos.ShowModal;
end;

procedure Tfrmprincipal.gestorClick(Sender: TObject);
begin
if frmlogin.c_grp = 'ADM' then frmParamSequencia.ShowModal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.bairroClick(Sender: TObject);
begin
if frmlogin.c_grp = 'ADM' then frmParamBairro.ShowModal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.Setores1Click(Sender: TObject);
begin
messagedlg('Função em fase de desenvolvimento',mtwarning,[mbok],0);
end;

procedure Tfrmprincipal.Bairros1Click(Sender: TObject);
begin
messagedlg('Função em fase de desenvolvimento',mtwarning,[mbok],0);
end;

procedure Tfrmprincipal.Numerao1Click(Sender: TObject);
begin
messagedlg('Função em fase de desenvolvimento',mtwarning,[mbok],0);
end;

procedure Tfrmprincipal.RDPF2Click(Sender: TObject);
begin
nova_data:=true;
frmrdpf.showmodal;
end;

procedure Tfrmprincipal.MesesFechados1Click(Sender: TObject);
begin
frmrdpfvelho.showmodal ;
end;

procedure Tfrmprincipal.OrdensdeOfcio1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') or (frmlogin.c_per = 'PRO') then frmoficio.showmodal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.OrdesdeOfcios1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then
    begin
{         rel_ofpen.tboficio.open;
         rel_ofpen.tbbairro.open;
         rel_ofpen.QRLFiscal.Caption   := frmlogin.c_user;
         rel_ofpen.tboficio.Filter     := 'motivo <>'+quotedstr('RETORNO')+' and '+'Fiscalencaminha ='+ quotedstr(frmlogin.c_user)+' and Archive <> true'+' and Cancela <> true';
         rel_ofpen.repoficio.PreviewModal;
         rel_ofpen.tbbairro.close;
         rel_ofpen.tboficio.close; }
        rel_ofi.tbofi.Open;
        rel_ofi.tbbairro.open;
        rel_ofi.QRLFiscal.Caption  := frmlogin.c_user;
        rel_ofi.tbofi.Filter       := 'motivo <>'+quotedstr('RETORNO')+' and '+'Fiscalencaminha ='+ quotedstr(frmlogin.c_user) +' and Archive <> true'+' and Cancela <> true';
        rel_ofi.qrofi.PreviewModal;
        rel_ofi.tbbairro.close;
        rel_ofi.tbofi.close;
    end;


end;

procedure Tfrmprincipal.Processos1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then
    begin
         rel_ptpen.tbprotocolo.open;
         rel_ptpen.tbcontrib.open;
         rel_ptpen.tbtramita.open;
         rel_ptpen.QRLFiscal.Caption      := frmlogin.c_user;
         rel_ptpen.tbprotocolo.Filter     := 'Carga ='+ quotedstr(frmlogin.c_user);
         rel_ptpen.repptpen.PreviewModal;
         rel_ptpen.tbtramita.open;
         rel_ptpen.tbcontrib.close;
         rel_ptpen.tbprotocolo.close;
    end
    else showmessage('Usuário não autorizado');

end;

procedure Tfrmprincipal.RelatrioOSOfcio1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then frmosof.showmodal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.GeraaoemBloco1Click(Sender: TObject);
begin
//  if frmlogin.c_user = 'CLÁUDIO NASCIMENTO SILVA' then frmgera.showmodal else showmessage('Em desenvolvimento');
showmessage('Em desenvolvimento')
end;

procedure Tfrmprincipal.TotalClick(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then frmpendencia.ShowModal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.OrdensdeRetorno1Click(Sender: TObject);
begin
    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then
    begin
        { rel_retpen.tboficio.open;
         rel_retpen.tbbairro.open;
         rel_retpen.QRLFiscal.Caption   := frmlogin.c_user;
         rel_retpen.tboficio.Filter     := 'motivo ='+quotedstr('RETORNO')+' and '+'Fiscalencaminha ='+ quotedstr(frmlogin.c_user)+' and Archive <> true'+' and Cancela <> true';
         rel_retpen.repretorno.PreviewModal;
         rel_retpen.tbbairro.close;
         rel_retpen.tboficio.close;  }
         rel_ofi.tbofi.Open;
        rel_ofi.tbbairro.open;
        rel_ofi.QRLFiscal.Caption  := frmlogin.c_user;
        rel_ofi.tbofi.Filter       := 'motivo ='+quotedstr('RETORNO')+' and '+'Fiscalencaminha ='+ quotedstr(frmlogin.c_user) +' and Archive <> true'+' and Cancela <> true';
        rel_ofi.qrofi.PreviewModal;
        rel_ofi.tbbairro.close;
        rel_ofi.tbofi.close;

         
    end
    else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.ProClick(Sender: TObject);
begin
frmconpt.showmodal;
end;

procedure Tfrmprincipal.ProtocolosporFiscal1Click(Sender: TObject);
begin
if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then frmospt.showmodal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.DennciasporFiscal1Click(Sender: TObject);
begin
if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then frmfisden.showmodal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.RelatrioMensaldeProduoFiscal1Click(
  Sender: TObject);
begin
 if (frmlogin.c_grp = 'FIS') or  (frmlogin.c_grp = 'ADM') then frmrdpf.ShowModal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.usrClick(Sender: TObject);
begin
if frmlogin.c_grp = 'ADM' then frmParamLogin.ShowModal else showmessage('Usuário não autorizado');
end;

procedure Tfrmprincipal.cnarClick(Sender: TObject);
begin
if frmlogin.c_grp = 'ADM' then frmParamCnae.ShowModal else showmessage('Usuário não autorizado');
end;
 {
procedure Tfrmprincipal.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  FLastActivity := Now;
end;
  }
procedure Tfrmprincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FLastActivity := Now;
end;

procedure Tfrmprincipal.WMMostraAvisoInatividade(var Msg: TMessage);
var
  Aviso: TfrmAvisoInatividade;
begin
  // Chamado via PostMessage — todos os modais já fecharam de verdade
  Aviso := TfrmAvisoInatividade.Create(nil);
  try
    Aviso.ShowModal;
    if Aviso.ModalResult = mrCancel then
    begin
      FLastActivity := Now;
      TimerInatividade.Enabled := True;
    end
    else
      Application.Terminate;
  finally
    Aviso.Free;
  end;
end;

procedure Tfrmprincipal.TimerInatividadeTimer(Sender: TObject);
begin
  if SecondsBetween(Now, FLastActivity) < INATIVIDADE_PRINCIPAL_SEGUNDOS then Exit;


  TimerInatividade.Enabled := False;

  // frmos — cancela edição se houver
  if Assigned(frmos) and frmos.Visible then begin
    if frmos.tbreq.Active and (frmos.tbreq.State in [dsEdit, dsInsert]) then frmos.tbreq.Cancel;
    if frmos.tbcontrib.Active and (frmos.tbcontrib.State in [dsEdit, dsInsert]) then frmos.tbcontrib.Cancel;
  end;

  // frmoficio — cancela edição se houver
  if Assigned(frmoficio) and frmoficio.Visible then
    if frmoficio.tboficio.Active and (frmoficio.tboficio.State in [dsEdit, dsInsert]) then frmoficio.tboficio.Cancel;

  // frmdenuncia — cancela edição se houver
  if Assigned(frmdenuncia) and frmdenuncia.Visible then
    if frmdenuncia.tbdenuncia.Active and (frmdenuncia.tbdenuncia.State in [dsEdit, dsInsert]) then frmdenuncia.tbdenuncia.Cancel;

  // frmatendimento — cancela edição se houver
  if Assigned(frmatendimento) and frmatendimento.Visible then begin
    if frmatendimento.tbatend.Active and (frmatendimento.tbatend.State in [dsEdit, dsInsert]) then frmatendimento.tbatend.Cancel;
    if frmatendimento.tbdenuncia.Active and (frmatendimento.tbdenuncia.State in [dsEdit, dsInsert]) then frmatendimento.tbdenuncia.Cancel;
  end;

  // frmrdpf — cancela edição se houver
  if Assigned(frmrdpf) and frmrdpf.Visible then begin
    if frmrdpf.tbrdpf.Active and (frmrdpf.tbrdpf.State in [dsEdit, dsInsert]) then frmrdpf.tbrdpf.Cancel;
    if frmrdpf.tbrmpf.Active and (frmrdpf.tbrmpf.State in [dsEdit, dsInsert]) then frmrdpf.tbrmpf.Cancel;
    if frmrdpf.tbrcon.Active and (frmrdpf.tbrcon.State in [dsEdit, dsInsert]) then frmrdpf.tbrcon.Cancel;
  end;



  // frmParamLogin — cancela edição se houver
   if Assigned(frmParamLogin) and frmParamLogin.Visible then
    if frmParamLogin.Tb.Active and (frmParamLogin.Tb.State in [dsEdit, dsInsert]) then frmParamLogin.Tb.Cancel;

  // ParamSequencia — cancela edição se houver
  if Assigned(frmParamSequencia) and frmParamSequencia.Visible then
    if frmParamSequencia.Tb.Active and (frmParamSequencia.Tb.State in [dsEdit, dsInsert]) then frmParamSequencia.Tb.Cancel;

  // frmParamBairro — cancela edição se houver
  if Assigned(frmParamBairro) and frmParamBairro.Visible then
    if frmParamBairro.Tb.Active and (frmParamBairro.Tb.State in [dsEdit, dsInsert]) then frmParamBairro.Tb.Cancel;

  // frmParamCnae — cancela edição se houver
  if Assigned(frmParamCnae) and frmParamCnae.Visible then
    if frmParamCnae.Tb.Active and (frmParamCnae.Tb.State in [dsEdit, dsInsert]) then frmParamCnae.Tb.Cancel;

  // frmestabe — cancela edição se houver (via frmlocpro que o contém)
  if Assigned(frmestabe) and frmestabe.Visible then begin
    if frmestabe.tbrt.Active         and (frmestabe.tbrt.State         in [dsEdit, dsInsert]) then frmestabe.tbrt.Cancel;
    if frmestabe.tbhistorico.Active  and (frmestabe.tbhistorico.State  in [dsEdit, dsInsert]) then frmestabe.tbhistorico.Cancel;
    if frmestabe.tbreq.Active        and (frmestabe.tbreq.State        in [dsEdit, dsInsert]) then frmestabe.tbreq.Cancel;
    if frmestabe.tboficio.Active     and (frmestabe.tboficio.State     in [dsEdit, dsInsert]) then frmestabe.tboficio.Cancel;
    if frmestabe.tbtramitacao.Active and (frmestabe.tbtramitacao.State in [dsEdit, dsInsert]) then frmestabe.tbtramitacao.Cancel;
    if frmestabe.tbplanta.Active     and (frmestabe.tbplanta.State     in [dsEdit, dsInsert]) then frmestabe.tbplanta.Cancel;
    if frmestabe.tbalvlib.Active     and (frmestabe.tbalvlib.State     in [dsEdit, dsInsert]) then frmestabe.tbalvlib.Cancel;
    if frmestabe.tbveiculo.Active    and (frmestabe.tbveiculo.State    in [dsEdit, dsInsert]) then frmestabe.tbveiculo.Cancel;
    if frmestabe.tbvisitas.Active    and (frmestabe.tbvisitas.State    in [dsEdit, dsInsert]) then frmestabe.tbvisitas.Cancel;
    if frmestabe.tbalvara.Active     and (frmestabe.tbalvara.State     in [dsEdit, dsInsert]) then frmestabe.tbalvara.Cancel;
    if frmestabe.tbcontrib.Active    and (frmestabe.tbcontrib.State    in [dsEdit, dsInsert]) then frmestabe.tbcontrib.Cancel;
  end;

   // AvisoInatividade abre como modal aninhado sobre qualquer form em curso
  PostMessage(Handle, WM_USER + 100, 0, 0);

  end;



procedure Tfrmprincipal.OrdensUrgentes1Click(Sender: TObject);
begin
if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM') then frmosurg.showmodal else showmessage('Usuário não autorizado');
end;

end.
