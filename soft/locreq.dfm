object frmlocOS: TfrmlocOS
  Left = 406
  Top = 402
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
        FieldName = 'OS'
        Title.Caption = 'N'#186' OS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dt_Req'
        Title.Caption = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Caption = 'Matr'#237'cula'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fiscal_Encaminha'
        Title.Caption = 'Fiscal Encarregado'
        Width = 295
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
        'Data do Protocolo'
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
    IndexFieldNames = 'OS'
    TableName = 'requerimento.DB'
    Left = 560
    Top = 88
    object tbnumControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbnumCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbnumOS: TIntegerField
      FieldName = 'OS'
    end
    object tbnumDt_Req: TDateField
      FieldName = 'Dt_Req'
    end
    object tbnumFiscal_Encaminha: TStringField
      FieldName = 'Fiscal_Encaminha'
      Size = 40
    end
  end
  object tbdata: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Dt_Req'
    TableName = 'requerimento.DB'
    Left = 560
    Top = 136
    object tbdataControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbdataCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbdataOS: TIntegerField
      FieldName = 'OS'
    end
    object tbdataDt_Req: TDateField
      FieldName = 'Dt_Req'
    end
    object tbdataFiscal_Encaminha: TStringField
      FieldName = 'Fiscal_Encaminha'
      Size = 40
    end
  end
  object dsdata: TDataSource
    AutoEdit = False
    DataSet = tbdata
    Left = 616
    Top = 128
  end
  object tbregul: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Codigo'
    TableName = 'requerimento.DB'
    Left = 560
    Top = 168
    object tbregulControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbregulCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbregulOS: TIntegerField
      FieldName = 'OS'
    end
    object tbregulDt_Req: TDateField
      FieldName = 'Dt_Req'
    end
    object tbregulFiscal_Encaminha: TStringField
      FieldName = 'Fiscal_Encaminha'
      Size = 40
    end
  end
  object dsregul: TDataSource
    AutoEdit = False
    DataSet = tbregul
    Left = 616
    Top = 168
  end
  object tbfiscal: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Fiscal_Encaminha'
    TableName = 'requerimento.DB'
    Left = 560
    Top = 208
    object tbfiscalControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbfiscalCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbfiscalOS: TIntegerField
      FieldName = 'OS'
    end
    object tbfiscalDt_Req: TDateField
      FieldName = 'Dt_Req'
    end
    object tbfiscalFiscal_Encaminha: TStringField
      FieldName = 'Fiscal_Encaminha'
      Size = 40
    end
  end
  object dsfiscal: TDataSource
    AutoEdit = False
    DataSet = tbfiscal
    Left = 616
    Top = 208
  end
end
