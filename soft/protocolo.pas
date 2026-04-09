unit protocolo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, DBTables, Mask, ExtCtrls, Buttons,
  ToolWin, ComCtrls, Grids, DBGrids;

type
  TFrmproto = class(TForm)
    GroupBox1: TGroupBox;
    DBCAssunto: TDBComboBox;
    dsregistro: TDataSource;
    tbproto: TTable;
    tbprotoControle: TAutoIncField;
    tbprotoProto: TIntegerField;
    tbprotoInteressado: TStringField;
    tbprotoLogradouro: TStringField;
    tbprotoComplemento: TStringField;
    tbprotoCdbai: TSmallintField;
    Label3: TLabel;
    DBEInteressado: TDBEdit;
    Label4: TLabel;
    DBElogradouro: TDBEdit;
    Label5: TLabel;
    DBEComple: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    DBEFone: TDBEdit;
    Label8: TLabel;
    barraferra: TToolBar;
    btnovo: TSpeedButton;
    btaltera: TSpeedButton;
    btloc: TSpeedButton;
    btgrava: TSpeedButton;
    btcancel: TSpeedButton;
    btdeleta: TSpeedButton;
    btprn: TSpeedButton;
    btfecha: TSpeedButton;
    bthelp: TSpeedButton;
    navegador: TDBNavigator;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label9: TLabel;
    DBEPMA: TDBEdit;
    tbbai: TTable;
    dsbai: TDataSource;
    tbanda: TTable;
    tbandaControle: TAutoIncField;
    tbandaProto: TIntegerField;
    tbandaData: TDateField;
    tbandaHora: TTimeField;
    tbbaiCONTROLE: TAutoIncField;
    tbbaiCODIGO: TIntegerField;
    tbbaiNOME: TStringField;
    tbbaiSETOR: TIntegerField;
    dsanda: TDataSource;
    DBLBairro: TDBLookupComboBox;
    tbsequencia: TTable;
    tbsequenciaNumero: TIntegerField;
    tbsequenciaDoc: TIntegerField;
    tbsequenciaDen: TIntegerField;
    tbsequenciaPt: TIntegerField;
    tbsequenciaDisponibilidade: TBooleanField;
    tbsequenciaVersao: TStringField;
    tbsequenciaDt_versao: TStringField;
    tbprotoAssunto: TStringField;
    tbandaDestino: TStringField;
    tbandaUser_env: TStringField;
    tbandaUser_rec: TStringField;
    Label2: TLabel;
    DBComboBox1: TDBComboBox;
    tbprotoFone: TStringField;
    tbprotoPMA: TStringField;
    StatusBar1: TStatusBar;
    procedure btfechaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bthelpClick(Sender: TObject);
    procedure btprnClick(Sender: TObject);
    procedure btcancelClick(Sender: TObject);
    procedure btgravaClick(Sender: TObject);
    procedure btlocClick(Sender: TObject);
    procedure btalteraClick(Sender: TObject);
    procedure btnovoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dsregistroStateChange(Sender: TObject);
    procedure btdeletaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmproto: TFrmproto;

implementation
uses login, sobre;
{$R *.dfm}

procedure TFrmproto.btfechaClick(Sender: TObject);
begin
close;
end;

procedure TFrmproto.FormActivate(Sender: TObject);
begin
tbsequencia.open;
tbproto.open;
tbanda.open;
tbbai.open;
messagedlg('Atenção! Módulo em desenvolvimento, dados informados somente para testes.',mtwarning,[mbok],0);
end;

procedure TFrmproto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbbai.Close;
tbanda.close;
tbproto.close;
tbsequencia.Close;
end;

procedure TFrmproto.bthelpClick(Sender: TObject);
begin
aboutbox.showmodal;
end;

procedure TFrmproto.btprnClick(Sender: TObject);
begin
messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
end;

procedure TFrmproto.btcancelClick(Sender: TObject);
begin
tbanda.cancel;
tbproto.cancel;
tbsequencia.cancel;
end;

procedure TFrmproto.btgravaClick(Sender: TObject);
begin
tbanda.post;
tbproto.post;
end;

procedure TFrmproto.btlocClick(Sender: TObject);
begin
messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
end;

procedure TFrmproto.btalteraClick(Sender: TObject);
begin
tbproto.Edit;
tbanda.edit;
end;

procedure TFrmproto.btnovoClick(Sender: TObject);
var
pt:integer;
begin
        tbsequencia.edit;
        pt:=tbsequenciapt.value+1;
        tbproto.Insert;
        tbprotoproto.value:=pt;
        tbsequenciapt.value:=pt;
        tbsequencia.post;
        tbanda.insert;
        tbandaData.Value:=date;
        tbandaHora.value:=time;
        DBCassunto.setfocus;
        tbandauser_env.value := frmlogin.c_user;
end;

procedure TFrmproto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case key of
        vk_escape:
        begin
          if tbproto.state<>dsbrowse then btcancelClick(Sender)  else close;
        end;

        vk_F6:
        begin
          if tbproto.state<>dsbrowse then  btgravaClick(Sender)  else showmessage('Funcao nao suportada aqui');
        end;

        vk_F3:
        begin
            if tbproto.state=dsbrowse then btnovoClick(Sender)  else showmessage('Funcao nao suportada aqui');
        end;

        vk_F2:
        begin
             if tbproto.state=dsbrowse then  btlocClick(Sender)  else  showmessage('Funcao nao suportada aqui');
        end;

        vk_F1:
        begin
            if tbproto.state=dsbrowse then bthelpClick(Sender) else  showmessage('Funcao nao suportada aqui');
        end;

        vk_F4:
        begin
             if tbproto.state=dsbrowse then btalteraClick(Sender) else showmessage('Funcao nao suportada aqui');
        end;

        vk_F5:
        begin
        if tbproto.state=dsbrowse then  btprnClick(Sender)   else showmessage('Funcao nao suportada aqui');
        end;
end;
end;

procedure TFrmproto.dsregistroStateChange(Sender: TObject);
begin

if tbproto.state=dsbrowse then statusbar1.panels[0].text:=' [F1] Ajuda   [F2] Pesquisa   [F3] Inclusão   [F4] Alteração   [F5] Alvará' else statusbar1.panels[0].text:=' [F6] Grava   [ESC] Cancela';
btnovo.enabled       := tbproto.state =  dsbrowse;
btaltera.enabled     := tbproto.state =  dsbrowse;
btloc.enabled        := tbproto.state =  dsbrowse;
btgrava.enabled      := tbproto.state <> dsbrowse;
btcancel.enabled     := tbproto.state <> dsbrowse;
btdeleta.enabled     := tbproto.state =  dsbrowse;
btprn.enabled        := tbproto.state =  dsbrowse;
btfecha.enabled      := tbproto.state =  dsbrowse;
bthelp.enabled       := tbproto.state =  dsbrowse;
navegador.enabled    := tbproto.state =  dsbrowse;

end;

procedure TFrmproto.btdeletaClick(Sender: TObject);
begin

     if messagedlg('Confirma a Exclusão do protocolo '+#13+inttostr(tbprotoProto.value)+' ?',mtconfirmation,[mbyes,mbno],0)=mryes then
     if (frmlogin.c_grp = 'ADM') then
     begin
        if not tbanda.Eof then tbanda.Delete else showmessage('Não Há Andamentos a serem Excluídos!');
        tbproto.Delete;
     end
     else showmessage('Exclusão: Favor Encaminhar Para o Setor de Cadastro');
     navegador.setfocus;

end;

end.
