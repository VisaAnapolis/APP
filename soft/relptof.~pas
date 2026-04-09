unit relptof;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DB, DBTables, StdCtrls;

type
  Trel_ptoficio = class(TForm)
    repoficio: TQuickRep;
    banda1: TQRBand;
    QRDBText3: TQRDBText;
    qrldataano: TQRLabel;
    QRLdatames: TQRLabel;
    QRLdatadia: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
    tboficio: TTable;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    dsoficio: TDataSource;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel23: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel24: TQRLabel;
    QRShape5: TQRShape;
    QRShape4: TQRShape;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRLabel18: TQRLabel;
    tboficioControle: TAutoIncField;
    tboficioOficio: TIntegerField;
    tboficioData: TDateField;
    tboficioEmitente: TStringField;
    tboficioMotivo: TStringField;
    tboficioRegulado: TStringField;
    tboficioLogradouro: TStringField;
    tboficioCdbai: TSmallintField;
    tboficioOrdem: TStringField;
    tboficioCpf: TStringField;
    tboficioCnpj: TStringField;
    tboficioFiscalencaminha: TStringField;
    tboficioDtencaminha: TDateField;
    tboficioPrazo: TDateField;
    tboficioDtatendimento: TDateField;
    tboficioArchive: TBooleanField;
    tboficioUser: TStringField;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel3: TQRLabel;
    QRShape6: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    tboficioFantasia: TStringField;
    QRDBText8: TQRDBText;
    procedure repoficioBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_ptoficio: Trel_ptoficio;

implementation

{$R *.dfm}

procedure Trel_ptoficio.repoficioBeforePrint(Sender: TCustomQuickRep;var PrintReport: Boolean);
var
mes:integer;
begin
QRLdatadia.Caption:=formatdatetime('dd',tbOFICIOdata.value);
mes := strtoint(formatdatetime('mm',tbOFICIOdata.value));
case mes of
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
QRLdataano.Caption:=formatdatetime('yyyy',tbOFICIOdata.value);
{QRMObs.Caption:=tbdenunciaobs.Value; }

end;

end.
