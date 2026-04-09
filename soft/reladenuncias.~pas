unit reladenuncias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, QuickRpt, QRCtrls, StdCtrls, jpeg, dateutils;

type
  Trel_denpen = class(TForm)
    QRDenpen: TQuickRep;
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
    QRDBText3: TQRDBText;
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
    dsdenuncia: TDataSource;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText6: TQRDBText;
    tbdenunciaPrazo: TDateField;
    tbdenunciaPonto: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure BRequerimentoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    contador:integer;
  public
    { Public declarations }
  end;

var
  rel_denpen: Trel_denpen;

implementation

uses principal, login;

{$R *.dfm}



procedure Trel_denpen.FormActivate(Sender: TObject);
begin
    QRLFiscal.Caption    := frmlogin.c_user;
end;

procedure Trel_denpen.BRequerimentoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//    if tbdenunciadtencaminha.IsNull then qrldias.Caption := '' else qrldias.Caption := inttostr(daysbetween(tbdenunciadtencaminha.value,date));
end;

end.
