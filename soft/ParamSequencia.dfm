object frmParamSequencia: TfrmParamSequencia
  Left = 300
  Top = 180
  Width = 930
  Height = 520
  Caption = 'Par'#226'metros '#8212' Sequ'#234'ncia de Numera'#231#227'o (sequencia.DB)'
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
    Width = 922
    Height = 41
    Align = alTop
    TabOrder = 0
    object BtnAlterar: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 0
      OnClick = BtnAlterarClick
    end
    object BtnSalvar: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = BtnSalvarClick
    end
    object BtnCancelar: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = BtnCancelarClick
    end
    object BtnFechar: TButton
      Left = 831
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 3
      OnClick = BtnFecharClick
    end
  end
  object PanelEdicao: TPanel
    Left = 0
    Top = 41
    Width = 922
    Height = 452
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object LblNumero: TLabel
      Left = 12
      Top = 10
      Width = 158
      Height = 13
      Caption = 'Numera'#231#227'o de Documento Fiscal'
    end
    object LblDoc: TLabel
      Left = 294
      Top = 10
      Width = 114
      Height = 13
      Caption = 'Numera'#231#227'o de Hist'#243'rico'
    end
    object LblDen: TLabel
      Left = 576
      Top = 10
      Width = 119
      Height = 13
      Caption = 'Numera'#231#227'o de Den'#250'ncia'
    end
    object LblOficio: TLabel
      Left = 12
      Top = 56
      Width = 151
      Height = 13
      Caption = 'Numera'#231#227'o de Ordem de Of'#237'cio'
    end
    object LblPt: TLabel
      Left = 294
      Top = 56
      Width = 188
      Height = 13
      Caption = 'Numera'#231#227'o de Ordem de Requerimento'
    end
    object LblProtocolo: TLabel
      Left = 576
      Top = 56
      Width = 118
      Height = 13
      Caption = 'Numera'#231#227'o de Protocolo'
    end
    object LblAlvara: TLabel
      Left = 12
      Top = 102
      Width = 147
      Height = 13
      Caption = 'Numera'#231#227'o de Alvar'#225' Sanit'#225'rio'
    end
    object LblVeiculo: TLabel
      Left = 294
      Top = 102
      Width = 144
      Height = 13
      Caption = 'Numera'#231#227'o de Alvar'#225' Veicular'
    end
    object BevelNum: TBevel
      Left = 8
      Top = 152
      Width = 898
      Height = 6
      Shape = bsTopLine
    end
    object LblOrgao: TLabel
      Left = 12
      Top = 166
      Width = 182
      Height = 13
      Caption = 'Nome do '#211'rg'#227'o de Vigil'#226'ncia Sanit'#225'ria'
    end
    object LblAutoridade1: TLabel
      Left = 12
      Top = 212
      Width = 95
      Height = 13
      Caption = 'Autoridade Sanit'#225'ria'
    end
    object LblAutoridade2: TLabel
      Left = 12
      Top = 258
      Width = 141
      Height = 13
      Caption = 'Segunda Autoridade Sanit'#225'ria'
    end
    object BevelSys: TBevel
      Left = 8
      Top = 308
      Width = 898
      Height = 6
      Shape = bsTopLine
    end
    object LblMaster: TLabel
      Left = 12
      Top = 316
      Width = 257
      Height = 13
      Caption = 'Campos abaixo exclusivos do usu'#225'rio master:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblVersao: TLabel
      Left = 12
      Top = 340
      Width = 33
      Height = 13
      Caption = 'Vers'#227'o'
    end
    object LblDtVersao: TLabel
      Left = 104
      Top = 340
      Width = 74
      Height = 13
      Caption = 'Data da Vers'#227'o'
    end
    object LblDisponibilidade: TLabel
      Left = 296
      Top = 340
      Width = 71
      Height = 13
      Caption = 'Disponibilidade'
    end
    object EdNumero: TDBEdit
      Left = 12
      Top = 26
      Width = 270
      Height = 21
      DataField = 'NUMERO'
      DataSource = Ds
      TabOrder = 0
      OnKeyPress = EdEnterAsTab
    end
    object EdDoc: TDBEdit
      Left = 294
      Top = 26
      Width = 270
      Height = 21
      DataField = 'DOC'
      DataSource = Ds
      TabOrder = 1
      OnKeyPress = EdEnterAsTab
    end
    object EdDen: TDBEdit
      Left = 576
      Top = 26
      Width = 270
      Height = 21
      DataField = 'DEN'
      DataSource = Ds
      TabOrder = 2
      OnKeyPress = EdEnterAsTab
    end
    object EdOficio: TDBEdit
      Left = 12
      Top = 72
      Width = 270
      Height = 21
      DataField = 'OFICIO'
      DataSource = Ds
      TabOrder = 3
      OnKeyPress = EdEnterAsTab
    end
    object EdPt: TDBEdit
      Left = 294
      Top = 72
      Width = 270
      Height = 21
      DataField = 'PT'
      DataSource = Ds
      TabOrder = 4
      OnKeyPress = EdEnterAsTab
    end
    object EdProtocolo: TDBEdit
      Left = 576
      Top = 72
      Width = 270
      Height = 21
      DataField = 'PROTOCOLO'
      DataSource = Ds
      TabOrder = 5
      OnKeyPress = EdEnterAsTab
    end
    object EdAlvara: TDBEdit
      Left = 12
      Top = 118
      Width = 270
      Height = 21
      DataField = 'ALVARA'
      DataSource = Ds
      TabOrder = 6
      OnKeyPress = EdEnterAsTab
    end
    object EdVeiculo: TDBEdit
      Left = 294
      Top = 118
      Width = 270
      Height = 21
      DataField = 'VEICULO'
      DataSource = Ds
      TabOrder = 7
      OnKeyPress = EdEnterAsTab
    end
    object EdOrgao: TDBEdit
      Left = 12
      Top = 182
      Width = 560
      Height = 21
      DataField = 'ORGAO'
      DataSource = Ds
      TabOrder = 8
      OnKeyPress = EdEnterAsTab
    end
    object EdAutoridade1: TDBEdit
      Left = 12
      Top = 228
      Width = 560
      Height = 21
      DataField = 'AUTORIDADE1'
      DataSource = Ds
      TabOrder = 9
      OnKeyPress = EdEnterAsTab
    end
    object EdAutoridade2: TDBEdit
      Left = 12
      Top = 274
      Width = 560
      Height = 21
      DataField = 'AUTORIDADE2'
      DataSource = Ds
      TabOrder = 10
      OnKeyPress = EdEnterAsTab
    end
    object EdVersao: TDBEdit
      Left = 12
      Top = 356
      Width = 80
      Height = 21
      DataField = 'VERSAO'
      DataSource = Ds
      TabOrder = 11
      OnKeyPress = EdEnterAsTab
    end
    object EdDtVersao: TDBEdit
      Left = 104
      Top = 356
      Width = 180
      Height = 21
      DataField = 'DT_VERSAO'
      DataSource = Ds
      TabOrder = 12
      OnKeyPress = EdEnterAsTab
    end
    object CbDisponibilidade: TDBCheckBox
      Left = 296
      Top = 356
      Width = 97
      Height = 17
      Caption = 'Dispon'#237'vel'
      DataField = 'DISPONIBILIDADE'
      DataSource = Ds
      TabOrder = 13
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  object Ds: TDataSource
    DataSet = Tb
    OnStateChange = DsStateChange
    Left = 840
    Top = 60
  end
  object Tb: TTable
    DatabaseName = 'wcvs'
    TableName = 'sequencia.DB'
    Left = 840
    Top = 100
    object TbNumero: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Documento Fiscal'
      FieldName = 'Numero'
    end
    object TbDoc: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Hist'#243'rico'
      FieldName = 'Doc'
    end
    object TbDen: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Den'#250'ncia'
      FieldName = 'Den'
    end
    object TbOficio: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Ordem de Of'#237'cio'
      FieldName = 'Oficio'
    end
    object TbPt: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Ordem de Requerimento'
      FieldName = 'Pt'
    end
    object TbProtocolo: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Protocolo'
      FieldName = 'Protocolo'
    end
    object TbAlvara: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Alvar'#225' Sanit'#225'rio'
      FieldName = 'Alvara'
    end
    object TbVeiculo: TIntegerField
      DisplayLabel = 'Numera'#231#227'o de Alvar'#225' Veicular'
      FieldName = 'Veiculo'
    end
    object TbAutoridade1: TStringField
      DisplayLabel = 'Autoridade Sanit'#225'ria'
      FieldName = 'Autoridade1'
      Size = 60
    end
    object TbAutoridade2: TStringField
      DisplayLabel = 'Segunda Autoridade Sanit'#225'ria'
      FieldName = 'Autoridade2'
      Size = 60
    end
    object TbOrgao: TStringField
      DisplayLabel = 'Nome do '#211'rg'#227'o de Vigil'#226'ncia Sanit'#225'ria'
      FieldName = 'Orgao'
      Size = 60
    end
    object TbVersao: TStringField
      DisplayLabel = 'Vers'#227'o'
      FieldName = 'Versao'
      Size = 5
    end
    object TbDtVersao: TStringField
      DisplayLabel = 'Data da Vers'#227'o'
      FieldName = 'Dt_versao'
      Size = 25
    end
    object TbDisponibilidade: TBooleanField
      FieldName = 'Disponibilidade'
    end
  end
end
