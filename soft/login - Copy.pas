unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBTables, DBCtrls, Mask, dateutils;


type
  Tfrmlogin = class(TForm)
    Panel1: TPanel;
    ESenha: TEdit;
    BtEntra: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Btcancel: TButton;
    Btaltera: TButton;
    tblogin: TTable;
    Dslogin: TDataSource;
    Enova: TEdit;
    Label3: TLabel;
    tbloginControle: TAutoIncField;
    tbloginUsuario: TStringField;
    tbloginSenha: TMemoField;
    Labconf: TLabel;
    Econfirma: TEdit;
    Btconfirma: TButton;
    tbloginGrupo: TStringField;
    tbloginData: TDateField;
    tbloginSenha2: TMemoField;
    tbloginSenha3: TMemoField;
    tbloginLocal: TStringField;
    tbloginCpf: TStringField;
    DBLookupComboBox1: TDBLookupComboBox;
    tbloginPerfil: TStringField;
    procedure BtEntraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtcancelClick(Sender: TObject);
    procedure ESenhaKeyPress(Sender: TObject; var Key: Char);
    procedure CusuariosKeyPress(Sender: TObject; var Key: Char);
    procedure BtalteraClick(Sender: TObject);
    procedure BtconfirmaClick(Sender: TObject);
//    procedure CusuariosExit(Sender: TObject);
    procedure tbloginBeforeOpen(DataSet: TDataSet);
    procedure Database1BeforeConnect(Sender: TObject);
    procedure Database1Login(Database: TDatabase; LoginParams: TStrings);
    procedure DBLookupComboBox1Exit(Sender: TObject);
    procedure DBLookupComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBox1Exit(Sender: TObject);
    procedure DBComboBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    c_user:string;
    c_grp:string;
    c_per:string;
    c_area:string;
  end;

var
  frmlogin: Tfrmlogin;

implementation

uses Principal;

{uses ESTABE, Principal;}

{$R *.dfm}

procedure Tfrmlogin.BtEntraClick(Sender: TObject);
begin
    if Esenha.text = '' then
    begin
       showmessage('Favor informar a senha!');
       Esenha.setfocus;
    end
    else
    begin
//      tblogin.FindKey([cusuarios.text]);
        if tbloginsenha.value = Esenha.Text then
          begin
//            else
//            begin
        if tbloginusuario.value <> 'CLÁUDIO NASCIMENTO SILVA' then
        begin
              if (daysbetween(date,tblogindata.value) > 180)  then if messagedlg('Sua senha está inalterada há mais de seis meses, deseja alterar agora ?'+#13,mtconfirmation,[mbyes,mbno],0)=mryes then
              begin
                 BtalteraClick(sender);
                 exit;
              end;

              if (daysbetween(date,tblogindata.value) > 150) and (daysbetween(date,tblogindata.value) < 180) then if messagedlg('Sua senha está inalterada há mais de cinco meses, deseja alterar agora ?'+#13,mtconfirmation,[mbyes,mbno],0)=mryes then
              begin
                 BtalteraClick(sender);
                 exit;
              end;
              if (daysbetween(date,tblogindata.value) > 120) and (daysbetween(date,tblogindata.value) < 150) then if messagedlg('Sua senha está inalterada há mais de quatro meses, deseja alterar agora ?'+#13,mtconfirmation,[mbyes,mbno],0)=mryes then
              begin
                 BtalteraClick(sender);
                 exit;
              end;
              if (daysbetween(date,tblogindata.value) > 90) and (daysbetween(date,tblogindata.value) < 120) then if messagedlg('Sua senha está inalterada há mais de três meses, deseja alterar agora ?'+#13,mtconfirmation,[mbyes,mbno],0)=mryes then
              begin
                 BtalteraClick(sender);
                 exit;
              end;
              if (daysbetween(date,tblogindata.value) > 60) and (daysbetween(date,tblogindata.value) < 90) then if messagedlg('Sua senha está inalterada há mais de dois meses, deseja alterar agora ?'+#13,mtconfirmation,[mbyes,mbno],0)=mryes then
              begin
                 BtalteraClick(sender);
                 exit;
              end;
              if (daysbetween(date,tblogindata.value) > 30) and (daysbetween(date,tblogindata.value) < 60) then if messagedlg('Sua senha está inalterada há mais de 30 dias, deseja alterar agora ?'+#13,mtconfirmation,[mbyes,mbno],0)=mryes then
              begin
                 BtalteraClick(sender);
                 exit;
              end;
        end;
              c_user:= tbloginusuario.value;
              c_grp:= tblogingrupo.value;
              c_per:= tbloginperfil.value;
              c_area:= tbloginlocal.value;
              tblogin.close;
              frmlogin.Visible:= false;
              frmprincipal.showmodal;
//            end;
          end
          else
          begin
                showmessage('Senha digitada está incorreta!');
                Esenha.setfocus;
          end;
    end;
end;

procedure Tfrmlogin.FormActivate(Sender: TObject);
begin
Session.AddPassword('paradiso'); 
Esenha.Text := '';
Enova.Text := '';
Econfirma.Text := '';
//Cusuarios.setfocus;
DBLookupComboBox1.SetFocus;
tblogin.open;
end;

procedure Tfrmlogin.BtcancelClick(Sender: TObject);
begin
tblogin.Close;
Application.terminate;
end;



procedure Tfrmlogin.ESenhaKeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

procedure Tfrmlogin.CusuariosKeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;

end;

procedure Tfrmlogin.BtalteraClick(Sender: TObject);
begin
if Enova.Text = '' then
    begin
        showmessage('Favor informar a NOVA senha!');
        Enova.setfocus;
    end
    else
    begin
//        tblogin.FindKey([cusuarios.text]);
        if tbloginsenha.value = Esenha.Text then
        begin
          if (Enova.Text = tbloginsenha.value) or (Enova.Text = tbloginsenha2.value) or (Enova.Text = tbloginsenha3.value) then
          begin
             showmessage('A nova senha não pode ser igual às três últimas!');
          end
          else
          if length(Enova.text) < 8 then
          begin
          showmessage('A senha de ter pelo menos 8 caracteres!');
          Enova.setfocus;
          end
          else
          begin
            btaltera.enabled:=false;
            btentra.Enabled:=false;
            btconfirma.Visible:=true;
            labconf.Visible:=true;
            Econfirma.Visible:=true;
            Econfirma.text:='';
            Econfirma.setfocus;
          end;
        end
        else
        begin
            showmessage('Senha Atual Incorreta!');
            Esenha.setfocus;
        end;
        end;
    end;

procedure Tfrmlogin.BtconfirmaClick(Sender: TObject);
begin
    if Econfirma.text = Enova.Text then
    begin
        c_user:= tbloginusuario.value;
        c_grp:= tblogingrupo.value;
        c_per:= tbloginperfil.value;
        tblogin.edit;
        tbloginsenha3.value:=tbloginsenha2.value;
        tbloginsenha2.value:=tbloginsenha.value;
        tbloginsenha.value:=Enova.text;
        tblogindata.Value:=date;
        tblogin.post;
        Enova.Text:='';
        Esenha.text:='';
        Econfirma.Text:='';
        showmessage('Senha alterada com sucesso!');
        Esenha.setfocus;
        btaltera.enabled:=true;
        btentra.Enabled:=true;
        btconfirma.Visible:=false;
        labconf.Visible:=false;
        Econfirma.Visible:=false;
    end
    else
    begin
        showmessage('Nova Senha não confirmada!');
        Enova.Text:='';
        Econfirma.Text:='';
        Enova.setfocus;
    end;
end;

{procedure Tfrmlogin.CusuariosExit(Sender: TObject);
begin
tblogin.FindKey([cusuarios.text]);
if (cusuarios.text<>'') and (tbloginsenha.value ='') then
begin
    showmessage('Usuário sem senha, Cadastrar nova senha!');
    Enova.setfocus;
end;
end;   }


procedure Tfrmlogin.tbloginBeforeOpen(DataSet: TDataSet);
begin
Session.AddPassword('paradiso'); 
end;

procedure Tfrmlogin.Database1BeforeConnect(Sender: TObject);
begin
Session.AddPassword('paradiso'); 
end;

procedure Tfrmlogin.Database1Login(Database: TDatabase;
  LoginParams: TStrings);
begin
Session.AddPassword('paradiso'); 
end;

procedure Tfrmlogin.DBLookupComboBox1Exit(Sender: TObject);
begin
{tblogin.FindKey([cusuarios.text]);
if (cusuarios.text<>'') and (tbloginsenha.value ='') then
begin
    showmessage('Usuário sem senha, Cadastrar nova senha!');
    Enova.setfocus;
end; }

end;

procedure Tfrmlogin.DBLookupComboBox1KeyPress(Sender: TObject;
  var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;

end;

procedure Tfrmlogin.DBComboBox1Exit(Sender: TObject);
begin
//tblogin.FindKey([cusuarios.text]);
//if (cusuarios.text<>'') and (tbloginsenha.value ='') then
if tbloginsenha.value ='' then
begin
    showmessage('Usuário sem senha, Cadastrar nova senha!');
    Enova.setfocus;
end;
end;

procedure Tfrmlogin.DBComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;

end;

end.
