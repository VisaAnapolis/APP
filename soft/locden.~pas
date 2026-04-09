unit locden;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ExtCtrls, Grids, DBGrids;

type
  Tfrmlocden = class(TForm)
    grade: TDBGrid;
    Panel1: TPanel;
    Rselec: TRadioGroup;
    c_recl: TEdit;
    c_bai: TEdit;
    c_num: TEdit;
    btcancel: TButton;
    btok: TButton;
    dsnum: TDataSource;
    tbnum: TTable;
    tbnumControle: TAutoIncField;
    tbnumDenuncia: TIntegerField;
    tbnumData: TDateField;
    tbnumReclamado: TStringField;
    tbnumLogradouro: TStringField;
    c_data: TEdit;
    tbdata: TTable;
    dsdata: TDataSource;
    tbrecl: TTable;
    dsrecl: TDataSource;
    tbbai: TTable;
    dsbai: TDataSource;
    tbdataControle: TAutoIncField;
    tbdataDenuncia: TIntegerField;
    tbdataData: TDateField;
    tbdataReclamado: TStringField;
    tbdataLogradouro: TStringField;
    tbdataCdbai: TSmallintField;
    tbreclControle: TAutoIncField;
    tbreclDenuncia: TIntegerField;
    tbreclData: TDateField;
    tbreclReclamado: TStringField;
    tbreclLogradouro: TStringField;
    tbreclCdbai: TSmallintField;
    tbnumCdbai: TSmallintField;
    tbbaiControle: TAutoIncField;
    tbbaiDenuncia: TIntegerField;
    tbbaiData: TDateField;
    tbbaiReclamado: TStringField;
    tbbaiLogradouro: TStringField;
    tbbaiCdbai: TSmallintField;
    procedure c_denChange(Sender: TObject);
    procedure c_numExit(Sender: TObject);
    procedure c_dataExit(Sender: TObject);
    procedure c_reclChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btcancelClick(Sender: TObject);
    procedure btokClick(Sender: TObject);
    procedure RselecClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    seleden:integer;
    { Private declarations }
  public
    loc_den:integer;
    lugarden:integer;
    { Public declarations }
  end;

var
  frmlocden: Tfrmlocden;

implementation

uses denuncia,atendimento;
{$R *.dfm}

procedure Tfrmlocden.c_denChange(Sender: TObject);
begin
tbnum.FindNearest([c_num.text])
end;

procedure Tfrmlocden.c_numExit(Sender: TObject);
begin
tbnum.Findkey([c_num.text]);
end;

procedure Tfrmlocden.c_dataExit(Sender: TObject);
begin
tbdata.Findkey([c_data.text]);
end;

procedure Tfrmlocden.c_reclChange(Sender: TObject);
begin
tbrecl.Findnearest([c_recl.text]);
end;

procedure Tfrmlocden.FormActivate(Sender: TObject);
begin
tbnum.open;
tbdata.open;
tbrecl.open;
tbbai.open;

   c_num.text:='' ;
   c_data.text:='' ;
   c_recl.text:='' ;
   c_bai.text:='' ;
   Rselec.setfocus;
   Rselec.Itemindex := -1;
   seleden := Rselec.Itemindex;
   grade.DataSource:=dsnum;
   grade.Enabled:=false;
end;

procedure Tfrmlocden.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbnum.close;
tbdata.close;
tbrecl.close;
tbbai.close;
end;

procedure Tfrmlocden.btcancelClick(Sender: TObject);
begin
   loc_den:=0;
   close;
end;

procedure Tfrmlocden.btokClick(Sender: TObject);
begin

   if (tbnumdenuncia.AsString <> c_num.text) and (seleden = 0) then
   begin
           showmessage('Denúncia não cadastrado');
           c_num.setfocus;
           exit;
   end;

{   if (tbnumdata.AsString <> c_data.text) and (seleden = 1) then
   begin
           showmessage('Data não encontrada');
           c_data.setfocus;
           exit;
   end;}


          case seleden of
                0: lugarden:=tbnumCONTROLE.value;
                1: lugarden:=tbdataCONTROLE.value;
                2: lugarden:=tbreclCONTROLE.value;
                3: lugarden:=tbbaiCONTROLE.value;
          end;
          close;

end;

procedure Tfrmlocden.RselecClick(Sender: TObject);
begin

   seleden:= Rselec.ItemIndex;
   case seleden of
           0:
           begin
                c_num.enabled:=true;
                c_data.enabled:=false;
                c_recl.enabled:=false;
                c_bai.enabled:=false;
                c_num.setfocus;
                grade.DataSource:=dsnum;
                grade.Enabled:=false;
           end;
           1:
           begin
                c_num.enabled:=false;
                c_data.enabled:=true;
                c_recl.enabled:=false;
                c_bai.enabled:=false;
                c_data.setfocus;
                grade.DataSource:=dsdata;
                grade.Enabled:=true;
           end;
           2:
           begin
                c_num.enabled:=false;
                c_data.enabled:=false;
                c_recl.enabled:=true;
                c_bai.enabled:=false;
                grade.DataSource:=dsrecl;
                c_recl.setfocus;
                grade.Enabled:=true;
           end;
{           3:
           begin
                c_num.enabled:=false;
                c_data.enabled:=false;
                c_recl.enabled:=false;
                c_bai.enabled:=true;
                c_bai.setfocus;
                grade.DataSource:=dsbai;
                grade.Enabled:=false;
           end;}
   end;




end;

procedure Tfrmlocden.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

end.
