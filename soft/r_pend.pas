unit r_pend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, DB, DBTables;

type
  Trel_pen = class(TForm)
    reppen: TQuickRep;
    banda1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRLabel13: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel24: TQRLabel;
    QRShape5: TQRShape;
    QRShape2: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
    QRBand1: TQRBand;
    QRDBText6: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
    tbpen: TTable;
    tbpenControle: TAutoIncField;
    tbpenTipo: TStringField;
    tbpenNome: TStringField;
    tbpenData: TDateField;
    tbpenDoc: TStringField;
    tbpenEstabe: TStringField;
    tbpenMod: TStringField;
    tbpenComplex: TStringField;
    tbpenHomologado: TStringField;
    dspen: TDataSource;
    QRDBText2: TQRDBText;
    tbpenCnae: TStringField;
    QRLabel7: TQRLabel;
    QRLdtini: TQRLabel;
    QRLabel10: TQRLabel;
    QRLdtfim: TQRLabel;
    QRLabel15: TQRLabel;
    QRDBText1: TQRDBText;
    tbpenAcao: TStringField;
    SummaryBand1: TQRBand;
    tbpenPonto: TFloatField;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    QRLabel3: TQRLabel;
    QRDBText5: TQRDBText;
    tbpenEntrega: TBooleanField;
    tbpenFecha: TBooleanField;
    QRLabel18: TQRLabel;
    QRLOK: TQRLabel;
    tbpenData_os: TDateField;
    tbpenPrazo: TDateField;
    tbpenNegativo: TFloatField;
    QRDBText11: TQRDBText;
    QRLabel12: TQRLabel;
    QRDBText8: TQRDBText;
    tbpenOS: TIntegerField;
    QRLabel5: TQRLabel;
    tbpenMeio: TStringField;
    QRLabel21: TQRLabel;
    QRLCarro: TQRLabel;
    QRDBText7: TQRDBText;
    tbpenComply: TStringField;
    procedure reppenBeforePrint(Sender: TCustomQuickRep;
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
  rel_pen: Trel_pen;

implementation

uses rdpf;

{$R *.dfm}

procedure Trel_pen.reppenBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);


begin
  QRLdtini.Caption := (datetostr(frmrdpf.DTPrel.Date));
  QRLdtfim.Caption := (datetostr(frmrdpf.DTPFinal.Date));
  carro:=0;
  dia := date+1;
end;

procedure Trel_pen.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    if tbpenfecha.Value = true then QRLOK.enabled := true else QRLOK.enabled := false;
    if (tbpenmeio.Value = 'Próprio') and (dia <> tbpendata.Value) then
    begin
       carro := carro + 1;
       dia := tbpendata.Value;
    end;
end;

procedure Trel_pen.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
QRLCarro.Caption := inttostr(carro);
end;

end.
