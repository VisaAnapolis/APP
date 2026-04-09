unit relretorno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, DBTables, dateutils;

type
  TRel_retorno = class(TForm)
    QRret: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRLabel7: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand3: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape2: TQRShape;
    dataini: TQRLabel;
    datafim: TQRLabel;
    tbvisitas: TTable;
    tbvisitasCONTROLE: TAutoIncField;
    tbvisitasCODIGO: TIntegerField;
    tbvisitasDT_VISITA: TDateField;
    tbvisitasPZ_RETORNO: TSmallintField;
    tbvisitasACAO: TStringField;
    tbvisitasTIPO: TStringField;
    tbvisitasDenuncia: TIntegerField;
    tbvisitasNUMERO: TStringField;
    tbvisitasNDOC: TIntegerField;
    tbvisitasFiscal1: TStringField;
    tbvisitasFiscal2: TStringField;
    tbvisitasFiscal3: TStringField;
    dsvisitas: TDataSource;
    QRDBText6: TQRDBText;
    tbcontrib: TTable;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribRAZAO: TStringField;
    tbcontribFANTASIA: TStringField;
    tbcontribATIVIDADE: TIntegerField;
    tbcontribHORARIO: TStringField;
    tbcontribAREA: TIntegerField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribCDBAI: TIntegerField;
    tbcontribINATIVIDADE: TBooleanField;
    QRLabel6: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText9: TQRDBText;
    dscontrib: TDataSource;
    tbativi: TTable;
    tbativiCONTROLE: TAutoIncField;
    tbativiNUMERO: TIntegerField;
    tbativiNOME: TStringField;
    tbativiGRUPO: TIntegerField;
    tbativiSINAVISA: TIntegerField;
    tbativiVALOR: TCurrencyField;
    tbativiAREA: TStringField;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    QRLabel9: TQRLabel;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRLabel10: TQRLabel;
    QRLRet: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel12: TQRLabel;
    QRLAtraso: TQRLabel;
    QRLabel13: TQRLabel;
    tbvisitasPRIORIDADE: TBooleanField;
    QRLCrit: TQRLabel;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rel_retorno: TRel_retorno;

implementation

{$R *.dfm}

procedure TRel_retorno.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    if tbvisitaspz_retorno.value > 0 then
    begin
        QRLRet.Caption    := datetostr(tbvisitasdt_visita.value+tbvisitaspz_retorno.value);
        if (tbvisitasdt_visita.value+tbvisitaspz_retorno.value) < date  then
            QRLAtraso.Caption := inttostr(DaysBetween(date,(tbvisitasdt_visita.value+tbvisitaspz_retorno.value)))
        else
            QRLAtraso.Caption := '0';
    end
    else
    begin
        QRLRet.Caption    :='';
        QRLAtraso.Caption := '';
    end;
    if tbvisitasprioridade.value = true then QRLCrit.Caption := 'Crítico' else QRLCrit.Caption := '';
end;

end.
