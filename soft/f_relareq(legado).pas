unit f_relareq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, StdCtrls, Grids, DBGrids, Mask, DBCtrls,
  ComCtrls;

type
  Tfrmrelareq = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    StaticText1: TStaticText;
    tbarea: TTable;
    tbareaCod: TIntegerField;
    tbareaNome: TStringField;
    dsarea: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    cbvisitados: TCheckBox;
    CBativ: TCheckBox;
    tbativi: TTable;
    tbativiCONTROLE: TAutoIncField;
    tbativiNUMERO: TIntegerField;
    tbativiNOME: TStringField;
    tbativiGRUPO: TIntegerField;
    tbativiSINAVISA: TIntegerField;
    tbativiVALOR: TCurrencyField;
    tbativiAREA: TStringField;
    dsativi: TDataSource;
    DBativ: TDBGrid;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    dsbairro: TDataSource;
    CBBai: TCheckBox;
    DBBairro: TDBGrid;
    RGordem: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RGordemClick(Sender: TObject);
  private
    { Private declarations }
  public
    c_visitados:boolean;
  end;

var
  frmrelareq: Tfrmrelareq;

implementation

uses relarequerimento;

{$R *.dfm}

procedure Tfrmrelareq.Button2Click(Sender: TObject);
begin
frmrelareq.close;
tbarea.close;
tbativi.close;
tbbairro.close;
end;

procedure Tfrmrelareq.FormActivate(Sender: TObject);
begin
tbarea.open;
tbativi.open;
tbbairro.open;
end;

procedure Tfrmrelareq.Button1Click(Sender: TObject);
begin
c_visitados:=false;
rel_req.tbalvara.open;
rel_req.tbcontrib.open;
rel_req.tbativ.open;
rel_req.tbbairro.open;
rel_req.tbvisitas.open;
rel_req.tbalvara.filter:='exercicio= '+quotedstr(formatdatetime('yyyy',Date))+' and numero < 1' ;
//rel_req.tbvisitas.Filter:='dt_visita >= '+quotedstr(datetostr(01/01/2012));
//na tabela do relatódio
if (cbativ.Checked =true) and (cbbai.checked = false) then
    rel_req.tbcontrib.filter:='inatividade <> false and atividade= '+quotedstr(inttostr(tbativinumero.value));
if (cbativ.Checked =true) and (cbbai.checked = true) then
    rel_req.tbcontrib.filter:='inatividade <> false and atividade= '+quotedstr(inttostr(tbativinumero.value))+ ' and cdbai = '+quotedstr(inttostr(tbbairrocodigo.value));
if (cbativ.Checked =false) and (cbbai.checked = true) then
    rel_req.tbcontrib.filter:='inatividade <> false and cdbai = '+quotedstr(inttostr(tbbairrocodigo.value));
if (cbativ.Checked =false) and (cbbai.checked = false) then
    rel_req.tbcontrib.filter:='inatividade <> false';
if cbvisitados.Checked = true then c_visitados:= true;
rel_req.QRreq.preview;
rel_req.tbvisitas.close;
rel_req.tbbairro.close;
rel_req.tbativ.close;
rel_req.tbcontrib.close;
rel_req.tbalvara.close;
end;

procedure Tfrmrelareq.RGordemClick(Sender: TObject);
begin
    if rgordem.ItemIndex = 0 then tbbairro.IndexName:='PorNome';
    if rgordem.ItemIndex = 1 then tbbairro.IndexName:='PorSetorNome';
end;

end.
