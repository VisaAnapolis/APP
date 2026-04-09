unit rdpfvelho;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  Tfrmrdpfvelho = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    DateTimePicker1: TDateTimePicker;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmrdpfvelho: Tfrmrdpfvelho;

implementation

{$R *.dfm}

procedure Tfrmrdpfvelho.Button2Click(Sender: TObject);
begin
close;
end;

end.
