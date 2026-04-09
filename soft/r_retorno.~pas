unit r_retorno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, DBTables, DBCtrls, Grids, DBGrids,
  ExtCtrls ;

type
  Tfrmretorno = class(TForm)
    GroupBox1: TGroupBox;
    DTPini: TDateTimePicker;
    Label1: TLabel;
    DTPfim: TDateTimePicker;
    Label2: TLabel;
    BtOK: TButton;
    Button3: TButton;
    tbvisitas: TTable;
    dsvisitas: TDataSource;
    tbvisitasCONTROLE: TAutoIncField;
    tbvisitasCODIGO: TIntegerField;
    tbvisitasDT_VISITA: TDateField;
    tbvisitasPZ_RETORNO: TSmallintField;
    tbvisitasACAO: TStringField;
    tbvisitasTIPO: TStringField;
    tbvisitasFiscal1: TStringField;
    tbvisitasFiscal2: TStringField;
    tbvisitasFiscal3: TStringField;
    tbativi: TTable;
    tbativiCONTROLE: TAutoIncField;
    tbativiNUMERO: TIntegerField;
    tbativiNOME: TStringField;
    tbativiGRUPO: TIntegerField;
    tbativiSINAVISA: TIntegerField;
    tbativiAREA: TStringField;
    dsativi: TDataSource;
    GroupBox4: TGroupBox;
    CbFiscal: TComboBox;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    dsbairro: TDataSource;
    GroupBox2: TGroupBox;
    CBDoc: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmretorno: Tfrmretorno;

implementation

uses relretorno, login;

{$R *.dfm}

procedure Tfrmretorno.FormActivate(Sender: TObject);
begin
tbbairro.open;
tbvisitas.open;
tbativi.open;
dtpfim.date:=date;
dtpini.date:=date;
cbfiscal.Text:=frmlogin.c_user;
if (frmlogin.c_grp = 'ADM') then cbfiscal.enabled:=true else cbfiscal.enabled:=false;
end;

procedure Tfrmretorno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbbairro.Close;
tbvisitas.close;
tbativi.close;
end;

procedure Tfrmretorno.Button3Click(Sender: TObject);
begin
close;
end;

procedure Tfrmretorno.BtOKClick(Sender: TObject);
begin

if cbfiscal.text = '' then
begin
    showmessage('Selecione um Fiscal');
    exit;
end;

{if cbdoc.Text = '' then
begin
    showmessage('Selecione um Documento');
    exit;
end;
 }
if dtpfim.date > Date then
begin
   showmessage('Data Final maior que atual');
   exit;
end;

if dtpini.date > Date then
begin
   showmessage('Data Inicial maior que atual');
   exit;
end;

if dtpfim.date < dtpini.Date then
begin
   showmessage('Data Final menor que a inicial');
   exit;
end;
rel_retorno.tbvisitas.open;
rel_retorno.tbcontrib.open;
rel_retorno.tbbairro.open;
rel_retorno.tbATIVI.open;
//**
// não é filtro e sim controle na banda do relatório
//if rgselec.ItemIndex = 0 then  rel_retorno.tbcontrib.filter:='cdbai= '+inttostr(tbbairrocodigo.value)+' and inatividade <> true ';
//if rgselec.ItemIndex = 1 then  rel_retorno.tbcontrib.filter:='atividade = '+inttostr(tbativinumero.value)+' and inatividade <> true ';
//if rgselec.ItemIndex = 3 then  rel_retorno.tbvisitas.filter:='fiscal1= '+cbfiscal.text+' or '+'fiscal2= '+cbfiscal.text+' or '+'fiscal3= '+cbfiscal.text;
//**
rel_retorno.tbvisitas.Filter:= 'fiscal1= '+quotedstr(cbfiscal.text)+' and dt_visita >= '+quotedstr(formatdatetime('dd/mm/yyyy',dtpini.date))+ ' and dt_visita <='+quotedstr(formatdatetime('dd/mm/yyyy',dtpfim.date))+' and tipo=' + quotedstr(cbdoc.Text)
                               +' or '+
                               'fiscal2= '+quotedstr(cbfiscal.text)+' and dt_visita >= '+quotedstr(formatdatetime('dd/mm/yyyy',dtpini.date))+ ' and dt_visita <='+quotedstr(formatdatetime('dd/mm/yyyy',dtpfim.date))+' and tipo=' + quotedstr(cbdoc.Text)
                               +' or '+
                               'fiscal3= '+quotedstr(cbfiscal.text)+' and dt_visita >= '+quotedstr(formatdatetime('dd/mm/yyyy',dtpini.date))+ ' and dt_visita <='+quotedstr(formatdatetime('dd/mm/yyyy',dtpfim.date))+' and tipo=' + quotedstr(cbdoc.Text);
if cbdoc.Text = '' then
rel_retorno.tbvisitas.Filter:= 'fiscal1= '+quotedstr(cbfiscal.text)+' and dt_visita >= '+quotedstr(formatdatetime('dd/mm/yyyy',dtpini.date))+ ' and dt_visita <='+quotedstr(formatdatetime('dd/mm/yyyy',dtpfim.date))
                               +' or '+
                               'fiscal2= '+quotedstr(cbfiscal.text)+' and dt_visita >= '+quotedstr(formatdatetime('dd/mm/yyyy',dtpini.date))+ ' and dt_visita <='+quotedstr(formatdatetime('dd/mm/yyyy',dtpfim.date))
                               +' or '+
                               'fiscal3= '+quotedstr(cbfiscal.text)+' and dt_visita >= '+quotedstr(formatdatetime('dd/mm/yyyy',dtpini.date))+ ' and dt_visita <='+quotedstr(formatdatetime('dd/mm/yyyy',dtpfim.date));

rel_retorno.dataini.Caption:=datetostr(DTpini.date);
rel_retorno.datafim.Caption:=datetostr(DTpfim.date);
rel_retorno.QRret.preview;
rel_retorno.tbATIVI.close;
rel_retorno.tbbairro.close;
rel_retorno.tbcontrib.close;
rel_retorno.tbvisitas.close;
end;

end.

