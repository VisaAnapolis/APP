unit r_fisden;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, DBTables, DBCtrls, Grids, DBGrids,
  ExtCtrls ;

type
  Tfrmfisden = class(TForm)
    GroupBox1: TGroupBox;
    BtOK: TButton;
    Button3: TButton;
    GroupBox4: TGroupBox;
    CbFiscal: TComboBox;
    CBStatus: TComboBox;
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
  frmfisden: Tfrmfisden;

implementation

uses relretorno, login, relarequerimento, reladenuncias;

{$R *.dfm}

procedure Tfrmfisden.FormActivate(Sender: TObject);
begin
// tbos.open;
cbfiscal.Text:=frmlogin.c_user;
if (frmlogin.c_grp = 'ADM') then
begin
    cbfiscal.enabled:=true;
    cbfiscal.setfocus;
end
else cbfiscal.enabled:=false;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') then BtOk.Enabled:=true else
  begin
      BtOk.Enabled:= false;
      cbfiscal.Text:= '';
  end;
end;

procedure Tfrmfisden.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// tbreq.Close;
end;

procedure Tfrmfisden.Button3Click(Sender: TObject);
begin
close;
end;

procedure Tfrmfisden.BtOKClick(Sender: TObject);
begin

        rel_denpen.tbdenuncia.Open;
        rel_denpen.tbbairro.open;
        rel_denpen.QRLFiscal.Caption  := cbfiscal.Text;
        if cbstatus.text = 'ATENDIDAS' then
            rel_denpen.tbdenuncia.Filter       := 'Fiscalencaminha ='+ quotedstr(cbfiscal.text) +' and Archive = true'
        else
            rel_denpen.tbdenuncia.Filter       := 'Fiscalencaminha ='+ quotedstr(cbfiscal.text) +' and Archive <> true';
         rel_denpen.QRDenpen.PreviewModal;
         rel_denpen.tbbairro.close;
         rel_denpen.tbdenuncia.close;
end;

procedure Tfrmfisden.CbFiscalChange(Sender: TObject);
begin
 perform(Wm_nextdlgctl,0,0);
end;

end.
