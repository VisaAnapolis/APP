object frmrelareq: Tfrmrelareq
  Left = 342
  Top = 235
  BorderIcons = [biHelp]
  BorderStyle = bsDialog
  Caption = 'Gera rela'#231#227'o alvar'#225's requeridos e n'#227'o liberados'
  ClientHeight = 246
  ClientWidth = 789
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 7
    Top = 3
    Width = 777
    Height = 238
    TabOrder = 0
    object Button1: TButton
      Left = 32
      Top = 161
      Width = 113
      Height = 25
      Caption = 'OK'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 32
      Top = 200
      Width = 113
      Height = 24
      Caption = 'Cancela'
      TabOrder = 3
      OnClick = Button2Click
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 8
      Width = 163
      Height = 17
      Caption = 'Selecione a '#225'rea de Fiscaliza'#231#227'o:'
      TabOrder = 4
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 24
      Width = 161
      Height = 125
      DataSource = dsarea
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
          FieldName = 'Nome'
          Title.Caption = #193'rea'
          Visible = True
        end>
    end
    object GroupBox1: TGroupBox
      Left = 176
      Top = 8
      Width = 597
      Height = 225
      Caption = 'Cirt'#233'rios de Filtragem'
      TabOrder = 1
      object cbvisitados: TCheckBox
        Left = 7
        Top = 17
        Width = 314
        Height = 17
        Caption = 'Selecionar somente n'#227'o inspecionados no exerc'#237'cio corrente'
        TabOrder = 0
      end
      object CBativ: TCheckBox
        Left = 8
        Top = 43
        Width = 217
        Height = 17
        Caption = 'Somente a atividade selecionada:'
        TabOrder = 1
      end
      object DBativ: TDBGrid
        Left = 8
        Top = 63
        Width = 225
        Height = 152
        DataSource = dsativi
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Caption = 'Atividade'
            Visible = True
          end>
      end
      object CBBai: TCheckBox
        Left = 239
        Top = 43
        Width = 170
        Height = 17
        Caption = 'Somente o bairro selecionado:'
        TabOrder = 3
      end
      object DBBairro: TDBGrid
        Left = 239
        Top = 63
        Width = 351
        Height = 152
        DataSource = dsbairro
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
            Title.Caption = 'Bairro'
            Width = 294
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SETOR'
            Title.Caption = 'St'
            Width = 20
            Visible = True
          end>
      end
      object RGordem: TRadioGroup
        Left = 409
        Top = 9
        Width = 181
        Height = 49
        Caption = 'Ordem dos bairros'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Alfab'#233'tica'
          'Setor')
        TabOrder = 4
        OnClick = RGordemClick
      end
    end
  end
  object tbarea: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'area.db'
    Left = 32
    Top = 128
    object tbareaCod: TIntegerField
      FieldName = 'Cod'
    end
    object tbareaNome: TStringField
      FieldName = 'Nome'
    end
  end
  object dsarea: TDataSource
    AutoEdit = False
    DataSet = tbarea
    Left = 16
    Top = 112
  end
  object tbativi: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'ATIVI.DB'
    Left = 88
    Top = 128
    object tbativiCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbativiNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
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
    object tbativiVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
    object tbativiAREA: TStringField
      FieldName = 'AREA'
    end
  end
  object dsativi: TDataSource
    AutoEdit = False
    DataSet = tbativi
    Left = 72
    Top = 112
  end
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'bairro.DB'
    Left = 136
    Top = 128
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
    AutoEdit = False
    DataSet = tbbairro
    Left = 128
    Top = 112
  end
end
