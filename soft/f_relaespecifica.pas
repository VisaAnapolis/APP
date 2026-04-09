unit f_relaespecifica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, StdCtrls, Grids, DBGrids, Mask, DBCtrls;

type
  Tfrmrelespecifica = class(TForm)
    Panel1: TPanel;
    tbativi: TTable;
    dsativi: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    tbativiNOME: TStringField;
    tbativiGRUPO: TIntegerField;
    tbativiSINAVISA: TIntegerField;
    tbativiAREA: TStringField;
    tbativiNUMERO: TIntegerField;
    CBativ: TCheckBox;
    tbbairro: TTable;
    dsbairro: TDataSource;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    CBbairro: TCheckBox;
    DBGrid3: TDBGrid;
    RGbairro: TRadioGroup;
    RGativi: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RGativiClick(Sender: TObject);
    procedure RGbairroClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmrelespecifica: Tfrmrelespecifica;

implementation

uses relaespecifica;

{$R *.dfm}

procedure Tfrmrelespecifica.Button2Click(Sender: TObject);
begin
frmrelespecifica.close;
end;

procedure Tfrmrelespecifica.FormActivate(Sender: TObject);
begin
   tbativi.open;
   tbbairro.open;
end;

procedure Tfrmrelespecifica.Button1Click(Sender: TObject);
begin
rel_especifica.tbcontrib.open;
rel_especifica.tbbairro.open;
rel_especifica.tbATIVI.open;
if (cbativ.Checked = true) and (cbbairro.Checked = true) then
    rel_especifica.tbcontrib.filter:='atividade = '+inttostr(tbativinumero.value)+' and cdbai= '+inttostr(tbbairrocodigo.value)+' and inatividade <> true ';
if (cbativ.Checked = true) and (cbbairro.Checked = false) then
    rel_especifica.tbcontrib.filter:='atividade = '+inttostr(tbativinumero.value)+' and inatividade <> true ';
if (cbativ.Checked = false) and (cbbairro.Checked = true) then
    rel_especifica.tbcontrib.filter:='cdbai= '+inttostr(tbbairrocodigo.value)+' and inatividade <> true ';
if (cbativ.Checked = false) and (cbbairro.Checked = false) then
    rel_especifica.tbcontrib.filter:='inatividade <> true ';
rel_especifica.QRativ.preview;
rel_especifica.tbATIVI.close;
rel_especifica.tbbairro.close;
rel_especifica.tbcontrib.close;
end;

procedure Tfrmrelespecifica.RGativiClick(Sender: TObject);
begin
    if rgativi.ItemIndex = 0 then tbativi.IndexName:='PorNome';
    if rgativi.ItemIndex = 1 then tbativi.IndexName:='PorAreaNome';
end;

procedure Tfrmrelespecifica.RGbairroClick(Sender: TObject);
begin
    if rgbairro.ItemIndex = 0 then tbbairro.IndexName:='PorNome';
    if rgbairro.ItemIndex = 1 then tbbairro.IndexName:='PorSetorNome';
end;

procedure Tfrmrelespecifica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   tbativi.open;
   tbbairro.open;
end;

end.
