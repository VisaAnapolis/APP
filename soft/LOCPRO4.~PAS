unit LOCPRO4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  Tfrmlocpro4 = class(TForm)
    grade: TDBGrid;
    tbcgc: TTable;
    tbcgcCONTROLE: TAutoIncField;
    tbcgcCODIGO: TIntegerField;
    tbcgcCGC: TStringField;
    tbcgcRAZAO: TStringField;
    tbcgcFANTASIA: TStringField;
    dscgc: TDataSource;
    Panel1: TPanel;
    tbfan: TTable;
    dsfan: TDataSource;
    tbraz: TTable;
    dsraz: TDataSource;
    tbins: TTable;
    dsins: TDataSource;
    tbinsCONTROLE: TAutoIncField;
    tbinsCODIGO: TIntegerField;
    tbrazCONTROLE: TAutoIncField;
    tbrazCODIGO: TIntegerField;
    tbrazRAZAO: TStringField;
    tbfanCONTROLE: TAutoIncField;
    tbfanCODIGO: TIntegerField;
    tbfanFANTASIA: TStringField;
    Rselec: TRadioGroup;
    c_cgc: TEdit;
    c_ins: TEdit;
    c_raz: TEdit;
    c_fan: TEdit;
    c_cpf: TEdit;
    tbcpf: TTable;
    dscpf: TDataSource;
    tbcgcCPF: TStringField;
    tbinsRAZAO: TStringField;
    tbinsFANTASIA: TStringField;
    tbinsCPF: TStringField;
    tbinsCGC: TStringField;
    tbrazCPF: TStringField;
    tbrazCGC: TStringField;
    tbrazFANTASIA: TStringField;
    tbfanPESSOA: TStringField;
    tbfanCPF: TStringField;
    tbfanCGC: TStringField;
    tbfanRAZAO: TStringField;
    tbrazPESSOA: TStringField;
    tbinsPESSOA: TStringField;
    tbcgcPESSOA: TStringField;
    tbcpfCONTROLE: TAutoIncField;
    tbcpfCODIGO: TIntegerField;
    tbcpfPESSOA: TStringField;
    tbcpfCPF: TStringField;
    tbcpfCGC: TStringField;
    tbcpfRAZAO: TStringField;
    btcancel: TButton;
    btok: TButton;
    Btativ: TButton;
    tbcpfINATIVIDADE: TBooleanField;
    tbcgcINATIVIDADE: TBooleanField;
    tbinsINATIVIDADE: TBooleanField;
    tbrazINATIVIDADE: TBooleanField;
    tbfanINATIVIDADE: TBooleanField;
    StaticText1: TStaticText;
    t_cadastro: TStaticText;
    tbinsMUNICIPAL: TStringField;
    c_ccm: TEdit;
    dsccm: TDataSource;
    tbccm: TTable;
    tbccmCONTROLE: TAutoIncField;
    tbccmCODIGO: TIntegerField;
    tbccmMUNICIPAL: TStringField;
    tbccmINATIVIDADE: TBooleanField;
    tbcgcMUNICIPAL: TStringField;
    tbccmPESSOA: TStringField;
    tbccmCPF: TStringField;
    tbccmCGC: TStringField;
    tbccmRAZAO: TStringField;
    tbccmFANTASIA: TStringField;
    tbrazMUNICIPAL: TStringField;
    tbcpfMUNICIPAL: TStringField;
    tbfanMUNICIPAL: TStringField;
    procedure btokClick(Sender: TObject);
    procedure c_razChange(Sender: TObject);
    procedure btcancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure c_fanChange(Sender: TObject);
    procedure RselecClick(Sender: TObject);
    procedure c_cgcExit(Sender: TObject);
    procedure c_insExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure c_cpfExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtativClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure c_cpfChange(Sender: TObject);
    procedure c_cgcChange(Sender: TObject);
    procedure c_ccmExit(Sender: TObject);
    procedure c_ccmChange(Sender: TObject);
    procedure c_insChange(Sender: TObject);
  private
    inativo:integer;
    public
    loc_req:integer;
    selereq:integer;
  end;

var
  frmlocpro4: Tfrmlocpro4;


implementation

uses os;

{$R *.dfm}

procedure Tfrmlocpro4.btokClick(Sender: TObject);
begin

{   if (tbcgccgc.AsString <> c_cgc.text) and (sele = 1) then
   begin
           showmessage('Contribuinte não cadastrado');
           c_cgc.setfocus;
           exit;
   end;

   if (tbcpfcpf.AsString <> c_cpf.text) and (sele = 0) then
   begin
           showmessage('Contribuinte não cadastrado');
           c_cpf.setfocus;
           exit;
   end;}

   if (tbinscodigo.AsString <> c_ins.text) and (selereq = 3) then
   begin
           showmessage('Contribuinte não cadastrado');
           c_ins.setfocus;
           exit;
   end;

   if (tbccmmunicipal.value <> c_ccm.text) and (selereq = 3) then
   begin
           showmessage('Contribuinte não cadastrado');
           c_ccm.setfocus;
           exit;
   end;


   loc_req:=2;

    
   close;
{  close;}
end;


procedure Tfrmlocpro4.btcancelClick(Sender: TObject);
begin
   loc_req:=0;
   close;
end;

procedure Tfrmlocpro4.FormActivate(Sender: TObject);
begin
   tbraz.open;
   tbcpf.open;
   tbcgc.open;
   tbins.open;
   tbfan.open;
   tbccm.Open;

 {  c_nome := frmdenuncia.tbdenunciaReclamado.Value;
   c_cnpj := frmdenuncia.tbdenunciaCnpj.Value;
   c_logr := frmdenuncia.tbdenunciaLOGRADOURO.Value;
   c_refe := frmdenuncia.tbdenunciaREFERENCIA.Value;
   c_bai  := frmdenuncia.tbdenunciaCDBAI.Value;
 }
   c_raz.text:='' ;
   c_ins.text:='' ;
   c_cgc.text:='' ;
   c_fan.text:='' ;
   c_cpf.text:='' ;
   c_ccm.Text:='' ;
//   Rselec.setfocus;
// Rselec.Itemindex := -1;
   Rselec.Itemindex := 4;
//   c_raz.SetFocus;
   selereq := Rselec.Itemindex;
   grade.DataSource:=dsins;
   grade.Enabled:=false;
   inativo := 0;
   t_cadastro.Caption := 'Ativos Somente' ;
    tbcgc.Filter := 'inatividade <> true';
    tbcpf.Filter := 'inatividade <> true';
    tbins.Filter := 'inatividade <> true';
    tbraz.Filter := 'inatividade <> true';
    tbfan.Filter := 'inatividade <> true';
    tbccm.Filter := 'inatividade <> true';

                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_ccm.enabled:=false;
                c_raz.enabled:=true;
                c_fan.enabled:=false;
                c_raz.setfocus;
                grade.DataSource:=dsraz;
                grade.Enabled:=true;

end;

procedure Tfrmlocpro4.c_razChange(Sender: TObject);
begin
    tbraz.FindNearest([c_raz.text])
end;

procedure Tfrmlocpro4.c_fanChange(Sender: TObject);
begin
tbfan.FindNearest([c_fan.text])
end;

procedure Tfrmlocpro4.c_cpfChange(Sender: TObject);
begin
tbcpf.FindNearest([c_cpf.text])
end;
procedure Tfrmlocpro4.c_cgcChange(Sender: TObject);
begin
tbcgc.FindNearest([c_cgc.text])
end;



procedure Tfrmlocpro4.RselecClick(Sender: TObject);
begin
{   if  Rselec.ItemIndex = -1 then Rselec.ItemIndex := 0;}
   selereq:= Rselec.ItemIndex;
   case selereq of
           0:
           begin
                c_cpf.enabled:=true;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
                c_ccm.enabled:=false;
                c_cpf.setfocus;
                grade.DataSource:=dscpf;
                grade.Enabled:=true;
           end;
           1:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=true;
                c_ins.enabled:=false;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
                c_ccm.enabled:=false;
                c_cgc.setfocus;
                grade.DataSource:=dscgc;
                grade.Enabled:=true;
           end;
           2:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_ccm.enabled:=true;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
                c_ccm.setfocus;
                grade.DataSource:=dsccm;
                grade.Enabled:=false;
           end;
           3:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=true;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
                c_ccm.enabled:=false;
                c_ins.setfocus;
                grade.DataSource:=dsins;
                grade.Enabled:=false;
           end;
           4:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=true;
                c_fan.enabled:=false;
                c_ccm.enabled:=false;
                c_raz.setfocus;
                grade.DataSource:=dsraz;
                grade.Enabled:=true;
           end;
           5:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=false;
                c_fan.enabled:=true;
                c_ccm.enabled:=false;
                c_fan.setfocus;
                grade.DataSource:=dsfan;
                grade.Enabled:=true;
           end;
   end;



end;

procedure Tfrmlocpro4.c_cpfExit(Sender: TObject);
begin
{ tbCPF.Findkey([c_CPF.text]);}
end;

procedure Tfrmlocpro4.c_cgcExit(Sender: TObject);
begin
{   tbcgc.Findkey([c_cgc.text]);}
end;

procedure Tfrmlocpro4.c_insExit(Sender: TObject);
begin
   tbins.Findkey([c_ins.text]);
end;

procedure Tfrmlocpro4.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

procedure Tfrmlocpro4.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
        vk_escape: btcancelClick(Sender);
        end;
end;

procedure Tfrmlocpro4.FormClose(Sender: TObject; var Action: TCloseAction);
begin

 if loc_req = 2 then
    begin
         case selereq of
               0: if not frmos.tbauxreq.findkey([tbcpfcodigo.Value]) then
               begin
                  showmessage('Não há requerimento pra este Regulado');
                  exit;
               end;
               1: if not frmos.tbauxreq.findkey([tbcgccodigo.value]) then
               begin
                  showmessage('Não há requerimento pra este Regulado');
                  exit;
               end;
               2: if not frmos.tbauxreq.findkey([tbccmcodigo.value]) then
               begin
                  showmessage('Não há requerimento pra este Regulado');
                  exit;
               end;
               3: if not frmos.tbauxreq.findkey([tbinscodigo.value]) then
               begin
                  showmessage('Não há requerimento pra este Regulado');
                  exit;
               end;
               4: if not frmos.tbauxreq.findkey([tbrazcodigo.value]) then
               begin
                  showmessage('Não há requerimento pra este Regulado');
                  exit;
               end;
               5: if not frmos.tbauxreq.findkey([tbfancodigo.value]) then
               begin
                  showmessage('Não há requerimento pra este Regulado');
                  exit;
               end;

         end;
//         frmos.tbreq.FindKey([frmos.tbauxreqos.value]);
      end;

    if loc_req = 0 then
    begin
      {  frmos.tbdenunciaReclamado.Value  := '';
        frmos.tbdenunciaCnpj.Value       := '';
        frmos.tbdenunciaLOGRADOURO.Value := '';
        frmos.tbdenunciaREFERENCIA.Value := '';
        frmos.tbdenunciaCDBAI.Value      := 0;     }
    end;
    tbcgc.close;
    tbcpf.close;
    tbins.close;
    tbraz.close;
    tbfan.close;
    tbccm.Close;
end;

procedure Tfrmlocpro4.BtativClick(Sender: TObject);
begin
    if inativo = 0 then
    begin
    inativo := 1;
    t_cadastro.Caption := 'Inativos Somente';
    tbcgc.Filter := 'inatividade = true';
    tbcpf.Filter := 'inatividade = true';
    tbins.Filter := 'inatividade = true';
    tbraz.Filter := 'inatividade = true';
    tbfan.Filter := 'inatividade = true';
    tbccm.Filter := 'inatividade = true';
    end
    else
    begin
    inativo := 0;
    t_cadastro.Caption := 'Ativos Somente';
    tbcgc.Filter := 'inatividade <> true';
    tbcpf.Filter := 'inatividade <> true';
    tbins.Filter := 'inatividade <> true';
    tbraz.Filter := 'inatividade <> true';
    tbfan.Filter := 'inatividade <> true';
    tbccm.Filter := 'inatividade <> true';
    end;

end;

procedure Tfrmlocpro4.Button1Click(Sender: TObject);
begin
     frmos.showmodal;
end;


procedure Tfrmlocpro4.c_ccmExit(Sender: TObject);
begin
 tbccm.Findkey([c_ccm.text]);
end;

procedure Tfrmlocpro4.c_ccmChange(Sender: TObject);
begin
   tbccm.FindNearest([c_ccm.text])
end;

procedure Tfrmlocpro4.c_insChange(Sender: TObject);
begin
tbins.FindNearest([c_ins.text])
end;

end.
