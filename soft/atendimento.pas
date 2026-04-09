unit atendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, DBCtrls, ComCtrls, ExtCtrls, Buttons,
  ToolWin, Mask, Grids, DBGrids, QuickRpt, dateutils;

type
  Tfrmatendimento = class(TForm)
    GBRecl: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdata: TDBEdit;
    DBEreclamado: TDBEdit;
    DBElogradouro: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    barraferra: TToolBar;
    btaltera: TSpeedButton;
    btlocpro: TSpeedButton;
    btgrava: TSpeedButton;
    btcancel: TSpeedButton;
    btfecha: TSpeedButton;
    bthelp: TSpeedButton;
    navegador: TDBNavigator;
    StatusBar1: TStatusBar;
    tbdenuncia: TTable;
    tbdenunciaControle: TAutoIncField;
    tbdenunciaDenuncia: TIntegerField;
    tbdenunciaData: TDateField;
    tbdenunciaReclamado: TStringField;
    tbdenunciaLogradouro: TStringField;
    tbdenunciaReferencia: TStringField;
    tbdenunciaArea: TStringField;
    tbdenunciaObjeto1: TStringField;
    tbdenunciaCdbai: TSmallintField;
    dsdenuncia: TDataSource;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    dsbairro: TDataSource;
    GBatend: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    DBERetorno: TDBEdit;
    DBCFiscal1: TDBComboBox;
    DBMObs: TDBMemo;
    DBCtipo: TDBComboBox;
    Label12: TLabel;
    tbdenunciaCpf: TStringField;
    tbdenunciaCnpj: TStringField;
    DBEdoc: TDBEdit;
    Label14: TLabel;
    GradeDEN: TDBGrid;
    tbatend: TTable;
    tbatendControle: TAutoIncField;
    tbatendDenuncia: TIntegerField;
    tbatendData_atendimento: TDateField;
    tbatendPrazo: TIntegerField;
    tbatendData_retorno: TDateField;
    tbatendFiscal1: TStringField;
    tbatendFiscal2: TStringField;
    tbatendFiscal3: TStringField;
    tbatendObs: TMemoField;
    tbatendTipodoc: TStringField;
    dsatend: TDataSource;
    DBCFiscal2: TDBComboBox;
    DBCFiscal3: TDBComboBox;
    Label1: TLabel;
    DBECPF: TDBEdit;
    DBEcgc: TDBEdit;
    Label13: TLabel;
    DBEpz: TDBEdit;
    Label7: TLabel;
    PainelVisita: TPanel;
    btnovvisita: TSpeedButton;
    btaltvisita: TSpeedButton;
    btgravisita: TSpeedButton;
    btcanvisita: TSpeedButton;
    btdelvisita: TSpeedButton;
    DBEAtendimento: TDBEdit;
    Btarquiva: TSpeedButton;
    DBEdit2: TDBEdit;
    Texto_archive: TStaticText;
    tbdenunciaArchive: TBooleanField;
    tbdenunciaSatatus: TStringField;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    DBCSTATUS: TDBComboBox;
    tbatendH_inicio: TTimeField;
    tbatendH_fim: TTimeField;
    DBCencaminha: TDBComboBox;
    Label18: TLabel;
    Label19: TLabel;
    tbdenunciaSINAVISA: TIntegerField;
    tbdenunciaDescricao: TStringField;
    tbdenunciaUser: TStringField;
    tbdenunciaMeio: TStringField;
    tbdenunciaEmissao: TStringField;
    tbdenunciaDtEmite: TDateField;
    tbdenunciaDtEncaminha: TDateField;
    DBEDtencaminha: TDBEdit;
    STprazo: TStaticText;
    Label20: TLabel;
    DBCOb1: TDBComboBox;
    DBEDescri: TDBEdit;
    btprn: TSpeedButton;
    tbdenunciaFiscalAtend: TStringField;
    Label6: TLabel;
    DBEFiscalStatus: TDBEdit;
    tbdenunciaFiscalEncaminha: TStringField;
    tbatendNumdoc: TIntegerField;
    DBEdit1: TDBEdit;
    tbdenunciaPrazo: TDateField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsdenunciaStateChange(Sender: TObject);
    procedure btfechaClick(Sender: TObject);
    procedure bthelpClick(Sender: TObject);
    procedure btprnClick(Sender: TObject);
    procedure btcancelClick(Sender: TObject);
    procedure btlocproClick(Sender: TObject);
    procedure btalteraClick(Sender: TObject);
    procedure dsatendStateChange(Sender: TObject);
    procedure btnovvisitaClick(Sender: TObject);
    procedure btaltvisitaClick(Sender: TObject);
    procedure btgravisitaClick(Sender: TObject);
    procedure btcanvisitaClick(Sender: TObject);
    procedure btdelvisitaClick(Sender: TObject);
    procedure BtarquivaClick(Sender: TObject);
    procedure tbdenunciaAfterScroll(DataSet: TDataSet);
    procedure btgravaClick(Sender: TObject);
    procedure DBEpzExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBECPFExit(Sender: TObject);
    procedure DBEcgcExit(Sender: TObject);
    procedure DBEfimExit(Sender: TObject);
    procedure DBEAtendimentoExit(Sender: TObject);
    procedure DBCSTATUSChange(Sender: TObject);
    procedure DBCencaminhaChange(Sender: TObject);
    procedure DBCtipoChange(Sender: TObject);
    procedure DBCFiscal1Change(Sender: TObject);
    procedure DBCFiscal2Change(Sender: TObject);
    procedure DBCFiscal3Change(Sender: TObject);
  private
    arquivo:boolean;
  public

  end;

var
  frmatendimento: Tfrmatendimento;

implementation

uses login, locden, sobre, CPFeCGC, reldenuncia;

{$R *.dfm}

procedure Tfrmatendimento.FormActivate(Sender: TObject);
begin
arquivo:=false;
tbbairro.open;
tbdenuncia.Open;
tbdenuncia.last;
tbatend.Open;
//navegador.setfocus;
if (frmlogin.c_grp='ADM') or (frmlogin.c_per='ORD')
then
begin
//    DBEDtencaminha.Enabled:=true;
    DBCencaminha.Enabled:=true;
//    navegador.Enabled:=true;
end
else
begin
//   DBEDtencaminha.Enabled:=false;
    DBCencaminha.Enabled:=false;
//    navegador.Enabled:=false;
end;
{
if tbdenunciadtencaminha.Isnull    then STprazo.Caption:='Não Distribuída' else STprazo.Caption:=floattostr(secondsbetween(date,tbdenunciadtencaminha.value)/86400);
if tbatenddata_retorno.isnull      then STpazret.caption:='        '       else if tbatenddata_retorno.value < date then STpazret.caption:=floattostr(secondsbetween(date,tbatenddata_retorno.value)/86400) else STpazret.caption:='a vencer';
if tbdenunciaarchive.Value = true then STpazret.caption:='        ';
if tbdenunciaarchive.Value = true then texto_archive.visible := true else texto_archive.visible := false;
showmessage('Atenção! Favor complementar todos os dados do reclamado(se conhecido) antes de incluir documentos.');
}
end;

procedure Tfrmatendimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
tbatend.Close;
tbbairro.Close;
tbatend.Close;
tbdenuncia.Close;

end;

procedure Tfrmatendimento.dsdenunciaStateChange(Sender: TObject);
begin
if tbdenuncia.state=dsbrowse then statusbar1.panels[0].text:=' [F1] Ajuda   [F2] Pesquisa   [F3] Inclusão   [F4] Alteração ' else statusbar1.panels[0].text:=' [F6] Grava   [ESC] Cancela';
GBatend.enabled      := tbdenuncia.state =  dsbrowse;
btaltera.enabled     := tbdenuncia.state =  dsbrowse;
btlocpro.enabled     := tbdenuncia.state =  dsbrowse;
btgrava.enabled      := tbdenuncia.state <> dsbrowse;
btcancel.enabled     := tbdenuncia.state <> dsbrowse;
painelvisita.enabled := tbdenuncia.state =  dsbrowse;
btfecha.enabled      := tbdenuncia.state =  dsbrowse;
bthelp.enabled       := tbdenuncia.state =  dsbrowse;
navegador.enabled    := tbdenuncia.state =  dsbrowse;

end;

procedure Tfrmatendimento.btfechaClick(Sender: TObject);
begin
close;
end;

procedure Tfrmatendimento.bthelpClick(Sender: TObject);
begin
{  messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);}
aboutbox.showmodal;
    navegador.setfocus;

end;

procedure Tfrmatendimento.btprnClick(Sender: TObject);
var
volta:integer;
begin
//messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
volta:=tbdenunciacontrole.value;
Rel_ptden.tbbairro.open;
Rel_ptden.tbsinavisa.open;
Rel_ptden.tbdenuncia.open;
Rel_ptden.tbdenuncia.findkey([tbdenunciacontrole.value]);
Rel_ptden.repdenuncia.preview;
Rel_ptden.tbbairro.Close;
Rel_ptden.tbsinavisa.close;
Rel_ptden.tbdenuncia.Close;
Rel_ptden.Close;
navegador.setfocus;
tbdenuncia.edit;
tbdenunciaemissao.value:=frmlogin.c_user;
tbdenunciadtemite.value:=date;
tbdenuncia.post;
tbdenuncia.findkey([volta])

end;

procedure Tfrmatendimento.btcancelClick(Sender: TObject);
begin
tbdenuncia.Cancel;
navegador.setfocus;
end;

procedure Tfrmatendimento.btlocproClick(Sender: TObject);
begin
{ messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
    navegador.setfocus;}
   frmlocden.ShowModal;
   tbdenuncia.findkey([frmlocden.lugarden]);
end;

procedure Tfrmatendimento.btalteraClick(Sender: TObject);
begin

if frmlogin.c_grp <> 'CON'  then
begin

    if tbdenunciaarchive.value = true then
    begin
        showmessage('Denúncia Arquivada. Impossível alterar!');
        exit;
    end;

    tbdenuncia.Edit;
    if tbdenunciaDtEncaminha.IsNull then tbdenunciaDtEncaminha.value := date; 
    if frmlogin.c_grp = 'FIS' then tbdenunciafiscalatend.Value:=frmlogin.c_user;
    DBCSTATUS.setfocus;
end
else showmessage('Função não permitida para este usuário');

end;

procedure Tfrmatendimento.dsatendStateChange(Sender: TObject);
begin
navegador.enabled   := tbatend.state =  dsbrowse;
GBRecl.enabled      := tbatend.state =  dsbrowse;
GradeDEN.Enabled    := tbatend.state =  dsbrowse;
btnovvisita.enabled := tbatend.state =  dsbrowse;
btaltvisita.enabled := tbatend.state =  dsbrowse;
btarquiva.enabled   := tbatend.state =  dsbrowse;
btgravisita.enabled := tbatend.state <> dsbrowse;
btcanvisita.enabled := tbatend.state <> dsbrowse;
btdelvisita.enabled := tbatend.state =  dsbrowse;
barraferra.enabled  := tbatend.state =  dsbrowse;
if tbatend.state    <> dsbrowse then barraferra.Color := clmoneygreen;
if tbatend.state    = dsbrowse then barraferra.Color := clBtnFace;

end;

procedure Tfrmatendimento.btnovvisitaClick(Sender: TObject);
begin
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS')  then
begin
    if frmlogin.c_user <> tbdenunciafiscalencaminha.Value then
    begin
        showmessage('Denúncia não encaminhada para este fiscal!');
        exit;
    end;

    if tbdenunciaarchive.value = true then
    begin
        showmessage('Denúncia Arquivada. Impossível alterar!');
        exit;
    end;
    if tbdenunciasatatus.isnull then
    begin
        showmessage('Informar o parcecer, CPF/CNPJ e Nome Completo se houver, antes de incluir documento.');
        exit;
    end;
    tbatend.insert;
    tbatendfiscal1.value:=frmlogin.c_user;
    tbatenddata_atendimento.value:=date;
    DBEAtendimento.setfocus;
end
else showmessage('Função permitida somente para pessoal técnico');
end;


procedure Tfrmatendimento.btaltvisitaClick(Sender: TObject);
begin
    if frmlogin.c_user <> tbdenunciafiscalencaminha.Value then
    begin
        showmessage('Denúncia não encaminhada para este fiscal!');
        exit;
    end;
    if tbdenunciaarchive.value = true then
    begin
        showmessage('Denúncia Arquivada. Impossível alterar!');
        exit;
    end;
if (frmlogin.c_user = tbatendfiscal1.value) or (frmlogin.c_user = tbatendfiscal2.value) or (frmlogin.c_user = tbatendfiscal3.value) or (frmlogin.c_grp = 'ADM') or (frmlogin.c_per='ORD') then
begin
    tbatend.edit;
    DBEAtendimento.setfocus;
end
else showmessage('Usuário não autorizado!');
end;


procedure Tfrmatendimento.btgravisitaClick(Sender: TObject);
begin

    if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_user <> tbdenunciafiscalencaminha.Value) then
    begin
        showmessage('Denúncia não encaminhada para este fiscal!');
        exit;
    end;

        if tbatenddata_atendimento.IsNull then
        begin
            showmessage('Caro Usuário, favor informar A Data de Atendimento');
            DBEAtendimento.setfocus;
            exit;
        end;

{        if tbatendh_inicio.IsNull then
        begin
            showmessage('Caro Usuário, favor informar horário do início do atendimento');
            DBEAtendimento.setfocus;
            exit;
        end;

        if tbatendh_fim.IsNull then
        begin
            showmessage('Caro Usuário, favor informar horário do fim do atendimento');
            DBEAtendimento.setfocus;
            exit;
        end;

if (tbatendh_fim.value > time) and (tbatenddata_atendimento.value = date) then
   begin
      showmessage('Hora do fim da visita inválida!');
      exit;
   end;

   if (tbatendh_fim.value = tbatendh_inicio.value) and (arquivo = false)  then
        begin
              showmessage('Final da Inspeção igual ao início');
              exit;
        end;

       if secondsbetween(tbatendh_inicio.value,0) < 25200 then
        begin
              showmessage('Início da Inspeção anterior ao início do expediente');
              exit;
        end;

      if secondsbetween(tbatendh_inicio.value,0) > 79200 then
        begin
              showmessage('Início da Inspeção posterior ao final do expediente');
              exit;
        end;

       if secondsbetween(tbatendh_fim.value,0) > 79200 then
        begin
              showmessage('Final da Inspeção posterior ao final do expediente');
              exit;
        end;
       }


   if tbatenddata_atendimento.value > date then
   begin
        showmessage('Data da Inspeção inválida!');
        exit;
   end;

   if tbatenddata_atendimento.value < tbdenunciadata.value then
   begin
        showmessage('Data da Inspeção Anterior a da Denúncia!');
        exit;
   end;


   if (daysbetween(date,tbatenddata_atendimento.value) > 7) and (frmlogin.c_grp <> 'ADM') then
   begin
        showmessage('Data intempestiva para inclusão/alteração de insepeções!');
        exit;
   end;


        if tbatendprazo.IsNull then
        begin
            showmessage('Caro Usuário, favor informar O Prazo do documento');
            DBEpz.setfocus;
            exit;
        end;

        if (tbatendfiscal1.isnull) and (tbatendfiscal2.isnull) and (tbatendfiscal3.isnull) then
        begin
            showmessage('Caro Usuário, favor informar Pelo menos um fiscal atendente à denúncia');
            DBCFiscal1.setfocus;
            exit;
        end;

        if tbatendtipodoc.IsNull then
        begin
            showmessage('Caro Usuário, favor informar qual documento foi emitido');
            DBCtipo.setfocus;
            exit;
        end;

        if (tbatendtipodoc.value <> 'CERTIDÃO') and (tbatendtipodoc.value <> 'Arquivamento')  then
        begin
            if (tbdenunciacpf.isnull) and (tbdenunciacnpj.isnull) then
            begin
                showmessage('Caro Usuário, é necessário informar o CPF/CNPJ e Nome Completo para tipo de documento selecionado');
                DBCtipo.setfocus;
                exit;
            end;
        end;

        if (tbatendnumdoc.IsNull) and (arquivo=false) then
        begin
            showmessage('Caro Usuário, favor informar o número do documento');
            DBEdoc.setfocus;
            exit;
        end;


tbatend.post;
if arquivo = true then
begin
   tbdenuncia.edit;
   tbdenunciaarchive.value:=true;
   tbdenuncia.post;
end;

end;

procedure Tfrmatendimento.btcanvisitaClick(Sender: TObject);
begin
arquivo:=false;
tbatend.Cancel;
end;

procedure Tfrmatendimento.btdelvisitaClick(Sender: TObject);
begin

     if messagedlg('Confirma a Exclusão do Atendimento da Denúncia :'+#13+ tbatenddenuncia.AsString + '?',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin
             if (frmlogin.c_user = tbatendfiscal1.value) or (frmlogin.c_user = tbatendfiscal2.value) or (frmlogin.c_user = tbatendfiscal3.value) then
             begin
                     if not tbatend.Eof then tbatend.Delete else showmessage('Não Há Documento a ser Excluído!');
             end
             else showmessage('Usuário não autorizado!');
     end;


end;

procedure Tfrmatendimento.BtarquivaClick(Sender: TObject);
begin
     if messagedlg('Confirma a Arquivamento da Denúncia nº:'+#13+ tbdenunciadenuncia.AsString + ' ? ',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin
             if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'ORD') or (frmlogin.c_user = tbdenunciafiscalencaminha.Value  ) then
             begin
                 arquivo:=true;
                 tbatend.Insert;
                 tbatenddata_atendimento.value:=date;
                 tbatendh_inicio.value:=time;
                 tbatendh_fim.value:=time;
                 tbatendprazo.value:=0;
                 tbatendtipodoc.Value:='Arquivamento';
                 tbatendobs.value:='Arquivado nesta data';
                 tbatendfiscal1.value:=frmlogin.c_user;
                 dbmobs.setfocus;
                 if tbdenunciaarchive.Value = true then texto_archive.visible := true else texto_archive.visible := false;
             end
             else showmessage('Arquivamento: Favor Encaminhar Para o Setor de Denúncias');
     end;
end;

procedure Tfrmatendimento.tbdenunciaAfterScroll(DataSet: TDataSet);
begin
if tbdenunciadtencaminha.Isnull    then STprazo.Caption:='               ' else STprazo.Caption:=floattostr(daysbetween(date,tbdenunciadtencaminha.value))+' dias';
if tbdenunciaarchive.Value = true  then STprazo.caption:='               ';
if tbdenunciaarchive.Value = true  then texto_archive.visible := true      else texto_archive.visible := false;

end;

procedure Tfrmatendimento.btgravaClick(Sender: TObject);
begin

        if tbdenuncialogradouro.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o logradouro da denúncia');
            DBElogradouro.setfocus;
            exit;
        end;

        if tbdenunciareclamado.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o nome do reclamado. Se desconhecido informar "Desconhecido"!');
            DBEreclamado.setfocus;
            exit;
        end;

        if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_per <> 'ORD') then
        begin
            if tbdenunciasatatus.IsNull then
            begin
                showmessage('Caro Usuário, favor informar o parecer quanto à reclamação');
                DBCSTATUS.setfocus;
                exit;
            end;
        end;

      if tbdenunciaDtEncaminha.IsNull then
        begin
            if tbdenunciaDtEncaminha.IsNull then
            begin
                showmessage('data de encaminhamento inválida');
                exit;
            end;
        end;

        if not tbdenunciaFiscalEncaminha.isnull  then
            begin
                tbdenunciaprazo.Value := tbdenunciaDtEncaminha.value+15;
            end;




tbdenuncia.post;

end;

procedure Tfrmatendimento.DBEpzExit(Sender: TObject);
begin
   tbatenddata_retorno.value := tbatenddata_atendimento.value+tbatendprazo.value;
end;


procedure Tfrmatendimento.FormKeyPress(Sender: TObject; var Key: Char);
begin
{        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;}

end;

procedure Tfrmatendimento.DBECPFExit(Sender: TObject);
begin
  if not tbdenunciaCPF.isnull then
  begin
  If NOT CPF(tbdenunciaCPF.value) then
  Begin
    messagebox(Application.Handle, Pchar ('O CPF ' +tbdenunciacpf.value+ ' é inválido!'), 'Atenção', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
    DBECPF.setfocus;
  end;
  end;

end;

procedure Tfrmatendimento.DBEcgcExit(Sender: TObject);
begin
  if not tbdenunciacnpj.isnull then
  begin
  If NOT CGC(tbdenunciacnpj.value) then
  Begin
    messagebox(Application.Handle, Pchar ('O CNPJ ' +tbdenunciacnpj.value+ ' é inválido!'), 'Atenção', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
    DBECGC.setfocus;
  end;
  end;

end;

procedure Tfrmatendimento.DBEfimExit(Sender: TObject);
begin

  if tbatendh_fim.value < tbatendh_inicio.value  then
        begin
              showmessage('Atenção: Hora final Anterior a inicial!');
              exit;
        end;

end;

procedure Tfrmatendimento.DBEAtendimentoExit(Sender: TObject);
begin
if tbatenddata_atendimento.value > date then
   begin
        showmessage('Data da Inspeção inválida!');
        DBEAtendimento.setfocus;
   end;
end;

procedure Tfrmatendimento.DBCSTATUSChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmatendimento.DBCencaminhaChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmatendimento.DBCtipoChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmatendimento.DBCFiscal1Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmatendimento.DBCFiscal2Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmatendimento.DBCFiscal3Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

end.


