unit r_rpdf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, DB, DBTables, QRCtrls, StdCtrls, jpeg, Qrprev ;

type
  Trel_rpdf = class(TForm)
    reprdpf: TQuickRep;
    tbrdpf: TTable;
    dsrdpf: TDataSource;
    tbrdpfControle: TAutoIncField;
    tbrdpfTipo: TStringField;
    tbrdpfNome: TStringField;
    tbrdpfData: TDateField;
    tbrdpfDoc: TStringField;
    tbrdpfEstabe: TStringField;
    tbrdpfMod: TStringField;
    tbrdpfComplex: TStringField;
    tbrdpfPonto: TFloatField;
    QRBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText12: TQRDBText;
    QRBand2: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel17: TQRLabel;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    tbrdpfHomologado: TStringField;
    QRDBText13: TQRDBText;
    QRLabel18: TQRLabel;
    QRDBText14: TQRDBText;
    tbrdpfObs: TMemoField;
    QRDBText8: TQRDBText;
    tbrdpfCnae: TStringField;
    tbrdpfAcao: TStringField;
    PageHeaderBand1: TQRBand;
    QRImage2: TQRImage;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape9: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel12: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape10: TQRShape;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel25: TQRLabel;
    QRLdtini: TQRLabel;
    QRLabel27: TQRLabel;
    QRLdtfim: TQRLabel;
    QRShape11: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRShape12: TQRShape;
    QRLabel1: TQRLabel;
    QRDBText5: TQRDBText;
    procedure reprdpfBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
     

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_rpdf: Trel_rpdf;

implementation

uses rdpf;

{$R *.dfm}


    
procedure Trel_rpdf.reprdpfBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLdtini.Caption := (datetostr(frmrdpf.DTPrel.Date));
  QRLdtfim.Caption := (datetostr(frmrdpf.DTPFinal.Date));
end;


end.
