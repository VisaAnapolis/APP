unit relaoficio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, QuickRpt, QRCtrls, StdCtrls, jpeg, dateutils;

type
  Trel_ofi = class(TForm)
    QRofi: TQuickRep;
    Btitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    BOficio: TQRBand;
    QRDBText11: TQRDBText;
    QRDBText15: TQRDBText;
    QRBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLFiscal: TQRLabel;
    tbofi: TTable;
    dsofi: TDataSource;
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
    QRLabel14: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel18: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel19: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBTPZ: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel12: TQRLabel;
    tbofiControle: TAutoIncField;
    tbofiOficio: TIntegerField;
    tbofiData: TDateField;
    tbofiEmitente: TStringField;
    tbofiMotivo: TStringField;
    tbofiRegulado: TStringField;
    tbofiLogradouro: TStringField;
    tbofiCdbai: TSmallintField;
    tbofiOrdem: TStringField;
    tbofiCpf: TStringField;
    tbofiCnpj: TStringField;
    tbofiFiscalencaminha: TStringField;
    tbofiDtencaminha: TDateField;
    tbofiPrazo: TDateField;
    tbofiDtatendimento: TDateField;
    tbofiCancela: TBooleanField;
    tbofiArchive: TBooleanField;
    tbofiUser: TStringField;
    QRLabel7: TQRLabel;
    tbofiFantasia: TStringField;
    QRDBText3: TQRDBText;
    QRLabel11: TQRLabel;
    procedure FormActivate(Sender: TObject);
    procedure BOficioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    contador:integer;
  public
    { Public declarations }
  end;

var
  rel_ofi: Trel_ofi;

implementation

uses principal, login;

{$R *.dfm}



procedure Trel_ofi.FormActivate(Sender: TObject);
begin
    QRLFiscal.Caption    := frmlogin.c_user;
end;

procedure Trel_ofi.BOficioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//     if tbreqprioridade.value = true then QRSPriori.Enabled := true else QRSPriori.Enabled := false;
//     if tbalvaratipo.value = true    then QRLProv.Enabled := true   else QRLProv.Enabled := false;
//    if tbofiprazo.IsNull then qrldias.Caption := '' else qrldias.Caption := inttostr(daysbetween(date,tbofiprazo.value));
//    if tbreq
{     if tbcnaecomplexidade.Value = 'BAIXA' then qrldias.Caption :='0'
\\     else
\\     if tbreqdt_encaminha.value > date then
\\         qrldias.Caption := inttostr(daysbetween(tbreqdt_encaminha.value,date))
 \\    else
\\         qrldias.Caption := '0';
\\     if tbcnaecomplexidade.Value = 'BAIXA' then QRDBTdtencaminha.Enabled := false else QRDBTdtencaminha.Enabled := true;}
end;

end.
