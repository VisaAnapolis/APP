object frmlocden: Tfrmlocden
  Left = 386
  Top = 268
  BorderStyle = bsDialog
  Caption = 'localiza den'#250'ncias'
  ClientHeight = 436
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 120
  TextHeight = 16
  object grade: TDBGrid
    Left = 11
    Top = 256
    Width = 798
    Height = 169
    DataSource = dsnum
    Enabled = False
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Denuncia'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Reclamado'
        Width = 235
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Logradouro'
        Width = 281
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 11
    Top = 11
    Width = 798
    Height = 227
    TabOrder = 1
    object Rselec: TRadioGroup
      Left = 12
      Top = 11
      Width = 629
      Height = 207
      Hint = 'Selecione um modo de Pesquisa'
      Caption = 'Modalidade de Pesquisa'
      ItemIndex = 0
      Items.Strings = (
        'N'#250'mero'
        'Data'
        'Reclamado'
        'Bairro')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RselecClick
    end
    object c_recl: TEdit
      Left = 139
      Top = 128
      Width = 492
      Height = 21
      Hint = 'Digite aqui a Raz'#227'o Social do Contribuinte'
      CharCase = ecUpperCase
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = c_reclChange
    end
    object c_bai: TEdit
      Left = 139
      Top = 174
      Width = 492
      Height = 21
      Hint = 'Digite aqui o Nome de Fantasia do Contribuinte '
      CharCase = ecUpperCase
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object c_num: TEdit
      Left = 139
      Top = 36
      Width = 79
      Height = 21
      Hint = 'Digite aqui o CNPJ do Contribuinte'
      CharCase = ecUpperCase
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnExit = c_numExit
    end
    object btcancel: TButton
      Left = 652
      Top = 68
      Width = 137
      Height = 30
      Caption = 'Cancela'
      TabOrder = 4
      OnClick = btcancelClick
    end
    object btok: TButton
      Left = 652
      Top = 25
      Width = 137
      Height = 30
      Caption = 'OK'
      TabOrder = 5
      OnClick = btokClick
    end
    object c_data: TEdit
      Left = 139
      Top = 79
      Width = 79
      Height = 21
      Hint = 'Digite aqui o CNPJ do Contribuinte'
      CharCase = ecUpperCase
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnExit = c_dataExit
    end
  end
  object dsnum: TDataSource
    AutoEdit = False
    DataSet = tbnum
    Left = 616
    Top = 88
  end
  object tbnum: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorDenuncia'
    TableName = 'denuncia.DB'
    Left = 560
    Top = 88
    object tbnumControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbnumDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbnumData: TDateField
      FieldName = 'Data'
    end
    object tbnumReclamado: TStringField
      FieldName = 'Reclamado'
      Size = 60
    end
    object tbnumLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object tbnumCdbai: TSmallintField
      FieldName = 'Cdbai'
    end
  end
  object tbdata: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorData'
    TableName = 'denuncia.DB'
    Left = 560
    Top = 128
    object tbdataControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbdataDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbdataData: TDateField
      FieldName = 'Data'
    end
    object tbdataReclamado: TStringField
      FieldName = 'Reclamado'
      Size = 60
    end
    object tbdataLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object tbdataCdbai: TSmallintField
      FieldName = 'Cdbai'
    end
  end
  object dsdata: TDataSource
    AutoEdit = False
    DataSet = tbdata
    Left = 616
    Top = 128
  end
  object tbrecl: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorReclame'
    TableName = 'denuncia.DB'
    Left = 560
    Top = 168
    object tbreclControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbreclDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbreclData: TDateField
      FieldName = 'Data'
    end
    object tbreclReclamado: TStringField
      FieldName = 'Reclamado'
      Size = 60
    end
    object tbreclLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object tbreclCdbai: TSmallintField
      FieldName = 'Cdbai'
    end
  end
  object dsrecl: TDataSource
    AutoEdit = False
    DataSet = tbrecl
    Left = 616
    Top = 168
  end
  object tbbai: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Cdbai'
    TableName = 'denuncia.DB'
    Left = 560
    Top = 208
    object tbbaiControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbbaiDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbbaiData: TDateField
      FieldName = 'Data'
    end
    object tbbaiReclamado: TStringField
      FieldName = 'Reclamado'
      Size = 60
    end
    object tbbaiLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object tbbaiCdbai: TSmallintField
      FieldName = 'Cdbai'
    end
  end
  object dsbai: TDataSource
    AutoEdit = False
    DataSet = tbbai
    Left = 616
    Top = 208
  end
end
