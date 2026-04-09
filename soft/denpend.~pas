unit denpend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, ComCtrls;

type
  TFrmDenPen = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button3: TButton;
    RGselec: TRadioGroup;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDenPen: TFrmDenPen;

implementation

uses r_den ;

{$R *.dfm}

procedure TFrmDenPen.Button3Click(Sender: TObject);
begin
CLOSE;
end;

procedure TFrmDenPen.Button1Click(Sender: TObject);
begin
    rel_den.tbdenuncia.open;
    rel_den.tbatend.open;
    rel_den.repden.preview;
    rel_den.tbatend.close;
    rel_den.tbdenuncia.close;
end;

end.
