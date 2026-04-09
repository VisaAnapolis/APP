unit relretpen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, QuickRpt, QRCtrls, StdCtrls, jpeg, dateutils;

type
  Trel_retpen = class(TForm)
    repretorno: TQuickRep;
    Btitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    QRLabel8: TQRLabel;
    BRequerimento: TQRBand;
    QRDBText11: TQRDBText;
    QRDBText15: TQRDBText;
    QRBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLFiscal: TQRLabel;
    QRDBText1: TQRDBText;
    QRSysData3: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel6: TQRLabel;
    QRSysData5: TQRSysData;
    QRLabel9: TQRLabel;
    QRDBText4: TQRDBText;
    QRShape2: TQRShape;
    QRImage1: TQRImage;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape5: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    tboficio: TTable;
    dsoficio: TDataSource;
    QRDBText2: TQRDBText;
    QRLdias: TQRLabel;
    QRLabel11: TQRLabel;
    tboficioControle: TAutoIncField;
    tboficioOficio: TIntegerField;
    tboficioData: TDateField;
    tboficioRegulado: TStringField;
    tboficioLogradouro: TStringField;
    tboficioCdbai: TSmallintField;
    tboficioOrdem: TStringField;
    tboficioCpf: TStringField;
    tboficioCnpj: TStringField;
    tboficioArchive: TBooleanField;
    tboficioUser: TStringField;
    tboficioDtencaminha: TDateField;
    tboficioFiscalencaminha: TStringField;
    tboficioDtatendimento: TDateField;
    tboficioEmitente: TStringField;
    tboficioMotivo: TStringField;
    tboficioPrazo: TDateField;
    QRDBText5: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText3: TQRDBText;
    tboficioCancela: TBooleanField;
    procedure FormActivate(Sender: TObject);
    procedure BRequerimentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
//  contador:integer;
  public
    { Public declarations }
  end;

var
  rel_retpen: Trel_retpen;

implementation

uses principal, login;

{$R *.dfm}



procedure Trel_retpen.FormActivate(Sender: TObject);
begin
    QRLFiscal.Caption    := frmlogin.c_user;
end;

procedure Trel_retpen.BRequerimentoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
if tboficioprazo.isnull then qrldias.Caption := '' else qrldias.Caption :=inttostr(daysbetween(date,tboficioprazo.value));
end;

end.
