object Frmproto: TFrmproto
  Left = 345
  Top = 264
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Protocolo'
  ClientHeight = 407
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 3
    Top = 49
    Width = 633
    Height = 336
    Caption = 'Registro'
    TabOrder = 0
    object Label3: TLabel
      Left = 8
      Top = 56
      Width = 55
      Height = 13
      Caption = 'Interessado'
      FocusControl = DBEInteressado
    end
    object Label4: TLabel
      Left = 8
      Top = 99
      Width = 54
      Height = 13
      Caption = 'Logradouro'
      FocusControl = DBElogradouro
    end
    object Label5: TLabel
      Left = 495
      Top = 99
      Width = 64
      Height = 13
      Caption = 'Complemento'
      FocusControl = DBEComple
    end
    object Label6: TLabel
      Left = 8
      Top = 142
      Width = 27
      Height = 13
      Caption = 'Bairro'
    end
    object Label7: TLabel
      Left = 495
      Top = 56
      Width = 42
      Height = 13
      Caption = 'Telefone'
      FocusControl = DBEFone
    end
    object Label8: TLabel
      Left = 8
      Top = 15
      Width = 38
      Height = 13
      Caption = 'Assunto'
    end
    object Label1: TLabel
      Left = 8
      Top = 188
      Width = 59
      Height = 13
      Caption = 'Andamentos'
      FocusControl = DBEComple
    end
    object Label9: TLabel
      Left = 495
      Top = 16
      Width = 97
      Height = 13
      Caption = 'N'#186' Prot. Geral (PMA)'
      FocusControl = DBEPMA
    end
    object Label2: TLabel
      Left = 324
      Top = 144
      Width = 36
      Height = 13
      Caption = 'Destino'
    end
    object DBCAssunto: TDBComboBox
      Left = 8
      Top = 31
      Width = 465
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Assunto'
      DataSource = dsregistro
      ItemHeight = 13
      Items.Strings = (
        'BALAN'#199'O DE MEDICAMENTOS'
        'PROCESSO ADMINISTRATIVO'
        'APLICA'#199#195'O DE PENALIDADE'
        'GERAL(OUTROS)'
        'LIVRO DE RT'
        'MBPS/POP/PRGSS/CCIH'
        'PROCESSO DA PREFEITURA'
        'REQUERIMENTO DE ALVAR'#193
        'REQUISI'#199#195'O MINISTERIAL')
      TabOrder = 0
    end
    object DBEInteressado: TDBEdit
      Left = 8
      Top = 72
      Width = 465
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Interessado'
      DataSource = dsregistro
      TabOrder = 2
    end
    object DBElogradouro: TDBEdit
      Left = 8
      Top = 115
      Width = 465
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Logradouro'
      DataSource = dsregistro
      TabOrder = 4
    end
    object DBEComple: TDBEdit
      Left = 495
      Top = 115
      Width = 129
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Complemento'
      DataSource = dsregistro
      TabOrder = 5
    end
    object DBEFone: TDBEdit
      Left = 495
      Top = 72
      Width = 129
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Fone'
      DataSource = dsregistro
      TabOrder = 3
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 205
      Width = 617
      Height = 120
      TabStop = False
      DataSource = dsanda
      ReadOnly = True
      TabOrder = 8
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Data'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Hora'
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Destino'
          Title.Caption = 'Setor de Destino'
          Width = 178
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'User_env'
          Title.Caption = 'Usu'#225'rio Remetente'
          Width = 158
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'User_rec'
          Title.Caption = 'Usu'#225'rio Recebedor'
          Width = 161
          Visible = True
        end>
    end
    object DBEPMA: TDBEdit
      Left = 495
      Top = 32
      Width = 129
      Height = 21
      CharCase = ecUpperCase
      DataField = 'PMA'
      DataSource = dsregistro
      TabOrder = 1
    end
    object DBLBairro: TDBLookupComboBox
      Left = 8
      Top = 159
      Width = 300
      Height = 21
      DataField = 'Cdbai'
      DataSource = dsregistro
      KeyField = 'CODIGO'
      ListField = 'NOME'
      ListFieldIndex = 1
      ListSource = dsbai
      TabOrder = 6
    end
    object DBComboBox1: TDBComboBox
      Left = 325
      Top = 159
      Width = 299
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Destino'
      DataSource = dsanda
      ItemHeight = 13
      Items.Strings = (
        'ATENDIMENTO AO CONTRIBUINTE'
        'CCIH'
        'DIRETORIA DE VIGILANCIA EM SA'#218'DE'
        'EXPEDIENTE ADMINISTRATIVO'
        'EXTERNO'
        'FISCALIZA'#199#195'O AMBIENTAL'
        'FISCALIZA'#199#195'O EM ALIMENTOS'
        'FISCALIZA'#199#195'O EM MEDICAMENTOS'
        'FISCALIZA'#199#195'O EM SA'#218'DE'
        'FISCALIZA'#199#195'O OUTRAS '#193'REAS'
        'GER'#202'NCIA DE VIGIL'#194'NCIA SANIT'#193'RIA'
        'PROCESSO ADMINISTRATIVO'
        'PROTOCOLO GERAL - PREFEITURA')
      Sorted = True
      TabOrder = 7
    end
  end
  object barraferra: TToolBar
    Left = 0
    Top = 0
    Width = 640
    Height = 47
    ButtonHeight = 37
    Color = clBtnFace
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Indent = 5
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object btnovo: TSpeedButton
      Left = 5
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Registra Den'#250'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btnovoClick
    end
    object btaltera: TSpeedButton
      Left = 40
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Altera Den'#250'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btalteraClick
    end
    object btloc: TSpeedButton
      Left = 75
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Localiza Den'#250'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btlocClick
    end
    object btgrava: TSpeedButton
      Left = 110
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Grava'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btgravaClick
    end
    object btcancel: TSpeedButton
      Left = 145
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Cancela'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btcancelClick
    end
    object btdeleta: TSpeedButton
      Left = 180
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Exclui Den'#250'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
        03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
        33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
        0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
        3333333337FFF7F3333333333000003333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btdeletaClick
    end
    object btprn: TSpeedButton
      Left = 215
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Impress'#227'o da Dn'#250'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btprnClick
    end
    object btfecha: TSpeedButton
      Left = 250
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Fecha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33F333337F3333373B33333BB33333B337FF33377F33337F3BB3333BB333
        3BB3377FF3377F33377333BB777BB777BB333377FFF77FFF7733330000000000
        B3333377777777777333330FFFFFFFF03333337F3FF3FFF7F333330F00F000F0
        33333F7F77377737FFFFBB0FFF8FFFF0BBB3777F3F33FFF7777F3B0F08700000
        000B377F73F7777777773308880FFFFFF033337F377333333733330807FFFFF8
        033333737FFFFFFF7F33333000000000B3333337777777777FF333BB333BB333
        BB33337733377F3377FF3BB3333BB3333BB3377333377F33377F3B33333BB333
        33B33733333773333373B333333B3333333B7333333733333337}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btfechaClick
    end
    object bthelp: TSpeedButton
      Left = 285
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Ajuda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = bthelpClick
    end
    object navegador: TDBNavigator
      Left = 320
      Top = 2
      Width = 192
      Height = 37
      DataSource = dsregistro
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Hints.Strings = (
        'Primeiro'
        'Anterior'
        'Pr'#243'ximo'
        #218'ltimo'
        'Insert record'
        'Delete record'
        'Edit record'
        'Post edit'
        'Cancel edit'
        'Refresh data')
      TabOrder = 0
    end
    object DBEdit1: TDBEdit
      Left = 512
      Top = 2
      Width = 121
      Height = 37
      TabStop = False
      Color = clMenu
      DataField = 'Proto'
      DataSource = dsregistro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clOlive
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 388
    Width = 640
    Height = 19
    Panels = <
      item
        Text = '  '
        Width = 50
      end>
    SimplePanel = False
  end
  object dsregistro: TDataSource
    AutoEdit = False
    DataSet = tbproto
    OnStateChange = dsregistroStateChange
    Left = 432
    Top = 8
  end
  object tbproto: TTable
    DatabaseName = 'wcvs'
    TableName = 'registro.DB'
    Left = 424
    object tbprotoControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbprotoProto: TIntegerField
      FieldName = 'Proto'
    end
    object tbprotoInteressado: TStringField
      FieldName = 'Interessado'
      Size = 60
    end
    object tbprotoLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object tbprotoComplemento: TStringField
      FieldName = 'Complemento'
    end
    object tbprotoCdbai: TSmallintField
      FieldName = 'Cdbai'
    end
    object tbprotoAssunto: TStringField
      FieldName = 'Assunto'
      Size = 30
    end
    object tbprotoFone: TStringField
      FieldName = 'Fone'
      EditMask = '!\(99\)0000-0000;1;_'
      Size = 13
    end
    object tbprotoPMA: TStringField
      FieldName = 'PMA'
    end
  end
  object tbbai: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'Cdbai'
    TableName = 'bairro.DB'
    Left = 376
    object tbbaiCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbbaiCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbbaiNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object tbbaiSETOR: TIntegerField
      FieldName = 'SETOR'
    end
  end
  object dsbai: TDataSource
    AutoEdit = False
    DataSet = tbbai
    Left = 384
    Top = 8
  end
  object tbanda: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorProto'
    MasterFields = 'Proto'
    MasterSource = dsregistro
    TableName = 'andamentos.db'
    Left = 344
    object tbandaControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbandaProto: TIntegerField
      FieldName = 'Proto'
    end
    object tbandaData: TDateField
      FieldName = 'Data'
    end
    object tbandaHora: TTimeField
      FieldName = 'Hora'
    end
    object tbandaDestino: TStringField
      FieldName = 'Destino'
      Size = 40
    end
    object tbandaUser_env: TStringField
      FieldName = 'User_env'
      Size = 40
    end
    object tbandaUser_rec: TStringField
      FieldName = 'User_rec'
      Size = 40
    end
  end
  object dsanda: TDataSource
    AutoEdit = False
    DataSet = tbanda
    Left = 336
    Top = 8
  end
  object tbsequencia: TTable
    DatabaseName = 'wcvs'
    TableName = 'sequencia.DB'
    Left = 288
    Top = 8
    object tbsequenciaNumero: TIntegerField
      FieldName = 'Numero'
    end
    object tbsequenciaDoc: TIntegerField
      FieldName = 'Doc'
    end
    object tbsequenciaDen: TIntegerField
      FieldName = 'Den'
    end
    object tbsequenciaPt: TIntegerField
      FieldName = 'Pt'
    end
    object tbsequenciaDisponibilidade: TBooleanField
      FieldName = 'Disponibilidade'
    end
    object tbsequenciaVersao: TStringField
      FieldName = 'Versao'
      Size = 5
    end
    object tbsequenciaDt_versao: TStringField
      FieldName = 'Dt_versao'
      Size = 25
    end
  end
end
