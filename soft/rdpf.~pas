unit rdpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, DBTables, Grids, DBGrids, Mask, DBCtrls, dateutils,
  ExtCtrls, Buttons,IdTrivialFTPBase, ToolWin, math;

type
  Tfrmrdpf = class(TForm)
    GroupBox1: TGroupBox;
    CFiscal: TComboBox;
    Label1: TLabel;
    DTPrel: TDateTimePicker;
    Label2: TLabel;
    tbrdpf: TTable;
    tbcontrib: TTable;
    tbcontribCODIGO: TIntegerField;
    tbcontribRAZAO: TStringField;
    tbcontribATIVIDADE: TIntegerField;
    DBGraderdpf: TDBGrid;
    dsrdpf: TDataSource;
    dsvisitas: TDataSource;
    dscontrib: TDataSource;
    tbvisitas: TTable;
    tbvisitasCONTROLE: TAutoIncField;
    tbvisitasCODIGO: TIntegerField;
    tbvisitasDT_VISITA: TDateField;
    tbvisitasACAO: TStringField;
    tbvisitasTIPO: TStringField;
    tbvisitasDenuncia: TIntegerField;
    tbvisitasNDOC: TIntegerField;
    tbvisitasFiscal1: TStringField;
    tbvisitasFiscal2: TStringField;
    tbvisitasFiscal3: TStringField;
    GroupBox3: TGroupBox;
    tbrdpfControle: TAutoIncField;
    tbrdpfTipo: TStringField;
    tbrdpfNome: TStringField;
    tbrdpfData: TDateField;
    tbrdpfEstabe: TStringField;
    tbrdpfComplex: TStringField;
    Label3: TLabel;
    Label4: TLabel;
    DBEestabe: TDBEdit;
    DBCdoc: TDBComboBox;
    tbrdpfMod: TStringField;
    PainelSubjetivo: TPanel;
    btnovoat: TSpeedButton;
    btaltat: TSpeedButton;
    btgravat: TSpeedButton;
    btcanat: TSpeedButton;
    btdelat: TSpeedButton;
    DBNavat: TDBNavigator;
    tbauxcontrib: TTable;
    tbauxcontribCONTROLE: TAutoIncField;
    tbauxcontribCODIGO: TIntegerField;
    tbauxcontribPESSOA: TStringField;
    tbauxcontribCPF: TStringField;
    tbauxcontribCGC: TStringField;
    tbauxcontribRAZAO: TStringField;
    dsauxcontrib: TDataSource;
    DBCfiscal: TDBComboBox;
    Label6: TLabel;
    Label7: TLabel;
    DBEdata: TDBEdit;
    tbrdpfHomologado: TStringField;
    MonthCalendar1: TMonthCalendar;
    tbrmpf: TTable;
    tbrmpfControle: TAutoIncField;
    tbrmpfNome: TStringField;
    tbrmpfData: TDateField;
    tbrmpfHomologado: TStringField;
    dsrmpf: TDataSource;
    tbrmpfPonto: TFloatField;
    tbrmpfMes: TSmallintField;
    tbrmpfAno: TSmallintField;
    tbrcon: TTable;
    tbrconControle: TAutoIncField;
    tbrconNome: TStringField;
    tbrconPonto: TFloatField;
    tbrconMes: TSmallintField;
    tbrconAno: TSmallintField;
    dsrcon: TDataSource;
    barraferra: TToolBar;
    Btgera: TSpeedButton;
    btconfere: TSpeedButton;
    Btimprime: TSpeedButton;
    btmes: TSpeedButton;
    Btcontrole: TSpeedButton;
    bthelp: TSpeedButton;
    btpend: TSpeedButton;
    tbauxrdpf: TTable;
    dsauxrdpf: TDataSource;
    tbauxrdpfControle: TAutoIncField;
    tbauxrdpfTipo: TStringField;
    tbauxrdpfNome: TStringField;
    tbauxrdpfData: TDateField;
    tbauxrdpfEstabe: TStringField;
    tbauxrdpfMod: TStringField;
    tbauxrdpfComplex: TStringField;
    tbauxrdpfPonto: TFloatField;
    tbauxrdpfHomologado: TStringField;
    tbvisitasAtividade: TStringField;
    tbcnae: TTable;
    tbcnaeSubclasse: TStringField;
    tbcnaeClasse: TStringField;
    tbcnaeAtividade: TStringField;
    tbcnaeEquipe: TStringField;
    tbcnaeComplexidade: TStringField;
    tbrdpfPonto: TFloatField;
    tbvisitasOS: TIntegerField;
    tbvisitasGr_inclu: TStringField;
    tbrdpfCnae: TStringField;
    Label9: TLabel;
    DTPFinal: TDateTimePicker;
    tbauxrdpfDoc: TStringField;
    tbauxrdpfCnae: TStringField;
    tbrdpfDoc: TStringField;
    tbrdpfAcao: TStringField;
    tbrdpfUsuario: TStringField;
    tbrdpfData_altera: TDateField;
    btconsolida: TSpeedButton;
    Bthomologa: TSpeedButton;
    tbrdpfEntrega: TBooleanField;
    tbrdpfFecha: TBooleanField;
    tbrdpfData_fecha: TDateField;
    tbrdpfUsr_fecha: TStringField;
    tbrdpfUser_homoloda: TStringField;
    tbrdpfData_homologa: TDateField;
    DBEdit5: TDBEdit;
    btanota: TSpeedButton;
    Btold: TSpeedButton;
    tbvisitasArea: TStringField;
    tbrdpfOS: TIntegerField;
    tbrdpfTIPOOS: TStringField;
    DBEOs: TDBEdit;
    Label13: TLabel;
    DBCOrigem: TDBComboBox;
    Label14: TLabel;
    Btsai: TSpeedButton;
    tbrdpfArea: TStringField;
    tbrdpfDupla: TBooleanField;
    DBEdtos: TDBEdit;
    Label15: TLabel;
    tbvisitasModalidade: TStringField;
    tbvisitasProtocolo: TIntegerField;
    tbvisitasOficio: TIntegerField;
    tbos: TTable;
    tbosCodigo: TIntegerField;
    tbosOS: TIntegerField;
    tbosDt_encaminha: TDateField;
    tbrdpfData_os: TDateField;
    tbvisitasNUMERO: TStringField;
    tbrdpfNdoc: TStringField;
    tbrdpfMotivo: TStringField;
    tbrdpfPrazo: TDateField;
    Label18: TLabel;
    Label19: TLabel;
    tbrdpfNegativo: TFloatField;
    tbosPrazo: TDateField;
    tbden: TTable;
    tboficio: TTable;
    tboficioOficio: TIntegerField;
    tboficioDtencaminha: TDateField;
    tboficioPrazo: TDateField;
    tbdenDenuncia: TIntegerField;
    tbdenPrazo: TDateField;
    tbdenDtEncaminha: TDateField;
    tbtramita: TTable;
    tbtramitaProtocolo: TIntegerField;
    tbtramitaData: TDateField;
    tbtramitaDestino: TStringField;
    tbtramitaDescricao: TStringField;
    tbauxoficio: TTable;
    tbauxoficioDtencaminha: TDateField;
    tbauxoficioPrazo: TDateField;
    tbauxoficioOficio: TIntegerField;
    tbosMotivo: TStringField;
    tbauxoficioFiscalencaminha: TStringField;
    tbplanta: TTable;
    tbplantaCodigo: TIntegerField;
    tbplantaProtocolo: TIntegerField;
    tbplantaCarga: TStringField;
    tbauxden: TTable;
    tbauxdenDenuncia: TIntegerField;
    tbauxos: TTable;
    tbauxosCodigo: TIntegerField;
    tbauxosOS: TIntegerField;
    tbauxosFiscal_Encaminha: TStringField;
    tbauxdenFiscalEncaminha: TStringField;
    tbauxoficioDtatendimento: TDateField;
    tbauxoficioArchive: TBooleanField;
    tbauxoficioCancela: TBooleanField;
    tbrmpfNegativo: TFloatField;
    tbrconNegativo: TFloatField;
    tbrdpfMeio: TStringField;
    tbvisitasMeio: TStringField;
    tbauxoficioMotivo: TStringField;
    tboficioOrdem: TStringField;
    tbauxrdpfOS: TIntegerField;
    tbauxrdpfTIPOOS: TStringField;
    tbrdpfComply: TStringField;
    DBEdit6: TDBEdit;
    Label5: TLabel;
    procedure BtgeraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtcontroleClick(Sender: TObject);
    procedure BtimprimeClick(Sender: TObject);
    procedure dsrdpfStateChange(Sender: TObject);
    procedure btnovoatClick(Sender: TObject);
    procedure btaltatClick(Sender: TObject);
    procedure btgravatClick(Sender: TObject);
    procedure btcanatClick(Sender: TObject);
    procedure btdelatClick(Sender: TObject);
    procedure DBEdataExit(Sender: TObject);
    procedure BtmanualClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBCdocExit(Sender: TObject);
    procedure btmesClick(Sender: TObject);
    procedure bthelpClick(Sender: TObject);
    procedure btpendClick(Sender: TObject);
    procedure DBCdocChange(Sender: TObject);
    procedure DBCfiscalChange(Sender: TObject);
    procedure btconsolidaClick(Sender: TObject);
    procedure BthomologaClick(Sender: TObject);
    procedure btconfereClick(Sender: TObject);
    procedure btanotaClick(Sender: TObject);
    procedure BtoldClick(Sender: TObject);
    procedure BtsaiClick(Sender: TObject);
   private

  public
    { Public declarations }
  end;

var
  frmrdpf: Tfrmrdpf;

implementation

uses login, r_rpdf, r_rmpf, r_rcon, Principal, sobre, r_pend, r_old,
  r_controle;

{$R *.dfm}

procedure Tfrmrdpf.BtgeraClick(Sender: TObject);
var
c_ponto:real;
c_acao:boolean;
c_estabe:integer;

begin
if (frmlogin.c_grp <> 'ADM')  then
begin
  if CFiscal.text ='' then
  begin
        showmessage('Favor Selecionar um Fiscal');
        exit;
  end
  else
  begin
    if frmlogin.c_user <> CFiscal.text then
    begin
        showmessage('Usuário não Autorizado');
        exit;
    end;
  end;
end;

if length(cfiscal.text) = 0 then
begin
   showmessage('Selecione um Fiscal');
   CFiscal.SetFocus;
   exit;
end;

// if daysbetween(dtprel.Date,date) > 34  then  showmessage('Atenção!!!!! Relatório com atraso maior que 15 dias. Tecle ok para continuar ...');
if (daysbetween(dtprel.Date,date) > 30) and (frmlogin.c_grp <> 'ADM') then
begin
    showmessage('Atenção!!!!! Relatório Fora do Prazo');
    exit;
end;

if dtprel.Date > date then
begin
    showmessage('Atenção!!!!! Data inválida');
    exit;
end;


tbrmpf.Filtered:=false;
tbrmpf.IndexName:='PorData';
if tbrmpf.FindKey([DTPrel.date])then
    while not tbrmpf.Eof
    do
    begin
        if (tbrmpfnome.value=cfiscal.text) and (DTPrel.date=tbrmpfdata.value) then
        begin
            messagedlg('Relatório Homologado: '+datetostr(tbrmpfdata.value)+' - '+tbrmpfnome.value+'.',mtwarning,[mbok],0);
            exit;
        end
        else tbrmpf.Next;
    end;

if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_grp <> 'FIS') then
begin
    showmessage('Usuário não autorizado');
    exit;
end
else
begin
  if dayofweek(date) = 2 then
   begin
    if (daysbetween(DTPrel.date,date) > 30) and (frmlogin.c_grp <> 'ADM') then
    begin
        showmessage('Data para Geração não permitida!');
        dtprel.setfocus;
        exit;
    end;
   end
   else
   begin
    if (daysbetween(DTPrel.date,date) > 30) and (frmlogin.c_grp <> 'ADM') then
    begin
        showmessage('Data para Geração não permitida!');
        dtprel.setfocus;
        exit;
    end;
   end;
end;


tbrdpf.filtered:=false;
if tbrdpf.FindKey([DTPrel.date]) then
begin
    while not tbrdpf.eof
    do
    begin
        if (tbrdpfnome.value = cfiscal.text) and (tbrdpftipo.value='O') and (tbrdpfdata.value = DTPrel.date) and (tbrdpfentrega.value = true) then
        begin
            messagedlg('Atenção! Reportar-se à gerencia devido a apontamento nesta data : '+datetostr(tbrdpfdata.value)+' - '+tbrdpfnome.value,mtwarning,[mbok],0);            tbrdpf.filtered:=true;
            tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.Date));
            exit;
        end
        else tbrdpf.Next;
        if tbrdpfdata.Value <> DTPrel.date then break;
    end;
end;



tbrdpf.filtered:=false;
if tbrdpf.FindKey([DTPrel.date]) then
begin
    while not tbrdpf.eof
    do
    begin
        if (tbrdpfnome.value = cfiscal.text)  and (tbrdpfdata.value = DTPrel.date) then
        tbrdpf.Delete
        else tbrdpf.Next;
        if tbrdpfdata.Value <> DTPrel.date then break;
    end;
end;


//**********************************************************************************************************************************************************

if tbvisitas.FindKey([DTPrel.date]) then
begin
{   messagedlg('Inspeção encontrada para a data: '+datetostr(DTPrel.date)+', clique pra continuar a  geração do RDPF . . .',mtwarning,[mbok],0);}
   c_acao:=true;
  c_estabe:=tbvisitascodigo.Value;
   while tbvisitasdt_visita.value = DTPrel.date
{   while not tbvisitas.Eof}
       do
       begin
{         if tbvisitasdt_visita.value = DTPrel.date then
         begin}
           if (tbvisitasfiscal1.value = Cfiscal.text) or (tbvisitasfiscal2.value = Cfiscal.text) or (tbvisitasfiscal3.value = Cfiscal.text) then
           begin
                c_ponto:=0;
                tbrdpf.insert;
                tbrdpfnome.Value:=CFiscal.text;
                tbrdpfdata.Value:=DTPrel.date;
                tbrdpftipo.value:='O';
                tbrdpfestabe.value:=tbcontribrazao.value;
                tbrdpfcomplex.value:=tbcnaecomplexidade.value;
                if tbcnaesubclasse.Value = '4639-7/02' then tbrdpfcomplex.value:= 'MÉDIA';
                if tbcnaesubclasse.Value = '3831-9/01' then tbrdpfcomplex.value:= 'MÉDIA';
                if tbcnaesubclasse.Value = '3831-9/99' then tbrdpfcomplex.value:= 'MÉDIA';
                if tbcnaesubclasse.Value = '3832-7/00' then tbrdpfcomplex.value:= 'MÉDIA';
                if tbcnaesubclasse.Value = '3839-4/99' then tbrdpfcomplex.value:= 'MÉDIA';
                if tbcnaesubclasse.Value = '8630-5/03' then tbrdpfcomplex.value:= 'BAIXA';
                tbrdpfcnae.value:=tbcnaesubclasse.value;
                tbrdpfdoc.value    := tbvisitastipo.value;
                tbrdpfndoc.Value   := tbvisitasnumero.value;
                tbrdpftipoos.Value := tbvisitasmodalidade.Value;
                tbrdpfmeio.Value   := tbvisitasmeio.Value;


                if tbvisitasmodalidade.Value = 'DE OFÍCIO'    then
                begin
                    if not tbvisitasoficio.isnull then
                    begin
                        tbrdpfos.Value      := tbvisitasoficio.Value;
                        tbrdpfdata_os.value := tboficiodtencaminha.value;
                        tbrdpfprazo.Value   := tboficioprazo.value;
                        if copy(tboficioordem.value,17,5) = 'BAIXA' then  tbrdpfprazo.Clear;
// aqui....
                    end;
                 end;

                if tbvisitasmodalidade.Value = 'DENÚNCIA'     then
                begin
                    tbrdpfos.Value := tbvisitasdenuncia.Value;
                    tbrdpfdata_os.Value := tbdendtencaminha.Value  ;
                    tbrdpfprazo.Value   := tbdenprazo.Value;
                    if tbdendtencaminha.Value < strtodate('30/01/2024') then
                    begin
                        tbrdpfdata_os.Value := strtodate('30/01/2024');
                        tbrdpfprazo.Value   := strtodate('22/02/2024');
                    end;
                end;

               if tbvisitasmodalidade.Value = 'REQUERIMENTO' then
                begin
                    tbrdpfos.Value            := tbvisitasos.Value;
                    tbrdpfdata_os.Value       := tbosdt_encaminha.Value;
                    tbrdpfprazo.Value         := tbosprazo.Value;
                    if tbosdt_encaminha.Value < strtodate('30/01/2024') then
                    begin
                        tbrdpfdata_os.Value := strtodate('30/01/2024');
                        tbrdpfprazo.Value   := strtodate('29/04/2024');
                    end
                    else
                    if  tbosdt_encaminha.Value < strtodate('10/04/2024') then
                    begin
                        if tbosmotivo.Value = 'Abertura' then
                        begin
                            if tbcnaecomplexidade.Value = 'ALTA'  then   tbrdpfprazo.Value   := tbosdt_encaminha.Value+90;
                            if tbcnaecomplexidade.Value = 'MÉDIA' then   tbrdpfprazo.Value   := tbosdt_encaminha.Value+60;
                        end
                        else
                            if tbcnaecomplexidade.value <> 'BAIXA' then  tbrdpfprazo.Value   := tbosdt_encaminha.Value+90
                    end;
                   if tbcnaecomplexidade.value = 'BAIXA' then  tbrdpfprazo.Clear;
                end;


                if (tbvisitasmodalidade.Value = 'PROTOCOLO') and (tbvisitastipo.Value ='ANÁLISE DE PAS') then
                begin
                     tbrdpfos.Value := tbvisitasprotocolo.Value;
                     if tbtramita.FindKey([tbvisitasprotocolo.Value]) then
                     while not tbtramita.eof do
                     begin
                         if (tbtramitadescricao.value = 'Para Análise') or (tbtramitadescricao.value = 'Para Reanálise') then
                         begin
                             tbrdpfdata_os.Value := tbtramitadata.Value ;
                             tbrdpfprazo.Value   := tbrdpfdata_os.Value+20;
                         end;
                         tbtramita.Next;
                         if tbtramitaprotocolo.value <> tbvisitasprotocolo.value then tbtramita.Last;
                     end;

                     if tbrdpfdata_os.value < strtodate('30/01/2024') then
                     begin
                        tbrdpfdata_os.Value := strtodate('30/01/2024');
                        tbrdpfprazo.Value   := strtodate('15/03/2024');
                     end;
                end;

                if (tbvisitasmodalidade.Value = 'PROTOCOLO') and (tbvisitastipo.Value ='ANÁLISE DE RPA') then
                begin
                     tbrdpfos.Value := tbvisitasprotocolo.Value;
                     if tbtramita.FindKey([tbvisitasprotocolo.Value]) then
                     while not tbtramita.eof do
                     begin
                         if (tbtramitadescricao.value = 'Para Análise') or (tbtramitadescricao.value = 'Para Reanálise') then
                         begin
                             tbrdpfdata_os.Value := tbtramitadata.Value ;
                             tbrdpfprazo.Value   := tbrdpfdata_os.Value+20;
                         end;
                         tbtramita.Next;
                         if tbtramitaprotocolo.value <> tbvisitasprotocolo.value then tbtramita.Last;
                     end;

                     if tbrdpfdata_os.value < strtodate('30/01/2024') then
                     begin
                        tbrdpfdata_os.Value := strtodate('30/01/2024');
                        tbrdpfprazo.Value   := strtodate('15/03/2024');
                     end;
                end;


                if (tbvisitasmodalidade.Value = 'PROTOCOLO') and (tbvisitastipo.Value ='MANIFESTAÇÃO DO FISCAL ATUANTE') then
                begin
               {        tbrdpfos.Value := tbvisitasprotocolo.Value;
                       tbrdpfdata_os.Value := strtodate('01/04/2024');
                       tbrdpfprazo.Value   := strtodate('22/04/2024');  }

                     tbrdpfos.Value := tbvisitasprotocolo.Value;
                     if tbtramita.FindKey([tbvisitasprotocolo.Value]) then
                     while not tbtramita.eof do
                     begin
                         if (tbtramitadescricao.value = 'Para Manifestação')  then
                         begin
                             tbrdpfdata_os.Value := tbtramitadata.Value ;
                             tbrdpfprazo.Value   := tbrdpfdata_os.Value+20;
                         end;
                         tbtramita.Next;
                         if tbtramitaprotocolo.value <> tbvisitasprotocolo.value then tbtramita.Last;
                     end;

                     if tbrdpfdata_os.value < strtodate('30/01/2024') then
                     begin
                        tbrdpfdata_os.Value := strtodate('30/01/2024');
                        tbrdpfprazo.Value   := strtodate('22/02/2024');
                     end;
                end;

                if c_acao = false then
                begin
                    if tbcnaecomplexidade.value = 'ALTA'  then c_ponto:= 0;
                    if tbcnaecomplexidade.value = 'MÉDIA' then c_ponto:= 0;
                    if tbcnaecomplexidade.value = 'BAIXA' then c_ponto:= 0;
                    tbrdpfmod.value:='DOC';
                end;

                if c_acao = true then
                begin
                  if (tbvisitastipo.value = 'CERTIDÃO')                         or
                     (tbvisitastipo.value = 'MANIFESTAÇÃO DO FISCAL ATUANTE')   or
                     (tbvisitastipo.value = 'RELATÓRIO TÉCNICO')                or
                     (tbvisitastipo.value = 'ANÁLISE DE PAS')                   or
                     (tbvisitastipo.value = 'ANÁLISE DE RPA')                  or
                     (tbvisitastipo.value = 'RELATÓRIO HARMONIZADO')            then
                  begin
                     if  tbvisitastipo.value = 'CERTIDÃO'                       then
                     begin
                        if tbcnaecomplexidade.value = 'ALTA'  then c_ponto:= 2;
                        if tbcnaecomplexidade.value = 'MÉDIA' then c_ponto:= 2;
                        if tbcnaecomplexidade.value = 'BAIXA' then c_ponto:= 2;
                     end;
                     if  tbvisitastipo.value = 'RELATÓRIO TÉCNICO'               then
                     begin
                        if tbcnaecomplexidade.value = 'ALTA'  then c_ponto:= 48;
                        if tbcnaecomplexidade.value = 'MÉDIA' then c_ponto:= 12;
                        if tbcnaecomplexidade.value = 'BAIXA' then c_ponto:= 6;
                            if tbcnaesubclasse.Value = '4639-7/02' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3831-9/01' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3831-9/99' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3832-7/00' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3839-4/99' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '8630-5/03' then c_ponto:= 6;
                     end;
                     if  tbvisitastipo.value = 'MANIFESTAÇÃO DO FISCAL ATUANTE' then c_ponto := 12;
                     if  tbvisitastipo.value = 'ANÁLISE DE RPA'                then c_ponto := 12;
                     if  tbvisitastipo.value = 'ANÁLISE DE PAS'                 then
                     begin
                        if tbcnaecomplexidade.value = 'ALTA'  then c_ponto:= 24;
                        if tbcnaecomplexidade.value = 'MÉDIA' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '4639-7/02' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3831-9/01' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3831-9/99' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3832-7/00' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '3839-4/99' then c_ponto:= 12;
                            if tbcnaesubclasse.Value = '8630-5/03' then c_ponto:= 6;
                     end;
                     if  tbvisitastipo.value = 'RELATÓRIO HARMONIZADO'          then c_ponto := 48;

                     tbrdpfmod.value:='DOC';
                  end
                  else
                  begin
                   if (tbvisitastipo.value = 'TERMO DE INTIMAÇÃO')              or
                      (tbvisitastipo.value = 'AUTO DE INFRAÇÃO')                or
                      (tbvisitastipo.value = 'TERMO DE NOTIFICAÇÃO')            or
                      (tbvisitastipo.value = 'AUTO DE IMPOSIÇÃO DE PENALIDADE') then
                      begin
                           if tbvisitasacao.value = 'INSPEÇÃO SANITÁRIA' then
                           begin
                               if  tbcnaecomplexidade.value = 'ALTA'  then
                               begin
                                   c_ponto:= 48;
                                   if (tbcnaeequipe.Value = 'IA') or (tbcnaeequipe.Value = 'AG') then
                                   begin
                                       c_ponto:= 0;
                                       if tbvisitasarea.Value = 'Até 101' then
                                       begin
                                       c_ponto:= 8;
                                       tbrdpfarea.Value :='pequena';
                                       end;
                                       if tbvisitasarea.Value = '101-399' then
                                       begin
                                       c_ponto:= 16;
                                       tbrdpfarea.Value :='média';
                                       end;
                                       if tbvisitasarea.Value = '> 399'   then
                                       begin
                                       c_ponto:= 48;
                                       tbrdpfarea.Value :='grande';
                                       end;

                                   end;
                                end;
                                if (tbcnaecomplexidade.value = 'MÉDIA') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 12;
                                if (tbcnaecomplexidade.value = 'MÉDIA') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 9;
                                if (tbcnaecomplexidade.value = 'MÉDIA') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 9;

                                if (tbcnaecomplexidade.value = 'BAIXA') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 6;
                                if (tbcnaecomplexidade.value = 'BAIXA') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 3;
                                if (tbcnaecomplexidade.value = 'BAIXA') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 3;

                                if (length(tbvisitasfiscal2.value) > 0) or  (length(tbvisitasfiscal3.value) > 0) then tbrdpfdupla.Value := true;


                                    if (tbcnaesubclasse.Value = '4639-7/02') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 12;
                                    if (tbcnaesubclasse.Value = '4639-7/02') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 9;
                                    if (tbcnaesubclasse.Value = '4639-7/02') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 9;

                                    if (tbcnaesubclasse.Value = '3831-9/01') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 12;
                                    if (tbcnaesubclasse.Value = '3831-9/01') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 9;
                                    if (tbcnaesubclasse.Value = '3831-9/01') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 9;

                                    if (tbcnaesubclasse.Value = '3831-9/99') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 12;
                                    if (tbcnaesubclasse.Value = '3831-9/99') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 9;
                                    if (tbcnaesubclasse.Value = '3831-9/99') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 9;

                                    if (tbcnaesubclasse.Value = '3832-7/00') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 12;
                                    if (tbcnaesubclasse.Value = '3832-7/00') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 9;
                                    if (tbcnaesubclasse.Value = '3832-7/00') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 9;

                                    if (tbcnaesubclasse.Value = '3839-4/99') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 12;
                                    if (tbcnaesubclasse.Value = '3839-4/99') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 9;
                                    if (tbcnaesubclasse.Value = '3839-4/99') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 9;

                                    if (tbcnaesubclasse.Value = '8630-5/03') and (length(tbvisitasfiscal2.value) = 0) and (length(tbvisitasfiscal3.value) = 0) then c_ponto:= 6;
                                    if (tbcnaesubclasse.Value = '8630-5/03') and (length(tbvisitasfiscal2.value) > 0) then c_ponto:= 3;
                                    if (tbcnaesubclasse.Value = '8630-5/03') and (length(tbvisitasfiscal3.value) > 0) then c_ponto:= 3;

                                tbrdpfmod.value:='INS';
                           end;
                      end;
                  end;
                end;

                if tbvisitasacao.value ='DOCUMENTO EXTRA INSPEÇÃO' then
                begin
                    if tbcnaecomplexidade.value = 'ALTA'  then c_ponto:= 0;
                    if tbcnaecomplexidade.value = 'MÉDIA' then c_ponto:= 0;
                    if tbcnaecomplexidade.value = 'BAIXA' then c_ponto:= 0;
                    if tbvisitastipo.value = 'TERMO DE COLETA DE AMOSTRA' then c_ponto:= 12;
                    tbrdpfmod.value:='DOC';
                end;

                if tbvisitasacao.value ='PLANTÃO FISCAL' then
                begin
                    c_ponto:= 0;
                    tbrdpfmod.value:='DOC';
                end;

                 if tbvisitasgr_inclu.Value = 'CAD' then c_ponto := 0;

                tbrdpfponto.value:=c_ponto;

                if (tbrdpfprazo.value < tbrdpfdata.value)       and  not (tbrdpfprazo.isnull) then //(tbrdpfcomplex.value <> 'BAIXA') then
                    tbrdpfnegativo.value:=  c_ponto/2;
                if (tbvisitasmodalidade.Value = 'PROTOCOLO')    and not (tbplanta.FindKey([tbvisitascodigo.value,tbvisitasprotocolo.Value])) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value = 'PROTOCOLO')    and (tbrdpfos.IsNull) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value = 'REQUERIMENTO') and not (tbauxos.FindKey([tbvisitascodigo.value,tbvisitasos.value])) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value = 'REQUERIMENTO') and (tbrdpfos.IsNull) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value = 'DENÚNCIA')     and not (tbauxden.FindKey([tbvisitasdenuncia.value])) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value = 'DENÚNCIA')     and (tbrdpfos.IsNull) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value = 'DE OFÍCIO')   and  not (tbauxoficio.FindKey([tbvisitasoficio.value])) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value = 'DE OFÍCIO')   and (tbrdpfos.isnull) then
                    tbrdpfnegativo.value:=  c_ponto;
                if (tbvisitasmodalidade.Value <> 'DENÚNCIA')    and (tbvisitasmodalidade.Value <> 'REQUERIMENTO') and (tbvisitasmodalidade.Value <> 'PROTOCOLO') and (tbvisitasmodalidade.Value <> 'DE OFÍCIO' ) then
                    tbrdpfnegativo.value:=  c_ponto;
                tbrdpfacao.value := tbvisitasacao.value;
                tbrdpfhomologado.Value := 'Não';
                tbrdpfusuario.Value := frmlogin.c_user;
                tbrdpfdata_altera.Value := date;
                if tbrdpfnegativo.Value > 0 then tbrdpfcomply.Value := 'Não Conforme';
                if c_ponto > 0 then tbrdpf.Post else tbrdpf.Cancel;
//              if tbrdpfnegativo.Value > 0 then shoWmessage('ATENÇAO!!!!!   NÃO CONFORMIDADE');
                if tbrdpfnegativo.Value > 0 then messagedlg('ATENÇAO!!!!!   NÃO CONFORMIDADE: '+tbrdpfestabe.value+' - Ordem de Serviço nº: '+inttostr(tbrdpfos.value)+'.',mtwarning,[mbok],0);
           end; // end do fiscal
//           end; // end da data
         tbvisitas.Next;
         if tbvisitas.Eof then break;
         if (tbvisitasfiscal1.value = Cfiscal.text) or (tbvisitasfiscal2.value = Cfiscal.text) or (tbvisitasfiscal3.value = Cfiscal.text) then
         begin
             if  c_estabe = tbvisitascodigo.Value then c_acao := false else c_acao := true;
             c_estabe:= tbvisitascodigo.Value;
         end;
       end; // end do loop
end; // end do findkey visitas

//**********************************************************************************************************************************************************
// *********************************            DENUNCIAS                ***************************************************

{if tbatend.FindKey([DTPrel.date]) then
begin
//   messagedlg('Atendimento encontrado para a data: '+datetostr(DTPrel.date)+', clique pra continuar a  geração do RDPF . . .',mtwarning,[mbok],0);
//   while tbatenddata_atendimento.value = DTPrel.date
while not tbatend.eof
       do
       begin
         if tbatenddata_atendimento.value = DTPrel.date then
         begin
           if (tbatendfiscal1.value = Cfiscal.text) or (tbatendfiscal2.value = Cfiscal.text) or (tbatendfiscal3.value = Cfiscal.text) then
           begin
//                messagedlg('Atendimento encontrado para o Fiscal: '+tbatendfiscal1.value+', clique pra continuar a  geração do RDPF . . .',mtwarning,[mbok],0);
                c_ponto:=0;
                fis:=true;
                jur:=true;
                tbrdpf.insert;
                tbrdpfnome.Value:=CFiscal.text;
                tbrdpfdata.Value:=DTPrel.date;
                tbrdpftipo.value:='O';
                tbrdpfestabe.value:=tbdenunciasreclamado.value;
                tbrdpfdoc.value:=tbatendtipodoc.value;
                tbrdpfmod.value:='DEN';
//calcula pontuação
                tbauxcontrib.IndexName:='PorCPF';
                if not tbauxcontrib.findkey([tbdenunciascpf.value])  then fis:=false else if tbauxcontribcpf.IsNull then fis:=false ;
                tbauxcontrib.IndexName:='PorCGC';
                if not tbauxcontrib.findkey([tbdenunciascnpj.value]) then jur:=false else if tbauxcontribcgc.isnull then jur:=false ;
                if (fis=true) or (jur=true) then c_ponto:= 0 else if tbatendtipodoc.Value = 'CERTIDÃO' then  c_ponto := 1 else c_ponto := 2;
                tbrdpfponto.value:=c_ponto;
                tbrdpfhomologado.Value := 'Não';
                tbrdpf.Post;
           end; // end do fiscal
          end; //end da data
         tbatend.Next;
 //         if tbatend.eof then break;
       end; // end do loop
end; // end do findkey atend denuncias
 }
//**********************************************************************************************************************************************************

tbrdpf.Filtered:=true;
tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.Date));
showmessage('Geração Concluída.')
//frmprincipal.nova_data:=false;

end;

procedure Tfrmrdpf.FormActivate(Sender: TObject);
begin
tbrcon.open;
tbrmpf.open;
tbrdpf.open;
//tbrdpf.last;
tbauxoficio.open;
tbauxrdpf.Open;
tbauxos.Open;
tbauxden.Open;
tbplanta.Open;
tbtramita.Open;
tboficio.open;
tbos.Open;
tbden.open;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO') then
begin
    CFiscal.Enabled:=true;
end
else
begin
    CFiscal.Enabled:=false;
end;
if frmlogin.c_grp = 'FIS' then cfiscal.text := frmlogin.c_user;

tbrdpf.filtered:=true;
tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.Date));
tbvisitas.open;
tbcontrib.open;
tbCNAE.Open;
tbos.Open;
tbauxcontrib.open;
DTPrel.Date:=date;
DTPfinal.Date:=date;
if frmprincipal.nova_data = true then DTPrel.Date:=date;
if frmprincipal.nova_data = true then DTPfinal.Date:=date;
{messagedlg('Atenção! Módulo em desenvolvimento, dados informados somente para testes.',mtwarning,[mbok],0);}
end;

procedure Tfrmrdpf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbauxoficio.close;
tbtramita.Close;
tbauxrdpf.close;
tbauxcontrib.Close;
tbcNAE.close;
tbos.Close;
tbcontrib.close;
tbvisitas.Close;
tbauxos.Open;
tbauxden.Open;
tboficio.close;
tbos.close;
tbden.close;
tbplanta.close;
tbrdpf.close;
tbrmpf.close;
tbrcon.Close;
end;

procedure Tfrmrdpf.BtcontroleClick(Sender: TObject);
begin
if (frmlogin.c_grp <> 'ADM')  then
begin
   showmessage('Usuário não Autorizado');
   exit;
end;

if length(cfiscal.text) = 0 then
begin
   showmessage('Selecione um Fiscal');
   CFiscal.SetFocus;
   exit;
end;

if DTPrel.Date > DTPFinal.Date then
begin
   showmessage('Data final menor que a incial');
   DTPrel.SetFocus;
   exit;
end;


rel_controle.tbrdpf.open;
rel_controle.tbrdpf.Filtered:=true;
//rel_rpdf.tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.Date));
rel_controle.tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data>='+quotedstr(datetostr(DTPrel.Date))+' and '+'data<='+quotedstr(datetostr(DTPFinal.Date))+' and '+'homologado ='+quotedstr('Sim');
rel_controle.repcontrole.Preview;
rel_controle.tbrdpf.close;
frmprincipal.nova_data:=false;
end;

procedure Tfrmrdpf.BtimprimeClick(Sender: TObject);
begin

if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_grp <> 'FIS') and (frmlogin.c_per <> 'PRO') then
begin
   showmessage('Usuário não Autorizado');
   exit;
end;

if length(cfiscal.text) = 0 then
begin
   showmessage('Selecione um Fiscal');
   CFiscal.SetFocus;
   exit;
end;

if DTPrel.Date > DTPFinal.Date then
begin
   showmessage('Data final menor que a incial');
   DTPrel.SetFocus;
   exit;
end;


rel_rdpf.tbrdpf.open;
rel_rdpf.tbrdpf.Filtered:=true;
//rel_rpdf.tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.Date));
rel_rdpf.tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data>='+quotedstr(datetostr(DTPrel.Date))+' and '+'data<='+quotedstr(datetostr(DTPFinal.Date))+' and '+'homologado ='+quotedstr('Sim');
rel_rdpf.reprdpf.Preview;
rel_rdpf.tbrdpf.close;
frmprincipal.nova_data:=false;
end;

procedure Tfrmrdpf.dsrdpfStateChange(Sender: TObject);
begin
    DBNavat.Enabled         := tbrdpf.state =  dsbrowse;
    btnovoat.enabled        := tbrdpf.state =  dsbrowse;
    btaltat.enabled         := tbrdpf.state =  dsbrowse;
    btgravat.enabled        := tbrdpf.state <> dsbrowse;
    btcanat.enabled         := tbrdpf.state <> dsbrowse;
    btdelat.enabled         := tbrdpf.state =  dsbrowse;
    Btsai.enabled           := tbrdpf.state =  dsbrowse;
    Btimprime.enabled       := tbrdpf.state =  dsbrowse;
    btpend.enabled          := tbrdpf.state =  dsbrowse;
    btold.enabled           := tbrdpf.state =  dsbrowse;
    bthelp.enabled          := tbrdpf.state =  dsbrowse;
    btmes.enabled           := tbrdpf.state =  dsbrowse;;
    Btgera.Enabled          := tbrdpf.state =  dsbrowse;
    bthomologa.enabled      := tbrdpf.state =  dsbrowse;
    btconsolida.enabled     := tbrdpf.state =  dsbrowse;
    btconfere.enabled       := tbrdpf.state =  dsbrowse;
    DBCfiscal.Enabled       := tbrdpf.state <> dsbrowse;
    DBCdoc.enabled          := tbrdpf.state <> dsbrowse;
    DBEdata.enabled         := tbrdpf.state <> dsbrowse;
    DBEestabe.enabled       := tbrdpf.state <> dsbrowse;
    DBCOrigem.enabled       := tbrdpf.state <> dsbrowse;
    DBEOs.Enabled           := tbrdpf.state <> dsbrowse;
    DBEdtos.Enabled         := tbrdpf.state <> dsbrowse;
//    DBEponto.enabled        := tbrdpf.state <> dsbrowse;
    if (frmlogin.c_grp  = 'ADM') or (frmlogin.c_per = 'PRO') then
    CFiscal.Enabled         := tbrdpf.state =  dsbrowse;
    DTPrel.enabled          := tbrdpf.state =  dsbrowse;
    DBGraderdpf.enabled     := tbrdpf.state =  dsbrowse;
end;

procedure Tfrmrdpf.btnovoatClick(Sender: TObject);
begin
if (frmlogin.c_grp  = 'FIS') or (frmlogin.c_grp  = 'ADM') or (frmlogin.c_per = 'PRO') then
    begin
//==
tbrmpf.Filtered:=false;
tbrmpf.IndexName:='PorData';
if tbrmpf.FindKey([DTPrel.date])then
    while not tbrmpf.Eof
    do
    begin
        if (tbrmpfnome.value=cfiscal.text) and (DTPrel.date=tbrmpfdata.value) then
        begin
            messagedlg('Relatório Fechado: '+datetostr(tbrmpfdata.value)+' - '+tbrmpfnome.value+'.',mtwarning,[mbok],0);
//            tbrmpf.Filtered:=true;
            exit;
        end
        else tbrmpf.Next;
    end;
//==
            tbrdpf.insert;
            tbrdpftipoos.Value := 'DE OFÍCIO';
            tbrdpftipo.value:='S';
            tbrdpfdata.Value:=dtprel.Date;
            tbrdpfmod.value:='OUT';
            if frmlogin.c_grp = 'FIS' then
            begin
                DBCfiscal.ReadOnly := true;
                tbrdpfnome.value:=frmlogin.c_user
            end
            else
            begin
                tbrdpfnome.value:=Cfiscal.Text;
                DBCfiscal.ReadOnly := false;
            end;
            DBCfiscal.SetFocus;
      end
      else showmessage('Relatório já fechado nesta data!');
end;

procedure Tfrmrdpf.btaltatClick(Sender: TObject);
begin
    if (frmlogin.c_user = tbrdpfnome.value) or  (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO') then
    begin
    if tbrdpfhomologado.value = 'Não' then
       begin
         if (tbrdpffecha.Value <> true) or (frmlogin.c_grp = 'ADM')  then
         begin
           if tbrdpftipo.value= 'S' then
           begin
              tbrdpf.edit;
              tbrdpftipoos.value := 'DE OFÍCIO';
              DBEData.SetFocus;
           end
           else showmessage('Pontuação obtida das inspeções, impossível alterar!');
         end
         else showmessage('Atividade conferida, impossível alterar!');
       end
       else showmessage('Atividae homologada, impossível alterar!');
    end
    else showmessage('Usuário não autorizado!');
end;

procedure Tfrmrdpf.btgravatClick(Sender: TObject);
var
c_ope : extended;
c_s : extended; 
begin
    c_ope:= 48;
    c_s := 48;
    perform(Wm_nextdlgctl,0,0);
    if tbrdpfnome.IsNull then
    begin
        showmessage('Caro Usuário, favor informar o Fiscal Atuante');
        exit;
    end;

    if tbrdpfdata.IsNull then
    begin
        showmessage('Caro Usuário, favor informar a data da Atividade');
        exit;
    end;

    if tbrdpfdata.value > date then
    begin
        showmessage('Atenção! Data selecionada inválida!');
        DTPrel.SetFocus;
        exit;
    end;

    if tbrdpfdoc.Value =  'AFASTAMENTOS (LC 548/2023)' then
    begin
        tbauxrdpf.filter:='nome=' + quotedstr(tbrdpfnome.value)+' and '+'data='+quotedstr(datetostr(tbrdpfdata.value));
        tbauxrdpf.first;
        while not tbauxrdpf.eof
        do
        begin
            if (tbauxrdpfdoc.value = 'AFASTAMENTOS (LC 548/2023)') and (tbauxrdpfcontrole.value <> tbrdpfcontrole.value) then
            begin
                showmessage('Caro Usuário, Informação já digitada para esta data!');
                exit;
            end;
            tbauxrdpf.next;
        end;
    end;

tbrmpf.Filtered:=false;
tbrmpf.IndexName:='PorData';
if tbrmpf.FindKey([tbrdpfdata.value])then
    while not tbrmpf.Eof
    do
    begin
        if (tbrmpfnome.value=tbrdpfnome.value) and  (tbrdpfdata.value<>dtprel.date) then
        begin
            showmessage('Relatório Fechado para data e fiscal selecionados, Impossível Alterar!');
            exit;
        end
        else tbrmpf.Next;
    end;

// if daysbetween(tbrdpfdata.value,date) > 3 then showmessage('Atenção!!!!! Inclusão/alteração de Atividade com prazo maior que 3 dias, tecle ok para continuar ...');

if (daysbetween(tbrdpfdata.value,date) > 30) AND (frmlogin.c_grp <> 'ADM') and (frmlogin.c_per<> 'PRO') then
begin
    showmessage('Atençaõ!!!!! Inclusão/alteração de Atividade fora do prazo');
    exit;
end;

if (frmlogin.c_grp = 'ADM') or  (frmlogin.c_per = 'PRO') then
else
begin
    if daysbetween(tbrdpfdata.value,date) > 30 then
    begin
        showmessage('Data não permitida para inclusão/alteração de Atividade');
        DBEdata.setfocus;
        exit;
    end;

    if frmlogin.c_user <> tbrdpfnome.Value then
    begin
        showmessage('usuário não autorizado a informar para o fiscal selecionado');
        DBEdata.setfocus;
        exit;
    end;

end;

   if tbrdpfdoc.IsNull then
    begin
        showmessage('Caro Usuário, favor informar o Documento/Atividade');
        exit;
    end;

    if tbrdpfestabe.IsNull then
    begin
        showmessage('Caro Usuário, descrever a atividade desenvolvida/ ou o nome do Contribuinte interesssado');
        exit;
    end;

    if (tbrdpfdoc.Value <> 'AFASTAMENTOS (LC 548/2023)') and (tbrdpftipoos.isnull) then
    begin
        showmessage('Caro Usuário, necessário informar a orgiem da OS');
        exit;
    end;


    if tbrdpftipoos.Value = 'DE OFÍCIO' then
    begin
        if tbauxoficio.FindKey([tbrdpfos.value]) then
        begin
            if tbauxoficiocancela.value = true then
            begin
                showmessage('Atenção! OS Cancelada :'+ inttostr(tbauxoficiooficio.value));
                exit;
            end
            else
            begin

               if tbauxoficioprazo.Value < tbrdpfdata.Value then
               begin
                   showmessage('Atenção! OS Vencida :'+ datetostr(tbauxoficioprazo.Value));
                   exit;
               end;

               if tbauxoficiodtencaminha.Value > tbrdpfdata.Value then
               begin
                   showmessage('Atenção! OS foi encaminhada somente na data de :'+ datetostr(tbauxoficiodtencaminha.Value));
                   exit;
               end;

                if (tbauxoficiofiscalencaminha.value = tbrdpfnome.value) then
                begin
                    tbrdpfdata_os.Value := tbauxoficiodtencaminha.Value;
                    tbrdpfprazo.Value := tbauxoficioprazo.Value;
                end
                else
                begin
                    if (tbauxoficiofiscalencaminha.value = 'TODOS FISCAIS') and (tbauxoficioMotivo.value = 'PLANTÃO FISCAL') and (tbrdpfdoc.Value = 'PLANTÃO FISCAL') then
                    begin
                       tbrdpfdata_os.Value := tbauxoficiodtencaminha.Value;
                       tbrdpfprazo.Value := tbauxoficioprazo.Value;
                    end
                    else
                    begin
                        if (tbauxoficiofiscalencaminha.value = 'TODOS FISCAIS') and (tbauxoficioMotivo.value = 'TREINAMENTO/REUNIÃO') and (tbrdpfdoc.Value = 'APRESENTAÇÃO/PARTICIPAÇÃO/PREPARAÇÃO DE CURSOS E SIMILARES') then
                        begin
                            tbrdpfdata_os.Value := tbauxoficiodtencaminha.Value;
                            tbrdpfprazo.Value := tbauxoficioprazo.Value;
                        end
                        else
                        begin
                            if (tbauxoficiofiscalencaminha.value = 'TODOS FISCAIS') and (tbauxoficioMotivo.value = 'OPERAÇÃO FISCAL') and (tbrdpfdoc.Value = 'OPERAÇÕES FISCAIS NÃO PREVISTAS E/OU SITUAÇÕES EXTRAORDINÁRIAS') then
                            begin
                                tbrdpfdata_os.Value := tbauxoficiodtencaminha.Value;
                                tbrdpfprazo.Value := tbauxoficioprazo.Value;
                            end
                            else
                            begin
                                showmessage('Atenção, a OS informada refere-se somente a '+tbauxoficioMotivo.value+', encaminhada para '+ tbauxoficiofiscalencaminha.value);
                                DBEOs.SetFocus;
                                exit;
                            end;
                        end;
                    end;
                end;
            end;
        end
        else
        begin
            if tbrdpfdoc.value <> 'AFASTAMENTOS (LC 548/2023)' then
            begin
                showmessage('Atenção, a OS informada não foi encontrada ');
                exit;
            end;
        end;
    end;

//========================
   if tbrdpfdoc.value <> 'AFASTAMENTOS (LC 548/2023)' then
   begin
       if (tbauxoficiomotivo.value <> 'SERVIÇO TÉCNICO') and
          (tbauxoficiomotivo.value <> 'OPERAÇÃO FISCAL') and
          (tbauxoficiomotivo.value <> 'PLANTÃO FISCAL')   and
          (tbauxoficiomotivo.value <> 'TREINAMENTO/REUNIÃO') then
      begin
            showmessage('Atenção, a OS informada é exclusivamente para digitação no histórico do contribuinte');
            exit;
      end;
   end;

    if (tbauxoficiomotivo.value = 'SERVIÇO TÉCNICO')  and (tbrdpfdoc.value <> 'SERVIÇOS TÉCNICOS REALIZADOS NO ÂMBITO DA VIGILÂNCIA SANITÁRIA') then
    begin
            showmessage('Atenção, a OS'+inttostr(tbauxoficiooficio.value)+' é somente para SERVIÇO TÉCNICO');
            exit;
    end;
    if (tbauxoficiomotivo.value = 'OPERAÇÃO FISCAL')     and (tbrdpfdoc.value <> 'OPERAÇÕES FISCAIS NÃO PREVISTAS E/OU SITUAÇÕES EXTRAORDINÁRIAS') then
    begin
            showmessage('Atenção, a OS'+inttostr(tbauxoficiooficio.value)+' é somente para OPERAÇÃO FISCAL');
            exit;
    end;
    if (tbauxoficiomotivo.value = 'PLANTÃO FISCAL')      and (tbrdpfdoc.value <> 'PLANTÃO FISCAL')                                                 then
    begin
            showmessage('Atenção, a OS'+inttostr(tbauxoficiooficio.value)+' é somente para PLANTÃO FISCAL');
            exit;
    end;
    if (tbauxoficiomotivo.value = 'TREINAMENTO/REUNIÃO') and (tbrdpfdoc.value <> 'APRESENTAÇÃO/PARTICIPAÇÃO/PREPARAÇÃO DE CURSOS E SIMILARES')     then
    begin
            showmessage('Atenção, a OS'+inttostr(tbauxoficiooficio.value)+' é somente para TREINAMENTO/REUNIÃO');
            exit;
    end;

    //========================








  {  if tbrdpfdoc.Value ='CRÉDITO MÊS ANTERIOR  (ART. 6º, § 3º LC 389/2018)'  then
    begin
    if dayof(tbrdpfdata.value) <> 1 then
    begin
        showmessage('A pontuação do mês anterior só pode ser lançada dia primeiro');
        exit;
    end
    else
    begin
        tbrcon.indexname := 'PorNome';
        if tbrcon.FindKey([tbrdpfnome.value]) then
        while not tbrcon.Eof do
        begin
            if (tbrconnome.Value = tbrdpfnome.Value) and (monthof(tbrdpfdata.Value)-1 = tbrconmes.value) and (yearof(tbrdpfdata.value) = tbrconano.value) then
            begin
                if tbrconponto.Value > 200 then
                begin
                    if (tbrconponto.Value - 200) > 50 then tbrdpfponto.value := 50 else tbrdpfponto.value := roundto(tbrconponto.Value-200, -2);
                end;
            end;
            tbrcon.next;
            if tbrconnome.Value <> tbrdpfnome.Value then tbrcon.last;
        end;
        tbrcon.indexname := '';
    end;
    end;  }




   if tbrdpfdoc.Value = 'OPERAÇÕES FISCAIS NÃO PREVISTAS E/OU SITUAÇÕES EXTRAORDINÁRIAS' then
   begin
        tbauxrdpf.filter:='nome=' + quotedstr(tbrdpfnome.value)+' and '+'data='+quotedstr(datetostr(tbrdpfdata.value));
        tbauxrdpf.first;
       while not tbauxrdpf.eof do
       begin
            if (tbauxrdpfos.value = tbrdpfos.value) and (tbauxrdpfcontrole.value <> tbrdpfcontrole.value)  then
            begin
              showmessage('OS já informada pra esta data .');
              exit;
           end;
            if (tbauxrdpfcontrole.value <> tbrdpfcontrole.value) and (tbauxrdpftipo.Value = 'O') and (tbauxrdpftipoos.value = 'REQUERIMENTO') then c_ope := c_ope - tbauxrdpfponto.value;
            if (tbauxrdpfcontrole.value <> tbrdpfcontrole.value) and (tbauxrdpftipo.Value = 'O') and (tbauxrdpftipoos.value <> 'REQUERIMENTO') then
            begin
                showmessage('Não foi possível registrar o Operações.  Existe inspeção nào requerida pelo contribuinte informada nesta data.');
                exit;
            end;
            if (tbauxrdpfcontrole.value <> tbrdpfcontrole.value) and (tbauxrdpftipo.Value = 'O') and (tbauxrdpftipoos.value = 'REQUERIMENTO') and (tbrdpfos.value <> 20250000) then
            begin
                showmessage('Não foi possível registrar o Operações.  Existe inspeção informada nesta data.');
                exit;
            end;
            if (tbauxrdpfcontrole.value <> tbrdpfcontrole.value) and (tbauxrdpftipo.Value = 'S') then c_s := c_s - tbauxrdpfponto.value;
            tbauxrdpf.Next;
       end;
       if c_s < 48 then
       begin
           showmessage('Não foi possível registrar o Operações.  Existe atividade extra-inspeção informada nesta data.');
           exit;
       end;
       if (c_ope > 30) and (c_ope < 48) then c_ope := 0;
       if c_ope < 0  then c_ope := 0;
       if (c_ope > 47) and (tbrdpfos.value = 20250000) then
       begin
           showmessage('Não foi possível registrar o Operações.  A OS informada é exclusiva para Operações com inspeções .');
           exit;
       end;
       tbrdpfponto.value := c_ope;
   end;



   if tbrdpfdoc.Value = 'AFASTAMENTOS (LC 548/2023)' then
   begin
        tbauxrdpf.filter:='nome=' + quotedstr(tbrdpfnome.value)+' and '+'data='+quotedstr(datetostr(tbrdpfdata.value));
        tbauxrdpf.first;
       while not tbauxrdpf.eof do
       begin
            if tbauxrdpfcontrole.value <> tbrdpfcontrole.value then c_ope := c_ope - tbauxrdpfponto.value;
            tbauxrdpf.Next;
       end;
       if (c_ope < 48) then
       begin
           showmessage('Não foi possível registrar o Afatamento.  Existe atividade extra-inspeção informada nesta data.');
           exit;
       end;
   end;

   if tbrdpfdoc.Value = 'APRESENTAÇÃO/PARTICIPAÇÃO/PREPARAÇÃO DE CURSOS E SIMILARES' then
   begin
        tbauxrdpf.filter:='nome=' + quotedstr(tbrdpfnome.value)+' and '+'data='+quotedstr(datetostr(tbrdpfdata.value));
        tbauxrdpf.first;
       while not tbauxrdpf.eof do
       begin
            if (tbauxrdpfcontrole.value <> tbrdpfcontrole.value) and (tbauxrdpftipo.Value = 'S') then c_ope := c_ope - tbauxrdpfponto.value;
            tbauxrdpf.Next;
       end;
    //   if c_ope < 0  then c_ope := 0;
       if c_ope < 24 then
       begin
           showmessage('Não foi possível registrar o Treinamento.  Existe atividade extra-inspeção informada nesta data.');
           exit;
       end;
   end;

   if tbrdpfdoc.Value = 'PLANTÃO FISCAL' then
   begin
        tbauxrdpf.filter:='nome=' + quotedstr(tbrdpfnome.value)+' and '+'data='+quotedstr(datetostr(tbrdpfdata.value));
        tbauxrdpf.first;
       while not tbauxrdpf.eof do
       begin
            if tbauxrdpfcontrole.value <> tbrdpfcontrole.value then c_ope := c_ope - tbauxrdpfponto.value;
            tbauxrdpf.Next;
       end;
       if (c_ope < 48) then
       begin
           showmessage('Não foi possível registrar o PLANTÃO FISCAL. Existe atividade informada nesta data.');
           exit;
       end;
   end;

   if tbrdpfdoc.Value = 'SERVIÇOS TÉCNICOS REALIZADOS NO ÂMBITO DA VIGILÂNCIA SANITÁRIA' then
   begin
        tbauxrdpf.filter:='nome=' + quotedstr(tbrdpfnome.value)+' and '+'data='+quotedstr(datetostr(tbrdpfdata.value));
        tbauxrdpf.first;
       while not tbauxrdpf.eof do
       begin
            if (tbauxrdpfcontrole.value <> tbrdpfcontrole.value) and (tbauxrdpftipo.Value = 'S') then c_ope := c_ope - tbauxrdpfponto.value;
            tbauxrdpf.Next;
       end;
       if (c_ope < 48 ) then
       begin
           showmessage('Não foi possível registrar o SERVIÇOS TÉCNICOS. Existe atividade extra-inspeção informada nesta data.');
           exit;
       end;

   end;

     if tbrdpftipoos.value = 'DE OFÍCIO' then
     begin
            if tbauxoficio.FindKey([tbrdpfos.value]) then
            begin
                if tbauxoficioarchive.Value = false then
                begin
                    tbauxoficio.Edit;
                    tbauxoficioarchive.Value       := true;
                    tbauxoficiodtatendimento.Value := tbrdpfdata.Value;
                    tbauxoficio.Post;
                    showmessage('Ordem de serviço: ' + tbauxoficiooficio.AsString+' Baixada com sucesso.');
                end
                else showmessage('Atenção OS '+ tbauxoficiooficio.AsString+' já baixada anteriormente.' );
             end;
        end;


    cfiscal.text:=tbrdpfnome.value;
    tbrdpfhomologado.Value := 'Não';
                tbrdpfusuario.Value := frmlogin.c_user;
                tbrdpfdata_altera.Value := date;
    tbrdpf.Post;

// apontamento ini
           DBCfiscal.ReadOnly := false;
           DBEdata.ReadOnly   := false;
           DBCdoc.ReadOnly    := false;
           DBEestabe.ReadOnly := false;
// apontamento final

    DBCfiscal.ReadOnly := true;
    tbrmpf.Filtered:=true;
    tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.Date));
    tbrdpf.Refresh;
end;

procedure Tfrmrdpf.btcanatClick(Sender: TObject);
begin

// apontamento ini
           DBCfiscal.ReadOnly := false;
           DBEdata.ReadOnly   := false;
           DBCdoc.ReadOnly    := false;
           DBEestabe.ReadOnly := false;
// apontamento final

    DBCfiscal.ReadOnly := true;
    tbauxoficio.First; 
    tbrdpf.Cancel;
end;

procedure Tfrmrdpf.btdelatClick(Sender: TObject);
begin

    if tbrdpfhomologado.Value = 'Não' then
    begin
        if (tbrdpffecha.Value <> true) or (frmlogin.c_grp = 'ADM') then 
        begin
            if tbrdpftipo.value = 'S' then
            begin
             if messagedlg('Confirma a Exclusão da Atividade :'+#13+ tbrdpfdoc.value+ '?',mtconfirmation,[mbyes,mbno],0)=mryes then
             if (frmlogin.c_user = tbrdpfnome.value) or
             (frmlogin.c_grp = 'ADM')
             then tbrdpf.Delete else showmessage('Usuário não autorizado!');
            end
            else showmessage('Possível somente para Outras Atividades Fiscais');
        end
        else showmessage('Atividade Conferida, Impossível Excluir!.');
    end
    else showmessage('Atividade Homologada, Impossível Excluir!.');
end;

procedure Tfrmrdpf.DBEdataExit(Sender: TObject);
begin
  if frmlogin.c_user<>'CLÁUDIO NASCIMENTO SILVA' then
  begin
   if tbrdpfdata.value > date then
   begin
        showmessage('Data da Atividade inválida!');
        DBEData.setfocus;
   end;
  end;
end;

procedure Tfrmrdpf.BtmanualClick(Sender: TObject);
begin
tbrdpf.Filtered:=false;
end;

procedure Tfrmrdpf.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

procedure Tfrmrdpf.BtHomologaClick(Sender: TObject);
var
d_ponto:real;
d_negativo:real;
begin

 if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_per <> 'PRO')  then
 begin
          showmessage('Usuário não autorizado');
          exit;
 end;

       if daysbetween(DTPrel.date,date) < 2 then
       begin
           showmessage('Atenção!!!!! Inpossível fechar relat[ririo com prazo menor que 2 dias.');
           CFiscal.SetFocus;
           exit;
       end;


tbrmpf.Filtered:=false;
tbrmpf.IndexName:='PorData';
if tbrmpf.FindKey([DTPrel.date])then
    while not tbrmpf.Eof
    do
    begin
        if (tbrmpfnome.value=cfiscal.text) and (tbrmpfdata.value=DTPrel.date) then
        begin
         //   showmessage('Relatório Homologado para data e fiscal selecionados, Impossível Alterar!');
           messagedlg('Relatório Fechado: '+#13+ tbrmpfnome.value+ ' para esta data: '+tbrmpfdata.asstring+' Impossível Alterar!',mtinformation,[mbok],0);
           exit;
        end
        else tbrmpf.Next;
    end;

       if length(cfiscal.text) = 0 then
       begin
          showmessage('Selecione um Fiscal');
          CFiscal.SetFocus;
          exit;
       end;


    if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO') then
    begin
       if messagedlg('Confirma o Fechamento da Relatório de: '+#13+ cfiscal.text+ ' para a data: '+quotedstr(datetostr(DTPrel.date))+' ?',mtconfirmation,[mbyes,mbno],0)=mryes then
       begin
           d_ponto:=0;
           d_negativo:=0;
           tbrdpf.filtered:=true;
           tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.date));
           tbrdpf.First;
           while not tbrdpf.eof do
           begin
 //               if tbrdpfnome.Value = cfiscal.text and tbrdpfdata.Value = cfiscal.text then
 //               begin
                    tbrdpf.Edit;
                    tbrdpfhomologado.Value:='Sim';

                tbrdpfusuario.Value := frmlogin.c_user;
                tbrdpfdata_altera.Value := date;
                tbrdpfuser_homoloda.value := frmlogin.c_user;
                tbrdpfdata_homologa.value := date;

                    tbrdpf.post;
                    d_ponto:=d_ponto+tbrdpfponto.value;
                    d_negativo:=d_negativo+tbrdpfnegativo.value;
                    tbrdpf.next;
 //               end;
           end;
           if d_ponto > 0 then
           begin
                tbrmpf.insert;
                tbrmpfnome.value:=cfiscal.text;
                tbrmpfdata.value:=DTPrel.Date;
                tbrmpfmes.value:=monthof(DTPrel.Date);
                tbrmpfano.value:=yearof(DTPrel.Date);
                tbrmpfponto.value:=d_ponto;
                tbrmpfnegativo.value:=d_negativo;
                tbrmpf.Post;
                showmessage('Relatório fechado com sucesso!');
           end
           else showmessage('Não há relatório para data selecionada!');
//       tbrdpf.filtered:=false;
       end
       else exit;
    end
    else showmessage('Usuário não autorizado!');
//    frmprincipal.nova_data:=false;
end;


procedure Tfrmrdpf.DBCdocExit(Sender: TObject);
begin
     if dsrdpf.State <> dsbrowse then
     begin
        if tbrdpfdoc.Value ='AFASTAMENTOS (LC 548/2023)'                                                     then tbrdpfponto.value := 50;
        if tbrdpfdoc.Value ='APRESENTAÇÃO/PARTICIPAÇÃO/PREPARAÇÃO DE CURSOS E SIMILARES'                     then tbrdpfponto.value := 24;
        if tbrdpfdoc.Value ='OPERAÇÕES FISCAIS NÃO PREVISTAS E/OU SITUAÇÕES EXTRAORDINÁRIAS'                 then tbrdpfponto.value := 0;
        if tbrdpfdoc.Value ='PLANTÃO FISCAL'                                                                 then tbrdpfponto.value := 48;
        if tbrdpfdoc.Value ='SERVIÇOS TÉCNICOS REALIZADOS NO ÂMBITO DA VIGILÂNCIA SANITÁRIA'                 then tbrdpfponto.value := 48;
     end;
end;

procedure Tfrmrdpf.btmesClick(Sender: TObject);
begin

if length(cfiscal.text) = 0 then
begin
   showmessage('Selecione um Fiscal');
   CFiscal.SetFocus;
   exit;
end;
if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_grp <> 'FIS')   then
begin
        showmessage('Usuário não Autorizado');
        exit;
end;
        rel_rmpf.tbrmpf.open;
        rel_rmpf.tbrmpf.Filtered:=true;
        rel_rmpf.tbrmpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'mes='+quotedstr(formatdatetime('mm',DTPrel.Date))+' and '+'ano= '+quotedstr(formatdatetime('yyyy',DTPrel.Date));
        rel_rmpf.mes_rel:=monthof(DTPrel.Date);
        rel_rmpf.ano_rel:=yearof(DTPrel.Date);
        rel_rmpf.reprmpf.preview;
        rel_rmpf.tbrmpf.close;
        frmprincipal.nova_data:=false;
end;


procedure Tfrmrdpf.bthelpClick(Sender: TObject);
begin
aboutbox.showmodal;
end;

procedure Tfrmrdpf.btpendClick(Sender: TObject);
var
nao :string ;

begin

if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_grp <> 'FIS') and (frmlogin.c_per <> 'PRO') then
   begin
      showmessage('Usuário não Autorizado');
      exit;
   end;
nao :='Não';
rel_pen.tbpen.open;
rel_pen.tbpen.Filtered:=true;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO')
then
    if length(cfiscal.text) = 0 then
          rel_pen.tbpen.filter:=                                         'homologado='+quotedstr(nao)+' and '+'data>='+quotedstr(datetostr(DTPrel.Date))+' and '+'data<='+quotedstr(datetostr(DTPFinal.Date))
    else  rel_pen.tbpen.filter:= 'nome='+quotedstr(cfiscal.text)+' and '+'homologado='+quotedstr(nao)+' and '+'data>='+quotedstr(datetostr(DTPrel.Date))+' and '+'data<='+quotedstr(datetostr(DTPFinal.Date))
else      rel_pen.tbpen.filter:= 'nome='+quotedstr(cfiscal.text)+' and '+'homologado='+quotedstr(nao)+' and '+'data>='+quotedstr(datetostr(DTPrel.Date))+' and '+'data<='+quotedstr(datetostr(DTPFinal.Date));
    rel_pen.reppen.Preview;
    rel_pen.tbpen.close;
    frmprincipal.nova_data:=false;
end;

procedure Tfrmrdpf.DBCdocChange(Sender: TObject);
begin
 perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmrdpf.DBCfiscalChange(Sender: TObject);
begin
//perform(Wm_nextdlgctl,0,0);
end;


procedure Tfrmrdpf.btconsolidaClick(Sender: TObject);
var
c_fis:string;
c_pon:real;
c_neg:real;
begin
if (frmlogin.c_grp = 'ADM')  then
 begin
    tbrcon.filtered:=false;
    tbrcon.first;
 {   if (monthof(DTPrel.Date) < monthof(date)-1) and (yearof(dtprel.date)<2023) then
    begin
        showmessage('RMPDF já fechado para mês selecionado, impossível alterar');
        exit;
    end; }
    while not tbrcon.eof do if (tbrconmes.value = monthof(DTPrel.Date)) and (tbrconano.value = yearof(dtprel.date)) then tbrcon.delete else tbrcon.next;
    tbrmpf.filtered:=true;
    tbrmpf.Filter:='mes='+quotedstr(formatdatetime('mm',DTPrel.Date))+' and '+'ano= '+quotedstr(formatdatetime('yyyy',DTPrel.Date));
    tbrmpf.IndexName:='PorNome';
    tbrmpf.First;
    c_fis:=tbrmpfnome.value;
    c_pon:=0;
    c_neg:=0;
     while not tbrmpf.Eof do
     begin
        if tbrmpfnome.value<>c_fis  then
        begin
            tbrcon.insert;
            tbrconnome.value:=c_fis;
            tbrconponto.value:=c_pon;
            tbrconnegativo.value:=c_neg;
            tbrconmes.value:= monthof(DTPrel.Date);
            tbrconano.value:= yearof(DTPrel.Date);
            tbrcon.post;
            c_pon:=0;
            c_neg:=0;
            c_fis:=tbrmpfnome.value;
         end;
         c_pon:=c_pon+tbrmpfponto.value;
         c_neg:=c_neg+tbrmpfnegativo.value;
         tbrmpf.Next;
         if (tbrmpf.Eof) and (tbrmpfnome<>tbrconnome) then
         begin
            tbrcon.insert;
            tbrconnome.value:=c_fis;
            tbrconponto.value:=c_pon;
            tbrconnegativo.value:=c_neg;
//            tbrconprodutividade.Value:= roundto((c_pon-250)*0.2666, -2);
            tbrconmes.value:= monthof(DTPrel.Date);
            tbrconano.value:= yearof(DTPrel.Date);
            tbrcon.post;
            c_pon:=0;
            c_neg:=0;
            c_fis:=tbrmpfnome.value;
         end;

    end;   // fim do loop
    tbrmpf.filtered:=true;
///relatorio
        rel_rcon.tbrcon.open;
        rel_rcon.tbrcon.Filtered:=true;
        rel_rcon.tbrcon.filter:= 'mes='+quotedstr(formatdatetime('mm',DTPrel.Date))+' and '+'ano= '+quotedstr(formatdatetime('yyyy',DTPrel.Date));
        rel_rcon.mes_rel:=monthof(DTPrel.Date);
        rel_rcon.ano_rel:=yearof(DTPrel.Date);
        rel_rcon.repcon.preview;
        rel_rcon.tbrcon.close;
        frmprincipal.nova_data:=false;
end
else showmessage('Perfil não autorizado');


end;



procedure Tfrmrdpf.btconfereClick(Sender: TObject);
begin
    if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO') then
    begin

       if length(cfiscal.text) = 0 then
       begin
          showmessage('Selecione um Fiscal');
          CFiscal.SetFocus;
          exit;
       end;

       if tbrdpf.Eof then
       begin
          showmessage('Selecione uma Atividade ou documento fiscal');
          CFiscal.SetFocus;
          exit;
       end;

       if daysbetween(tbrdpfdata.value,date) < 2 then
       begin
           showmessage('Atenção!!!!! Inpossível conferência de Atividade com prazo menor que 2 dias.');
           CFiscal.SetFocus;
           exit;
       end;

      if tbrdpfhomologado.Value <> 'Sim' then
      begin
        if tbrdpffecha.Value <> true then
        begin
            if messagedlg(frmlogin.c_user+', confirma que o documento/atividade: '+tbrdpfdoc.Value+' referente à/ao '+tbrdpfestabe.Value+' de '+datetostr(tbrdpfdata.value)+', informada(o) por '+tbrdpfnome.Value+' foi devidamente conferida(o) ?',mtwarning,[mbyes,mbno],0)=mryes then
            begin
               tbrdpf.edit;
               tbrdpffecha.Value := true;
               tbrdpfData_fecha.Value := date;
               tbrdpfUsr_fecha.Value := frmlogin.c_user;
               tbrdpf.Post;
            end;
        end
        else showmessage('Atividade já confedida');
      end
      else showmessage('Atividade já homologada');
    end
    else showmessage('Perfil não autorizado');
end;

procedure Tfrmrdpf.btanotaClick(Sender: TObject);
begin
    if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'PRO') then
    begin

       if length(cfiscal.text) = 0 then
       begin
          showmessage('Selecione um Fiscal');
          CFiscal.SetFocus;
          exit;
       end;

       if tbrdpf.Eof then
       begin
          showmessage('Selecione uma Atividade ou documento fiscal');
          CFiscal.SetFocus;
          exit;
       end;


       if tbrdpfhomologado.Value <> 'Sim' then
       begin
          if (tbrdpffecha.Value <> true) or (frmlogin.c_grp = 'ADM') then
          begin
              tbrdpf.edit;
              DBCfiscal.ReadOnly  := true;
              DBEdata.ReadOnly    := true;
              DBCdoc.ReadOnly     := true;
              DBEestabe.ReadOnly  := true;
              tbrdpfentrega.Value := true;
              tbrdpffecha.Value   := false;
          end
          else showmessage('Atividade já confedida');
       end
       else showmessage('Atividade já homologada');
    end
    else showmessage('Perfil não autorizado');

end;

procedure Tfrmrdpf.BtoldClick(Sender: TObject);
begin
if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_grp <> 'FIS') then
begin
   showmessage('Usuário não Autorizado');
   exit;
end;

if length(cfiscal.text) = 0 then
begin
   showmessage('Selecione um Fiscal');
   CFiscal.SetFocus;
   exit;
end;

if DTPrel.Date > DTPFinal.Date then
begin
   showmessage('Data final menor que a incial');
   DTPrel.SetFocus;
   exit;
end;


rel_old.tbarq.open;
rel_old.tbarq.Filtered:=true;
//rel_rpdf.tbrdpf.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data='+quotedstr(datetostr(DTPrel.Date));
rel_old.tbarq.filter:= 'nome=' + quotedstr(cfiscal.text)+' and '+'data>='+quotedstr(datetostr(DTPrel.Date))+' and '+'data<='+quotedstr(datetostr(DTPFinal.Date))+' and '+'homologado ='+quotedstr('Sim');
rel_old.repold.Preview;
rel_old.tbarq.close;
frmprincipal.nova_data:=false;

end;

procedure Tfrmrdpf.BtsaiClick(Sender: TObject);
begin
Cfiscal.text:='';
close;

end;

end.


