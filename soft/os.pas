unit os;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, Mask, DBCtrls, ExtCtrls, Buttons,
  ToolWin, ComCtrls, Grids, DBGrids, jpeg, dateutils;

type
  TfrmOs = class(TForm)
    GPReq: TGroupBox;
    GPOS: TGroupBox;
    GPAtend: TGroupBox;
    dssequencia: TDataSource;
    tbsequencia: TTable;
    tbsequenciaNumero: TIntegerField;
    tbsequenciaDoc: TIntegerField;
    tbsequenciaDen: TIntegerField;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    dsbairro: TDataSource;
    tbcontrib: TTable;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribFANTASIA: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribATIVIDADE: TSmallintField;
    tbcontribCEP: TStringField;
    tbcontribFONE: TStringField;
    tbcontribCGC: TStringField;
    tbcontribINATIVIDADE: TBooleanField;
    tbcontribRAZAO: TStringField;
    tbcontribAREA: TIntegerField;
    tbcontribEMAIL: TStringField;
    tbcontribCDBAI: TIntegerField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribPESSOA: TStringField;
    tbcontribCPF: TStringField;
    tbcontribZONA: TSmallintField;
    tbcontribREPRESENTANTE: TStringField;
    tbcontribCPFREPRES: TStringField;
    tbcontribHORARIO: TStringField;
    tbcontribREPRESENTANTE2: TStringField;
    tbcontribCPFREPRES2: TStringField;
    tbcontribCELULAR: TStringField;
    barraferra: TToolBar;
    btnovo: TSpeedButton;
    btaltera: TSpeedButton;
    btlocreq: TSpeedButton;
    btgrava: TSpeedButton;
    btcancel: TSpeedButton;
    btdeleta: TSpeedButton;
    btprn: TSpeedButton;
    btfecha: TSpeedButton;
    btlocon: TSpeedButton;
    navegador: TDBNavigator;
    Proto: TDBEdit;
    DBEdata: TDBEdit;
    BtProcura: TButton;
    DBERequerente: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBElogradouro: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBLBairro: TDBLookupComboBox;
    Label7: TLabel;
    DBEAlvara: TDBEdit;
    DBFantasia: TDBEdit;
    Label12: TLabel;
    Label39: TLabel;
    DBCHora: TDBComboBox;
    Label8: TLabel;
    DBECelular: TDBEdit;
    DBEfone: TDBEdit;
    Label14: TLabel;
    DBEmail: TDBEdit;
    Label52: TLabel;
    Label16: TLabel;
    DBMObsReq: TDBMemo;
    dscontrib: TDataSource;
    tbreq: TTable;
    dsreq: TDataSource;
    Label9: TLabel;
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
    tbreqEncaminhador: TStringField;
    tbreqFiscal_Atend: TStringField;
    tbreqDt_Atend: TDateField;
    tbreqTipo_Documento: TStringField;
    tbreqObs_Atend: TStringField;
    tbreqDt_encaminha: TDateField;
    Label1: TLabel;
    Label10: TLabel;
    DBERecebe: TDBEdit;
    tbsequenciaAlvara: TIntegerField;
    tbsequenciaVeiculo: TIntegerField;
    tbsequenciaPt: TIntegerField;
    tbsequenciaDisponibilidade: TBooleanField;
    tbsequenciaVersao: TStringField;
    tbsequenciaDt_versao: TStringField;
    StatusBar1: TStatusBar;
    tbbairroIA: TStringField;
    tbbairroAG: TStringField;
    tbbairroED: TStringField;
    tbbairroOS: TStringField;
    tbbairroSS: TStringField;
    tbbairroOD: TStringField;
    tbbairroCS: TStringField;
    tbbairroAM: TStringField;
    tbbairroVT: TStringField;
    tbbairroBI: TStringField;
    tbbairroLP: TStringField;
    tbbairroAO: TStringField;
    tbbairroTR: TStringField;
    tbbairroFU: TStringField;
    tbbairroDR: TStringField;
    tbbairroMD: TStringField;
    tbcnae: TTable;
    dscnae: TDataSource;
    tbcnaeControle: TAutoIncField;
    tbcnaeSubclasse: TStringField;
    tbcnaeClasse: TStringField;
    tbcnaeAtividade: TStringField;
    tbcnaeEquipe: TStringField;
    DBEDtos: TDBEdit;
    DBCencaminha: TDBComboBox;
    Label11: TLabel;
    Label13: TLabel;
    DBEdit2: TDBEdit;
    Label15: TLabel;
    tbcnaeComplexidade: TStringField;
    DBEdit4: TDBEdit;
    Label18: TLabel;
    DBEdit5: TDBEdit;
    Label19: TLabel;
    tbreqEncaminhamento: TBooleanField;
    tbreqAtendimento: TBooleanField;
    tbrt: TTable;
    dsrt: TDataSource;
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
    DBNavCAE: TDBNavigator;
    DBGCae: TDBGrid;
    dblsub: TDBLookupComboBox;
    DBLdescri: TDBLookupComboBox;
    Label20: TLabel;
    Label22: TLabel;
    DBCMotivo: TDBComboBox;
    Label21: TLabel;
    DBERequer: TDBEdit;
    Label23: TLabel;
    DBEdit7: TDBEdit;
    tbreqNum_Documento: TStringField;
    DBEdit8: TDBEdit;
    tbauxreq: TTable;
    tbauxreqControle: TAutoIncField;
    tbauxreqCodigo: TIntegerField;
    tbauxreqOS: TIntegerField;
    tbreqCancelado: TBooleanField;
    Imcancel: TImage;
    lbatend: TLabel;
    tbauxreqAtendimento: TBooleanField;
    tbauxreqCancelado: TBooleanField;
    tbcontribMUNICIPAL: TStringField;
    tbreqPrioridade: TBooleanField;
    tbalvara: TTable;
    tbalvaraControle: TAutoIncField;
    tbalvaraCodigo: TIntegerField;
    tbalvaraExercicio: TIntegerField;
    tbalvaraEvento: TBooleanField;
    tbalvaraTipo: TBooleanField;
    tbalvaraNumero: TIntegerField;
    tbalvaraDt_validade: TDateField;
    tbalvaraCancela: TBooleanField;
    tbalvaraDt_cancela: TDateField;
    dsalvara: TDataSource;
    Btpt: TSpeedButton;
    tbauxreqMotivo: TStringField;
    DBEPrazo: TDBEdit;
    tbreqPrazo: TDateField;
    Label6: TLabel;
    tbreqFiscal_Sugere: TStringField;
    Label17: TLabel;
    DBComboBox1: TDBComboBox;
    Label24: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DBEdit6: TDBEdit;
    tbreqComplexidade: TStringField;
    Label25: TLabel;
    DBMJusta: TDBMemo;
    lbencaminha: TLabel;
    tbreqJustificativa: TMemoField;
    Bt1: TButton;
    Bt5: TButton;
    Bt10: TButton;
    bt30: TButton;
    GBCNAE: TGroupBox;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    DBEdit1: TDBEdit;
    DBEdit3: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBEdit9: TDBEdit;
    DBLookupComboBox4: TDBLookupComboBox;
    DBEdit10: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBMemo1: TDBMemo;
    Label27: TLabel;
    procedure btfechaClick(Sender: TObject);
    procedure btnovoClick(Sender: TObject);
    procedure btalteraClick(Sender: TObject);
    procedure btgravaClick(Sender: TObject);
    procedure btcancelClick(Sender: TObject);
    procedure BtProcuraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsreqStateChange(Sender: TObject);
    procedure BtdevolveClick(Sender: TObject);
    procedure btprnClick(Sender: TObject);
    procedure btlocreqClick(Sender: TObject);
    procedure btdeletaClick(Sender: TObject);
    procedure tbreqAfterScroll(DataSet: TDataSet);
//    procedure BtSalvadevClick(Sender: TObject);
//    procedure BtCancDevClick(Sender: TObject);
    procedure DBCencaminhaChange(Sender: TObject);
    procedure btloconClick(Sender: TObject);
    procedure DBCMotivoChange(Sender: TObject);
    procedure BtptClick(Sender: TObject);
    procedure Bt1Click(Sender: TObject);
    procedure Bt5Click(Sender: TObject);
    procedure Bt10Click(Sender: TObject);
    procedure bt30Click(Sender: TObject);
//    procedure BtgravadevolveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOs: TfrmOs;

implementation

uses LOCPRO3, locpro4, login, relrequerimento, locreq, relptos;

{$R *.dfm}

procedure TfrmOs.btfechaClick(Sender: TObject);
begin
close;
end;

procedure TfrmOs.btnovoClick(Sender: TObject);
var
req:integer;
begin
    if (frmlogin.c_grp = 'CAD') or
       (frmlogin.c_per = 'ORD') or
       (frmlogin.c_grp = 'ADM') then
    begin
//       if tbreq.findkey([tbcontribcodigo.value]) then
//       begin
            GPOS.Enabled := false;
            GBCNAE.Enabled := false;
            tbreq.Last;
            tbreq.Insert;
            tbsequencia.edit;
            req:=tbsequenciapt.value+1;
            tbreqos.value:=req;
            tbsequenciapt.value:=req;
            tbsequencia.post;
            tbreqDt_req.Value:=date;
            BTPROCURA.setfocus;
            tbreqrecebedor.value := frmlogin.c_user;
 //       end
 //       else
 //       begin
 //           showmessage('Regulado com requerimemnto já protocolado: '+tbreqos.AsString);
//        end;
    end
    else showmessage('Função permitida somente para pessoal administrativo');
end;


procedure TfrmOs.btalteraClick(Sender: TObject);
begin
if tbreqcancelado.value = false then
begin
if tbreqatendimento.value = false then
begin
 if (frmlogin.c_grp = 'CAD') or
    (frmlogin.c_per = 'ORD') or
    (frmlogin.c_grp = 'ADM') then
    begin
    if (frmlogin.c_grp = 'CAD') and (tbreqencaminhamento.Value = true) then
        begin
            showmessage('OS já encaminhada, Impossível alterar');
            exit
        end;
        tbreq.Edit;
        tbcontrib.Edit;
        DBCMotivo.SetFocus;
       if (frmlogin.c_grp = 'ADM') or
          (frmlogin.c_per = 'ORD') then
        begin
           DBEDtos.readonly          := false;
           DBEDtos.Color             := clWindow;
           if tbreqencaminhamento.Value <> true then tbreqdt_encaminha.Value   := date;
           tbreqencaminhamento.Value := true;
           tbreqencaminhador.Value   := frmlogin.c_user;
           DBCencaminha.SetFocus;
        end;
    end else  messagedlg('Função para funcionários administrativos',mtwarning,[mbok],0);
end
else messagedlg('Ordem de Serviço já cumprida ! ',mtwarning,[mbok],0);
end
else messagedlg('Ordem de Serviço Cancelada ! ',mtwarning,[mbok],0);
end;


procedure TfrmOs.btgravaClick(Sender: TObject);
var
pode : boolean;

begin
   pode := false;
   
   if tbreqOs.IsNull then
   begin
      messagedlg('Falha da rede, impossível gerar OS',mtwarning,[mbok],0);
      DBCMotivo.SetFocus;
      exit;
   end;

   if tbreqMotivo.IsNull then
   begin
      messagedlg('Selecione o motivo do requerimento',mtwarning,[mbok],0);
      DBCMotivo.SetFocus;
      exit;
   end;

   if tbcontribCELULAR.IsNull then
   begin
      messagedlg('Informe o telefone móvel do requerente',mtwarning,[mbok],0);
      DBECelular.SetFocus;
      exit;
   end;        

   if tbcontribHORARIO.IsNull then
   begin
      messagedlg('Selecione o período de funcionamento do regulado',mtwarning,[mbok],0);
      DBCHora.SetFocus;
      exit;
   end;

   if    tbreqRequerente.IsNull then
   begin
       messagedlg('Informe o nome da pessoa que faz a solicitação',mtwarning,[mbok],0);
       DBERequer.SetFocus;
       exit;
   end;

   if tbauxreq.FindKey([tbreqcodigo.value]) then
   while not tbauxreq.Eof do
   begin
       if tbauxreqcodigo.value <> tbreqcodigo.value then tbauxreq.Last;
       if (tbreqcodigo.Value = tbauxreqcodigo.value) and (tbreqos.Value <> tbauxreqos.Value) and (tbreqmotivo.Value = tbauxreqmotivo.Value) and  (tbauxreqcancelado.Value <> true) and (tbauxreqatendimento.Value <> true) then
       begin
           messagedlg('Já existe solicitaçao para esta finalidade em aberto',mtwarning,[mbok],0);
           DBCMotivo.SetFocus;
           exit;
       end;
       tbauxreq.Next;
   end;

   if (tbreqmotivo.Value =  'Ren. Medicamentos') or (tbreqmotivo.Value =  'Ren. Cosméticos/Saneantes') or (tbreqmotivo.Value =  'Ren. Produtos para Saúde') then
   begin
           if tbauxreq.FindKey([tbreqcodigo.value]) then
           while not tbauxreq.Eof do
           begin
               if tbauxreqcodigo.value <> tbreqcodigo.value then tbauxreq.Last;
               if (tbreqcodigo.Value = tbauxreqcodigo.value) and (tbreqos.Value <> tbauxreqos.Value) and (tbauxreqmotivo.Value = 'Renovação') and  (tbauxreqcancelado.Value <> true) and (tbauxreqatendimento.Value <> true) then pode := true;
               tbauxreq.Next;
           end;

           if pode <> true then
           begin
              messagedlg('Finalidade selecionada é inválida, pois não existe solicitaçao de Renovação em aberto.',mtwarning,[mbok],0);
              DBCMotivo.SetFocus;
              exit;
           end;
   end;

    if tbreqencaminhamento.Value <> true then
    begin;
        tbrt.First;
        while not tbrt.Eof do
        begin
            if tbrttipo.Value = 'Principal' then
            begin
//             messagedlg('achei a principal'+tbrtcodigo.asstring,mtwarning,[mbok],0);
                if tbcnae.FindKey([tbrtsubclasse.value]) then
                begin
//                messagedlg('achei a ssubclasse'+tbrtcodigo.asstring,mtwarning,[mbok],0);
                    if tbcnaeequipe.Value = 'IA' then tbreqfiscal_sugere.Value := tbbairroIA.Value;
                    if tbcnaeequipe.Value = 'AG' then tbreqfiscal_sugere.Value := tbbairroAG.Value;
                    if tbcnaeequipe.Value = 'ED' then tbreqfiscal_sugere.Value := tbbairroED.Value;
                    if tbcnaeequipe.Value = 'OS' then tbreqfiscal_sugere.Value := tbbairroOS.Value;
                    if tbcnaeequipe.Value = 'SS' then tbreqfiscal_sugere.Value := tbbairroSS.Value;
                    if tbcnaeequipe.Value = 'OD' then tbreqfiscal_sugere.Value := tbbairroOD.Value;
                    if tbcnaeequipe.Value = 'ED' then tbreqfiscal_sugere.Value := tbbairroED.Value;
                    if tbcnaeequipe.Value = 'CS' then tbreqfiscal_sugere.Value := tbbairroCS.Value;
                    if tbcnaeequipe.Value = 'AM' then tbreqfiscal_sugere.Value := tbbairroAM.Value;
                    if tbcnaeequipe.Value = 'VT' then tbreqfiscal_sugere.Value := tbbairroVT.Value;
                    if tbcnaeequipe.Value = 'BI' then tbreqfiscal_sugere.Value := tbbairroBI.Value;
                    if tbcnaeequipe.Value = 'LP' then tbreqfiscal_sugere.Value := tbbairroLP.Value;
                    if tbcnaeequipe.Value = 'AO' then tbreqfiscal_sugere.Value := tbbairroAO.Value;
                    if tbcnaeequipe.Value = 'TR' then tbreqfiscal_sugere.Value := tbbairroTR.Value;
                    if tbcnaeequipe.Value = 'FU' then tbreqfiscal_sugere.Value := tbbairroFU.Value;
                    if tbcnaeequipe.Value = 'DR' then tbreqfiscal_sugere.Value := tbbairroDR.Value;
                    if tbcnaeequipe.Value = 'MD' then tbreqfiscal_sugere.Value := tbbairroMD.Value;
                end;
            end;
            tbreqfiscal_encaminha.Value:= 'GERENTE DE VIGILÂNCIA SANITÁRIA';
            tbreqencaminhador.Value  := frmlogin.c_user;
            tbrt.Next;
        end;
   end;
//    DBEDtos.Color    := clInfoBk;
//    DBEDtos.readonly := true;
    tbcontrib.post;

    if  tbreqfiscal_encaminha.value <> 'GERENTE DE VIGILÂNCIA SANITÁRIA' then
    begin
//        tbreqdt_encaminha.Value     := date;
         tbreqencaminhador.Value     := frmlogin.c_user;
         tbreqcomplexidade.Value     := tbcnaecomplexidade.Value;
         tbreqarea.Value             := tbcnaesubclasse.value;

         if (tbreqcomplexidade.Value = 'MÉDIA') and (tbreqmotivo.Value ='Abertura') then
         tbreqprazo.Value := tbreqdt_encaminha.Value + 60 else
         tbreqprazo.Value := tbreqdt_encaminha.Value + 90;

         if tbreqcomplexidade.Value = 'BAIXA' then
         tbreqprazo.clear;
    end;

 {   if tbreqprazo.value < date then
    begin
       messagedlg('Atenção! Prazo informado inválido... '+tbreqprazo.asstring,mtwarning,[mbok],0);
       DBEPrazo.setfocus;
       exit
    end;

    if (tbreqdt_encaminha.Value <> date) and  (tbreqprazo.value > 30) then
    begin
       messagedlg('Atenção! Prazo da OS maior 30 dias... '+tbreqprazo.asstring,mtwarning,[mbok],0);
       DBEPrazo.setfocus;
       exit
    end;  }

    tbreq.Post;
    GPOS.Enabled       :=true;
    GBCNAE.Enabled := true;
//    Btdevolve.enabled  :=true;
//    BtSalvadev.Enabled :=true;
//    BtCancDev.enabled  :=true

end;

procedure TfrmOs.btcancelClick(Sender: TObject);
begin
      DBEDtos.readonly          := true;
      DBEDtos.Color             := clInfoBk;
      tbcontrib.cancel;
      tbreq.Cancel;
           GPOS.Enabled       :=true;
           GBCNAE.Enabled := true;
//           Btdevolve.enabled  :=true;
//           BtSalvadev.Enabled :=true;
//           BtCancDev.enabled  :=true

end;

procedure TfrmOs.BtProcuraClick(Sender: TObject);
begin
     frmlocpro3.Showmodal;
     tbauxreq.filtered := true;
     tbauxreq.Filter   := 'atendimento <> true and cancelado <> true';
     if tbauxreq.findkey([tbcontribcodigo.value]) then
     begin
        if (frmlogin.c_grp = 'ADM') OR (frmlogin.c_per = 'ORD') OR (frmlogin.c_grp = 'CAD') then
         begin
            if messagedlg('Atenção!!!! Regulado com requerimento Pendente: '+tbauxreqos.AsString+ '. Deseja registrar outro requerimento para este regulado ?',mtconfirmation,[mbyes,mbno],0)=mryes then dbcmotivo.setfocus else
             begin
                 tbcontrib.cancel;
                 tbreq.cancel;
                 tbreq.findkey([tbauxreqos.value]);
             end;
         end
         else
         begin
             showmessage('Regulado com requerimento Pendente: '+tbauxreqos.AsString+ '. Só pode ser requerido pela gerência');
             tbcontrib.cancel;
             tbreq.cancel;
             tbreq.findkey([tbauxreqos.value]);
         end;
     end;
     tbauxreq.filtered := false;
     if tbalvara.FindKey([tbcontribcodigo.value]) then  if (daysbetween(date,tbalvaradt_validade.value) > 120) and (tbalvaradt_validade.value > date) then
     begin
         if (frmlogin.c_grp = 'ADM') OR (frmlogin.c_per = 'ORD') OR (frmlogin.c_grp = 'CAD') then
         if messagedlg('Alvará com validade até:  '+datetostr(tbalvaradt_validade.value)+ '. Deseja requerer com mais de 120 dias de antecipação ?',mtconfirmation,[mbyes,mbno],0)=mryes then dbcmotivo.setfocus else
         begin
             tbcontrib.cancel;
             tbreq.cancel;
             tbreq.last;
         end
         else
         begin
             showmessage('Alvará com validade até:  '+datetostr(tbalvaradt_validade.value)+'.  Só pode ser requerido pela gerência.');
             tbcontrib.cancel;
             tbreq.cancel;
             tbreq.last;
         end;
     end;
end;

procedure TfrmOs.FormActivate(Sender: TObject);

begin
tbalvara.Open;
tbauxreq.open;
tbreq.Open;
tbsequencia.open;
tbcontrib.Open;
tbrt.open;
tbbairro.open;
tbcnae.open;

if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_grp <> 'FIS') and (frmlogin.c_grp <> 'CAD') and (frmlogin.c_per <> 'PRO')then
begin
    gpos.Visible := false;
    gpatend.Visible := false;
    GBCNAE.Visible := true;
//    showmessage('Atenção! Conferir os CNAEs de acordo com o cadastro da Receita Municipal antes de registrar o Protocolo'); 
end;
if frmlogin.c_grp = 'ADM' then
    begin
        Bt1.Enabled  := true;
        Bt5.Enabled  := true;
        Bt10.Enabled := true;
        Bt30.Enabled := true;
    end
    else
    begin
        Bt1.Enabled  := false;
        Bt5.Enabled  := false;
        Bt10.Enabled := false;
        Bt30.Enabled := false;
    end;
end;

procedure TfrmOs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbauxreq.Close;
tbcnae.close;
tbrt.close;
tbbairro.close;
tbcontrib.close;
tbreq.close;
tbsequencia.close;
tbalvara.Close;
end;

procedure TfrmOs.dsreqStateChange(Sender: TObject);
begin
    if tbreq.state=dsbrowse then statusbar1.panels[0].text:=' [F1] Ajuda   [F2] Pesquisa   [F3] Inclusão   [F4] Alteração   [F5] Emite Protocolo' else statusbar1.panels[0].text:=' [F6] Grava   [ESC] Cancela';
//  btprocura.Enabled    := tbreq.state =  dsinsert;
    btnovo.enabled       := tbreq.state =  dsbrowse;
    btaltera.enabled     := tbreq.state =  dsbrowse;
    Bt1.enabled          := tbreq.state =  dsbrowse;
    Bt5.enabled          := tbreq.state =  dsbrowse;
    Bt10.enabled         := tbreq.state =  dsbrowse;
    Bt30.enabled         := tbreq.state =  dsbrowse;
    btlocreq.enabled     := tbreq.state =  dsbrowse;
    btgrava.enabled      := tbreq.state <> dsbrowse;
    btcancel.enabled     := tbreq.state <> dsbrowse;
    btdeleta.enabled     := tbreq.state =  dsbrowse;
    btpt.enabled         := tbreq.state =  dsbrowse;
    btprn.enabled        := tbreq.state =  dsbrowse;
    btfecha.enabled      := tbreq.state =  dsbrowse;
    btlocon.enabled      := tbreq.state =  dsbrowse;
    navegador.enabled    := tbreq.state =  dsbrowse;
//  btdevolve.enabled    := tbreq.state =  dsbrowse;
//  BtSalvadev.Enabled   := tbreq.state <> dsbrowse;
//  BtCancDev.Enabled    := tbreq.state <> dsbrowse;
    DBNavCAE.Enabled     := tbreq.state =  dsbrowse;
    DBGCae.Enabled       := tbreq.state =  dsbrowse;
    proto.Visible        := tbreq.state =  dsbrowse;
    if tbreqcancelado.Value = true   then Imcancel.Visible := true else Imcancel.Visible := false;
    if tbreqatendimento.Value = true then Lbatend.Visible  := true else Lbatend.Visible := false;
    if (tbreqencaminhamento.Value = true) and (tbreqcancelado.value <> true) then lbencaminha.Visible  := true else lbencaminha.Visible := false;
end;

procedure TfrmOs.BtdevolveClick(Sender: TObject);
begin
 if tbreqcancelado.value = false then
 begin
  if tbreqatendimento.value = false then
  begin
    if (frmlogin.c_grp = 'FIS') and (frmlogin.c_user = tbreqfiscal_encaminha.value) then
    begin
       //  if tbreqencaminhamento.Value = false then
     //    begin
             barraferra.Enabled:=false;
             GPReq.Enabled:= false;
             DBCencaminha.Enabled:= false;
//             CBPriori.enabled    := false;
             tbreq.Edit;
//             DBMObs.SetFocus;
     //    end
     //    else showmessage('Encaminhamento ratificado pela gerência. Impossível devolver');
    end
    else showmessage('Função permitida somente para fiscal encarregado');
  end
  else showmessage('OS já cumprida');
end
else  showmessage('OS já cancelada');
end;

procedure TfrmOs.btprnClick(Sender: TObject);
begin
  if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'ORD') then
  begin
    if tbreqatendimento.value = false then
    begin
        rel_requer.tbreq.open;
        rel_requer.tbcontrib.open;
        rel_requer.tbrt.open;
        rel_requer.tbcnae.open;
        rel_requer.tbbairro.open;
        rel_requer.tbalvara.Open;
        rel_requer.tbreq.FindKey([tbreqcontrole.value]);
        rel_requer.reprequerimento.preview;
        rel_requer.tbalvara.close;
        rel_requer.tbbairro.close;
        rel_requer.tbcnae.close;
        rel_requer.tbrt.close;
        rel_requer.tbcontrib.close;
        rel_requer.tbreq.close;
        navegador.setfocus;
    end
    else messagedlg('Ordem de Serviço já cumprida ! ',mtwarning,[mbok],0);
   end
   else messagedlg('Perfil no Autorizado ! ',mtwarning,[mbok],0);
end;


procedure TfrmOs.btlocreqClick(Sender: TObject);
begin
   frmlocos.ShowModal;
   tbreq.Indexfieldnames := 'OS';
   tbreq.findkey([frmlocos.lugarreq]);
   if frmlocos.loc_req = 0 then tbreq.Indexfieldnames := 'OS';
   if frmlocos.loc_req = 1 then tbreq.Indexfieldnames := 'Fiscal_Encaminha';
   if frmlocos.loc_req = 2 then tbreq.Indexfieldnames := 'codigo;OS';

end;

{procedure TfrmOs.BtgravadevolveClick(Sender: TObject);
begin
 if messagedlg('Confirma a devoluçãio da Ordem de Serviço '+ tbreqos.AsString+ ' - '+tbcontribrazao.value+' ?',mtconfirmation,[mbyes,mbno],0)=mryes then
 begin
    tbreq.post;
    Btgravadevolve.Enabled :=false;
 end
 else exit;
end;  }

procedure TfrmOs.btdeletaClick(Sender: TObject);
begin
    if (frmlogin.c_grp = 'ADM') OR (frmlogin.c_per = 'ORD') then
    begin
        if tbreqatendimento.Value = false then
        begin
            if not tbreqObs_Req.isnull then
            begin
               if messagedlg('Confirma o Cancelamendo da Ordem de Serviço ?'+ tbreqos.AsString+ ' - '+tbcontribrazao.value+' ?',mtconfirmation,[mbyes,mbno],0)=mryes then
               begin
                   tbreq.Edit;
                   tbreqcancelado.Value := true;
                   tbreq.Post;
               end
               else exit;
            end
            else showmessage('Informar o Motivo do Cancelamento');
        end
        else showmessage('Impossível cancelar. Os Atendida');
    end
    else showmessage('Função permitida somente para a Gerência');
end;

procedure TfrmOs.tbreqAfterScroll(DataSet: TDataSet);
begin
    if tbreqcancelado.Value = true then Imcancel.Visible := true else Imcancel.Visible := false;
    if tbreqatendimento.Value = true then Lbatend.Visible  := true else Lbatend.Visible := false;
    if (tbreqencaminhamento.Value = true) and (tbreqcancelado.value <> true) then lbencaminha.Visible  := true else lbencaminha.Visible := false;
end;

{procedure TfrmOs.BtSalvadevClick(Sender: TObject);
begin
    if tbreqObs_Atend.IsNull then
    begin
        showmessage('Informe o Motivo da Devolução');
        DBMObs.SetFocus;
        exit;
    end;

    begin
        tbreqfiscal_encaminha.Value := 'ARIANE CAMILA RODRIGUES';
        tbreqencaminhador.Value     :=  frmlogin.c_user;
        if messagedlg('Confirma a devolução da Ordem de Serviço '+ tbreqos.AsString+ ' - '+tbcontribrazao.value+' ?', mtconfirmation,[mbyes,mbno],0)=mryes then tbreq.post else exit;
    end;
    barraferra.Enabled:=true;
    GPReq.Enabled:= true;
    DBCencaminha.Enabled:=false;
//    CBPriori.enabled   := false;
end;

procedure TfrmOs.BtCancDevClick(Sender: TObject);
begin
    barraferra.Enabled:=true;
    GPReq.Enabled:= true;
    DBCencaminha.Enabled:=false;
//    CBPriori.enabled   := false;
    tbreq.Cancel;
end;   }

procedure TfrmOs.DBCencaminhaChange(Sender: TObject);
begin
 perform(Wm_nextdlgctl,0,0);
end;

procedure TfrmOs.btloconClick(Sender: TObject);
begin
   frmlocpro4.ShowModal;
   if frmlocpro4.loc_req = 0 then
   begin
      tbreq.Indexname := 'PorOS';
      tbreq.FindKey([tbauxreqos.value]);
   end;
   if frmlocpro4.loc_req = 2 then
   begin
      tbreq.Indexname := 'PorCodigoOS';
      tbreq.FindKey([tbauxreqcodigo.value]);
   end;

 end;

procedure TfrmOs.DBCMotivoChange(Sender: TObject);
begin
 perform(Wm_nextdlgctl,0,0);
end;

procedure TfrmOs.BtptClick(Sender: TObject);
begin
if tbreqatendimento.value = false then
  begin
    rel_ptos.tbreq.open;
    rel_ptos.tbcontrib.open;
    rel_ptos.tbrt.open;
    rel_ptos.tbcnae.open;
    rel_ptos.tbbairro.open;
    rel_ptos.tbalvara.Open;
    rel_ptos.tbreq.FindKey([tbreqcontrole.value]);
    rel_ptos.reprequerimento.preview;
    rel_ptos.tbalvara.close;
    rel_ptos.tbbairro.close;
    rel_ptos.tbcnae.close;
    rel_ptos.tbrt.close;
    rel_ptos.tbcontrib.close;
    rel_ptos.tbreq.close;
    navegador.setfocus;
  end
  else messagedlg('Ordem de Serviço já cumprida ! ',mtwarning,[mbok],0);

end;

procedure TfrmOs.Bt1Click(Sender: TObject);
begin
    if tbreqencaminhamento.value <> true then
    begin
        showmessage('OS nao encaminhada');
        exit;
    end
    else
    begin
            if tbreqObs_Atend.IsNull then
            begin
                showmessage('Para dilatar o prazo de atendimento é necessário informar o motivo');
                DBMJusta.SetFocus;
                exit;
            end
            else
            begin
                tbreq.edit;
                tbreqprazo.Value :=  tbreqprazo.Value + 1;
                if tbreqprazo.Value > date + 30 then
                begin
                   showmessage('Prazo não pode ser superior a 30 dias a partir de hoje');
                   tbreq.cancel;
                   exit;
                end;
                if (tbalvaraDt_validade.Value > tbreqdt_req.value) and (daysbetween(tbalvaraDt_validade.Value,tbreqdt_req.value) >= 90) then
                else
                begin
                    if (tbreqprazo.Value > tbreqdt_encaminha.Value + 120)  then
                    begin
                       showmessage('Não permitida dilação de prazo conforme Art. 78 § 2º da LC 377');
                       tbreq.cancel;
                       exit;
                    end;
                end;
                tbreq.Post;
            end;
     end;
end;

procedure TfrmOs.Bt5Click(Sender: TObject);
begin
    if tbreqencaminhamento.value <> true then
    begin
        showmessage('OS nao encaminhada');
        exit;
    end
    else
    begin
            if tbreqObs_Atend.IsNull then
            begin
                showmessage('Para dilatar o prazo de atendimento é necessário informar o motivo');
                DBMJusta.SetFocus;
                exit;
            end
            else
            begin
                tbreq.edit;
                tbreqprazo.Value :=  tbreqprazo.Value + 5;
                if tbreqprazo.Value > date + 30 then
                begin
                   showmessage('Prazo não pode ser superior a 30 dias a partir de hoje');
                   tbreq.cancel;
                   exit;
                end;
                if (tbalvaraDt_validade.Value > tbreqdt_req.value) and (daysbetween(tbalvaraDt_validade.Value,tbreqdt_req.value) >= 90) then
                else
                begin
                    if (tbreqprazo.Value > tbreqdt_encaminha.Value + 120)  then
                    begin
                       showmessage('Não permitida dilação de prazo conforme Art. 78 § 2º da LC 377');
                       tbreq.cancel;
                       exit;
                    end;
                end;
                tbreq.Post;
            end;
     end;
end;

procedure TfrmOs.Bt10Click(Sender: TObject);
begin
    if tbreqencaminhamento.value <> true then
    begin
        showmessage('OS nao encaminhada');
        exit;
    end
    else
    begin
            if tbreqObs_Atend.IsNull then
            begin
                showmessage('Para dilatar o prazo de atendimento é necessário informar o motivo');
                DBMJusta.SetFocus;
                exit;
            end
            else
            begin
                tbreq.edit;
                tbreqprazo.Value :=  tbreqprazo.Value + 10;
                if tbreqprazo.Value > date + 30 then
                begin
                   showmessage('Prazo não pode ser superior a 30 dias a partir de hoje');
                   tbreq.cancel;
                   exit;
                end;
                if (tbalvaraDt_validade.Value > tbreqdt_req.value) and (daysbetween(tbalvaraDt_validade.Value,tbreqdt_req.value) >= 90) then
                else
                begin
                    if (tbreqprazo.Value > tbreqdt_encaminha.Value + 120)  then
                    begin
                       showmessage('Não permitida dilação de prazo conforme Art. 78 § 2º da LC 377');
                       tbreq.cancel;
                       exit;
                    end;
                end;
                tbreq.Post;
            end;
     end;
end;

procedure TfrmOs.bt30Click(Sender: TObject);
begin
    if tbreqencaminhamento.value <> true then
    begin
        showmessage('OS nao encaminhada');
        exit;
    end
    else
    begin
            if tbreqObs_Atend.IsNull then
            begin
                showmessage('Para dilatar o prazo de atendimento é necessário informar o motivo');
                DBMJusta.SetFocus;
                exit;
            end
            else
            begin
                tbreq.edit;
                tbreqprazo.Value :=  tbreqprazo.Value + 30;
                if tbreqprazo.Value > date + 30 then
                begin
                   showmessage('Prazo não pode ser superior a 30 dias a partir de hoje');
                   tbreq.cancel;
                   exit;
                end;
                if (tbalvaraDt_validade.Value > tbreqdt_req.value) and (daysbetween(tbalvaraDt_validade.Value,tbreqdt_req.value) >= 90) then
                else
                begin
                    if (tbreqprazo.Value > tbreqdt_encaminha.Value + 120)  then
                    begin
                       showmessage('Não permitida dilação de prazo conforme Art. 78 § 2º da LC 377');
                       tbreq.cancel;
                       exit;
                    end;
                end;
                tbreq.Post;
            end;
     end;
end;

end.
