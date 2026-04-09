        unit relremessa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DB, DBTables, StdCtrls, Qrprev;

type
  Trel_remessa = class(TForm)
    repremessa: TQuickRep;
    banda1: TQRBand;
    QRDBText3: TQRDBText;
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
    QRShape3: TQRShape;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRLabel13: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape5: TQRShape;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
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
    QRDBText4: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText11: TQRDBText;
    QRLabel20: TQRLabel;
    QRDBText15: TQRDBText;
    QRLabel12: TQRLabel;
    tbplanta: TTable;
    tbplantaControle: TAutoIncField;
    tbplantaCodigo: TIntegerField;
    tbplantaProtocolo: TIntegerField;
    tbplantaData: TDateField;
    tbplantaHora: TTimeField;
    tbplantaProtocolante: TStringField;
    tbplantaDocumento: TStringField;
    tbplantaEmail: TStringField;
    tbplantaCelular: TStringField;
    tbplantaAssunto: TStringField;
    tbplantaUsuario: TStringField;
    DetailBand1: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText7: TQRDBText;
    QRShape6: TQRShape;
    QRShape9: TQRShape;
    tbtramitacao: TTable;
    tbtramitacaoControle: TAutoIncField;
    tbtramitacaoProtocolo: TIntegerField;
    tbtramitacaoData: TDateField;
    tbtramitacaoHora: TTimeField;
    tbtramitacaoDescricao: TStringField;
    tbtramitacaoDestino: TStringField;
    tbtramitacaoDespacho: TMemoField;
    tbtramitacaoUsuario: TStringField;
    QRLabel8: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel10: TQRLabel;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRLabel21: TQRLabel;
    QRLdatadia: TQRLabel;
    QRLabel25: TQRLabel;
    QRLdatames: TQRLabel;
    QRLabel27: TQRLabel;
    QRLdataano: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText14: TQRDBText;
    dscontrib: TDataSource;
    procedure repremessaBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_remessa: Trel_remessa;

implementation

uses  login;


{$R *.dfm}



procedure Trel_remessa.repremessaBeforePrint(Sender: TCustomQuickRep;var PrintReport: Boolean);
var
mes    :integer;
mesenc :integer;
I      :integer;
begin
QRLdatadia.Caption          :=formatdatetime('dd',date);
// QRLdatadiaencaminha.Caption :=formatdatetime('dd',tbreqdt_encaminha.value);
mes    := strtoint(formatdatetime('mm',date));
// mesenc := strtoint(formatdatetime('mm',tbreqdt_encaminha.value));
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
{case mesenc of
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
end;      }
QRLdataano.Caption          :=formatdatetime('yyyy',date);
//QRLdataanoencaminha.Caption :=formatdatetime('yyyy',tbreqdt_encaminha.value);
{QRMObs.Caption:=tbdenunciaobs.Value; }

// if tbreqcancelado.Value = true then QRImageCancel.enabled := true else QRImageCancel.enabled := false;

// *************** PRINT *****************
 {if (frmlogin.c_grp <> 'CAD') and  (frmlogin.c_grp <> 'ADM') then
 begin
     For I:=1 to Screen.FormCount do
     If Screen.Forms[I-1] is TQRStandardPreview Then
     begin
        TQRStandardPreview(Screen.Forms[I-1]).Print.Visible:=False;
        TQRStandardPreview(Screen.Forms[I-1]).Printsetup.Visible:=False;
        TQRStandardPreview(Screen.Forms[I-1]).Savereport.visible:=false;
        TQRStandardPreview(Screen.Forms[I-1]).LoadReport.Enabled:=False;
     end;
  end;   }


// *************** PRINT *****************
end;


end.
