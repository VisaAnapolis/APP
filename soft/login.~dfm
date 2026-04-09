object frmlogin: Tfrmlogin
  Left = 440
  Top = 345
  Hint = 'Entrada no WCVS'
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'CVS - login'
  ClientHeight = 193
  ClientWidth = 412
  Color = clBtnFace
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 396
    Height = 175
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 39
      Height = 13
      Caption = 'Usu'#225'rio:'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 34
      Height = 13
      Caption = 'Senha:'
    end
    object Label3: TLabel
      Left = 16
      Top = 96
      Width = 63
      Height = 13
      Caption = 'Nova Senha:'
    end
    object Labconf: TLabel
      Left = 16
      Top = 136
      Width = 62
      Height = 13
      Caption = 'Confirma'#231#227'o:'
      Visible = False
    end
    object ESenha: TEdit
      Left = 96
      Top = 56
      Width = 65
      Height = 21
      Hint = 'Alfanumerica de 8 a 14 caracteres'
      MaxLength = 14
      PasswordChar = '*'
      TabOrder = 1
      OnKeyPress = ESenhaKeyPress
    end
    object Btaltera: TButton
      Left = 176
      Top = 93
      Width = 199
      Height = 24
      Hint = 'Clique para alterar a senha'
      Caption = 'Alterar/Cadastrar Senha'
      TabOrder = 3
      TabStop = False
      OnClick = BtalteraClick
    end
    object Enova: TEdit
      Left = 96
      Top = 96
      Width = 65
      Height = 21
      Hint = 'Alfanumerica de 8 a 14 caracteres'
      MaxLength = 14
      PasswordChar = '*'
      TabOrder = 2
      OnKeyPress = ESenhaKeyPress
    end
    object Econfirma: TEdit
      Left = 96
      Top = 136
      Width = 65
      Height = 21
      Hint = 'Repetir a nova senha '
      MaxLength = 14
      PasswordChar = '*'
      TabOrder = 4
      Visible = False
      OnKeyPress = ESenhaKeyPress
    end
    object Btconfirma: TButton
      Left = 176
      Top = 132
      Width = 199
      Height = 26
      Hint = 'Clique para confirma'#231#227'o da nova senha'
      Caption = 'Confirmar Altera'#231#227'o de Senha'
      TabOrder = 5
      TabStop = False
      Visible = False
      OnClick = BtconfirmaClick
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 96
      Top = 13
      Width = 280
      Height = 21
      DataField = 'Controle'
      KeyField = 'Usuario'
      ListField = 'Usuario'
      ListSource = Dslogin
      TabOrder = 0
      OnExit = DBLookupComboBox1Exit
      OnKeyPress = DBLookupComboBox1KeyPress
    end
  end
  object BtEntra: TButton
    Left = 176
    Top = 56
    Width = 81
    Height = 25
    Hint = 'Entrar no Sistema'
    Caption = 'ENTRA'
    TabOrder = 0
    OnClick = BtEntraClick
  end
  object Btcancel: TButton
    Left = 302
    Top = 56
    Width = 82
    Height = 25
    Hint = 'Sair do Sistema'
    Caption = 'CANCELA'
    TabOrder = 1
    OnClick = BtcancelClick
  end
  object tblogin: TTable
    BeforeOpen = tbloginBeforeOpen
    DatabaseName = 'wcvs'
    IndexName = 'PorUser'
    TableName = 'login.db'
    Left = 17
    Top = 24
    object tbloginControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbloginUsuario: TStringField
      FieldName = 'Usuario'
      Size = 60
    end
    object tbloginSenha: TMemoField
      FieldName = 'Senha'
      BlobType = ftMemo
      Size = 8
    end
    object tbloginGrupo: TStringField
      FieldName = 'Grupo'
      Size = 3
    end
    object tbloginData: TDateField
      FieldName = 'Data'
    end
    object tbloginSenha2: TMemoField
      FieldName = 'Senha2'
      BlobType = ftMemo
      Size = 8
    end
    object tbloginSenha3: TMemoField
      FieldName = 'Senha3'
      BlobType = ftMemo
      Size = 8
    end
    object tbloginLocal: TStringField
      FieldName = 'Local'
      Size = 40
    end
    object tbloginCpf: TStringField
      FieldName = 'Cpf'
      Size = 14
    end
    object tbloginPerfil: TStringField
      FieldName = 'Perfil'
      Size = 3
    end
  end
  object Dslogin: TDataSource
    AutoEdit = False
    DataSet = tblogin
    Left = 49
    Top = 24
  end
end
