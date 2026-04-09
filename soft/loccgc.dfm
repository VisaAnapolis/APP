object frmloccgc: Tfrmloccgc
  Left = 306
  Top = 208
  Width = 470
  Height = 286
  Caption = 'Busca por CNPJ'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 8
    Width = 439
    Height = 38
  end
  object Label1: TLabel
    Left = 18
    Top = 19
    Width = 33
    Height = 13
    Caption = 'CNPJ: '
  end
  object c_processo: TEdit
    Left = 56
    Top = 16
    Width = 153
    Height = 21
    Hint = 'Digite aqui o nome do cliente'
    CharCase = ecUpperCase
    TabOrder = 0
    OnChange = c_processoChange
  end
  object btok: TButton
    Left = 114
    Top = 216
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btokClick
  end
  object btcancel: TButton
    Left = 282
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Cancela'
    TabOrder = 2
  end
  object tbcontrib: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'CGC'
    TableName = 'CONTRIB.DB'
    Left = 248
    Top = 8
    object tbcontribCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbcontribCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcontribCGC: TStringField
      FieldName = 'CGC'
      Size = 18
    end
    object tbcontribRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 40
    end
    object tbcontribFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object tbcontribATIVIDADE: TSmallintField
      FieldName = 'ATIVIDADE'
    end
    object tbcontribALVARA: TStringField
      FieldName = 'ALVARA'
      Size = 30
    end
    object tbcontribMUNICIPAL: TStringField
      FieldName = 'MUNICIPAL'
      Size = 6
    end
    object tbcontribESTADUAL: TStringField
      FieldName = 'ESTADUAL'
      Size = 12
    end
    object tbcontribLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 40
    end
    object tbcontribCOMPLEMENT: TStringField
      FieldName = 'COMPLEMENT'
      Size = 7
    end
    object tbcontribBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object tbcontribZONA: TSmallintField
      FieldName = 'ZONA'
    end
  end
  object dscontrib: TDataSource
    AutoEdit = False
    DataSet = tbcontrib
    Left = 264
    Top = 16
  end
end
