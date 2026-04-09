object frmAvisoInatividade: TfrmAvisoInatividade
  Left = 290
  Top = 137
  BorderStyle = bsDialog
  Caption = 'Aviso de Inatividade'
  ClientHeight = 135
  ClientWidth = 430
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object LblMensagem: TLabel
    Left = 16
    Top = 16
    Width = 316
    Height = 26
    Caption = 
      'O sistema ser'#225' encerrado por inatividade. Clique em Cancelar par' +
      'a continuar.'
    WordWrap = True
  end
  object LblContagem: TLabel
    Left = 16
    Top = 58
    Width = 220
    Height = 16
    Caption = 'Encerrando em 15 segundo(s)...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnCancelar: TButton
    Left = 167
    Top = 96
    Width = 96
    Height = 25
    Caption = 'Cancelar'
    Default = True
    TabOrder = 0
    OnClick = BtnCancelarClick
  end
  object TimerContagem: TTimer
    Enabled = False
    OnTimer = TimerContagemTimer
    Left = 8
    Top = 100
  end
end
