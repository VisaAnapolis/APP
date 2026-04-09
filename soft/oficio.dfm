object frmoficio: Tfrmoficio
  Left = 337
  Top = 278
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Ordens de Of'#237'co'
  ClientHeight = 404
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object GBRecl: TGroupBox
    Left = 8
    Top = 56
    Width = 713
    Height = 201
    Caption = 'Ordem de Servi'#231'o'
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 21
      Width = 23
      Height = 13
      Caption = 'Data'
      FocusControl = DBEdata
    end
    object Label3: TLabel
      Left = 320
      Top = 21
      Width = 46
      Height = 13
      Caption = 'Regulado'
      FocusControl = DBEregulado
    end
    object Label4: TLabel
      Left = 320
      Top = 106
      Width = 46
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object Label5: TLabel
      Left = 8
      Top = 106
      Width = 27
      Height = 13
      Caption = 'Bairro'
    end
    object Label1: TLabel
      Left = 98
      Top = 21
      Width = 20
      Height = 13
      Caption = 'CPF'
    end
    object Label13: TLabel
      Left = 202
      Top = 21
      Width = 27
      Height = 13
      Caption = 'CNPJ'
    end
    object Label6: TLabel
      Left = 8
      Top = 153
      Width = 50
      Height = 13
      Caption = 'Motiva'#231#227'o'
    end
    object Label9: TLabel
      Left = 320
      Top = 153
      Width = 97
      Height = 13
      Caption = 'Descri'#231#227'o da Ordem'
    end
    object Label7: TLabel
      Left = 320
      Top = 64
      Width = 40
      Height = 13
      Caption = 'Fantasia'
      FocusControl = DBEregulado
    end
    object DBEdata: TDBEdit
      Left = 8
      Top = 37
      Width = 73
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      DataField = 'Data'
      DataSource = dsoficio
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object DBEregulado: TDBEdit
      Left = 320
      Top = 37
      Width = 380
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Regulado'
      DataSource = dsoficio
      TabOrder = 3
    end
    object DBLBairro: TDBLookupComboBox
      Left = 8
      Top = 124
      Width = 300
      Height = 21
      DataField = 'Cdbai'
      DataSource = dsoficio
      KeyField = 'CODIGO'
      ListField = 'NOME'
      ListFieldIndex = 3
      ListSource = dsbairro
      TabOrder = 5
    end
    object DBECPF: TDBEdit
      Left = 98
      Top = 37
      Width = 87
      Height = 21
      DataField = 'CPF'
      DataSource = dsoficio
      TabOrder = 1
      OnExit = DBECPFExit
    end
    object DBEcgc: TDBEdit
      Left = 202
      Top = 37
      Width = 107
      Height = 21
      DataField = 'Cnpj'
      DataSource = dsoficio
      TabOrder = 2
      OnExit = DBEcgcExit
    end
    object DBElogradouro: TDBEdit
      Left = 320
      Top = 124
      Width = 380
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Logradouro'
      DataSource = dsoficio
      TabOrder = 6
    end
    object DBEOrdem: TDBEdit
      Left = 320
      Top = 170
      Width = 377
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Ordem'
      DataSource = dsoficio
      TabOrder = 8
    end
    object DBCMotivo: TDBComboBox
      Left = 8
      Top = 170
      Width = 300
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Motivo'
      DataSource = dsoficio
      ItemHeight = 13
      Items.Strings = (
        'INSPE'#199#195'O SANIT'#193'RIA'
        'RETORNO'
        'BUSCA ATIVA'
        'SERVI'#199'O T'#201'CNICO'
        'OPERA'#199#195'O FISCAL'
        'PLANT'#195'O FISCAL'
        'TREINAMENTO/REUNI'#195'O')
      TabOrder = 7
      OnChange = DBCencaminhaChange
    end
    object DBEdit6: TDBEdit
      Left = 320
      Top = 80
      Width = 380
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Fantasia'
      DataSource = dsoficio
      TabOrder = 4
    end
  end
  object barraferra: TToolBar
    Left = 0
    Top = 0
    Width = 849
    Height = 47
    ButtonHeight = 34
    Color = clBtnFace
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Indent = 5
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object btnovo: TSpeedButton
      Left = 5
      Top = 2
      Width = 35
      Height = 34
      Hint = 'Registra OS'
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
      Height = 34
      Hint = 'Altera/Reencaminha OS'
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
    object btlocpro: TSpeedButton
      Left = 75
      Top = 2
      Width = 35
      Height = 34
      Hint = 'Localiza OS'
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
      OnClick = btlocproClick
    end
    object btgrava: TSpeedButton
      Left = 110
      Top = 2
      Width = 35
      Height = 34
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
    object Btdeleta: TSpeedButton
      Left = 145
      Top = 2
      Width = 35
      Height = 34
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
      OnClick = BtdeletaClick
    end
    object btcancel: TSpeedButton
      Left = 180
      Top = 2
      Width = 35
      Height = 34
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
    object btfecha: TSpeedButton
      Left = 215
      Top = 2
      Width = 35
      Height = 34
      Hint = 'Fecha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btfechaClick
    end
    object btprn: TSpeedButton
      Left = 250
      Top = 2
      Width = 35
      Height = 34
      Hint = 'Impress'#227'o da OS'
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
    object bthelp: TSpeedButton
      Left = 285
      Top = 2
      Width = 35
      Height = 34
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
      Width = 140
      Height = 34
      DataSource = dsoficio
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
    object DBEdit2: TDBEdit
      Left = 460
      Top = 2
      Width = 120
      Height = 34
      TabStop = False
      Color = clMenu
      DataField = 'Oficio'
      DataSource = dsoficio
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -23
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Texto_Archive: TStaticText
      Left = 580
      Top = 2
      Width = 120
      Height = 34
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Caption = 'Atendida'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object Texto_cancela: TStaticText
      Left = 700
      Top = 2
      Width = 141
      Height = 34
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Caption = 'Cancelada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 385
    Width = 849
    Height = 19
    Panels = <
      item
        Text = '  '
        Width = 50
      end>
    SimplePanel = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 264
    Width = 713
    Height = 113
    Caption = 'Encaminhamento'
    TabOrder = 0
    object Label18: TLabel
      Left = 9
      Top = 20
      Width = 91
      Height = 13
      Caption = 'Fiscal Encarregado'
    end
    object Label19: TLabel
      Left = 312
      Top = 66
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
    end
    object Label20: TLabel
      Left = 631
      Top = 20
      Width = 62
      Height = 13
      Caption = 'Demora(dias)'
    end
    object Label8: TLabel
      Left = 528
      Top = 20
      Width = 59
      Height = 13
      Caption = 'Atendimento'
    end
    object Label10: TLabel
      Left = 320
      Top = 20
      Width = 57
      Height = 13
      Caption = 'Prazo Limite'
    end
    object Label11: TLabel
      Left = 424
      Top = 20
      Width = 82
      Height = 13
      Caption = 'Encaminhamento'
    end
    object Label12: TLabel
      Left = 8
      Top = 66
      Width = 95
      Height = 13
      Caption = 'Autoridade Emitente'
    end
    object DBCencaminha: TDBComboBox
      Left = 8
      Top = 35
      Width = 300
      Height = 21
      CharCase = ecUpperCase
      DataField = 'FiscalEncaminha'
      DataSource = dsoficio
      ItemHeight = 13
      Items.Strings = (
        'TODOS FISCAIS'
        'ACADIA DE SOUZA VIEIRA SILVA'
        'ADRIANA CRHISTINA DE REZENDE CARNEIRO'
        'ADRIANE PEREIRA GUIMAR'#195'ES'
        'ALINE CASTRO DAMASIO'
        'ANA PAULA RODRIGUES CORR'#202'A GUIMAR'#195'ES'
        'ANGELA RIBEIRO NEVES'
        'ARIANNE FERREIRA VIEIRA'
        'C'#201'SIO MALAQUIAS'
        'CL'#193'UDIO NASCIMENTO SILVA'
        'CL'#211'VIS RAFAEL BORGES FERREIRA'
        'DANIEL SOARES BARBOSA'
        'DANIELA DE ALMEIDA CASTRO'
        'EDSON ARANTES FARIA FILHO'
        'EDUARDO LUCAS MAGALH'#195'ES CASTRO'
        'FAB'#205'OLA PEDROSA PEIXOTO MARQUES'
        'GERALDO EDSON ROSA'
        'GLEICIANE MARIA JOS'#201' DA SILVA'
        'G'#218'BIO DIAS PEREIRA'
        'JO'#195'O BATISTA LUCAS DA SILVA REIS'
        'JOSE LUIZ RIBEIRO'
        'JULIANA FERREIRA VITURINO'
        'JULIANA K'#202'NIA MARTINS DA SILVA'
        'JULIO C'#201'SAR TELES SPINDOLA'
        'KAMILLA CHRYSTINE ROLIM D. SANTOS GARC'#202'S'
        'LIDIANE SIM'#213'ES'
        'LIVIA BRITO'
        'LUCIANA CONSOLA'#199#195'O DOS SANTOS'
        'LUCIANA SANTANA DA ROCHA'
        'LUCIENE DE SOUZA BARBOSA GOMES SILVA'
        'MARCIO HENRIQUE GOMES RODOVALHO'
        'MARIA EDWIGES PINHEIRO DE SOUZA CHAVES'
        'MARINA PERILLO NAVARRETE LAVERS'
        'PATR'#205'CIA CORDEIRO DE MORAES E SOUZA'
        'PEDRO HENRIQUE AIRES RIBEIRO'
        'RODRIGO ALESSANDRO T'#212'GO SANTOS'
        'R'#218'BIA MARA DE FREITAS'
        'SILVIA MARQUES NAVES DA MOTA SOUZA'
        'SIMONE DUARTE GROSSI'
        'TATHIANE PESSOA DE SOUZA'
        'THIAGO GOMES GOBO'
        'VANESSA SANTANA'
        'VIVIANE MANOEL DA SILVA BORGES'
        'VIVIANE MIYADA'
        'WANESSA DE BRITO JORGE')
      TabOrder = 0
      OnChange = DBCencaminhaChange
    end
    object STprazo: TStaticText
      Left = 631
      Top = 35
      Width = 63
      Height = 20
      Caption = 'STprazo'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object DBEPrazo: TDBEdit
      Left = 320
      Top = 35
      Width = 85
      Height = 21
      DataField = 'Prazo'
      DataSource = dsoficio
      TabOrder = 1
      OnExit = DBEPrazoExit
    end
    object DBEdit5: TDBEdit
      Left = 424
      Top = 35
      Width = 85
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      DataField = 'Dtencaminha'
      DataSource = dsoficio
      Enabled = False
      ReadOnly = True
      TabOrder = 3
    end
    object DBEdit1: TDBEdit
      Left = 312
      Top = 83
      Width = 187
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      DataField = 'User'
      DataSource = dsoficio
      Enabled = False
      ReadOnly = True
      TabOrder = 5
    end
    object DBEdit3: TDBEdit
      Left = 8
      Top = 83
      Width = 300
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      DataField = 'Emitente'
      DataSource = dsoficio
      Enabled = False
      ReadOnly = True
      TabOrder = 6
    end
    object DBCTerceiro: TDBCheckBox
      Left = 528
      Top = 83
      Width = 169
      Height = 17
      Caption = 'Autorizado Terceiro Fiscal '
      DataField = 'Terceiro'
      DataSource = dsoficio
      TabOrder = 2
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBEdit4: TDBEdit
      Left = 528
      Top = 36
      Width = 85
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      DataField = 'Dtatendimento'
      DataSource = dsoficio
      Enabled = False
      ReadOnly = True
      TabOrder = 7
    end
  end
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'bairro.DB'
    Left = 632
    Top = 104
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
    Left = 592
    Top = 104
  end
  object tboficio: TTable
    AfterScroll = tboficioAfterScroll
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Controle'
    TableName = 'oficio.db'
    Left = 632
    Top = 144
    object tboficioControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tboficioOficio: TIntegerField
      FieldName = 'Oficio'
    end
    object tboficioData: TDateField
      FieldName = 'Data'
    end
    object tboficioRegulado: TStringField
      FieldName = 'Regulado'
      Size = 60
    end
    object tboficioLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object tboficioCdbai: TSmallintField
      FieldName = 'Cdbai'
    end
    object tboficioCpf: TStringField
      FieldName = 'Cpf'
      Size = 14
    end
    object tboficioCnpj: TStringField
      FieldName = 'Cnpj'
      Size = 18
    end
    object tboficioArchive: TBooleanField
      FieldName = 'Archive'
    end
    object tboficioUser: TStringField
      FieldName = 'User'
      Size = 60
    end
    object tboficioDtencaminha: TDateField
      FieldName = 'Dtencaminha'
    end
    object tboficioFiscalencaminha: TStringField
      FieldName = 'Fiscalencaminha'
      Size = 60
    end
    object tboficioOrdem: TStringField
      FieldName = 'Ordem'
      Size = 120
    end
    object tboficioDtatendimento: TDateField
      FieldName = 'Dtatendimento'
    end
    object tboficioEmitente: TStringField
      FieldName = 'Emitente'
      Size = 60
    end
    object tboficioMotivo: TStringField
      FieldName = 'Motivo'
      Size = 25
    end
    object tboficioPrazo: TDateField
      FieldName = 'Prazo'
      EditMask = '!99/99/0000;1;_'
    end
    object tboficioCancela: TBooleanField
      FieldName = 'Cancela'
    end
    object tboficioTerceiro: TBooleanField
      FieldName = 'Terceiro'
    end
    object tboficioFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 40
    end
  end
  object dsoficio: TDataSource
    AutoEdit = False
    DataSet = tboficio
    OnStateChange = dsoficioStateChange
    Left = 592
    Top = 144
  end
  object tbsequencia: TTable
    DatabaseName = 'wcvs'
    TableName = 'sequencia.DB'
    Left = 632
    Top = 192
    object tbsequenciaNumero: TIntegerField
      FieldName = 'Numero'
    end
    object tbsequenciaDoc: TIntegerField
      FieldName = 'Doc'
    end
    object tbsequenciaDen: TIntegerField
      FieldName = 'Den'
    end
    object tbsequenciaAlvara: TIntegerField
      FieldName = 'Alvara'
    end
    object tbsequenciaVeiculo: TIntegerField
      FieldName = 'Veiculo'
    end
    object tbsequenciaPt: TIntegerField
      FieldName = 'Pt'
    end
    object tbsequenciaProtocolo: TIntegerField
      FieldName = 'Protocolo'
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
    object tbsequenciaOficio: TIntegerField
      FieldName = 'Oficio'
    end
  end
  object dssequencia: TDataSource
    DataSet = tbsequencia
    Left = 592
    Top = 192
  end
end
