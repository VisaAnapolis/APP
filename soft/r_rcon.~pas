unit r_rcon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, QRCtrls, jpeg, QuickRpt, ExtCtrls, StdCtrls;

type
  Trel_rcon = class(TForm)
    repcon: TQuickRep;
    QRBTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
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
    QRLdatames: TQRLabel;
    QRLdataano: TQRLabel;
    QRBDetalhe: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText4: TQRDBText;
    QRImage1: TQRImage;
    tbrcon: TTable;
    tbrconControle: TAutoIncField;
    tbrconNome: TStringField;
    tbrconPonto: TFloatField;
    tbrconMes: TSmallintField;
    tbrconAno: TSmallintField;
    SummaryBand1: TQRBand;
    QRShape8: TQRShape;
    QRLabel19: TQRLabel;
    QRShape4: TQRShape;
    QRLabel4: TQRLabel;
    QRExpr3: TQRExpr;
    tbrconNegativo: TFloatField;
    QRDBText2: TQRDBText;
    QRLabel5: TQRLabel;
    procedure repconBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    mes_rel:integer;
    ano_rel:integer;
  end;

var
  rel_rcon: Trel_rcon;

implementation

{$R *.dfm}

procedure Trel_rcon.repconBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
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

end;

end.
