unit consultapt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, DBTables, DBCtrls, Grids, DBGrids,
  ExtCtrls, Mask ;

type
  Tfrmconpt = class(TForm)
    GroupBox1: TGroupBox;
    BtOK: TButton;
    Button3: TButton;
    GroupBox4: TGroupBox;
    c_num: TEdit;
    DBGTramita: TDBGrid;
    tbprotocolo: TTable;
    tbtramita: TTable;
    dsprotocolo: TDataSource;
    dstramita: TDataSource;
    tbprotocoloCodigo: TIntegerField;
    tbprotocoloProtocolo: TIntegerField;
    tbprotocoloData: TDateField;
    tbprotocoloAssunto: TStringField;
    DBEdit31: TDBEdit;
    tbcontrib: TTable;
    tbcontribCODIGO: TIntegerField;
    tbcontribRAZAO: TStringField;
    DBERazao: TDBEdit;
    dscontrib: TDataSource;
    tbtramitaProtocolo: TIntegerField;
    tbtramitaData: TDateField;
    tbtramitaDestino: TStringField;
    tbtramitaUsuario: TStringField;
    tbtramitaHora: TTimeField;
    tbtramitaDescricao: TStringField;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
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
  frmconpt: Tfrmconpt;

implementation

uses relretorno, login, relarequerimento, relaoficio;

{$R *.dfm}

procedure Tfrmconpt.FormActivate(Sender: TObject);
begin
    tbprotocolo.open;
    tbtramita.open;
    tbcontrib.Open;
    c_num.Text := '';
    tbprotocolo.last;
end;

procedure Tfrmconpt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    tbcontrib.close;
    tbtramita.close;
    tbprotocolo.close;
end;

procedure Tfrmconpt.Button3Click(Sender: TObject);
begin
close;
end;

procedure Tfrmconpt.BtOKClick(Sender: TObject);
begin
     if not tbprotocolo.findkey([c_num.text]) then
     begin
        c_num.SetFocus;
        showmessage('Protocolo informado não cadastrado');
     end;

end;

end.
