unit concatena;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables;

type
  Tfrmconcatena = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Lfantasia: TLabel;
    tbmatricula: TTable;
    tbmatriculaCONTROLE: TAutoIncField;
    tbmatriculaCODIGO: TIntegerField;
    tbmatriculaPESSOA: TStringField;
    tbmatriculaCPF: TStringField;
    tbmatriculaCGC: TStringField;
    tbmatriculaAGREGADO: TBooleanField;
    tbmatriculaRAZAO: TStringField;
    tbmatriculaFANTASIA: TStringField;
    tbmatriculaREPRESENTANTE: TStringField;
    tbmatriculaCPFREPRES: TStringField;
    tbmatriculaATIVIDADE: TIntegerField;
    tbmatriculaAREA: TIntegerField;
    tbmatriculaGRUPO: TIntegerField;
    tbmatriculaMUNICIPAL: TStringField;
    tbmatriculaLOGRADOURO: TStringField;
    tbmatriculaCOMPLEMENT: TStringField;
    tbmatriculaBAIRRO: TStringField;
    tbmatriculaCDBAI: TIntegerField;
    tbmatriculaZONA: TSmallintField;
    tbmatriculaCEP: TStringField;
    tbmatriculaFONE: TStringField;
    tbmatriculaEMAIL: TStringField;
    tbmatriculaTAXA: TBooleanField;
    tbmatriculaINATIVIDADE: TBooleanField;
    tbmatriculaOBS: TMemoField;
    tbmatriculaPendoc: TBooleanField;
    tbmatriculaDt_cadastro: TDateField;
    tbmatriculaUser: TStringField;
    tbmatriculaDt_alter: TDateField;
    tbmatriculaH_alter: TTimeField;
    dsmatricula: TDataSource;
    Lbcodigo: TLabel;
    LRT1: TLabel;
    tbcnpj: TTable;
    tbcnpjCONTROLE: TAutoIncField;
    tbcnpjCODIGO: TIntegerField;
    tbcnpjPESSOA: TStringField;
    tbcnpjCPF: TStringField;
    tbcnpjCGC: TStringField;
    tbcnpjAGREGADO: TBooleanField;
    tbcnpjRAZAO: TStringField;
    tbcnpjFANTASIA: TStringField;
    tbcnpjREPRESENTANTE: TStringField;
    tbcnpjCPFREPRES: TStringField;
    tbcnpjATIVIDADE: TIntegerField;
    tbcnpjAREA: TIntegerField;
    tbcnpjGRUPO: TIntegerField;
    tbcnpjMUNICIPAL: TStringField;
    tbcnpjLOGRADOURO: TStringField;
    tbcnpjCOMPLEMENT: TStringField;
    tbcnpjBAIRRO: TStringField;
    tbcnpjCDBAI: TIntegerField;
    tbcnpjZONA: TSmallintField;
    tbcnpjCEP: TStringField;
    tbcnpjFONE: TStringField;
    tbcnpjEMAIL: TStringField;
    tbcnpjTAXA: TBooleanField;
    tbcnpjINATIVIDADE: TBooleanField;
    tbcnpjOBS: TMemoField;
    tbcnpjPendoc: TBooleanField;
    tbcnpjDt_cadastro: TDateField;
    tbcnpjUser: TStringField;
    tbcnpjDt_alter: TDateField;
    tbcnpjH_alter: TTimeField;
    dscgc: TDataSource;
    rtcontr: TTable;
    rtcontrControle: TAutoIncField;
    rtcontrCodigo: TIntegerField;
    rtcontrNomeResp1: TStringField;
    rtcontrConsResp1: TStringField;
    rtcontrUFResp1: TStringField;
    rtcontrRegResp1: TStringField;
    rtcontrNomeResp2: TStringField;
    rtcontrConsResp2: TStringField;
    rtcontrUFResp2: TStringField;
    rtcontrRegResp2: TStringField;
    rtcontrRepresentante: TStringField;
    rtcontrCPFRepres: TStringField;
    rtcontrAtividade: TStringField;
    LObs: TLabel;
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
    rtmatri: TTable;
    rtmatriControle: TAutoIncField;
    rtmatriCodigo: TIntegerField;
    rtmatriNomeResp1: TStringField;
    rtmatriConsResp1: TStringField;
    rtmatriUFResp1: TStringField;
    rtmatriRegResp1: TStringField;
    rtmatriNomeResp2: TStringField;
    rtmatriConsResp2: TStringField;
    rtmatriUFResp2: TStringField;
    rtmatriRegResp2: TStringField;
    rtmatriRepresentante: TStringField;
    rtmatriCPFRepres: TStringField;
    rtmatriAtividade: TStringField;
    tbvisitas: TTable;
    tbvisitasCONTROLE: TAutoIncField;
    tbvisitasCODIGO: TIntegerField;
    tbvisitasDT_VISITA: TDateField;
    tbvisitasH_visita: TTimeField;
    tbvisitasH_fim: TTimeField;
    tbvisitasItens: TSmallintField;
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
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    arrumacpf: TButton;
    tbcpf: TTable;
    tbcpfCONTROLE: TAutoIncField;
    tbcpfCODIGO: TIntegerField;
    tbcpfPESSOA: TStringField;
    tbcpfCPF: TStringField;
    tbcpfCGC: TStringField;
    tbcpfAGREGADO: TBooleanField;
    tbcpfRAZAO: TStringField;
    tbcpfFANTASIA: TStringField;
    tbcpfREPRESENTANTE: TStringField;
    tbcpfCPFREPRES: TStringField;
    tbcpfATIVIDADE: TIntegerField;
    tbcpfAREA: TIntegerField;
    tbcpfGRUPO: TIntegerField;
    tbcpfMUNICIPAL: TStringField;
    tbcpfLOGRADOURO: TStringField;
    tbcpfCOMPLEMENT: TStringField;
    tbcpfBAIRRO: TStringField;
    tbcpfCDBAI: TIntegerField;
    tbcpfZONA: TSmallintField;
    tbcpfCEP: TStringField;
    tbcpfFONE: TStringField;
    tbcpfEMAIL: TStringField;
    tbcpfTAXA: TBooleanField;
    tbcpfINATIVIDADE: TBooleanField;
    tbcpfOBS: TMemoField;
    tbcpfPendoc: TBooleanField;
    tbcpfDt_cadastro: TDateField;
    tbcpfUser: TStringField;
    tbcpfDt_alter: TDateField;
    tbcpfH_alter: TTimeField;
    dscpf: TDataSource;
    lbcpf: TLabel;
    lbcpffan: TLabel;
    Button3: TButton;
    tbcaracter: TTable;
    tbcaracterCONTROLE: TAutoIncField;
    tbcaracterCODIGO: TIntegerField;
    tbcaracterHOSTEL: TIntegerField;
    tbcaracterFUNCIONARIO: TIntegerField;
    tbcaracterPISCINA: TBooleanField;
    tbcaracterRADIO: TBooleanField;
    tbcaracterCIRUGIA: TBooleanField;
    tbcaracterSALA: TBooleanField;
    tbcaracterDISPENSA: TBooleanField;
    tbcaracterFARMACEUTICOS: TBooleanField;
    tbcaracterHORARIO: TStringField;
    dscaracter: TDataSource;
    tbcontribHORARIO: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure arrumacpfClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmconcatena: Tfrmconcatena;

implementation

{$R *.dfm}

procedure Tfrmconcatena.Button1Click(Sender: TObject);
var
cgc:string;
obs:string;
x:integer;
begin
    tbcnpj.First;
    cgc:='inicio';
    obs:='';
    x:=0;
    while not tbcnpj.eof do
    begin
       cgc:=tbcnpjcgc.value;
       tbcnpj.Next;
       if tbmatricula.findkey([tbcnpjcodigo.value]) then
       begin
          if (tbmatriculacgc.value = cgc) and (tbmatriculacgc.value <> '01.067.479/0001-46') and (tbmatriculacgc.value <> '06.086.006/0001-00')  and (tbmatriculacgc.value <> '06.169.881/0001-55') and not (tbmatriculacgc.isnull) then
          begin
             if tbcontrib.FindKey([tbmatriculacgc.value]) then
             begin
                 lbcodigo.caption:=inttostr(x)+' - CNPJ: '+tbmatriculacgc.value+' - '+tbmatricularazao.value;
                 Lfantasia.Caption:=tbmatriculafantasia.Value+tbmatriculaobs.value;
//                 tbvisitas.filter:='codigo='+inttostr(tbmatriculacodigo.value);
                 tbvisitas.First;
                 if tbvisitas.findkey([tbmatriculacodigo.value]) then
                 begin
                 while not tbvisitas.Eof do
                 begin
                     if tbvisitascodigo.value=tbmatriculacodigo.value then
                     begin
                         lrt1.caption:=inttostr(tbvisitascodigo.value)+' para '+inttostr(tbcontribcodigo.value);
                         Lobs.caption:=datetostr(tbvisitasdt_visita.value);
                         tbvisitas.Edit;
                         tbvisitascodigo.value:=tbcontribcodigo.value;
                         tbvisitas.post;
                         tbmatricula.edit;
                         tbmatriculainatividade.value:=true;
                         tbmatricula.post;
                     end;
                     refresh;
                     tbvisitas.Next;
                     if tbvisitascodigo.value <> tbmatriculacodigo.Value then tbvisitas.last;
                 end;
                 end;
                 x:=x+1;
                 refresh;
//                 showmessage('proximo');
             end;
          end;
       end;
    end;
    end;

procedure Tfrmconcatena.FormActivate(Sender: TObject);
begin
tbcpf.open;
tbcnpj.open;
tbmatricula.Open;
rtmatri.open;
tbcontrib.open;
rtcontr.Open;
end;

procedure Tfrmconcatena.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
rtcontr.open;
tbcontrib.open;
rtmatri.Close;
tbmatricula.Close;
tbcnpj.Close;
tbcpf.close;
end;

procedure Tfrmconcatena.Button2Click(Sender: TObject);
var
x:integer;
begin
tbcontrib.First;
x:=1;
while not tbcontrib.Eof do
begin
   if (length(tbcontribcpf.value) < 14) and (length(tbcontribcgc.value) < 18) then
   begin
      label1.caption:=tbcontribcpf.value;
      label2.caption:=tbcontribcgc.value;
      tbcontrib.edit;
      tbcontribinatividade.Value:=true;
      tbcontrib.post;
      label3.caption:='Proc.: '+inttostr(x);
      x:=x+1;
   end;
tbcontrib.Next;
refresh;
end;
label3.caption:='fim.: '+inttostr(x);
end;

procedure Tfrmconcatena.arrumacpfClick(Sender: TObject);
var
cpf:string;
x:integer;
begin
    tbcpf.First;
    cpf:='inicio';
    x:=0;
    while not tbcpf.eof do
    begin
       cpf:=tbcpfcpf.value;
       tbcpf.Next;
       if tbmatricula.findkey([tbcpfcodigo.value]) then
       begin
          if (tbmatriculacpf.value = cpf) and not (tbmatriculacpf.isnull) then
          begin
             if tbcontrib.FindKey([tbmatriculacpf.value]) then
             begin
                 lbcpf.caption:=inttostr(x)+' - CPF: '+tbmatriculacpf.value+' - '+tbmatricularazao.value;
                 Lbcpffan.Caption:=tbmatriculafantasia.Value;
             end;
             x:=x+1;
             refresh;
             showmessage('proximo');
          end;
       end;
    end;
end;

procedure Tfrmconcatena.Button3Click(Sender: TObject);
begin
    tbcontrib.First;
    while not tbcontrib.Eof do
    begin
        if tbcaracter.findkey([tbcontribcodigo.value]) then
        begin
           tbcontrib.edit;
           tbcontribhorario.value:=tbcaracterhorario.value;
           tbcontrib.post;
        end;
        tbcontrib.next;
    end;
end;

end.
