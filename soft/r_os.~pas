unit r_os;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, QRCtrls, jpeg, QuickRpt, ExtCtrls, StdCtrls;

type
  Trel_os = class(TForm)
    repos: TQuickRep;
    QRBTitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRLabel13: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel24: TQRLabel;
    QRShape5: TQRShape;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLdatames: TQRLabel;
    QRLdataano: TQRLabel;
    QRBDetalhe: TQRBand;
    QRDBText4: TQRDBText;
    QRImage1: TQRImage;
    SummaryBand1: TQRBand;
    QRShape8: TQRShape;
    QRLabel19: TQRLabel;
    QRShape4: TQRShape;
    tbreq: TTable;
    tbreqControle: TAutoIncField;
    tbreqCodigo: TIntegerField;
    tbreqOS: TIntegerField;
    tbreqArea: TStringField;
    tbreqMotivo: TStringField;
    tbreqVeiculos: TSmallintField;
    tbreqRequerente: TStringField;
    tbreqTelefone: TStringField;
    tbreqPeriodo: TStringField;
    tbreqObs_Req: TStringField;
    tbreqDt_Req: TDateField;
    tbreqFiscal_Encaminha: TStringField;
    tbreqRecebedor: TStringField;
    tbreqDt_encaminha: TDateField;
    tbreqEncaminhamento: TBooleanField;
    tbreqEncaminhador: TStringField;
    tbreqAtendimento: TBooleanField;
    tbreqFiscal_Atend: TStringField;
    tbreqDt_Atend: TDateField;
    tbreqTipo_Documento: TStringField;
    tbreqObs_Atend: TStringField;
    tbreqNum_Documento: TStringField;
    procedure reposBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    mes_rel:integer;
    ano_rel:integer;
  end;

var
  rel_os: Trel_os;

implementation

{$R *.dfm}

procedure Trel_os.reposBeforePrint(Sender: TCustomQuickRep;
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
