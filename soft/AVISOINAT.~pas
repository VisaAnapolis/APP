unit AVISOINAT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls;

type
  TfrmAvisoInatividade = class(TForm)
    LblMensagem: TLabel;
    LblContagem: TLabel;
    BtnCancelar: TButton;
    TimerContagem: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure TimerContagemTimer(Sender: TObject);
//     procedure AnyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure BtnCancelarClick(Sender: TObject);
  private
    FSecondsLeft: Integer;
  end;

var
  frmAvisoInatividade: TfrmAvisoInatividade;

implementation

{$R *.dfm}

const
  CONTAGEM_SEGUNDOS = 15;

procedure TfrmAvisoInatividade.FormActivate(Sender: TObject);
begin
  FSecondsLeft := CONTAGEM_SEGUNDOS;
  LblContagem.Caption := 'Encerrando em ' + IntToStr(FSecondsLeft) + ' segundo(s)...';
  TimerContagem.Enabled := True;
end;

procedure TfrmAvisoInatividade.TimerContagemTimer(Sender: TObject);
begin
  Dec(FSecondsLeft);
  LblContagem.Caption := 'Encerrando em ' + IntToStr(FSecondsLeft) + ' segundo(s)...';
  if FSecondsLeft <= 0 then
  begin
    TimerContagem.Enabled := False;
    ModalResult := mrOk;
  end;
end;
{
procedure TfrmAvisoInatividade.AnyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  TimerContagem.Enabled := False;
  ModalResult := mrCancel;
end;
 }
procedure TfrmAvisoInatividade.BtnCancelarClick(Sender: TObject);
begin
  TimerContagem.Enabled := False;
  ModalResult := mrCancel;
end;

end.
