unit r_osurg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, DBTables, DBCtrls, Grids, DBGrids,
  ExtCtrls ;

type
  Tfrmosurg = class(TForm)
    GroupBox1: TGroupBox;
    BtOK: TButton;
    Button3: TButton;
    GroupBox4: TGroupBox;
    CbFiscal: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
    procedure CbFiscalChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmosurg: Tfrmosurg;

implementation

uses relretorno, login, relarequerimento, relaoficio, relptpen, urgencia;

{$R *.dfm}

procedure Tfrmosurg.FormActivate(Sender: TObject);
begin
// tbos.open;
cbfiscal.Text:=frmlogin.c_user;
if (frmlogin.c_grp = 'ADM')  then
begin
    cbfiscal.enabled:=true;
    cbfiscal.setfocus;
end
else cbfiscal.enabled:=false;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS')  then BtOk.Enabled:=true else
  begin
      BtOk.Enabled:= false;
      cbfiscal.Text:= '';
  end;
end;

procedure Tfrmosurg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// tbreq.Close;
end;

procedure Tfrmosurg.Button3Click(Sender: TObject);
begin
close;
end;

procedure Tfrmosurg.BtOKClick(Sender: TObject);
begin
frmurgencia.showmodal;
end;

procedure Tfrmosurg.CbFiscalChange(Sender: TObject);
begin
 perform(Wm_nextdlgctl,0,0);
end;

end.
