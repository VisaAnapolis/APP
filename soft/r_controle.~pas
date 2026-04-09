unit r_controle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, DB, DBTables, QRCtrls, StdCtrls, jpeg, Qrprev ;

type
  Trel_controle = class(TForm)
    repcontrole: TQuickRep;
    tbrdpf: TTable;
    dsrdpf: TDataSource;
    tbrdpfControle: TAutoIncField;
    tbrdpfTipo: TStringField;
    tbrdpfNome: TStringField;
    tbrdpfData: TDateField;
    tbrdpfDoc: TStringField;
    tbrdpfEstabe: TStringField;
    tbrdpfMod: TStringField;
    tbrdpfComplex: TStringField;
    tbrdpfPonto: TFloatField;
    QRBand1: TQRBand;
    QRDBText12: TQRDBText;
    QRBand2: TQRBand;
    QRExpr1: TQRExpr;
    QRLabel17: TQRLabel;
    QRShape4: TQRShape;
    QRShape6: TQRShape;
    tbrdpfHomologado: TStringField;
    tbrdpfObs: TMemoField;
    QRDBText8: TQRDBText;
    tbrdpfCnae: TStringField;
    tbrdpfAcao: TStringField;
    PageHeaderBand1: TQRBand;
    QRImage2: TQRImage;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape9: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel12: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape10: TQRShape;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel25: TQRLabel;
    QRLdtini: TQRLabel;
    QRLabel27: TQRLabel;
    QRLdtfim: TQRLabel;
    QRShape11: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel33: TQRLabel;
    QRShape12: TQRShape;
    QRLabel1: TQRLabel;
    QRDBText5: TQRDBText;
    QRShape8: TQRShape;
    QRLabel19: TQRLabel;
    QRLabel2: TQRLabel;
    tbrdpfOS: TIntegerField;
    tbrdpfTIPOOS: TStringField;
    tbrdpfEntrega: TBooleanField;
    tbrdpfUser_homoloda: TStringField;
    tbrdpfData_homologa: TDateField;
    tbrdpfUsuario: TStringField;
    tbrdpfData_altera: TDateField;
    tbrdpfFecha: TBooleanField;
    tbrdpfObs_confere: TMemoField;
    tbrdpfData_fecha: TDateField;
    tbrdpfUsr_fecha: TStringField;
    QRDBText4: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText6: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText7: TQRDBText;
    QRLAtividade: TQRLabel;
    tbrdpfArea: TStringField;
    tbrdpfDupla: TBooleanField;
    QRLabel8: TQRLabel;
    tbrdpfData_os: TDateField;
    tbrdpfNdoc: TStringField;
    QRDBText9: TQRDBText;
    QRLabel9: TQRLabel;
    QRLdupla: TQRLabel;
    QRLDoc: TQRLabel;
    tbrdpfMotivo: TStringField;
    tbrdpfPrazo: TDateField;
    tbrdpfNegativo: TFloatField;
    QRDBText2: TQRDBText;
    QRLabel10: TQRLabel;
    QRExpr2: TQRExpr;
    tbrdpfMeio: TStringField;
    QRLabel11: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel13: TQRLabel;
    QRLCarro: TQRLabel;
    procedure repcontroleBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
     

  private
    { Private declarations }
     carro: short;
    dia: tdatetime;

  public
    { Public declarations }
  end;

var
  rel_controle: Trel_controle;

implementation

uses rdpf;

{$R *.dfm}


    
procedure Trel_controle.repcontroleBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRLdtini.Caption := (datetostr(frmrdpf.DTPrel.Date));
  QRLdtfim.Caption := (datetostr(frmrdpf.DTPFinal.Date));
  carro:=0;
  dia := date;
end;


procedure Trel_controle.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    if (tbrdpfcomplex.Value = 'ALTA' ) and (tbrdpfacao.Value = 'INSPEÇÃO SANITÁRIA')               then qrlatividade.Caption := 'ITEM 1 Anexo VII DECRETO 49.723';

    if (tbrdpfcomplex.Value = 'ALTA' ) and (tbrdpfacao.Value = 'INSPEÇÃO SANITÁRIA') and (tbrdpfarea.Value = 'pequena') then qrlatividade.Caption := 'ITEM 6 Anexo VII DECRETO 49.723';
    if (tbrdpfcomplex.Value = 'ALTA' ) and (tbrdpfacao.Value = 'INSPEÇÃO SANITÁRIA') and (tbrdpfarea.Value = 'média') then qrlatividade.Caption := 'ITEM 5 Anexo VII DECRETO 49.723';
    if (tbrdpfcomplex.Value = 'ALTA' ) and (tbrdpfacao.Value = 'INSPEÇÃO SANITÁRIA') and (tbrdpfarea.Value = 'grande') then qrlatividade.Caption := 'ITEM 4 Anexo VII DECRETO 49.723';

    if (tbrdpfcomplex.Value = 'MÉDIA') and (tbrdpfacao.Value = 'INSPEÇÃO SANITÁRIA')               then qrlatividade.Caption := 'ITEM 2 Anexo VII DECRETO 49.723' ;
    if (tbrdpfcomplex.Value = 'BAIXA') and (tbrdpfacao.Value = 'INSPEÇÃO SANITÁRIA')               then qrlatividade.Caption := 'ITEM 3 Anexo VII DECRETO 49.723' ;

    if (tbrdpfcomplex.Value = 'ALTA' ) and (tbrdpfacao.Value = 'ANÁLISE DE PAS')                   then qrlatividade.Caption := 'ITEM 7 Anexo VII DECRETO 49.723';
    if (tbrdpfcomplex.Value = 'MÉDIA') and (tbrdpfacao.Value = 'ANÁLISE DE PAS')                   then qrlatividade.Caption := 'ITEM 8 Anexo VII DECRETO 49.723' ;

    if tbrdpfdoc.Value = 'PLANTÃO FISCAL'                                                         then qrlatividade.Caption := 'ITEM 9 Anexo VII DECRETO 49.723' ;
    if tbrdpfdoc.Value = 'TERMO DE COLETA DE AMOSTRA'                                             then qrlatividade.Caption := 'ITEM 10 Anexo VII DECRETO 49.723' ;
    if tbrdpfdoc.Value = 'MANIFESTAÇÃO DO FISCAL ATUANTE'                                         then qrlatividade.Caption := 'ITEM 11 Anexo VII DECRETO 49.723' ;
    if tbrdpfdoc.Value = 'APRESENTAÇÃO/PARTICIPAÇÃO/PREPARAÇÃO DE CURSOS E SIMILARES'             then qrlatividade.Caption := 'ITEM 12 Anexo VII DECRETO 49.723' ;

    if (tbrdpfcomplex.Value = 'ALTA' )  and (tbrdpfdoc.Value = 'RELATÓRIO TÉCNICO')               then qrlatividade.Caption := 'ITEM 13 Anexo VII DECRETO 49.723' ;
    if (tbrdpfcomplex.Value = 'MÉDIA' ) and (tbrdpfdoc.Value = 'RELATÓRIO TÉCNICO')               then qrlatividade.Caption := 'ITEM 14 Anexo VII DECRETO 49.723' ;
    if (tbrdpfcomplex.Value = 'MÉDIA' ) and (tbrdpfdoc.Value = 'RELATÓRIO TÉCNICO')               then qrlatividade.Caption := 'ITEM 15 Anexo VII DECRETO 49.723' ;

    if tbrdpfdoc.Value = 'RELATÓRIO HARMONIZADO'                                                  then qrlatividade.Caption := 'ITEM 16 Anexo VII DECRETO 49.723' ;
    if tbrdpfdoc.Value = 'SERVIÇOS TÉCNICOS REALIZADOS NO ÂMBITO DA VIGILÂNCIA SANITÁRIA'         then qrlatividade.Caption := 'ITEM 17 Anexo VII DECRETO 49.723' ;
    if tbrdpfdoc.Value = 'OPERAÇÕES FISCAIS NÃO PREVISTAS E/OU SITUAÇÕES EXTRAORDINÁRIAS'         then qrlatividade.Caption := 'ITEM 18 Anexo VII DECRETO 49.723' ;
    if tbrdpfdoc.Value = 'CERTIDÃO'                                                               then qrlatividade.Caption := 'ITEM 19 Anexo VII DECRETO 49.723' ;
    if tbrdpfdoc.Value = 'AFASTAMENTOS (LC 548/2023)'                                             then qrlatividade.Caption := 'Art. 11 Lei Complentar 548/2023' ;

    if tbrdpfdupla.Value = true then QRLdupla.Caption := 'Sim' else QRLdupla.Caption := '';

    QRLDoc.Caption := '   ';
    if tbrdpfdoc.Value = 'TERMO DE NOTIFICAÇÃO'             then QRLDoc.Caption := 'TN';
    if tbrdpfdoc.Value = 'TERMO DE INTIMAÇÃO'               then QRLDoc.Caption := 'TI';
    if tbrdpfdoc.Value = 'AUTO DE INFRAÇÃO'                 then QRLDoc.Caption := 'AI';
    if tbrdpfdoc.Value = 'AUTO DE IMPOSIÇÃO DE PENALIDADE'  then QRLDoc.Caption := 'AIP';

    if (tbrdpfmeio.Value = 'Próprio') and (dia <> tbrdpfdata.Value) then
    begin
       carro := carro + 1;
       dia := tbrdpfdata.Value;
    end;


end;

procedure Trel_controle.QRBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
qrlatividade.Caption := ' ';
QRLDoc.Caption := '   ';
end;

procedure Trel_controle.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
QRLCarro.Caption := inttostr(carro);
end;

end.
