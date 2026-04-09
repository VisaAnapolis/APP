unit relptden;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DB, DBTables, StdCtrls;

type
  Trel_ptden = class(TForm)
    repdenuncia: TQuickRep;
    banda1: TQRBand;
    QRDBText3: TQRDBText;
    qrldataano: TQRLabel;
    QRLdatames: TQRLabel;
    QRLdatadia: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
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
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    dsdenuncia: TDataSource;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRLabel7: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText8: TQRDBText;
    tbdenunciaDescricao: TStringField;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel23: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel24: TQRLabel;
    QRShape5: TQRShape;
    QRShape4: TQRShape;
    tbdenunciaSINAVISA: TIntegerField;
    tbdenunciaUser: TStringField;
    tbdenunciaMeio: TStringField;
    QRLabel14: TQRLabel;
    QRDBText7: TQRDBText;
    tbsinavisa: TTable;
    tbsinavisaCONTROLE: TAutoIncField;
    tbsinavisaDELE: TBooleanField;
    tbsinavisaCOMPLEXIDADE: TStringField;
    tbsinavisaCODIGO: TIntegerField;
    tbsinavisaPROCEDIMENTO: TStringField;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
    tbdenunciaSatatus: TStringField;
    tbdenunciaCpf: TStringField;
    tbdenunciaCnpj: TStringField;
    tbdenunciaArchive: TBooleanField;
    tbdenunciaEmissao: TStringField;
    QRDBText11: TQRDBText;
    QRLabel17: TQRLabel;
    tbdenunciaDtEmite: TDateField;
    tbdenunciaDtEncaminha: TDateField;
    tbdenunciaFiscalEncaminha: TStringField;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRLabel18: TQRLabel;
    procedure repdenunciaBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_ptden: Trel_ptden;

implementation

{$R *.dfm}

procedure Trel_ptden.repdenunciaBeforePrint(Sender: TCustomQuickRep;var PrintReport: Boolean);
var
mes:integer;
begin
QRLdatadia.Caption:=formatdatetime('dd',tbdenunciadata.value);
mes := strtoint(formatdatetime('mm',tbdenunciadata.value));
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
QRLdataano.Caption:=formatdatetime('yyyy',tbdenunciadata.value);
{QRMObs.Caption:=tbdenunciaobs.Value; }

end;

end.
