unit locreq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ExtCtrls, Grids, DBGrids, ComCtrls;

type
  TfrmlocOS = class(TForm)
    grade: TDBGrid;
    Panel1: TPanel;
    Rselec: TRadioGroup;
    c_fiscal: TEdit;
    c_num: TEdit;
    btcancel: TButton;
    btok: TButton;
    dsnum: TDataSource;
    tbnum: TTable;
    tbdata: TTable;
    dsdata: TDataSource;
    tbregul: TTable;
    dsregul: TDataSource;
    tbfiscal: TTable;
    dsfiscal: TDataSource;
    tbnumControle: TAutoIncField;
    tbnumCodigo: TIntegerField;
    tbnumOS: TIntegerField;
    tbnumDt_Req: TDateField;
    tbnumFiscal_Encaminha: TStringField;
    tbdataControle: TAutoIncField;
    tbdataCodigo: TIntegerField;
    tbdataOS: TIntegerField;
    tbdataDt_Req: TDateField;
    tbdataFiscal_Encaminha: TStringField;
    tbregulControle: TAutoIncField;
    tbregulCodigo: TIntegerField;
    tbregulOS: TIntegerField;
    tbregulDt_Req: TDateField;
    tbregulFiscal_Encaminha: TStringField;
    tbfiscalControle: TAutoIncField;
    tbfiscalCodigo: TIntegerField;
    tbfiscalOS: TIntegerField;
    tbfiscalDt_Req: TDateField;
    tbfiscalFiscal_Encaminha: TStringField;
    c_data: TDateTimePicker;
    procedure c_numExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btcancelClick(Sender: TObject);
    procedure btokClick(Sender: TObject);
    procedure RselecClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure c_fiscalChange(Sender: TObject);
    procedure c_dataChange(Sender: TObject);
  private
    selereq:integer;
    { Private declarations }
  public
    loc_req:integer;
    lugarreq:integer;
    { Public declarations }
  end;

var
  frmlocOS: TfrmlocOS;

implementation

uses OS;
{$R *.dfm}

{procedure TfrmlocOS.c_denChange(Sender: TObject);
begin
tbnum.FindNearest([c_num.text])
end;   }

procedure TfrmlocOS.c_numExit(Sender: TObject);
begin
tbnum.Findkey([c_num.text]);
end;

procedure TfrmlocOS.FormActivate(Sender: TObject);
begin
tbnum.open;
tbdata.open;
tbregul.open;
tbfiscal.open;

   c_num.text:='' ;
//   c_data.text:='' ;
   c_fiscal.text:='' ;
   Rselec.setfocus;
   Rselec.Itemindex := -1;
   selereq := Rselec.Itemindex;
   grade.DataSource:=dsnum;
   grade.Enabled:=false;
end;

procedure TfrmlocOS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbnum.close;
tbdata.close;
tbregul.close;
tbfiscal.close;
end;

procedure TfrmlocOS.btcancelClick(Sender: TObject);
begin
   loc_req:=0;
   close;
end;

procedure TfrmlocOS.btokClick(Sender: TObject);
begin

   if (tbnumos.AsString <> c_num.text) and (selereq = 0) then
   begin
           showmessage('OS não cadastrado');
           c_num.setfocus;
           exit;
   end;


          case selereq of
                0:
                begin
                    lugarreq:=tbnumOS.value;
                    loc_req := 0;
                end;
                1:
                begin
                    lugarreq:=tbdataOS.value;
                    loc_req := 0;
                end;
                2:
                begin
                    lugarreq:=tbfiscalOS.value;
                    loc_req := 1
                end;
          end;
          close;

end;

procedure TfrmlocOS.RselecClick(Sender: TObject);
begin

   selereq:= Rselec.ItemIndex;
   case selereq of
           0:
           begin
                c_num.enabled:=true;
                c_data.enabled:=false;
                c_fiscal.enabled:=false;
                c_num.setfocus;
                grade.DataSource:=dsnum;
                grade.Enabled:=false;
           end;
           1:
           begin
                c_num.enabled:=false;
                c_data.enabled:=true;
                c_fiscal.enabled:=false;
                grade.DataSource:=dsdata;
                grade.Enabled:=true;
                grade.setfocus;
           end;
           2:
           begin
                c_num.enabled:=false;
                c_data.enabled:=false;
                c_fiscal.enabled:=true;
                c_fiscal.setfocus;
                grade.DataSource:=dsfiscal;
                grade.Enabled:=true;
           end;
   end;




end;

procedure TfrmlocOS.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

procedure TfrmlocOS.c_fiscalChange(Sender: TObject);
begin
tbfiscal.FindNearest([c_fiscal.text])
end;

procedure TfrmlocOS.c_dataChange(Sender: TObject);
begin
    tbdata.Findkey([c_data.date]);
end;

end.
