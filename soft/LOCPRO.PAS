unit LOCPRO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  Tfrmlocpro = class(TForm)
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
    Button1: TButton;
    tbccm: TTable;
    tbccmCONTROLE: TAutoIncField;
    tbccmCODIGO: TIntegerField;
    tbccmMUNICIPAL: TStringField;
    tbccmINATIVIDADE: TBooleanField;
    dsccm: TDataSource;
    c_ccm: TEdit;
    tbcgcMUNICIPAL: TStringField;
    tbccmPESSOA: TStringField;
    tbccmCPF: TStringField;
    tbccmCGC: TStringField;
    tbccmRAZAO: TStringField;
    tbccmFANTASIA: TStringField;
    tbrazMUNICIPAL: TStringField;
    tbinsMUNICIPAL: TStringField;
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
    procedure c_insChange(Sender: TObject);
    procedure c_ccmChange(Sender: TObject);
    procedure c_ccmExit(Sender: TObject);
  private
    inativo:integer;
  public
    sele:integer;
    loc_pro:integer;
    inclu:integer;
    FechouPorInatividade: Boolean;
  end;

var
  frmlocpro: Tfrmlocpro;


implementation

uses ESTABE, PRINCIPAL;

{$R *.dfm}

procedure Tfrmlocpro.btokClick(Sender: TObject);
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

   if (tbinscodigo.AsString <> c_ins.text) and (sele = 3) then
   begin
           showmessage('Contribuinte não cadastrado');
           c_ins.setfocus;
           exit;
   end;

    if (tbccmmunicipal.value <> c_ccm.text) and (sele = 2) then
   begin
           showmessage('Contribuinte não cadastrado');
           c_ccm.setfocus;
           exit;
   end;


   loc_pro:=1;
   inclu:=0;

   frmprincipal.tbsequencia.Refresh;
   if frmprincipal.tbsequenciadisponibilidade.Value = False then
   begin
     ShowMessage('Sistema em manutenção. Tente novamente em instantes.');
     Exit;
   end;

   frmestabe.showmodal;


   if FechouPorInatividade then
   begin
     FechouPorInatividade := False;
     Close;
     Exit;
   end;
{  close;}
end;


procedure Tfrmlocpro.btcancelClick(Sender: TObject);
begin
   loc_pro:=0;
   close;
end;

procedure Tfrmlocpro.FormActivate(Sender: TObject);
begin
   tbraz.open;
   tbcpf.open;
   tbcgc.open;
   tbins.open;
   tbfan.open;
   tbccm.open;
   c_raz.text:='' ;
   c_ins.text:='' ;
   c_cgc.text:='' ;
   c_fan.text:='' ;
   c_cpf.text:='' ;
   c_ccm.text:='' ;
//   Rselec.setfocus;
// Rselec.Itemindex := -1;
   Rselec.Itemindex := 4 ;
//   c_raz.SetFocus;
   sele := Rselec.Itemindex;
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
                c_raz.enabled:=true;
                c_fan.enabled:=false;
                c_ccm.enabled:=false;
                c_raz.setfocus;
                grade.DataSource:=dsraz;
                grade.Enabled:=true;

end;

procedure Tfrmlocpro.c_razChange(Sender: TObject);
begin
    tbraz.FindNearest([c_raz.text])
end;

procedure Tfrmlocpro.c_fanChange(Sender: TObject);
begin
tbfan.FindNearest([c_fan.text])
end;

procedure Tfrmlocpro.c_cpfChange(Sender: TObject);
begin
tbcpf.FindNearest([c_cpf.text])
end;
procedure Tfrmlocpro.c_cgcChange(Sender: TObject);
begin
tbcgc.FindNearest([c_cgc.text])
end;



procedure Tfrmlocpro.RselecClick(Sender: TObject);
begin
{   if  Rselec.ItemIndex = -1 then Rselec.ItemIndex := 0;}
   sele:= Rselec.ItemIndex;
   case sele of
           0:
           begin
                c_cpf.enabled:=true;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
                c_ccm.Enabled:=false;
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
                c_ccm.Enabled:=false;
                c_cgc.setfocus;
                grade.DataSource:=dscgc;
                grade.Enabled:=true;
           end;
           2:
           begin
                c_cpf.enabled:=false;
                c_cgc.enabled:=false;
                c_ins.enabled:=false;
                c_raz.enabled:=false;
                c_fan.enabled:=false;
                c_ccm.Enabled:=true;
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
                c_ccm.Enabled:=false;
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
                c_ccm.Enabled:=false;
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
                c_ccm.Enabled:=false;
                c_fan.setfocus;
                grade.DataSource:=dsfan;
                grade.Enabled:=true;
           end;
   end;



end;

procedure Tfrmlocpro.c_cpfExit(Sender: TObject);
begin
{ tbCPF.Findkey([c_CPF.text]);}
end;

procedure Tfrmlocpro.c_cgcExit(Sender: TObject);
begin
{   tbcgc.Findkey([c_cgc.text]);}
end;

procedure Tfrmlocpro.c_insExit(Sender: TObject);
begin
   tbins.Findkey([c_ins.text]);
end;

procedure Tfrmlocpro.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

procedure Tfrmlocpro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
        vk_escape: btcancelClick(Sender);
        end;
end;

procedure Tfrmlocpro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    tbcgc.close;
    tbcpf.close;
    tbins.close;
    tbraz.close;
    tbfan.close;
    tbccm.Close;
end;

procedure Tfrmlocpro.BtativClick(Sender: TObject);
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

procedure Tfrmlocpro.Button1Click(Sender: TObject);
begin
   inclu:=1;
   frmprincipal.tbsequencia.Refresh;
   if frmprincipal.tbsequenciadisponibilidade.Value = False then
   begin
     ShowMessage('Sistema em manuten' + Chr(231) + Chr(227) + 'o. Tente novamente em instantes.');
     Exit;
   end;
   frmestabe.showmodal;
end;


procedure Tfrmlocpro.c_insChange(Sender: TObject);
begin
tbins.FindNearest([c_ins.text])
end;

procedure Tfrmlocpro.c_ccmChange(Sender: TObject);
begin
tbccm.FindNearest([c_ccm.text])
end;

procedure Tfrmlocpro.c_ccmExit(Sender: TObject);
begin
tbccm.Findkey([c_ccm.text]);
end;

end.
