unit r_rmpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, DB, DBTables, Qrprev,
  StdCtrls;

type
  Trel_rmpf = class(TForm)
    reprmpf: TQuickRep;
    banda1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRDBText10: TQRDBText;
    QRLabel13: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel24: TQRLabel;
    QRShape5: TQRShape;
    QRLabel15: TQRLabel;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
    QRBand1: TQRBand;
    QRDBText5: TQRDBText;
    QRBand2: TQRBand;
    QRLabel17: TQRLabel;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRLabel19: TQRLabel;
    dsrmpf: TDataSource;
    tbrmpf: TTable;
    tbrmpfControle: TAutoIncField;
    tbrmpfNome: TStringField;
    tbrmpfData: TDateField;
    tbrmpfMes: TSmallintField;
    tbrmpfAno: TSmallintField;
    tbrmpfPonto: TFloatField;
    tbrmpfHomologado: TStringField;
    QRDBText1: TQRDBText;
    QRLdatames: TQRLabel;
    QRLdataano: TQRLabel;
    QRLabel4: TQRLabel;
    tbrmpfNegativo: TFloatField;
    QRLabel5: TQRLabel;
    QRExpr4: TQRExpr;
    QRDBText2: TQRDBText;
    QRLabel6: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr1: TQRExpr;
    procedure reprmpfBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    mes_rel:integer;
    ano_rel:integer;
  end;

var
  rel_rmpf: Trel_rmpf;

implementation

{$R *.dfm}

procedure Trel_rmpf.reprmpfBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
// var
// I: Integer;
begin
    case mes_rel of
        1: QRLdatames.Caption:='janeiro';
        2: QRLdatames.Caption:='fevereiro';
        3: QRLdatames.Caption:='março';
        4: QRLdatames.Caption:='abril';
        5: QRLdatames.Caption:='maio';
        6: QRLdatames.Caption:='junho';
        7: QRLdatames.Caption:='julho';
        8: QRLdatames.Caption:='agosto';
        9: QRLdatames.Caption:='setembro';
        10: QRLdatames.Caption:='outubro';
        11: QRLdatames.Caption:='novembro';
        12: QRLdatames.Caption:='dezembro';
    end;
    QRLdataano.Caption:=inttostr(ano_rel);
 {    For I:=1 to Screen.FormCount do
     If Screen.Forms[I-1] is TQRStandardPreview Then
     begin
        TQRStandardPreview(Screen.Forms[I-1]).Print.Visible:=False;
        TQRStandardPreview(Screen.Forms[I-1]).Printsetup.Visible:=False;
        TQRStandardPreview(Screen.Forms[I-1]).Savereport.visible:=false;
        TQRStandardPreview(Screen.Forms[I-1]).LoadReport.Enabled:=False;
     end;   }
end;

end.
