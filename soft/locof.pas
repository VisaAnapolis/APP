unit locof;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ExtCtrls, Grids, DBGrids, ComCtrls;

type
  TfrmlocOF = class(TForm)
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
    tbfiscal: TTable;
    dsfiscal: TDataSource;
    c_data: TDateTimePicker;
    tbfiscalData: TDateField;
    tbfiscalFiscalencaminha: TStringField;
    tbdataData: TDateField;
    tbdataFiscalencaminha: TStringField;
    tbnumData: TDateField;
    tbnumFiscalencaminha: TStringField;
    tbnumOficio: TIntegerField;
    tbdataOficio: TIntegerField;
    tbfiscalOficio: TIntegerField;
    tbdataDtencaminha: TDateField;
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
    loc_of:integer;
    lugarof:integer;
    { Public declarations }
  end;

var
  frmlocOF: TfrmlocOF;

implementation

uses OS;
{$R *.dfm}

{procedure TfrmlocOS.c_denChange(Sender: TObject);
begin
tbnum.FindNearest([c_num.text])
end;   }

procedure TfrmlocOF.c_numExit(Sender: TObject);
begin
tbnum.Findkey([c_num.text]);
end;

procedure TfrmlocOF.FormActivate(Sender: TObject);
begin
tbnum.open;
tbdata.open;
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

procedure TfrmlocOF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbnum.close;
tbdata.close;
tbfiscal.close;
end;

procedure TfrmlocOF.btcancelClick(Sender: TObject);
begin
   loc_of:=0;
   close;
end;

procedure TfrmlocOF.btokClick(Sender: TObject);
begin

   if (tbnumoficio.AsString <> c_num.text) and (selereq = 0) then
   begin
           showmessage('OS não cadastrado');
           c_num.setfocus;
           exit;
   end;


          case selereq of
                0:
                begin
                    lugarof:=tbnumOficio.value;
                    loc_of := 0;
                end;
                1:
                begin
                    lugarof:=tbdataOficio.value;
                    loc_of := 1;
                end;
                2:
                begin
                    lugarof:=tbfiscalOficio.value;
                    loc_of := 2
                end;
          end;
          close;

end;

procedure TfrmlocOF.RselecClick(Sender: TObject);
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

procedure TfrmlocOF.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;
end;

procedure TfrmlocOF.c_fiscalChange(Sender: TObject);
begin
tbfiscal.FindNearest([c_fiscal.text])
end;

procedure TfrmlocOF.c_dataChange(Sender: TObject);
begin
    tbdata.Findkey([c_data.date]);
end;

end.
