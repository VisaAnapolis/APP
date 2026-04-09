        unit relprotocolo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DB, DBTables, StdCtrls, Qrprev;

type
  Trel_protocolo = class(TForm)
    repprotocolo: TQuickRep;
    bandatitulo: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    QRShape3: TQRShape;
    QRLabel13: TQRLabel;
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
    bandape: TQRBand;
    QRShape16: TQRShape;
    QRDBText22: TQRDBText;
    QRLabel42: TQRLabel;
    QRDBText23: TQRDBText;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRDBText24: TQRDBText;
    QRLabel47: TQRLabel;
    QRLdatadia: TQRLabel;
    QRLdatames: TQRLabel;
    QRLdataano: TQRLabel;
    QRImage2: TQRImage;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRShape4: TQRShape;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRShape7: TQRShape;
    QRLabel23: TQRLabel;
    QRDBText17: TQRDBText;
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
    QRLabel6: TQRLabel;
    bandadetalhe: TQRBand;
    QRLabel9: TQRLabel;
    QRDBText5: TQRDBText;
    QRShape8: TQRShape;
    QRLabel10: TQRLabel;
    QRDBText13: TQRDBText;
    QRLabel19: TQRLabel;
    QRDBText14: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText7: TQRDBText;
    QRImageCancel: TQRImage;
    QRDBText10: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel20: TQRLabel;
    QRDBText11: TQRDBText;
    QRDBText15: TQRDBText;
    QRLabel12: TQRLabel;
    QRDBText4: TQRDBText;
    QRSysData1: TQRSysData;
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText8: TQRDBText;
    QRShape2: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    dscontrib: TDataSource;
    procedure repprotocoloBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_protocolo: Trel_protocolo;

implementation

uses  login;


{$R *.dfm}



procedure Trel_protocolo.repprotocoloBeforePrint(Sender: TCustomQuickRep;var PrintReport: Boolean);
var
mes    :integer;
mesenc :integer;
I      :integer;
begin
QRLdatadia.Caption          :=formatdatetime('dd',tbplantadata.value);
// QRLdatadiaencaminha.Caption :=formatdatetime('dd',tbreqdt_encaminha.value);
mes    := strtoint(formatdatetime('mm',tbplantadata.value));
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
QRLdataano.Caption          :=formatdatetime('yyyy',tbplantadata.value);
//QRLdataanoencaminha.Caption :=formatdatetime('yyyy',tbreqdt_encaminha.value);
{QRMObs.Caption:=tbdenunciaobs.Value; }

// if tbreqcancelado.Value = true then QRImageCancel.enabled := true else QRImageCancel.enabled := false;

// *************** PRINT *****************
 if (frmlogin.c_grp = 'CAD') and  (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'ORD') then
 begin
     For I:=1 to Screen.FormCount do
     If Screen.Forms[I-1] is TQRStandardPreview Then
     begin
        TQRStandardPreview(Screen.Forms[I-1]).Print.Visible:=true;
        TQRStandardPreview(Screen.Forms[I-1]).Printsetup.Visible:=true;
        TQRStandardPreview(Screen.Forms[I-1]).Savereport.visible:=true;
        TQRStandardPreview(Screen.Forms[I-1]).LoadReport.Enabled:=true;
     end;
  end;


// *************** PRINT *****************
end;


end.
