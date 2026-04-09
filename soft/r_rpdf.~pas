unit r_rpdf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, DB, DBTables, QRCtrls, StdCtrls, jpeg, Qrprev ;

type
  Trel_rdpf = class(TForm)
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
    tbrdpfHomologado: TStringField;
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
    QRShape12: TQRShape;
    tbrdpfNegativo: TFloatField;
    QRBand1: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel19: TQRLabel;
    SummaryBand1: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRExpr2: TQRExpr;
    QRLabel13: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    tbrdpfOS: TIntegerField;
    tbrdpfTIPOOS: TStringField;
    tbrdpfMotivo: TStringField;
    tbrdpfData_os: TDateField;
    tbrdpfPrazo: TDateField;
    tbrdpfNdoc: TStringField;
    tbrdpfArea: TStringField;
    tbrdpfDupla: TBooleanField;
    tbrdpfFecha: TBooleanField;
    QRDBText2: TQRDBText;
    tbrdpfMeio: TStringField;
    QRLabel1: TQRLabel;
    QRLabel6: TQRLabel;
    QRLCarro: TQRLabel;
    procedure reprdpfBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
     

  private
    { Private declarations }
         carro: short;
    dia: tdatetime;

  public
    { Public declarations }
  end;

var
  rel_rdpf: Trel_rdpf;

implementation

uses rdpf;

{$R *.dfm}


    
procedure Trel_rdpf.reprdpfBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLdtini.Caption := (datetostr(frmrdpf.DTPrel.Date));
  QRLdtfim.Caption := (datetostr(frmrdpf.DTPFinal.Date));
  dia := date;
  carro:=0;
end;


procedure Trel_rdpf.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    if (tbrdpfmeio.Value = 'Próprio') and (dia <> tbrdpfdata.Value) then
    begin
       carro := carro + 1;
       dia := tbrdpfdata.Value;
    end;
end;

procedure Trel_rdpf.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
QRLCarro.Caption := inttostr(carro);
end;

end.
