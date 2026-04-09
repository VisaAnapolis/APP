object frmlocOF: TfrmlocOF
  Left = 311
  Top = 207
  BorderStyle = bsDialog
  Caption = 'localiza OS'
  ClientHeight = 492
  ClientWidth = 821
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
    Width = 640
    Height = 228
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
        FieldName = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fiscalencaminha'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Oficio'
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
        'N'#250'mero da OS'
        'Data da OS'
        'Fiscal Encarregado')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RselecClick
    end
    object c_fiscal: TEdit
      Left = 188
      Top = 174
      Width = 443
      Height = 24
      Hint = 'Digite aqui o Nome de Fantasia do Contribuinte '
      CharCase = ecUpperCase
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = c_fiscalChange
    end
    object c_num: TEdit
      Left = 188
      Top = 36
      Width = 100
      Height = 24
      Hint = 'Digite aqui o CNPJ do Contribuinte'
      CharCase = ecUpperCase
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnExit = c_numExit
    end
    object btcancel: TButton
      Left = 652
      Top = 68
      Width = 137
      Height = 30
      Caption = 'Cancela'
      TabOrder = 3
      OnClick = btcancelClick
    end
    object btok: TButton
      Left = 652
      Top = 25
      Width = 137
      Height = 30
      Caption = 'OK'
      TabOrder = 4
      OnClick = btokClick
    end
    object c_data: TDateTimePicker
      Left = 188
      Top = 111
      Width = 100
      Height = 24
      CalAlignment = dtaLeft
      Date = 44468.7298337037
      Time = 44468.7298337037
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      MinDate = 44440
      ParseInput = False
      TabOrder = 5
      OnChange = c_dataChange
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
    IndexFieldNames = 'Oficio'
    TableName = 'oficio.DB'
    Left = 560
    Top = 88
    object tbnumData: TDateField
      FieldName = 'Data'
    end
    object tbnumFiscalencaminha: TStringField
      FieldName = 'Fiscalencaminha'
      Size = 60
    end
    object tbnumOficio: TIntegerField
      FieldName = 'Oficio'
    end
  end
  object tbdata: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Dtencaminha'
    TableName = 'oficio.DB'
    Left = 560
    Top = 136
    object tbdataData: TDateField
      FieldName = 'Data'
    end
    object tbdataFiscalencaminha: TStringField
      FieldName = 'Fiscalencaminha'
      Size = 60
    end
    object tbdataOficio: TIntegerField
      FieldName = 'Oficio'
    end
    object tbdataDtencaminha: TDateField
      FieldName = 'Dtencaminha'
    end
  end
  object dsdata: TDataSource
    AutoEdit = False
    DataSet = tbdata
    Left = 616
    Top = 128
  end
  object tbfiscal: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Fiscalencaminha'
    TableName = 'oficio.DB'
    Left = 560
    Top = 208
    object tbfiscalData: TDateField
      FieldName = 'Data'
    end
    object tbfiscalFiscalencaminha: TStringField
      FieldName = 'Fiscalencaminha'
      Size = 60
    end
    object tbfiscalOficio: TIntegerField
      FieldName = 'Oficio'
    end
  end
  object dsfiscal: TDataSource
    AutoEdit = False
    DataSet = tbfiscal
    Left = 616
    Top = 208
  end
end
