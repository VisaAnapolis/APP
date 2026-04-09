unit alvara;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, QUICKRPT, QRCTRLS, ExtCtrls, StdCtrls;

type
  Tfrmalvara = class(TForm)
    realvara: TQuickRep;
    dscontrib: TDataSource;
    QRDBText8: TQRDBText;
    banda1: TQRBand;
    QRDBText3: TQRDBText;
    tbcontrib: TTable;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribCGC: TStringField;
    tbcontribRAZAO: TStringField;
    tbcontribFANTASIA: TStringField;
    tbcontribATIVIDADE: TIntegerField;
    tbcontribMUNICIPAL: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribBAIRRO: TStringField;
    tbcontribZONA: TSmallintField;
    tbrt: TTable;
    tbrtControle: TAutoIncField;
    tbrtCodigo: TIntegerField;
    tbrtNomeResp1: TStringField;
    tbrtConsResp1: TStringField;
    tbrtUFResp1: TStringField;
    tbrtRegResp1: TStringField;
    tbrtNomeResp2: TStringField;
    tbrtConsResp2: TStringField;
    tbrtUFResp2: TStringField;
    tbrtRegResp2: TStringField;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
    tbativ: TTable;
    tbativCONTROLE: TAutoIncField;
    tbativNUMERO: TIntegerField;
    tbativNOME: TStringField;
    QRDBText1: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText14: TQRDBText;
    tbbairro: TTable;
    tbcontribCEP: TStringField;
    tbcontribFONE: TStringField;
    tbcontribTAXA: TBooleanField;
    tbcontribINATIVIDADE: TBooleanField;
    tbcontribOBS: TMemoField;
    QRDBText19: TQRDBText;
    QRDBcgc: TQRDBText;
    QRLcgc: TQRLabel;
    qrldataano: TQRLabel;
    QRLdatames: TQRLabel;
    QRLdatadia: TQRLabel;
    tbalvara: TTable;
    tbalvaraControle: TAutoIncField;
    tbalvaraCodigo: TIntegerField;
    tbalvaraExercicio: TIntegerField;
    tbalvaraUnidade: TStringField;
    tbalvaraNumero: TIntegerField;
    tbalvaraObs: TMemoField;
    tbalvaraDuam: TIntegerField;
    tbalvaraDt_duam: TDateField;
    QRDBText4: TQRDBText;
    QRDBText20: TQRDBText;
    tbgrupo: TTable;
    tbcontribAREA: TIntegerField;
    tbcontribGRUPO: TIntegerField;
    tbgrupoCONTROLE: TAutoIncField;
    tbgrupoCOD: TIntegerField;
    tbgrupoGRUPO: TStringField;
    tbgrupoAREA: TIntegerField;
    tbgrupoDESCRICAO: TStringField;
    tbgrupoVALOR: TCurrencyField;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    tbcontribCDBAI: TIntegerField;
    tbcontribPESSOA: TStringField;
    tbcontribCPF: TStringField;
    tbcontribAGREGADO: TBooleanField;
    tbcontribREPRESENTANTE: TStringField;
    tbcontribCPFREPRES: TStringField;
    tbcontribEMAIL: TStringField;
    tbcontribPendoc: TBooleanField;
    tbcontribDt_cadastro: TDateField;
    tbcontribUser: TStringField;
    tbcontribDt_alter: TDateField;
    tbcontribH_alter: TTimeField;
    procedure realvaraBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public

  end;

var
  frmalvara: Tfrmalvara;



implementation

uses estabe, login;


{$R *.dfm}


procedure Tfrmalvara.realvaraBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var
mes:integer;
begin
QRLdatadia.Caption:=formatdatetime('dd',date);
mes := strtoint(formatdatetime('mm',date));
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
QRLdataano.Caption:=formatdatetime('yyyy',date);
if tbcontribpessoa.Value = 'CPF' then
begin
QRLcgc.enabled := false ;
QRDBcgc.enabled := false;
end
else
begin
QRLcgc.enabled := true ;
QRDBcgc.enabled := true;
end;
end;

procedure Tfrmalvara.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{----------}
frmestabe.tbalvara.edit;
frmestabe.tbalvaraemitente.value := frmlogin.c_user;
frmestabe.tbalvaradt_emite.value := date;
frmestabe.tbalvara.post;
{-----------}

end;

end.
