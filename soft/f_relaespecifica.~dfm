object frmrelespecifica: Tfrmrelespecifica
  Left = 463
  Top = 254
  BorderIcons = [biHelp]
  BorderStyle = bsSingle
  Caption = 'Gera Rela'#231#227'o de Contribuintes'
  ClientHeight = 267
  ClientWidth = 614
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
  object Panel1: TPanel
    Left = 5
    Top = 5
    Width = 604
    Height = 260
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 8
      Top = 61
      Width = 241
      Height = 141
      DataSource = dsativi
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NOME'
          Width = 116
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AREA'
          Width = 90
          Visible = True
        end>
    end
    object Button1: TButton
      Left = 57
      Top = 217
      Width = 170
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 353
      Top = 217
      Width = 170
      Height = 25
      Caption = 'Cancela'
      TabOrder = 2
      OnClick = Button2Click
    end
    object CBativ: TCheckBox
      Left = 8
      Top = 7
      Width = 121
      Height = 17
      Caption = 'Atividade Econ'#244'mica'
      TabOrder = 3
    end
    object CBbairro: TCheckBox
      Left = 265
      Top = 7
      Width = 97
      Height = 17
      Caption = 'Bairro'
      TabOrder = 4
    end
    object DBGrid3: TDBGrid
      Left = 265
      Top = 61
      Width = 329
      Height = 140
      DataSource = dsbairro
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NOME'
          Width = 247
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SETOR'
          Width = 44
          Visible = True
        end>
    end
    object RGbairro: TRadioGroup
      Left = 265
      Top = 26
      Width = 181
      Height = 32
      Caption = 'Ordem dos bairros'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Geral'
        'Setor')
      TabOrder = 6
      OnClick = RGbairroClick
    end
    object RGativi: TRadioGroup
      Left = 8
      Top = 26
      Width = 181
      Height = 32
      Caption = 'Ordem das atividades'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Geral'
        #193'rea')
      TabOrder = 7
      OnClick = RGativiClick
    end
  end
  object tbativi: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'ATIVI.DB'
    Left = 240
    Top = 216
    object tbativiNOME: TStringField
      FieldName = 'NOME'
      Size = 40
    end
    object tbativiGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbativiSINAVISA: TIntegerField
      FieldName = 'SINAVISA'
    end
    object tbativiAREA: TStringField
      FieldName = 'AREA'
    end
    object tbativiNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
  end
  object dsativi: TDataSource
    DataSet = tbativi
    Left = 264
    Top = 216
  end
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'bairro.DB'
    Left = 296
    Top = 216
    object tbbairroCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbbairroCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbbairroNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object tbbairroSETOR: TIntegerField
      FieldName = 'SETOR'
    end
  end
  object dsbairro: TDataSource
    DataSet = tbbairro
    Left = 320
    Top = 216
  end
end
