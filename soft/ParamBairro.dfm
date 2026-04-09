object frmParamBairro: TfrmParamBairro
  Left = 209
  Top = 197
  Width = 900
  Height = 690
  Caption = 'Parametros - Bairros/Equipes (bairro.db)'
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
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 892
    Height = 41
    Align = alTop
    TabOrder = 0
    object BtnNovo: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = BtnNovoClick
    end
    object BtnAlterar: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = BtnAlterarClick
    end
    object BtnExcluir: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = BtnExcluirClick
    end
    object BtnSalvar: TButton
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 3
      OnClick = BtnSalvarClick
    end
    object BtnCancelar: TButton
      Left = 328
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 4
      OnClick = BtnCancelarClick
    end
    object BtnFechar: TButton
      Left = 792
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 5
      OnClick = BtnFecharClick
    end
  end
  object PanelEdicao: TPanel
    Left = 0
    Top = 41
    Width = 892
    Height = 344
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
  end
  object Grid: TDBGrid
    Left = 0
    Top = 385
    Width = 892
    Height = 272
    Align = alCustom
    DataSource = Ds
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = GridCellClick
  end
  object Ds: TDataSource
    DataSet = Tb
    OnStateChange = DsStateChange
    Left = 32
    Top = 176
  end
  object Tb: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'bairro.db'
    Left = 32
    Top = 216
  end
end
