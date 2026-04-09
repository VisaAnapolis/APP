unit sobre;

interface

uses Windows,  SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, Dialogs, DB, DBTables, DBCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    OKButton: TButton;
    Image1: TImage;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    Copyright: TLabel;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    tbsequencia: TTable;
    tbsequenciaDisponibilidade: TBooleanField;
    tbsequenciaVersao: TStringField;
    tbsequenciaDt_versao: TStringField;
    DBText1: TDBText;
    Dssequencia: TDataSource;
    DBText2: TDBText;
    Label2: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

procedure TAboutBox.BitBtn1Click(Sender: TObject);
begin
if  panel2.visible=false then panel2.visible:=true else panel2.visible:=false;

end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbsequencia.close;
panel2.visible:=false
end;

procedure TAboutBox.BitBtn2Click(Sender: TObject);
begin
 messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
end;

procedure TAboutBox.FormActivate(Sender: TObject);
begin
tbsequencia.open;
end;

end.

