unit consolidado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  Tfrmconso = class(TForm)
    GroupBox1: TGroupBox;
    DTPini: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    DTFim: TDateTimePicker;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmconso: Tfrmconso;

implementation

{$R *.dfm}

procedure Tfrmconso.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tfrmconso.Button1Click(Sender: TObject);
begin
messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
end;

procedure Tfrmconso.FormActivate(Sender: TObject);
begin
messagedlg('Atenção! Módulo em desenvolvimento, dados informados somente para testes.',mtwarning,[mbok],0);
end;

end.
