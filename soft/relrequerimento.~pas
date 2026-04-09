unit relrequerimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DB, DBTables, StdCtrls, Qrprev;

type
  Trel_requer = class(TForm)
    reprequerimento: TQuickRep;
    banda1: TQRBand;
    QRDBText3: TQRDBText;
    QRDBText1: TQRDBText;
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
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRLabel13: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel24: TQRLabel;
    QRShape5: TQRShape;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
    tbreq: TTable;
    dsreq: TDataSource;
    tbreqControle: TAutoIncField;
    tbreqCodigo: TIntegerField;
    tbreqOS: TIntegerField;
    tbreqArea: TStringField;
    tbreqMotivo: TStringField;
    tbreqVeiculos: TSmallintField;
    tbreqRequerente: TStringField;
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
    tbcontrib: TTable;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribPESSOA: TStringField;
    tbcontribCPF: TStringField;
    tbcontribCGC: TStringField;
    tbcontribAGREGADO: TBooleanField;
    tbcontribRAZAO: TStringField;
    tbcontribFANTASIA: TStringField;
    tbcontribREPRESENTANTE: TStringField;
    tbcontribREPRESENTANTE2: TStringField;
    tbcontribCPFREPRES: TStringField;
    tbcontribCPFREPRES2: TStringField;
    tbcontribATIVIDADE: TIntegerField;
    tbcontribHORARIO: TStringField;
    tbcontribAREA: TIntegerField;
    tbcontribGRUPO: TIntegerField;
    tbcontribMUNICIPAL: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribBAIRRO: TStringField;
    tbcontribCDBAI: TIntegerField;
    tbcontribZONA: TSmallintField;
    tbcontribCEP: TStringField;
    tbcontribFONE: TStringField;
    tbcontribCELULAR: TStringField;
    tbcontribEMAIL: TStringField;
    tbcontribTAXA: TBooleanField;
    tbcontribINATIVIDADE: TBooleanField;
    tbcontribOBS: TMemoField;
    tbcontribPendoc: TBooleanField;
    tbcontribDt_cadastro: TDateField;
    tbcontribUser: TStringField;
    tbcontribDt_alter: TDateField;
    tbcontribH_alter: TTimeField;
    dscontrib: TDataSource;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText14: TQRDBText;
    QRLabel9: TQRLabel;
    BAtividade: TQRBand;
    QRDBativ: TQRDBText;
    QRLDescrativi: TQRLabel;
    QRSysData3: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel7: TQRLabel;
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
    tbrtAtividade: TStringField;
    tbrtSubclasse: TStringField;
    tbrtTipo: TStringField;
    QRBand3: TQRBand;
    QRLabel40: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRLabel41: TQRLabel;
    QRShape16: TQRShape;
    QRDBText22: TQRDBText;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRDBText23: TQRDBText;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRDBText24: TQRDBText;
    QRLabel47: TQRLabel;
    QRLdatadiaencaminha: TQRLabel;
    QRLabel49: TQRLabel;
    QRLdatamesencaminha: TQRLabel;
    QRLabel51: TQRLabel;
    QRLdataanoencaminha: TQRLabel;
    QRLdatadia: TQRLabel;
    QRLdatames: TQRLabel;
    QRLdataano: TQRLabel;
    QRLabel10: TQRLabel;
    dsrt: TDataSource;
    tbcnae: TTable;
    tbcnaeControle: TAutoIncField;
    tbcnaeSubclasse: TStringField;
    tbcnaeClasse: TStringField;
    tbcnaeAtividade: TStringField;
    tbcnaeEquipe: TStringField;
    tbcnaeComplexidade: TStringField;
    QRImage2: TQRImage;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRShape4: TQRShape;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRShape6: TQRShape;
    QRDBText2: TQRDBText;
    QRShape7: TQRShape;
    QRLabel19: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText11: TQRDBText;
    QRLabel20: TQRLabel;
    QRDBText12: TQRDBText;
    QRLabel21: TQRLabel;
    QRDBText13: TQRDBText;
    QRImageCancel: TQRImage;
    tbreqNum_Documento: TStringField;
    tbreqCancelado: TBooleanField;
    tbalvara: TTable;
    tbalvaraControle: TAutoIncField;
    tbalvaraCodigo: TIntegerField;
    tbalvaraExercicio: TIntegerField;
    tbalvaraEvento: TBooleanField;
    tbalvaraTipo: TBooleanField;
    tbalvaraNumero: TIntegerField;
    tbalvaraLibera: TBooleanField;
    tbalvaraDt_libera: TDateField;
    tbalvaraAutoridade: TStringField;
    tbalvaraDt_emite: TDateField;
    tbalvaraDt_validade: TDateField;
    tbalvaraCancela: TBooleanField;
    QRDBText15: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel22: TQRLabel;
    QRDBText16: TQRDBText;
    QRLabel23: TQRLabel;
    QRDBText17: TQRDBText;
    QRLabel25: TQRLabel;
    tbreqPrazo: TDateField;
    QRDBText18: TQRDBText;
    QRLabel26: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel27: TQRLabel;
    procedure reprequerimentoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BAtividadeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_requer: Trel_requer;

implementation

uses  login;


{$R *.dfm}

procedure Trel_requer.reprequerimentoBeforePrint(Sender: TCustomQuickRep;var PrintReport: Boolean);
var
mes    :integer;
mesenc :integer;
I      :integer;
begin
QRLdatadia.Caption          :=formatdatetime('dd',tbreqdt_req.value);
QRLdatadiaencaminha.Caption :=formatdatetime('dd',tbreqdt_encaminha.value);
mes    := strtoint(formatdatetime('mm',tbreqdt_req.value));
mesenc := strtoint(formatdatetime('mm',tbreqdt_encaminha.value));
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
case mesenc of
        1: QRLdatamesencaminha.Caption:='janeiro';
        2: QRLdatamesencaminha.Caption:='fevereiro';
        3: QRLdatamesencaminha.Caption:='março';
        4: QRLdatamesencaminha.Caption:='abril';
        5: QRLdatamesencaminha.Caption:='maio';
        6: QRLdatamesencaminha.Caption:='junho';
        7: QRLdatamesencaminha.Caption:='julho';
        8: QRLdatamesencaminha.Caption:='agosto';
        9: QRLdatamesencaminha.Caption:='setembro';
        10: QRLdatamesencaminha.Caption:='outubro';
        11: QRLdatamesencaminha.Caption:='novembro';
        12: QRLdatamesencaminha.Caption:='dezembro';
end;
QRLdataano.Caption          :=formatdatetime('yyyy',tbreqdt_req.value);
QRLdataanoencaminha.Caption :=formatdatetime('yyyy',tbreqdt_encaminha.value);
{QRMObs.Caption:=tbdenunciaobs.Value; }

if tbreqcancelado.Value = true then QRImageCancel.enabled := true else QRImageCancel.enabled := false;

// *************** PRINT *****************
 if (frmlogin.c_grp <> 'CAD') and  (frmlogin.c_grp <> 'ADM') then
 begin
     For I:=1 to Screen.FormCount do
     If Screen.Forms[I-1] is TQRStandardPreview Then
     begin
        TQRStandardPreview(Screen.Forms[I-1]).Print.Visible:=False;
        TQRStandardPreview(Screen.Forms[I-1]).Printsetup.Visible:=False;
        TQRStandardPreview(Screen.Forms[I-1]).Savereport.visible:=false;
        TQRStandardPreview(Screen.Forms[I-1]).LoadReport.Enabled:=False;
     end;
  end;


// *************** PRINT *****************
end;

procedure Trel_requer.BAtividadeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
if tbcnae.FindKey([tbrtsubclasse.value]) then QRLDescrativi.caption:=tbcnaeatividade.value else QRLDescrativi.caption:='';;
end;

end.
