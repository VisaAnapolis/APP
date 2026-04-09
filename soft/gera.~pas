unit gera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, dateutils;

type
  Tfrmgera = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    LbRaz: TLabel;
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
    tbcontribCPFREPRES: TStringField;
    tbcontribATIVIDADE: TIntegerField;
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
    tbvisitas: TTable;
    dsvisitas: TDataSource;
    tbcontribHORARIO: TStringField;
    Lbcod:  TLabel;
    tbrt: TTable;
    Lbdata: TLabel;
    tbvisitasCONTROLE: TAutoIncField;
    tbvisitasCODIGO: TIntegerField;
    tbvisitasDT_VISITA: TDateField;
    tbvisitasPZ_RETORNO: TSmallintField;
    tbvisitasPRIORIDADE: TBooleanField;
    tbvisitasACAO: TStringField;
    tbvisitasTIPO: TStringField;
    tbvisitasModalidade: TStringField;
    tbvisitasDenuncia: TIntegerField;
    tbvisitasOS: TIntegerField;
    tbvisitasOficio: TIntegerField;
    tbvisitasProtocolo: TIntegerField;
    tbvisitasNUMERO: TStringField;
    tbvisitasNDOC: TIntegerField;
    tbvisitasAtividade: TStringField;
    tbvisitasArea: TStringField;
    tbvisitasLibera: TStringField;
    tbvisitasFiscal1: TStringField;
    tbvisitasFiscal2: TStringField;
    tbvisitasFiscal3: TStringField;
    tbvisitasMeio: TStringField;
    tbvisitasUs_inclu: TStringField;
    tbvisitasDt_inclu: TDateField;
    tbvisitasGr_inclu: TStringField;
    tbvisitasUs_altera: TStringField;
    tbvisitasDt_altera: TDateField;
    tbvisitasEntrega: TBooleanField;
    dsrt: TDataSource;
    LbCnae: TLabel;
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
    tbrtEquipe: TStringField;
    tbcnae: TTable;
    tbcnaeControle: TAutoIncField;
    tbcnaeSubclasse: TStringField;
    tbcnaeClasse: TStringField;
    tbcnaeAtividade: TStringField;
    tbcnaeEquipe: TStringField;
    tbcnaeComplexidade: TStringField;
    dscnae: TDataSource;
    lbequipe: TLabel;
    tbbairro: TTable;
    dsbairro: TDataSource;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    tbbairroSETORALIMENTO: TIntegerField;
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
    lbfiscal: TLabel;
    lbbairro: TLabel;
    lbcmplex: TLabel;
    lbx: TLabel;
    tbsequencia: TTable;
    tbsequenciaNumero: TIntegerField;
    tbsequenciaDoc: TIntegerField;
    tbsequenciaDen: TIntegerField;
    tbsequenciaOficio: TIntegerField;
    tbsequenciaAlvara: TIntegerField;
    tbsequenciaVeiculo: TIntegerField;
    tbsequenciaPt: TIntegerField;
    tbsequenciaProtocolo: TIntegerField;
    tbsequenciaDisponibilidade: TBooleanField;
    tbsequenciaVersao: TStringField;
    tbsequenciaDt_versao: TStringField;
    tboficio: TTable;
    tboficioControle: TAutoIncField;
    tboficioOficio: TIntegerField;
    tboficioData: TDateField;
    tboficioEmitente: TStringField;
    tboficioMotivo: TStringField;
    tboficioRegulado: TStringField;
    tboficioLogradouro: TStringField;
    tboficioCdbai: TSmallintField;
    tboficioOrdem: TStringField;
    tboficioCpf: TStringField;
    tboficioCnpj: TStringField;
    tboficioFiscalencaminha: TStringField;
    tboficioDtencaminha: TDateField;
    tboficioPrazo: TDateField;
    tboficioDtatendimento: TDateField;
    tboficioCancela: TBooleanField;
    tboficioArchive: TBooleanField;
    tboficioUser: TStringField;
    doficio: TDataSource;
    lblogradouro: TLabel;
    lbcpf: TLabel;
    lbcnpj: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmgera: Tfrmgera;

implementation

{$R *.dfm}

procedure Tfrmgera.Button1Click(Sender: TObject);
var
x:integer;
numof:integer;
begin
    x :=0;
    tbcontrib.First;
    while not tbcontrib.eof do
    begin
        begin
           if tbcontribinatividade.Value <> true then
           begin
               if (yearsbetween(tbvisitasdt_visita.Value,date) > 2) and (yearsbetween(tbvisitasdt_visita.Value,date) < 8) then
               begin
                   tbrt.First;
                   while not tbrt.Eof do
                   begin
                       if tbrttipo.value = 'Principal' then
                       begin
                           if tbcnae.FindKey([tbrtsubclasse.value]) then
                           begin

                                x                        := x+1;
                                lbx.Caption              :=inttostr(x);

                                numof                    :=tbsequenciaoficio.Value+1;
                                tboficio.Insert;
                                tboficiooficio.Value     := numof;

                                lbcod.caption            :=inttostr(tbcontribcodigo.value);
                                lbraz.caption            :=tbcontribrazao.value;
                                tboficioregulado.Value   :=tbcontribrazao.value+', '+'COD: '+inttostr(tbcontribcodigo.Value);
                                lblogradouro.Caption     :=tbcontriblogradouro.Value+' '+tbcontribcomplement.value;
                                tboficiologradouro.Value :=tbcontriblogradouro.Value+' '+tbcontribcomplement.value;
                                lbcpf.Caption            :=tbcontribcpf.Value;
                                tboficiocpf.Value        :=tbcontribcpf.Value;
                                lbcnpj.Caption           :=tbcontribcgc.Value;
                                tboficiocnpj.Value       :=tbcontribcgc.Value;
                                tboficiomotivo.Value     :='INSPEÇÃO SANITÁRIA';

                                tboficiocdbai.Value :=tbcontribcdbai.value;

                                lbdata.caption      :='INSC '+inttostr(tbcontribcodigo.Value)+' -  CNAE '+tbrtsubclasse.Value+' '+tbcnaecomplexidade.Value+', último doc: '+datetostr(tbvisitasdt_visita.value);
                                tboficioordem.Value :='CNAE '+tbrtsubclasse.Value+', '+tbcnaecomplexidade.Value+', último documento: '+datetostr(tbvisitasdt_visita.value);

                                lbcnae.Caption   := tbrtsubclasse.Value;

                                lbcmplex.Caption := tbcnaecomplexidade.Value;
                                lbequipe.caption := tbcnaeequipe.Value;
                                lbbairro.Caption := tbbairronome.Value;

                                if tbcnaeequipe.Value = 'IA' then lbfiscal.caption := tbbairroIA.Value;
                                if tbcnaeequipe.Value = 'AG' then lbfiscal.caption := tbbairroAG.Value;
                                if tbcnaeequipe.Value = 'ED' then lbfiscal.caption := tbbairroED.Value;
                                if tbcnaeequipe.Value = 'OS' then lbfiscal.caption := tbbairroOS.Value;
                                if tbcnaeequipe.Value = 'SS' then lbfiscal.caption := tbbairroSS.Value;
                                if tbcnaeequipe.Value = 'OD' then lbfiscal.caption := tbbairroOD.Value;
                                if tbcnaeequipe.Value = 'ED' then lbfiscal.caption := tbbairroED.Value;
                                if tbcnaeequipe.Value = 'CS' then lbfiscal.caption := tbbairroCS.Value;
                                if tbcnaeequipe.Value = 'AM' then lbfiscal.caption := tbbairroAM.Value;
                                if tbcnaeequipe.Value = 'VT' then lbfiscal.caption := tbbairroVT.Value;
                                if tbcnaeequipe.Value = 'BI' then lbfiscal.caption := tbbairroBI.Value;
                                if tbcnaeequipe.Value = 'LP' then lbfiscal.caption := tbbairroLP.Value;
                                if tbcnaeequipe.Value = 'AO' then lbfiscal.caption := tbbairroAO.Value;
                                if tbcnaeequipe.Value = 'TR' then lbfiscal.caption := tbbairroTR.Value;
                                if tbcnaeequipe.Value = 'FU' then lbfiscal.caption := tbbairroFU.Value;
                                if tbcnaeequipe.Value = 'DR' then lbfiscal.caption := tbbairroDR.Value;
                                if tbcnaeequipe.Value = 'MD' then lbfiscal.caption := tbbairroMD.Value;

                                tboficiofiscalencaminha.Value :=lbfiscal.Caption;
                                tboficiodata.Value            :=date;
                                tboficiodtencaminha.Value     :=strtodate('01/06/2025');
                                tboficioemitente.value        :='SIMONE DUARTE GROSSI';
                                tboficioprazo.Value           :=strtodate('01/06/2025')+90;
                                tboficiouser.Value            :='CLÁUDIO NASCIMENTO SILVA';

                                tboficio.Post;
                                tbsequencia.Edit;
                                tbsequenciaoficio.Value :=numof;
                                tbsequencia.Post;

                                refresh;
//                              sleep(100);
//                              if messagedlg(' sair ?',mtconfirmation,[mbyes,mbno],0)=mryes then exit;
                           end;
                       end;
                       tbrt.Next;
                   end;

                end;
           end;
        end;
//        refresh;
//        sleep(100);
//        if messagedlg(' sair ?',mtconfirmation,[mbyes,mbno],0)=mryes then exit;
        tbcontrib.next;

  end;
end;

procedure Tfrmgera.FormActivate(Sender: TObject);
begin
tbsequencia.open;
tbcontrib.open;
tbvisitas.open;
tbrt.Open;
tbcnae.Open;
tbbairro.open;
tboficio.Open;
end;

procedure Tfrmgera.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
tboficio.close;
tbbairro.close;
tbcnae.close;
tbvisitas.close;
tbrt.close;
tbcontrib.close;
tbsequencia.close;

end;


end.
