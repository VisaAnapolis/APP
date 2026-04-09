unit oficio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, DBCtrls, ComCtrls, ExtCtrls, Buttons,
  ToolWin, Mask, Grids, DBGrids, QuickRpt, dateutils;

type
  Tfrmoficio = class(TForm)
    GBRecl: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdata: TDBEdit;
    DBEregulado: TDBEdit;
    DBLBairro: TDBLookupComboBox;
    barraferra: TToolBar;
    btaltera: TSpeedButton;
    btlocpro: TSpeedButton;
    btgrava: TSpeedButton;
    btcancel: TSpeedButton;
    btfecha: TSpeedButton;
    bthelp: TSpeedButton;
    navegador: TDBNavigator;
    StatusBar1: TStatusBar;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    dsbairro: TDataSource;
    Label1: TLabel;
    DBECPF: TDBEdit;
    DBEcgc: TDBEdit;
    Label13: TLabel;
    DBEdit2: TDBEdit;
    Texto_cancela: TStaticText;
    GroupBox1: TGroupBox;
    DBCencaminha: TDBComboBox;
    Label18: TLabel;
    Label19: TLabel;
    STprazo: TStaticText;
    Label20: TLabel;
    btprn: TSpeedButton;
    tboficio: TTable;
    dsoficio: TDataSource;
    tboficioControle: TAutoIncField;
    tboficioOficio: TIntegerField;
    tboficioData: TDateField;
    tboficioRegulado: TStringField;
    tboficioLogradouro: TStringField;
    tboficioCdbai: TSmallintField;
    tboficioCpf: TStringField;
    tboficioCnpj: TStringField;
    tboficioArchive: TBooleanField;
    tboficioUser: TStringField;
    tboficioDtencaminha: TDateField;
    tboficioFiscalencaminha: TStringField;
    tboficioOrdem: TStringField;
    Label6: TLabel;
    DBElogradouro: TDBEdit;
    DBEOrdem: TDBEdit;
    DBEPrazo: TDBEdit;
    btnovo: TSpeedButton;
    Label8: TLabel;
    tboficioDtatendimento: TDateField;
    tboficioEmitente: TStringField;
    DBCMotivo: TDBComboBox;
    Label9: TLabel;
    tbsequencia: TTable;
    tbsequenciaNumero: TIntegerField;
    tbsequenciaDoc: TIntegerField;
    tbsequenciaDen: TIntegerField;
    tbsequenciaAlvara: TIntegerField;
    tbsequenciaVeiculo: TIntegerField;
    tbsequenciaPt: TIntegerField;
    tbsequenciaProtocolo: TIntegerField;
    tbsequenciaDisponibilidade: TBooleanField;
    tbsequenciaVersao: TStringField;
    tbsequenciaDt_versao: TStringField;
    dssequencia: TDataSource;
    tbsequenciaOficio: TIntegerField;
    tboficioMotivo: TStringField;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    tboficioPrazo: TDateField;
    Btdeleta: TSpeedButton;
    Texto_Archive: TStaticText;
    tboficioCancela: TBooleanField;
    DBEdit1: TDBEdit;
    Label11: TLabel;
    DBEdit3: TDBEdit;
    Label12: TLabel;
    DBCTerceiro: TDBCheckBox;
    tboficioTerceiro: TBooleanField;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    tboficioFantasia: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btfechaClick(Sender: TObject);
    procedure bthelpClick(Sender: TObject);
    procedure btprnClick(Sender: TObject);
    procedure btcancelClick(Sender: TObject);
    procedure btlocproClick(Sender: TObject);
    procedure btalteraClick(Sender: TObject);
    procedure tbdenunciaAfterScroll(DataSet: TDataSet);
    procedure btgravaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBECPFExit(Sender: TObject);
    procedure DBEcgcExit(Sender: TObject);
    procedure DBCSTATUSChange(Sender: TObject);
    procedure DBCencaminhaChange(Sender: TObject);
    procedure DBCtipoChange(Sender: TObject);
    procedure DBCFiscal1Change(Sender: TObject);
    procedure DBCFiscal2Change(Sender: TObject);
    procedure DBCFiscal3Change(Sender: TObject);
    procedure btnovoClick(Sender: TObject);
    procedure dsoficioStateChange(Sender: TObject);
    procedure tboficioAfterScroll(DataSet: TDataSet);
    procedure BtdeletaClick(Sender: TObject);
    procedure DBEPrazoExit(Sender: TObject);
  private
    arquivo:boolean;
  public

  end;

var
  frmoficio: Tfrmoficio;

implementation

uses login, sobre, CPFeCGC, locof, relofpen, relptof;

{$R *.dfm}

procedure Tfrmoficio.FormActivate(Sender: TObject);
begin
arquivo:=false;
tbsequencia.Open;
tbbairro.open;
tboficio.Open;
tboficio.last;
    if tboficiodtencaminha.Isnull   then STprazo.Caption:='Não Distribuída' else STprazo.Caption:=floattostr(secondsbetween(date,tboficiodtencaminha.value)/86400);
    if tboficioarchive.Value = true then texto_archive.visible := true else texto_archive.visible := false;
    if tboficiocancela.value = true then texto_cancela.visible := true else texto_cancela.visible := false;
end;

procedure Tfrmoficio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
tbbairro.Close;
tboficio.Close;
tbsequencia.close;

end;

procedure Tfrmoficio.btfechaClick(Sender: TObject);
begin
close;
end;

procedure Tfrmoficio.bthelpClick(Sender: TObject);
begin
{  messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);}
aboutbox.showmodal;
    navegador.setfocus;

end;

procedure Tfrmoficio.btprnClick(Sender: TObject);
var
volta:integer;
begin
    if (frmlogin.c_user = tboficiofiscalencaminha.Value) or  (frmlogin.c_grp = 'ADM') then
    begin
        volta:=tboficiocontrole.value;
        rel_ptoficio.tboficio.open;
        rel_ptoficio.tboficio.FindKey([tboficiocontrole.value]);
        rel_ptoficio.tbbairro.open;
        rel_ptoficio.repoficio.preview;
        rel_ptoficio.tbbairro.Close;
        rel_ptoficio.tboficio.Close;
        rel_ptoficio.Close;
        navegador.setfocus;
        tboficio.findkey([volta])
    end else showmessage('Perfil não autorizaado emitir OS encaminahda para: '+tboficioFiscalEncaminha.value);
end;

procedure Tfrmoficio.btcancelClick(Sender: TObject);
begin
        DBECPF.ReadOnly        := false;
        DBEcgc.ReadOnly        := false;
        DBEregulado.ReadOnly   := false;
        DBLBairro.ReadOnly     := false;
        DBElogradouro.ReadOnly := false;
        DBCMotivo.ReadOnly     := false;
        DBEOrdem.ReadOnly      := false;
        DBCencaminha.enabled  := true;
        DBCTerceiro.ReadOnly   := false;
tboficio.Cancel;
navegador.setfocus;
end;

procedure Tfrmoficio.btlocproClick(Sender: TObject);
begin
   frmlocof.ShowModal;
   tboficio.Indexfieldnames := 'oficio';
   tboficio.findkey([frmlocof.lugarof]);
   if frmlocof.loc_of = 0 then tboficio.Indexfieldnames := 'oficio';
   if frmlocof.loc_of = 1 then tboficio.Indexfieldnames := 'Dtencaminha';
   if frmlocof.loc_of = 2 then tboficio.Indexfieldnames := 'fiscalencaminha';
end;

procedure Tfrmoficio.btalteraClick(Sender: TObject);
begin

if (frmlogin.c_grp = 'ADM') then
begin

    if tboficioarchive.value = true then
    begin
        showmessage('Atenção!!! OS Baixada !');
        DBECPF.ReadOnly := true;
        DBEcgc.ReadOnly := true;
        DBEregulado.ReadOnly := true;
        DBLBairro.ReadOnly := true;
        DBElogradouro.ReadOnly := true;
        DBCMotivo.ReadOnly :=true;
        DBEOrdem.ReadOnly := true;
        DBCencaminha.enabled := false;
        DBCTerceiro.ReadOnly :=true;
        DBEPrazo.setfocus;
    end;
    tboficio.Edit;
//    tboficiodtencaminha.value :=date;
    tboficiouser.Value := frmlogin.c_user;
end
else showmessage('Função não permitida para este perfil');

end;





procedure Tfrmoficio.tbdenunciaAfterScroll(DataSet: TDataSet);
begin
    if tboficioarchive.Value = true  then texto_archive.visible:=true        else texto_archive.visible := false;
    if tboficiodtencaminha.Isnull    then STprazo.Caption:='Não Distribuída' else STprazo.Caption:=floattostr(secondsbetween(date,tboficiodtencaminha.value)/86400);
end;

procedure Tfrmoficio.btgravaClick(Sender: TObject);
begin

        if tboficiologradouro.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o logradouro do Regulado');
            DBElogradouro.setfocus;
            exit;
        end;

        if tboficioregulado.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o nome do regulado. Se desconhecido informar "Desconhecido"!');
            DBEregulado.setfocus;
            exit;
        end;

            if tboficiomotivo.IsNull then
            begin
                 showmessage('Caro Usuário, favor informar a motivação da OS');
                 DBCmotivo.setfocus;
                exit;
            end;

        begin
            if tboficioordem.IsNull then
            begin
                showmessage('Caro Usuário, favor descrever a atividade a ser executada');
                DBEOrdem.setfocus;
                exit;
            end;
        end;


           if tboficioprazo.IsNull then
            begin
                showmessage('Caro Usuário, favor informar o prazo final para execução da OS');
                DBEPrazo.setfocus;
                exit;
            end;

           if tboficioprazo.value < date then
            begin
                showmessage('Caro Usuário, prazo anterior a data atual ');
                DBEPrazo.setfocus;
                exit;
            end;

           if daysbetween(tboficioprazo.value,date) > 90 then
            begin
                showmessage('Caro Usuário, prazo maior que o legal ');
                DBEPrazo.setfocus;
                exit;
            end;


        if tboficioFiscalEncaminha.IsNull then
        begin
               showmessage('Caro Usuário, favor informar o Fiscal Encarregado');
               DBCencaminha.setfocus;
               exit;
         end;

{        if  (tboficioFiscalEncaminha.value = 'ORDEM GERAL') and (tboficiomotivo.Value <> 'OUTRAS') then
        begin
               showmessage('Caro Usuário, favor informar um Fiscal Encarregado para esta motivaçao');
               DBCencaminha.setfocus;
               exit;
         end;      }

        DBECPF.ReadOnly        := false;
        DBEcgc.ReadOnly        := false;
        DBEregulado.ReadOnly   := false;
        DBLBairro.ReadOnly     := false;
        DBElogradouro.ReadOnly := false;
        DBCMotivo.ReadOnly     := false;
        DBEOrdem.ReadOnly      := false;
        DBCencaminha.enabled  := true;
        DBCTerceiro.ReadOnly   := false;
        tboficiouser.Value     := frmlogin.c_user;
        tboficio.post;

end;


procedure Tfrmoficio.FormKeyPress(Sender: TObject; var Key: Char);
begin
{        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;}

end;

procedure Tfrmoficio.DBECPFExit(Sender: TObject);
begin
  if not tboficioCPF.isnull then
  begin
  If NOT CPF(tboficioCPF.value) then
  Begin
    messagebox(Application.Handle, Pchar ('O CPF ' +tboficiocpf.value+ ' é inválido!'), 'Atenção', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
    DBECPF.setfocus;
  end;
  end;

end;

procedure Tfrmoficio.DBEcgcExit(Sender: TObject);
begin
  if not tboficiocnpj.isnull then
  begin
  If NOT CGC(tboficiocnpj.value) then
  Begin
    messagebox(Application.Handle, Pchar ('O CNPJ ' +tboficiocnpj.value+ ' é inválido!'), 'Atenção', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
    DBECGC.setfocus;
  end;
  end;

end;


procedure Tfrmoficio.DBCSTATUSChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmoficio.DBCencaminhaChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmoficio.DBCtipoChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmoficio.DBCFiscal1Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmoficio.DBCFiscal2Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmoficio.DBCFiscal3Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmoficio.btnovoClick(Sender: TObject);
var
ofi :integer;
begin
if (frmlogin.c_grp = 'ADM') then
  begin
        tboficio.Insert;
        tbsequencia.edit;
        ofi:=tbsequenciaoficio.value+1;
        tboficiooficio.value:=ofi;
        tbsequenciaoficio.value:=ofi;
        tbsequencia.post;
        tboficioData.Value:=date-1;
        tboficiodtencaminha.value :=date-1;
        tboficiouser.Value := frmlogin.c_user;
        tbOFICIOEMITENTE.value := 'GERENTE DE VIGILÂNCIA SANITÁRIA';
        DBECPF.setfocus;
end
else showmessage('Função não permitida para este perfil');

//end;

end;

procedure Tfrmoficio.dsoficioStateChange(Sender: TObject);
begin
if tboficio.state=dsbrowse then statusbar1.panels[0].text:=' [F1] Ajuda   [F2] Pesquisa   [F3] Inclusão   [F4] Alteração ' else statusbar1.panels[0].text:=' [F6] Grava   [ESC] Cancela';
btnovo.enabled       := tboficio.state =  dsbrowse;
btaltera.enabled     := tboficio.state =  dsbrowse;
btlocpro.enabled     := tboficio.state =  dsbrowse;
btgrava.enabled      := tboficio.state <> dsbrowse;
btcancel.enabled     := tboficio.state <> dsbrowse;
btfecha.enabled      := tboficio.state =  dsbrowse;
bthelp.enabled       := tboficio.state =  dsbrowse;
navegador.enabled    := tboficio.state =  dsbrowse;
    if tboficiodtencaminha.Isnull   then STprazo.Caption:='Não Distribuída' else STprazo.Caption:=floattostr(secondsbetween(date,tboficiodtencaminha.value)/86400);
    if tboficioarchive.Value = true then texto_archive.visible := true else texto_archive.visible := false;
    if tboficiocancela.value = true then texto_cancela.visible := true else texto_cancela.visible := false;

end;

procedure Tfrmoficio.tboficioAfterScroll(DataSet: TDataSet);
begin
    if tboficiodtencaminha.Isnull   then STprazo.Caption:='Não Distribuída' else STprazo.Caption:=floattostr(secondsbetween(date,tboficiodtencaminha.value)/86400);
    if tboficioarchive.Value = true then texto_archive.visible := true else texto_archive.visible := false;
    if tboficiocancela.value = true then texto_cancela.visible := true else texto_cancela.visible := false;
end;

procedure Tfrmoficio.BtdeletaClick(Sender: TObject);
begin

    if tboficioarchive.value = true then
    begin
        showmessage('OS Atendida. Impossível Cancelar!');
        exit;
    end
    else
    begin
       if messagedlg('Tem Cereteza que deseja cancelar a OS: '+tboficioOFICIO.asstring+', encaminhadada patra o fiscal: '+tboficiofiscalencaminha.value+'?',mtconfirmation,[mbyes,mbno],0)=mrNO then EXIT elsE
        BEGIN
            tboficio.Edit;
            tboficiocancela.value := true;
            tboficio.Post;
        END
    end;
end;

procedure Tfrmoficio.DBEPrazoExit(Sender: TObject);
begin
   if tboficioprazo.value < date then
   begin
        showmessage('Data Inválida!');
        DBEPrazo.setfocus;
   end;

end;

end.


