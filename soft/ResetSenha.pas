unit ResetSenha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, DBTables, DateUtils;

type
  TfrmResetSenha = class(TForm)
    LblTitulo: TLabel;
    LblUsuarioValor: TLabel;
    LblTempSenha: TLabel;
    LblConfSenha: TLabel;
    ETempSenha: TEdit;
    EConfSenha: TEdit;
    BtnDefinir: TButton;
    BtnCancelar: TButton;
    Tb: TTable;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnDefinirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    FNomeUsuario: string;
  public
    property NomeUsuario: string read FNomeUsuario write FNomeUsuario;
  end;

implementation

uses uHashSenha;

{$R *.dfm}

procedure TfrmResetSenha.FormActivate(Sender: TObject);
begin
  Session.AddPassword('paradiso');
  Tb.Open;

  if not Tb.FindKey([FNomeUsuario]) then
  begin
    ShowMessage('Usu'#225'rio "' + FNomeUsuario + '" n'#227'o encontrado.');
    ModalResult := mrCancel;
    Exit;
  end;

  LblUsuarioValor.Caption := FNomeUsuario;
  ETempSenha.SetFocus;
end;

procedure TfrmResetSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Tb.Active then
    Tb.Close;
  Action := caHide;
end;

procedure TfrmResetSenha.BtnDefinirClick(Sender: TObject);
begin
  if ETempSenha.Text = '' then
  begin
    ShowMessage('Informe a senha tempor'#225'ria.');
    ETempSenha.SetFocus;
    Exit;
  end;

  if Length(ETempSenha.Text) < 8 then
  begin
    ShowMessage('A senha deve ter pelo menos 8 caracteres.');
    ETempSenha.SetFocus;
    Exit;
  end;

  if ETempSenha.Text <> EConfSenha.Text then
  begin
    ShowMessage('A confirma'#231#227'o n'#227'o coincide com a senha informada.');
    EConfSenha.Text := '';
    EConfSenha.SetFocus;
    Exit;
  end;

  Tb.Edit;
  Tb.FieldByName('SENHA').AsString  := HashSenha(ETempSenha.Text);
  Tb.FieldByName('SENHA2').AsString := '';
  Tb.FieldByName('SENHA3').AsString := '';
  Tb.FieldByName('DATA').AsDateTime := IncDay(Date, -31);
  Tb.Post;

  ModalResult := mrOk;
end;

procedure TfrmResetSenha.BtnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
