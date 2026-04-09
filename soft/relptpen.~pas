unit relptpen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, QuickRpt, QRCtrls, StdCtrls, jpeg, dateutils;

type
  Trel_ptpen = class(TForm)
    repptpen: TQuickRep;
    Btitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRLabel8: TQRLabel;
    BRequerimento: TQRBand;
    QRDBText11: TQRDBText;
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
    tbprotocolo: TTable;
    dsprotocolo: TDataSource;
    tbprotocoloControle: TAutoIncField;
    tbprotocoloCodigo: TIntegerField;
    tbprotocoloProtocolo: TIntegerField;
    tbprotocoloData: TDateField;
    tbprotocoloHora: TTimeField;
    tbprotocoloProtocolante: TStringField;
    tbprotocoloDocumento: TStringField;
    tbprotocoloEmail: TStringField;
    tbprotocoloCelular: TStringField;
    tbprotocoloAssunto: TStringField;
    tbprotocoloComplemento: TStringField;
    tbprotocoloObserva: TStringField;
    tbprotocoloEcarregado: TStringField;
    tbprotocoloCarga: TStringField;
    tbprotocoloUsuario: TStringField;
    tbcontrib: TTable;
    tbcontribCODIGO: TIntegerField;
    tbcontribRAZAO: TStringField;
    tbtramita: TTable;
    tbtramitaProtocolo: TIntegerField;
    tbtramitaData: TDateField;
    QRLabel5: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLPrazo: TQRLabel;
    procedure FormActivate(Sender: TObject);
    procedure BRequerimentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    contador:integer;
  public
    { Public declarations }
  end;

var
  rel_ptpen: Trel_ptpen;

implementation

uses principal, login;

{$R *.dfm}



procedure Trel_ptpen.FormActivate(Sender: TObject);
begin
    QRLFiscal.Caption    := frmlogin.c_user;
end;

procedure Trel_ptpen.BRequerimentoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
 if tbtramitadata.isnull then qrlprazo.Caption := '' else qrlprazo.Caption := datetostr(tbtramitadata.value+20);
end;

end.
