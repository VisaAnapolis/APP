unit LOCPRO2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  Tfrmlocpro2 = class(TForm)
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
  private
    inativo:integer;
  {  c_nome:string;
    c_cnpj:string;
    c_logr:string;
    c_refe:string;
    c_bai:integer;}
  public
    loc_den:integer;
    seleden:integer;
  end;

var
  frmlocpro2: Tfrmlocpro2;


implementation

uses denuncia;

{$R *.dfm}

procedure Tfrmlocpro2.btokClick(Sender: TObject);
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

   if (tbinscodigo.AsString <> c_ins.text) and (seleden = 2) then
   begin
           showmessage('Contribuinte não cadastrado');
           c_ins.setfocus;
           exit;
   end;


   loc_den:=1;

    
   close;
{  close;}
end;


procedure Tfrmlocpro2.btcancelClick(Sender: TObject);
begin
   loc_den:=0;
   close;
end;

procedure Tfrmlocpro2.FormActivate(Sender: TObject);
begin
   tbraz.open;
   tbcpf.open;
   tbcgc.open;
   tbins.open;
   tbfan.open;

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
//   Rselec.setfocus;
// Rselec.Itemindex := -1;
   Rselec.Itemindex := 3;
//   c_raz.SetFocus;
   seleden := Rselec.Itemindex;
   grade.DataSource:=dsins;
   grade.Enabled:=false;
   inativo := 0;
   t_cadastro.Caption := 'Ativos Somente' ;
    tbcgc.Filter := 'inatividade <> true';
    tbcpf.Filter := 'inatividade <> true';
    tbins.Filter := 'inatividade <> true';
    tbraz.Filter := 'inatividade <> true';
    tbfan.Filter := 'inatividade <> true';

                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=true;
                c_fan.enabled:=false;
                c_raz.setfocus;
                grade.DataSource:=dsraz;
                grade.Enabled:=true;

end;

procedure Tfrmlocpro2.c_razChange(Sender: TObject);
begin
    tbraz.FindNearest([c_raz.text])
end;

procedure Tfrmlocpro2.c_fanChange(Sender: TObject);
begin
tbfan.FindNearest([c_fan.text])
end;

procedure Tfrmlocpro2.c_cpfChange(Sender: TObject);
begin
tbcpf.FindNearest([c_cpf.text])
end;
procedure Tfrmlocpro2.c_cgcChange(Sender: TObject);
begin
tbcgc.FindNearest([c_cgc.text])
end;



procedure Tfrmlocpro2.RselecClick(Sender: TObject);
begin
{   if  Rselec.ItemIndex = -1 then Rselec.ItemIndex := 0;}
   seleden:= Rselec.ItemIndex;
   case seleden of
           0:
           begin
                c_cpf.enabled:=true;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
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
                c_cgc.setfocus;
                grade.DataSource:=dscgc;
                grade.Enabled:=true;
           end;
           2:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=true;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
                c_ins.setfocus;
                grade.DataSource:=dsins;
                grade.Enabled:=false;
           end;
           3:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=true;
                c_fan.enabled:=false;
                c_raz.setfocus;
                grade.DataSource:=dsraz;
                grade.Enabled:=true;
           end;
           4:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=false;
                c_fan.enabled:=true;
                c_fan.setfocus;
                grade.DataSource:=dsfan;
                grade.Enabled:=true;
           end;
   end;



end;

procedure Tfrmlocpro2.c_cpfExit(Sender: TObject);
begin
{ tbCPF.Findkey([c_CPF.text]);}
end;

procedure Tfrmlocpro2.c_cgcExit(Sender: TObject);
begin
{   tbcgc.Findkey([c_cgc.text]);}
end;

procedure Tfrmlocpro2.c_insExit(Sender: TObject);
begin
   tbins.Findkey([c_ins.text]);
end;

procedure Tfrmlocpro2.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

procedure Tfrmlocpro2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
        vk_escape: btcancelClick(Sender);
        end;
end;

procedure Tfrmlocpro2.FormClose(Sender: TObject; var Action: TCloseAction);
begin

 if loc_den = 1 then
    begin
         case seleden of
               0: frmdenuncia.tbcontrib.findkey([tbcpfCONTROLE.value]);
               1: frmdenuncia.tbcontrib.findkey([tbcgcCONTROLE.value]);
               2: frmdenuncia.tbcontrib.findkey([tbinsCONTROLE.value]);
               3: frmdenuncia.tbcontrib.findkey([tbrazCONTROLE.value]);
               4: frmdenuncia.tbcontrib.findkey([tbfanCONTROLE.value]);
         end;
         frmdenuncia.tbdenunciaReclamado.Value  := frmdenuncia.tbcontribRAZAO.Value;
         frmdenuncia.tbdenunciaCnpj.Value       := frmdenuncia.tbcontribCGC.Value;
         frmdenuncia.tbdenunciaLOGRADOURO.Value := frmdenuncia.tbcontribLOGRADOURO.Value;
         frmdenuncia.tbdenunciaREFERENCIA.Value := frmdenuncia.tbcontribCOMPLEMENT.Value;
         frmdenuncia.tbdenunciaCDBAI.Value      := frmdenuncia.tbcontribCDBAI.Value;
    end;

    if loc_den = 0 then
    begin
        frmdenuncia.tbdenunciaReclamado.Value  := '';
        frmdenuncia.tbdenunciaCnpj.Value       := '';
        frmdenuncia.tbdenunciaLOGRADOURO.Value := '';
        frmdenuncia.tbdenunciaREFERENCIA.Value := '';
        frmdenuncia.tbdenunciaCDBAI.Value      := 0;
    end;
    tbcgc.close;
    tbcpf.close;
    tbins.close;
    tbraz.close;
    tbfan.close;
end;

procedure Tfrmlocpro2.BtativClick(Sender: TObject);
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
    end;

end;

procedure Tfrmlocpro2.Button1Click(Sender: TObject);
begin
     frmdenuncia.showmodal;
end;


end.
