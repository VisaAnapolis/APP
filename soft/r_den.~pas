unit r_den;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, DB, DBTables, dateutils;

type
    Trel_den = class(TForm)
    repden: TQuickRep;
    banda1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRSysData1: TQRSysData;
    QRLabel24: TQRLabel;
    QRShape5: TQRShape;
    QRShape2: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
    QRBand1: TQRBand;
    tbatend: TTable;
    tbatendControle: TAutoIncField;
    tbatendDenuncia: TIntegerField;
    tbatendData_atendimento: TDateField;
    tbatendPrazo: TIntegerField;
    tbatendData_retorno: TDateField;
    tbatendFiscal1: TStringField;
    tbatendFiscal2: TStringField;
    tbatendFiscal3: TStringField;
    tbatendObs: TMemoField;
    tbatendTipodoc: TStringField;
    tbatendH_inicio: TTimeField;
    tbatendH_fim: TTimeField;
    tbatendNumdoc: TIntegerField;
    QRDenuncia: TQRDBText;
    QRDtregistro: TQRDBText;
    QRDtatend: TQRDBText;
    tbdenuncia: TTable;
    tbdenunciaControle: TAutoIncField;
    tbdenunciaDenuncia: TIntegerField;
    tbdenunciaData: TDateField;
    tbdenunciaReclamado: TStringField;
    tbdenunciaLogradouro: TStringField;
    tbdenunciaCdbai: TSmallintField;
    tbdenunciaReferencia: TStringField;
    tbdenunciaArea: TStringField;
    tbdenunciaObjeto1: TStringField;
    tbdenunciaSatatus: TStringField;
    tbdenunciaSINAVISA: TIntegerField;
    tbdenunciaDescricao: TStringField;
    tbdenunciaCpf: TStringField;
    tbdenunciaCnpj: TStringField;
    tbdenunciaArchive: TBooleanField;
    tbdenunciaUser: TStringField;
    tbdenunciaMeio: TStringField;
    tbdenunciaEmissao: TStringField;
    tbdenunciaDtEmite: TDateField;
    tbdenunciaDtEncaminha: TDateField;
    tbdenunciaFiscalEncaminha: TStringField;
    tbdenunciaFiscalAtend: TStringField;
    QRLabel4: TQRLabel;
    dsdenuncia: TDataSource;
    QRLabel3: TQRLabel;
    QRLDias: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel5: TQRLabel;
    QRDtencaminha: TQRDBText;
    QRFiscal: TQRDBText;
    QRLabel7: TQRLabel;
    QRAtrazo: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBFiscalencaminha: TQRDBText;
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
   { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_den: Trel_den;

implementation

{$R *.dfm}

procedure Trel_den.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
qrldias.Caption  := '          ';
QRAtrazo.Caption := '          ';

    if tbatenddata_atendimento.IsNull then
        QRAtrazo.Caption := floattostr(daysbetween(date,tbdenunciadata.value))
    else
        qrldias.Caption  := floattostr(daysbetween(tbatenddata_atendimento.value,tbdenunciaDtEncaminha.value));
    if tbdenunciaDtEncaminha.isnull then
        QRDBFiscalencaminha.Visible :=true
    else
        QRDBFiscalencaminha.Visible :=false;
end;

end.
