object frmatendimento: Tfrmatendimento
  Left = 428
  Top = 297
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Atendimento '#224' den'#250'ncias'
  ClientHeight = 588
  ClientWidth = 703
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
    Top = 152
    Width = 689
    Height = 97
    Caption = 'Dados do Reclamado'
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 13
      Width = 23
      Height = 13
      Caption = 'Data'
      FocusControl = DBEdata
    end
    object Label3: TLabel
      Left = 296
      Top = 13
      Width = 28
      Height = 13
      Caption = 'Nome'
      FocusControl = DBEreclamado
    end
    object Label4: TLabel
      Left = 8
      Top = 54
      Width = 46
      Height = 13
      Caption = 'Endere'#231'o'
      FocusControl = DBElogradouro
    end
    object Label5: TLabel
      Left = 384
      Top = 54
      Width = 27
      Height = 13
      Caption = 'Bairro'
    end
    object Label1: TLabel
      Left = 82
      Top = 13
      Width = 20
      Height = 13
      Caption = 'CPF'
    end
    object Label13: TLabel
      Left = 178
      Top = 13
      Width = 27
      Height = 13
      Caption = 'CNPJ'
    end
    object DBEdata: TDBEdit
      Left = 8
      Top = 29
      Width = 65
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'Data'
      DataSource = dsdenuncia
      Enabled = False
      TabOrder = 0
    end
    object DBEreclamado: TDBEdit
      Left = 296
      Top = 29
      Width = 380
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Reclamado'
      DataSource = dsdenuncia
      TabOrder = 3
    end
    object DBElogradouro: TDBEdit
      Left = 8
      Top = 70
      Width = 360
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Logradouro'
      DataSource = dsdenuncia
      TabOrder = 4
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 384
      Top = 69
      Width = 292
      Height = 21
      DataField = 'Cdbai'
      DataSource = dsdenuncia
      KeyField = 'CODIGO'
      ListField = 'NOME'
      ListFieldIndex = 3
      ListSource = dsbairro
      TabOrder = 5
    end
    object DBECPF: TDBEdit
      Left = 82
      Top = 29
      Width = 87
      Height = 21
      DataField = 'CPF'
      DataSource = dsdenuncia
      TabOrder = 1
      OnExit = DBECPFExit
    end
    object DBEcgc: TDBEdit
      Left = 178
      Top = 29
      Width = 107
      Height = 21
      DataField = 'Cnpj'
      DataSource = dsdenuncia
      TabOrder = 2
      OnExit = DBEcgcExit
    end
  end
  object barraferra: TToolBar
    Left = 0
    Top = 0
    Width = 703
    Height = 47
    ButtonHeight = 37
    Color = clBtnFace
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Indent = 5
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    object btaltera: TSpeedButton
      Left = 5
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Registra o Atendimento'
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
      Left = 40
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
      OnClick = btlocproClick
    end
    object btgrava: TSpeedButton
      Left = 75
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
      Left = 110
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
    object btfecha: TSpeedButton
      Left = 145
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
      Left = 180
      Top = 2
      Width = 35
      Height = 37
      Hint = 'Impress'#227'o da Den'#250'ncia'
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
      Left = 215
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
      Left = 250
      Top = 2
      Width = 164
      Height = 37
      DataSource = dsdenuncia
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
      Left = 414
      Top = 2
      Width = 138
      Height = 37
      TabStop = False
      Color = clMenu
      DataField = 'Denuncia'
      DataSource = dsdenuncia
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Texto_archive: TStaticText
      Left = 552
      Top = 2
      Width = 136
      Height = 37
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Caption = 'Arquivada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
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
    Top = 569
    Width = 703
    Height = 19
    Panels = <
      item
        Text = '  '
        Width = 50
      end>
    SimplePanel = False
  end
  object GBatend: TGroupBox
    Left = 8
    Top = 251
    Width = 689
    Height = 313
    Caption = 'Registro de Andamentos'
    TabOrder = 2
    object Label10: TLabel
      Left = 9
      Top = 107
      Width = 189
      Height = 13
      Caption = 'Especifica'#231#227'odo do Documento Emitido'
    end
    object Label11: TLabel
      Left = 385
      Top = 66
      Width = 61
      Height = 13
      Caption = 'Prev. retorno'
    end
    object Label9: TLabel
      Left = 9
      Top = 178
      Width = 105
      Height = 13
      Caption = 'Autoridades Sanit'#225'rias'
    end
    object Label8: TLabel
      Left = 9
      Top = 64
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Label12: TLabel
      Left = 84
      Top = 63
      Width = 91
      Height = 13
      Caption = 'Documento emitido'
    end
    object Label14: TLabel
      Left = 280
      Top = 67
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object Label7: TLabel
      Left = 343
      Top = 66
      Width = 27
      Height = 13
      Caption = 'Prazo'
    end
    object DBERetorno: TDBEdit
      Left = 384
      Top = 83
      Width = 65
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'Data_retorno'
      DataSource = dsatend
      Enabled = False
      TabOrder = 5
    end
    object DBCFiscal1: TDBComboBox
      Left = 8
      Top = 194
      Width = 217
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Fiscal1'
      DataSource = dsatend
      ItemHeight = 13
      Items.Strings = (
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
      TabOrder = 7
      OnChange = DBCFiscal1Change
    end
    object DBMObs: TDBMemo
      Left = 9
      Top = 121
      Width = 662
      Height = 51
      DataField = 'Obs'
      DataSource = dsatend
      TabOrder = 6
    end
    object DBCtipo: TDBComboBox
      Left = 84
      Top = 80
      Width = 182
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Tipodoc'
      DataSource = dsatend
      ItemHeight = 13
      Items.Strings = (
        'AUTO DE IMPOSI'#199#195'O DE PENALIDADE'
        'AUTO DE INFRA'#199#195'O'
        'CERTID'#195'O'
        'TERMO DE COLETA PARA AN'#193'LISE'
        'TERMO DE INTIMA'#199#195'O'
        'TERMO DE NOTIFICA'#199#195'O')
      TabOrder = 2
      OnChange = DBCtipoChange
    end
    object DBEdoc: TDBEdit
      Left = 279
      Top = 82
      Width = 57
      Height = 21
      DataField = 'Numdoc'
      DataSource = dsatend
      TabOrder = 3
    end
    object GradeDEN: TDBGrid
      Left = 8
      Top = 220
      Width = 665
      Height = 85
      TabStop = False
      Color = clMoneyGreen
      DataSource = dsatend
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ReadOnly = True
      TabOrder = 10
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Data_atendimento'
          Title.Caption = 'Data'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Prazo'
          Width = 24
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Data_retorno'
          Title.Caption = 'Retorno'
          Width = 57
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Tipodoc'
          Title.Caption = 'Tipo do Documento'
          Width = 121
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Numdoc'
          Title.Caption = 'N'#186' Doc'
          Width = 38
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fiscal1'
          Title.Caption = 'Autoridade Sanit'#225'ria'
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fiscal2'
          Title.Caption = 'Autoridade Sanit'#225'ria'
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fiscal3'
          Title.Caption = 'Autoridade Sanit'#225'ria'
          Width = 102
          Visible = True
        end>
    end
    object DBCFiscal2: TDBComboBox
      Left = 232
      Top = 194
      Width = 217
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Fiscal2'
      DataSource = dsatend
      ItemHeight = 13
      Items.Strings = (
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
      TabOrder = 8
      OnChange = DBCFiscal2Change
    end
    object DBCFiscal3: TDBComboBox
      Left = 456
      Top = 194
      Width = 217
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Fiscal3'
      DataSource = dsatend
      ItemHeight = 13
      Items.Strings = (
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
      TabOrder = 9
      OnChange = DBCFiscal3Change
    end
    object DBEpz: TDBEdit
      Left = 345
      Top = 82
      Width = 30
      Height = 21
      DataField = 'Prazo'
      DataSource = dsatend
      TabOrder = 4
      OnExit = DBEpzExit
    end
    object PainelVisita: TPanel
      Left = 8
      Top = 14
      Width = 257
      Height = 45
      TabOrder = 0
      object btnovvisita: TSpeedButton
        Left = 2
        Top = 5
        Width = 35
        Height = 35
        Hint = 'Inclui Andamento'
        Flat = True
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
        Layout = blGlyphRight
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = btnovvisitaClick
      end
      object btaltvisita: TSpeedButton
        Left = 37
        Top = 5
        Width = 35
        Height = 35
        Hint = 'Altera Ocorr'#234'ncia'
        Flat = True
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
        Layout = blGlyphBottom
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = btaltvisitaClick
      end
      object btgravisita: TSpeedButton
        Left = 72
        Top = 5
        Width = 35
        Height = 35
        Hint = 'Grava'
        Flat = True
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
        Layout = blGlyphBottom
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = btgravisitaClick
      end
      object btcanvisita: TSpeedButton
        Left = 107
        Top = 5
        Width = 35
        Height = 35
        Hint = 'Cancela'
        Flat = True
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
        Layout = blGlyphBottom
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = btcanvisitaClick
      end
      object btdelvisita: TSpeedButton
        Left = 142
        Top = 5
        Width = 35
        Height = 35
        Hint = 'Exclui'
        Flat = True
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
        Layout = blGlyphBottom
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = btdelvisitaClick
      end
      object Btarquiva: TSpeedButton
        Left = 177
        Top = 5
        Width = 35
        Height = 35
        Hint = 'Registra o arquivamento'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00550000000005
          555555777777777FF5555500000000805555557777777777FF555550BBBBB008
          05555557F5FFF7777FF55550B000B03080555557F77757F777F55550BBBBB033
          00555557F55557F577555550BBBBB03305555557FFFFF7F57F55555000000033
          05555557777777F57F555550BBBBB03305555557F5FFF7F57F555550B000B033
          05555557F77757F57F555550BBBBB03305555557F55557F57F555550BBBBB033
          05555557FFFFF7FF7F55550000000003055555777777777F7F55550777777700
          05555575FF5555777F5555500B3B3B300555555775FF55577FF555555003B3B3
          005555555775FFFF77F555555570000000555555555777777755}
        Layout = blGlyphBottom
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = BtarquivaClick
      end
    end
    object DBEAtendimento: TDBEdit
      Left = 8
      Top = 80
      Width = 65
      Height = 21
      DataField = 'Data_atendimento'
      DataSource = dsatend
      MaxLength = 10
      TabOrder = 1
      OnExit = DBEAtendimentoExit
    end
    object DBCOb1: TDBComboBox
      Left = 280
      Top = 14
      Width = 391
      Height = 21
      CharCase = ecUpperCase
      Color = clBtnFace
      DataField = 'Objeto1'
      DataSource = dsdenuncia
      Enabled = False
      ItemHeight = 13
      Items.Strings = (
        'AC'#218'MULO DE LIXO E ENTULHO'
        'CRIA'#199#195'O DE ANIMAIS EM '#193'REA URBANA'
        'ESGOTAMENTO SANIT'#193'RIO INADEQUADO'
        'EXERC'#205'CIO ILEGAL DE PROFISS'#195'O REGULAMENTADA'
        'FALTA DE ALVAR'#193' SANIT'#193'RIO'
        'FALTA DE EPI'
        'HIGIENE'
        'MAU CHEIRO'
        'PRESEN'#199'A DE PRAGAS'
        'PRODUTO CLANDESTINO'
        'PRODUTO SEM REGISTRO'
        'PRODUTOS COM VALIDADE EXPIRADA'
        'PRODUTOS DETERIORADOS'
        'SUSPEITA DE TOXINFEC'#199#195'O ALIMENTAR'
        'TRANSPORTE INADEQUADO DE PRODUTOS'
        'VENDA DE MEDICAMENTOS SEM RECEITA')
      Sorted = True
      TabOrder = 11
      TabStop = False
    end
    object DBEDescri: TDBEdit
      Left = 280
      Top = 38
      Width = 389
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'Descricao'
      DataSource = dsdenuncia
      Enabled = False
      TabOrder = 12
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 48
    Width = 689
    Height = 99
    Caption = 'Status da Den'#250'ncia'
    TabOrder = 0
    object Label15: TLabel
      Left = 8
      Top = 16
      Width = 67
      Height = 13
      Caption = 'Parecer Fiscal'
    end
    object Label18: TLabel
      Left = 177
      Top = 16
      Width = 108
      Height = 13
      Caption = '(Re)Distribui'#231#227'o da OS'
    end
    object Label19: TLabel
      Left = 466
      Top = 14
      Width = 41
      Height = 13
      Caption = 'Data OS'
    end
    object Label20: TLabel
      Left = 562
      Top = 14
      Width = 66
      Height = 13
      Caption = 'Prazo M'#225'ximo'
    end
    object Label6: TLabel
      Left = 8
      Top = 54
      Width = 143
      Height = 13
      Caption = 'Fiscal respos'#225'vel pelo parecer'
      FocusControl = DBEFiscalStatus
    end
    object DBCSTATUS: TDBComboBox
      Left = 8
      Top = 31
      Width = 161
      Height = 21
      CharCase = ecUpperCase
      DataField = 'Satatus'
      DataSource = dsdenuncia
      ItemHeight = 13
      Items.Strings = (
        'PROCEDENTE'
        'PARCIALMENTE PROCEDENTE'
        'IMPROCEDENTE'
        'INDETERMIN'#193'VEL')
      TabOrder = 0
      OnChange = DBCSTATUSChange
    end
    object DBCencaminha: TDBComboBox
      Left = 176
      Top = 31
      Width = 281
      Height = 21
      CharCase = ecUpperCase
      DataField = 'FiscalEncaminha'
      DataSource = dsdenuncia
      ItemHeight = 13
      Items.Strings = (
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
      Sorted = True
      TabOrder = 1
      OnChange = DBCencaminhaChange
    end
    object DBEDtencaminha: TDBEdit
      Left = 466
      Top = 30
      Width = 71
      Height = 21
      Color = clMoneyGreen
      DataField = 'DtEncaminha'
      DataSource = dsdenuncia
      Enabled = False
      TabOrder = 2
      OnExit = DBEAtendimentoExit
    end
    object STprazo: TStaticText
      Left = 562
      Top = 64
      Width = 103
      Height = 33
      Caption = 'STprazo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object DBEFiscalStatus: TDBEdit
      Left = 8
      Top = 70
      Width = 529
      Height = 21
      CharCase = ecUpperCase
      Color = clMoneyGreen
      DataField = 'FiscalAtend'
      DataSource = dsdenuncia
      Enabled = False
      TabOrder = 4
    end
    object DBEdit1: TDBEdit
      Left = 562
      Top = 30
      Width = 87
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      DataField = 'Prazo'
      DataSource = dsdenuncia
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      OnExit = DBEAtendimentoExit
    end
  end
  object tbdenuncia: TTable
    AfterScroll = tbdenunciaAfterScroll
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Controle'
    TableName = 'denuncia.db'
    Left = 632
    Top = 152
    object tbdenunciaControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbdenunciaDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbdenunciaData: TDateField
      FieldName = 'Data'
      EditMask = '!99/99/0000;1;_'
    end
    object tbdenunciaReclamado: TStringField
      FieldName = 'Reclamado'
      Size = 60
    end
    object tbdenunciaLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object tbdenunciaReferencia: TStringField
      FieldName = 'Referencia'
      Size = 40
    end
    object tbdenunciaArea: TStringField
      FieldName = 'Area'
      Size = 35
    end
    object tbdenunciaObjeto1: TStringField
      FieldName = 'Objeto1'
      Size = 60
    end
    object tbdenunciaCdbai: TSmallintField
      FieldName = 'Cdbai'
    end
    object tbdenunciaCpf: TStringField
      FieldName = 'Cpf'
      EditMask = '000\.000\.000\-00;1;_'
      Size = 14
    end
    object tbdenunciaCnpj: TStringField
      FieldName = 'Cnpj'
      EditMask = '00\.000\.000\/0000\-00;1;_'
      Size = 18
    end
    object tbdenunciaArchive: TBooleanField
      FieldName = 'Archive'
    end
    object tbdenunciaSatatus: TStringField
      FieldName = 'Satatus'
      Size = 25
    end
    object tbdenunciaSINAVISA: TIntegerField
      FieldName = 'SINAVISA'
    end
    object tbdenunciaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 255
    end
    object tbdenunciaUser: TStringField
      FieldName = 'User'
      Size = 60
    end
    object tbdenunciaMeio: TStringField
      FieldName = 'Meio'
      Size = 30
    end
    object tbdenunciaEmissao: TStringField
      FieldName = 'Emissao'
      Size = 60
    end
    object tbdenunciaDtEmite: TDateField
      FieldName = 'DtEmite'
    end
    object tbdenunciaDtEncaminha: TDateField
      FieldName = 'DtEncaminha'
      EditMask = '!99/99/0000;1;_'
    end
    object tbdenunciaFiscalAtend: TStringField
      FieldName = 'FiscalAtend'
      Size = 60
    end
    object tbdenunciaFiscalEncaminha: TStringField
      FieldName = 'FiscalEncaminha'
      Size = 60
    end
    object tbdenunciaPrazo: TDateField
      FieldName = 'Prazo'
    end
  end
  object dsdenuncia: TDataSource
    AutoEdit = False
    DataSet = tbdenuncia
    OnStateChange = dsdenunciaStateChange
    Left = 592
    Top = 200
  end
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    TableName = 'bairro.DB'
    Left = 648
    Top = 200
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
    Left = 496
    Top = 168
  end
  object tbatend: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorDenuncia'
    MasterFields = 'Denuncia'
    MasterSource = dsdenuncia
    TableName = 'atend.DB'
    Left = 488
    Top = 152
    object tbatendControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbatendDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbatendData_atendimento: TDateField
      FieldName = 'Data_atendimento'
      EditMask = '!99/99/0000;1;_'
    end
    object tbatendPrazo: TIntegerField
      FieldName = 'Prazo'
    end
    object tbatendData_retorno: TDateField
      FieldName = 'Data_retorno'
    end
    object tbatendFiscal1: TStringField
      FieldName = 'Fiscal1'
      Size = 60
    end
    object tbatendFiscal2: TStringField
      FieldName = 'Fiscal2'
      Size = 60
    end
    object tbatendFiscal3: TStringField
      FieldName = 'Fiscal3'
      Size = 60
    end
    object tbatendObs: TMemoField
      FieldName = 'Obs'
      BlobType = ftMemo
      Size = 20
    end
    object tbatendTipodoc: TStringField
      FieldName = 'Tipodoc'
      Size = 35
    end
    object tbatendH_inicio: TTimeField
      FieldName = 'H_inicio'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object tbatendH_fim: TTimeField
      FieldName = 'H_fim'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object tbatendNumdoc: TIntegerField
      FieldName = 'Numdoc'
    end
  end
  object dsatend: TDataSource
    AutoEdit = False
    DataSet = tbatend
    OnStateChange = dsatendStateChange
    Left = 552
    Top = 160
  end
end
