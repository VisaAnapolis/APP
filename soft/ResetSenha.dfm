object frmResetSenha: TfrmResetSenha
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Definir / Resetar Senha'
  ClientHeight = 210
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object LblTitulo: TLabel
    Left = 12
    Top = 12
    Width = 336
    Height = 13
    Caption = 'Defina a senha tempor'#225'ria para o usu'#225'rio:'
  end
  object LblUsuarioValor: TLabel
    Left = 12
    Top = 30
    Width = 200
    Height = 16
    Caption = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblTempSenha: TLabel
    Left = 12
    Top = 62
    Width = 336
    Height = 13
    Caption = 'Senha tempor'#225'ria (m'#237'n. 8 caracteres):'
  end
  object LblConfSenha: TLabel
    Left = 12
    Top = 112
    Width = 336
    Height = 13
    Caption = 'Confirmar senha tempor'#225'ria:'
  end
  object ETempSenha: TEdit
    Left = 12
    Top = 78
    Width = 336
    Height = 21
    MaxLength = 32
    PasswordChar = '*'
    TabOrder = 0
  end
  object EConfSenha: TEdit
    Left = 12
    Top = 128
    Width = 336
    Height = 21
    MaxLength = 32
    PasswordChar = '*'
    TabOrder = 1
  end
  object BtnDefinir: TButton
    Left = 184
    Top = 170
    Width = 80
    Height = 25
    Caption = 'Definir'
    Default = True
    TabOrder = 2
    OnClick = BtnDefinirClick
  end
  object BtnCancelar: TButton
    Left = 272
    Top = 170
    Width = 80
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = BtnCancelarClick
  end
  object Tb: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Usuario'
    TableName = 'login.db'
    Left = 16
    Top = 176
  end
end
