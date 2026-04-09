object frmrdpf: Tfrmrdpf
  Left = 357
  Top = 262
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Apura'#231#227'o da Produ'#231#227'o Fiscal'
  ClientHeight = 441
  ClientWidth = 698
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label19: TLabel
    Left = 607
    Top = 248
    Width = 52
    Height = 13
    Caption = 'Pontua'#231#227'o'
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 50
    Width = 689
    Height = 383
    Caption = 'Gera'#231#227'o do Relat'#243'rio de Produ'#231#227'o Fiscal'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 19
      Width = 71
      Height = 13
      Caption = 'Fiscal Sanit'#225'rio'
    end
    object Label2: TLabel
      Left = 283
      Top = 19
      Width = 52
      Height = 13
      Caption = 'Data inicial'
    end
    object Label9: TLabel
      Left = 513
      Top = 19
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object CFiscal: TComboBox
      Left = 8
      Top = 35
      Width = 265
      Height = 21
      Hint = 'Selecione o Fiscal Sanit'#225'rio Para Gera'#231#227'o do RDPF'
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
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
    end
    object DTPrel: TDateTimePicker
      Left = 282
      Top = 35
      Width = 159
      Height = 21
      Hint = 
        'Selecione a Data inicial para Gera'#231#227'o do Relat'#243'rio ou a data  ex' +
        'clusiva para outras fun'#231#245'es'
      CalAlignment = dtaLeft
      Date = 44562
      Time = 44562
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 60
      Width = 673
      Height = 150
      Caption = 'Outras Atividades Fiscais '
      Color = clBtnFace
      ParentColor = False
      TabOrder = 3
      object Label3: TLabel
        Left = 8
        Top = 60
        Width = 307
        Height = 13
        Caption = 'Atividade conforme tabela do anexo VII do Decreto 49.723/2023'
      end
      object Label4: TLabel
        Left = 8
        Top = 103
        Width = 105
        Height = 13
        Caption = 'Contribuinte/Atividade'
        FocusControl = DBEestabe
      end
      object Label6: TLabel
        Left = 274
        Top = 16
        Width = 71
        Height = 13
        Caption = 'Fiscal Sanit'#225'rio'
        FocusControl = DBEestabe
      end
      object Label7: TLabel
        Left = 416
        Top = 103
        Width = 55
        Height = 13
        Caption = 'Dt Encamin'
        FocusControl = DBEdata
      end
      object Label13: TLabel
        Left = 574
        Top = 63
        Width = 30
        Height = 13
        Caption = 'N'#186' OS'
        FocusControl = DBEdata
      end
      object Label14: TLabel
        Left = 416
        Top = 62
        Width = 66
        Height = 13
        Caption = 'Origem da OS'
        FocusControl = DBEdata
      end
      object Label15: TLabel
        Left = 574
        Top = 16
        Width = 23
        Height = 13
        Caption = 'Data'
        FocusControl = DBEdata
      end
      object Label18: TLabel
        Left = 499
        Top = 103
        Width = 57
        Height = 13
        Caption = 'Prazo Limite'
      end
      object Label5: TLabel
        Left = 574
        Top = 103
        Width = 63
        Height = 13
        Caption = 'Apontamento'
        FocusControl = DBEdata
      end
      object DBEestabe: TDBEdit
        Left = 8
        Top = 118
        Width = 401
        Height = 21
        Hint = 'Indica'#231#227'o sint'#233'tica da a'#231#227'o fiscal'
        CharCase = ecUpperCase
        DataField = 'Estabe'
        DataSource = dsrdpf
        TabOrder = 6
      end
      object DBCdoc: TDBComboBox
        Left = 8
        Top = 77
        Width = 401
        Height = 21
        Hint = 'Selecione uma op'#231#227'o '
        CharCase = ecUpperCase
        DataField = 'Doc'
        DataSource = dsrdpf
        ItemHeight = 13
        Items.Strings = (
          'APRESENTA'#199#195'O/PARTICIPA'#199#195'O/PREPARA'#199#195'O DE CURSOS E SIMILARES'
          'OPERA'#199#213'ES FISCAIS N'#195'O PREVISTAS E/OU SITUA'#199#213'ES EXTRAORDIN'#193'RIAS'
          'PLANT'#195'O FISCAL'
          'SERVI'#199'OS T'#201'CNICOS REALIZADOS NO '#194'MBITO DA VIGIL'#194'NCIA SANIT'#193'RIA')
        Sorted = True
        TabOrder = 3
        OnChange = DBCdocChange
        OnExit = DBCdocExit
      end
      object PainelSubjetivo: TPanel
        Left = 8
        Top = 19
        Width = 256
        Height = 34
        TabOrder = 0
        object btnovoat: TSpeedButton
          Left = 2
          Top = 4
          Width = 30
          Height = 25
          Hint = 'Inclui Atividade'
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
          OnClick = btnovoatClick
        end
        object btaltat: TSpeedButton
          Left = 32
          Top = 4
          Width = 30
          Height = 25
          Hint = 'Altera Atividade'
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
          OnClick = btaltatClick
        end
        object btgravat: TSpeedButton
          Left = 62
          Top = 4
          Width = 30
          Height = 25
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
          OnClick = btgravatClick
        end
        object btcanat: TSpeedButton
          Left = 92
          Top = 4
          Width = 30
          Height = 25
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
          OnClick = btcanatClick
        end
        object btdelat: TSpeedButton
          Left = 122
          Top = 4
          Width = 30
          Height = 25
          Hint = 'Exclui Atividade'
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
          OnClick = btdelatClick
        end
        object DBNavat: TDBNavigator
          Left = 152
          Top = 4
          Width = 84
          Height = 25
          Hint = 'Navega'
          DataSource = dsrdpf
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          Flat = True
          TabOrder = 0
        end
        object MonthCalendar1: TMonthCalendar
          Left = 256
          Top = 0
          Width = 191
          Height = 155
          Date = 40869.5727476389
          TabOrder = 1
        end
      end
      object DBCfiscal: TDBComboBox
        Left = 274
        Top = 32
        Width = 295
        Height = 21
        Hint = 'Fiscal Selecionado'
        AutoDropDown = True
        CharCase = ecUpperCase
        DataField = 'Nome'
        DataSource = dsrdpf
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
        ReadOnly = True
        TabOrder = 1
        TabStop = False
        OnChange = DBCfiscalChange
      end
      object DBEdata: TDBEdit
        Left = 574
        Top = 32
        Width = 90
        Height = 21
        Hint = 'Data selecionada'
        DataField = 'Data'
        DataSource = dsrdpf
        TabOrder = 2
        OnExit = DBEdataExit
      end
      object DBEdit5: TDBEdit
        Left = 499
        Top = 118
        Width = 68
        Height = 21
        TabStop = False
        Color = clMoneyGreen
        DataField = 'Prazo'
        DataSource = dsrdpf
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
      end
      object DBEOs: TDBEdit
        Left = 574
        Top = 78
        Width = 90
        Height = 21
        Hint = 'Data selecionada'
        DataField = 'OS'
        DataSource = dsrdpf
        TabOrder = 5
        OnExit = DBEdataExit
      end
      object DBCOrigem: TDBComboBox
        Left = 416
        Top = 77
        Width = 153
        Height = 21
        Hint = 'Selecione uma op'#231#227'o '
        CharCase = ecUpperCase
        DataField = 'TIPOOS'
        DataSource = dsrdpf
        ItemHeight = 13
        Items.Strings = (
          'DE OF'#205'CIO')
        ReadOnly = True
        Sorted = True
        TabOrder = 4
        TabStop = False
        OnChange = DBCdocChange
      end
      object DBEdtos: TDBEdit
        Left = 416
        Top = 118
        Width = 68
        Height = 21
        Hint = 'Data selecionada'
        TabStop = False
        Color = clMoneyGreen
        DataField = 'Data_os'
        DataSource = dsrdpf
        ReadOnly = True
        TabOrder = 7
        OnExit = DBEdataExit
      end
      object DBEdit6: TDBEdit
        Left = 574
        Top = 118
        Width = 90
        Height = 21
        Hint = 'Data selecionada'
        TabStop = False
        Color = clSkyBlue
        DataField = 'Comply'
        DataSource = dsrdpf
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        OnExit = DBEdataExit
      end
    end
    object DBGraderdpf: TDBGrid
      Left = 8
      Top = 216
      Width = 672
      Height = 150
      DataSource = dsrdpf
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Mod'
          Title.Caption = 'C'#243'd'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Data'
          Title.Caption = 'Dt. Atividade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OS'
          Title.Caption = 'N'#186' OS'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Prazo'
          Title.Caption = 'Prazo OS'
          Width = 62
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Estabe'
          Title.Caption = 'Contribuinte/Atividade'
          Width = 194
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Cnae'
          Title.Caption = 'CNAE'
          Width = 56
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Complex'
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Comply'
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Homologado'
          Title.Caption = 'Fecha'
          Visible = True
        end>
    end
    object DTPFinal: TDateTimePicker
      Left = 521
      Top = 35
      Width = 159
      Height = 21
      Hint = 'Selecione a Data final para Gera'#231#227'o do Relat'#243'rio'
      CalAlignment = dtaLeft
      Date = 44562
      Time = 44562
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
  end
  object barraferra: TToolBar
    Left = 0
    Top = 0
    Width = 698
    Height = 43
    ButtonHeight = 34
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    TabOrder = 1
    object Btgera: TSpeedButton
      Left = 0
      Top = 2
      Width = 58
      Height = 34
      Hint = 
        'Contabilizar a pontua'#231#227'o das inspe'#231#245'es sanit'#225'rias do hist'#243'rico d' +
        'os contribuintes e do atendimento '#224's den'#250'ncias'
      Caption = 'Inspe'#231#245'es'
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
        333333333333333333333333333333333333333FFFFFFFFFFF33330000000000
        03333377777777777F33333003333330033333377FF333377F33333300333333
        0333333377FF33337F3333333003333303333333377FF3337333333333003333
        333333333377FF3333333333333003333333333333377FF33333333333330033
        3333333333337733333333333330033333333333333773333333333333003333
        33333333337733333F3333333003333303333333377333337F33333300333333
        03333333773333337F33333003333330033333377FFFFFF77F33330000000000
        0333337777777777733333333333333333333333333333333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = BtgeraClick
    end
    object btpend: TSpeedButton
      Left = 58
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Lista RDPF'#180's pendentes de Homologa'#231#227'o para data selecionada'
      Caption = 'Relat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333330000000
        00003333377777777777333330FFFFFFFFF03FF3F7FFFF33FFF7003000000FF0
        00F077F7777773F77737E00FBFBFB0FFFFF07773333FF7FF33F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F3333FFFF733F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F33FFFFFF733F7E0FB0000000F
        F0F077FF777777733737000FB0FFFFFFFFF07773F7F333333337333000FFFFFF
        FFF0333777F3FFF33FF7333330F000FF0000333337F777337777333330FFFFFF
        0FF0333337FFFFFF7F37333330CCCCCC0F033333377777777F73333330FFFFFF
        0033333337FFFFFF773333333000000003333333377777777333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = btpendClick
    end
    object btanota: TSpeedButton
      Left = 116
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Analisa e confere a documenta'#231#227'o  relativa a produ'#231#227'o'
      Caption = 'Apontamento'
      Enabled = False
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
        333333777777777F33333330B00000003333337F7777777F3333333000000000
        333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
        333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
        03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
        03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
        3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
        333333333377F7F33333333333330F03333333333337F7F33333333333330B03
        3333333333373733333333333333303333333333333373333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btanotaClick
    end
    object btconfere: TSpeedButton
      Left = 174
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Analisa e confere a documenta'#231#227'o  relativa a produ'#231#227'o'
      Caption = 'Confer'#235'ncia'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btconfereClick
    end
    object Bthomologa: TSpeedButton
      Left = 232
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Homologa a produ'#231#227'o fiscal'
      Caption = 'Fechamento'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000003
        333333333F777773FF333333008888800333333377333F3773F3333077870787
        7033333733337F33373F3308888707888803337F33337F33337F330777880887
        7703337F33337FF3337F3308888000888803337F333777F3337F330777700077
        7703337F33377733337F33088888888888033373FFFFFFFFFF73333000000000
        00333337777777777733333308033308033333337F7F337F7F33333308033308
        033333337F7F337F7F33333308033308033333337F73FF737F33333377800087
        7333333373F77733733333333088888033333333373FFFF73333333333000003
        3333333333777773333333333333333333333333333333333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = BthomologaClick
    end
    object Btimprime: TSpeedButton
      Left = 290
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Emite o Relat'#243'rio Di'#225'rio de Produ'#231#227'o Fiscal'
      Caption = 'Anal'#237'tico'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        003337777777777777F330FFFFFFFFFFF03337F3333FFF3337F330FFFF000FFF
        F03337F33377733337F330FFFFF0FFFFF03337F33337F33337F330FFFF00FFFF
        F03337F33377F33337F330FFFFF0FFFFF03337F33337333337F330FFFFFFFFFF
        F03337FFF3F3F3F3F7F33000F0F0F0F0F0333777F7F7F7F7F7F330F0F000F070
        F03337F7F777F777F7F330F0F0F0F070F03337F7F7373777F7F330F0FF0FF0F0
        F03337F733733737F7F330FFFFFFFF00003337F33333337777F330FFFFFFFF0F
        F03337FFFFFFFF7F373330999999990F033337777777777F733330FFFFFFFF00
        333337FFFFFFFF77333330000000000333333777777777733333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = BtimprimeClick
    end
    object Btcontrole: TSpeedButton
      Left = 348
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Sair do M'#243'dulo'
      Caption = 'RH'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = BtcontroleClick
    end
    object btmes: TSpeedButton
      Left = 406
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Emite o Relat'#243'rio Mensal de Produtividade Fiscal'
      Caption = 'Sint'#233'tico'
      Enabled = False
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
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btmesClick
    end
    object btconsolida: TSpeedButton
      Left = 464
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Relat'#243'rio Mensal da Produ'#231#227'o Fiscal'
      Caption = 'Geral'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555FFFFF555555555544C4C5555555555F777775FF5555554C444C444
        5555555775FF55775F55554C4334444445555575577F55557FF554C4C334C4C4
        335557F5577FF55577F554CCC3334444335557555777F555775FCCCCC333CCC4
        C4457F55F777F555557F4CC33333CCC444C57F577777F5F5557FC4333333C3C4
        CCC57F777777F7FF557F4CC33333333C4C457F577777777F557FCCC33CC4333C
        C4C575F7755F777FF5755CCCCC3333334C5557F5FF777777F7F554C333333333
        CC55575777777777F755553333CC3C33C555557777557577755555533CC4C4CC
        5555555775FFFF77555555555C4CCC5555555555577777555555}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btconsolidaClick
    end
    object Btold: TSpeedButton
      Left = 522
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Emite o Relat'#243'rio dos meses fechados'
      Caption = 'Arquivo'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00550000000005
        555555777777777FF5555500000000805555557777777777FF555550BBBBB008
        05555557F5FFF7777FF55550B000B030805555F7F777F7F777F550000000B033
        005557777777F7F5775550BBBBB00033055557F5FFF777F57F5550B000B08033
        055557F77757F7F57F5550BBBBB08033055557F55557F7F57F5550BBBBB00033
        055557FFFFF777F57F5550000000703305555777777757F57F555550FFF77033
        05555557FFFFF7FF7F55550000000003055555777777777F7F55550777777700
        05555575FF5555777F55555003B3B3B00555555775FF55577FF55555500B3B3B
        005555555775FFFF77F555555570000000555555555777777755}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = BtoldClick
    end
    object bthelp: TSpeedButton
      Left = 580
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Ajuda'
      Caption = 'Ajuda'
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
    object Btsai: TSpeedButton
      Left = 638
      Top = 2
      Width = 58
      Height = 34
      Hint = 'Sair do M'#243'dulo'
      Caption = 'Sair'
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
      ParentShowHint = False
      ShowHint = True
      OnClick = BtsaiClick
    end
  end
  object tbrdpf: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorData'
    TableName = 'RDPF.DB'
    Left = 424
    Top = 384
    object tbrdpfControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbrdpfTipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
    object tbrdpfNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object tbrdpfData: TDateField
      FieldName = 'Data'
      EditMask = '!99/99/0000;1;_'
    end
    object tbrdpfEstabe: TStringField
      FieldName = 'Estabe'
      Size = 60
    end
    object tbrdpfPonto: TFloatField
      FieldName = 'Ponto'
    end
    object tbrdpfComplex: TStringField
      FieldName = 'Complex'
      Size = 5
    end
    object tbrdpfMod: TStringField
      FieldName = 'Mod'
      Size = 3
    end
    object tbrdpfHomologado: TStringField
      FieldName = 'Homologado'
      Size = 3
    end
    object tbrdpfCnae: TStringField
      FieldName = 'Cnae'
      Size = 9
    end
    object tbrdpfDoc: TStringField
      FieldName = 'Doc'
      Size = 80
    end
    object tbrdpfAcao: TStringField
      FieldName = 'Acao'
      Size = 35
    end
    object tbrdpfUsuario: TStringField
      FieldName = 'Usuario'
      Size = 60
    end
    object tbrdpfData_altera: TDateField
      FieldName = 'Data_altera'
    end
    object tbrdpfEntrega: TBooleanField
      FieldName = 'Entrega'
    end
    object tbrdpfFecha: TBooleanField
      FieldName = 'Fecha'
    end
    object tbrdpfData_fecha: TDateField
      FieldName = 'Data_fecha'
    end
    object tbrdpfUsr_fecha: TStringField
      FieldName = 'Usr_fecha'
      Size = 60
    end
    object tbrdpfUser_homoloda: TStringField
      FieldName = 'User_homoloda'
      Size = 60
    end
    object tbrdpfData_homologa: TDateField
      FieldName = 'Data_homologa'
    end
    object tbrdpfOS: TIntegerField
      FieldName = 'OS'
    end
    object tbrdpfTIPOOS: TStringField
      FieldName = 'TIPOOS'
      Size = 30
    end
    object tbrdpfArea: TStringField
      FieldName = 'Area'
      Size = 7
    end
    object tbrdpfDupla: TBooleanField
      FieldName = 'Dupla'
    end
    object tbrdpfData_os: TDateField
      FieldName = 'Data_os'
    end
    object tbrdpfNdoc: TStringField
      FieldName = 'Ndoc'
      Size = 6
    end
    object tbrdpfMotivo: TStringField
      FieldName = 'Motivo'
      Size = 10
    end
    object tbrdpfPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tbrdpfNegativo: TFloatField
      FieldName = 'Negativo'
    end
    object tbrdpfMeio: TStringField
      FieldName = 'Meio'
      Size = 7
    end
    object tbrdpfComply: TStringField
      FieldName = 'Comply'
      Size = 12
    end
  end
  object tbcontrib: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dsvisitas
    TableName = 'CONTRIB.DB'
    Left = 328
    Top = 408
    object tbcontribCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcontribRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
    object tbcontribATIVIDADE: TIntegerField
      FieldName = 'ATIVIDADE'
    end
  end
  object dsrdpf: TDataSource
    AutoEdit = False
    DataSet = tbrdpf
    OnStateChange = dsrdpfStateChange
    Left = 416
    Top = 400
  end
  object dsvisitas: TDataSource
    AutoEdit = False
    DataSet = tbvisitas
    Left = 256
    Top = 400
  end
  object dscontrib: TDataSource
    DataSet = tbcontrib
    Left = 336
    Top = 400
  end
  object tbvisitas: TTable
    DatabaseName = 'wcvs'
    IndexName = 'Porvisitacodigo'
    TableName = 'VISITAS.DB'
    Left = 248
    Top = 400
    object tbvisitasCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbvisitasCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbvisitasDT_VISITA: TDateField
      FieldName = 'DT_VISITA'
    end
    object tbvisitasACAO: TStringField
      FieldName = 'ACAO'
      Size = 35
    end
    object tbvisitasTIPO: TStringField
      FieldName = 'TIPO'
      Size = 35
    end
    object tbvisitasDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbvisitasNDOC: TIntegerField
      FieldName = 'NDOC'
    end
    object tbvisitasFiscal1: TStringField
      FieldName = 'Fiscal1'
      Size = 40
    end
    object tbvisitasFiscal2: TStringField
      FieldName = 'Fiscal2'
      Size = 40
    end
    object tbvisitasFiscal3: TStringField
      FieldName = 'Fiscal3'
      Size = 40
    end
    object tbvisitasAtividade: TStringField
      FieldName = 'Atividade'
      Size = 9
    end
    object tbvisitasOS: TIntegerField
      FieldName = 'OS'
    end
    object tbvisitasGr_inclu: TStringField
      FieldName = 'Gr_inclu'
      Size = 3
    end
    object tbvisitasArea: TStringField
      FieldName = 'Area'
      Size = 7
    end
    object tbvisitasModalidade: TStringField
      FieldName = 'Modalidade'
      Size = 30
    end
    object tbvisitasProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbvisitasOficio: TIntegerField
      FieldName = 'Oficio'
    end
    object tbvisitasNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 6
    end
    object tbvisitasMeio: TStringField
      FieldName = 'Meio'
      Size = 7
    end
  end
  object tbauxcontrib: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCPF'
    TableName = 'CONTRIB.DB'
    Left = 288
    Top = 400
    object tbauxcontribCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbauxcontribCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbauxcontribPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 4
    end
    object tbauxcontribCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object tbauxcontribCGC: TStringField
      FieldName = 'CGC'
      Size = 18
    end
    object tbauxcontribRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
  end
  object dsauxcontrib: TDataSource
    AutoEdit = False
    DataSet = tbauxcontrib
    Left = 296
    Top = 400
  end
  object tbrmpf: TTable
    DatabaseName = 'wcvs'
    TableName = 'rmpf.db'
    Left = 472
    Top = 400
    object tbrmpfControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbrmpfNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object tbrmpfData: TDateField
      FieldName = 'Data'
    end
    object tbrmpfHomologado: TStringField
      FieldName = 'Homologado'
      Size = 3
    end
    object tbrmpfPonto: TFloatField
      FieldName = 'Ponto'
    end
    object tbrmpfMes: TSmallintField
      FieldName = 'Mes'
    end
    object tbrmpfAno: TSmallintField
      FieldName = 'Ano'
    end
    object tbrmpfNegativo: TFloatField
      FieldName = 'Negativo'
    end
  end
  object dsrmpf: TDataSource
    AutoEdit = False
    DataSet = tbrmpf
    Left = 456
    Top = 400
  end
  object tbrcon: TTable
    DatabaseName = 'wcvs'
    TableName = 'tbcon.db'
    Left = 504
    Top = 384
    object tbrconControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbrconNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object tbrconPonto: TFloatField
      FieldName = 'Ponto'
    end
    object tbrconMes: TSmallintField
      FieldName = 'Mes'
    end
    object tbrconAno: TSmallintField
      FieldName = 'Ano'
    end
    object tbrconNegativo: TFloatField
      FieldName = 'Negativo'
    end
  end
  object dsrcon: TDataSource
    AutoEdit = False
    DataSet = tbrcon
    Left = 496
    Top = 400
  end
  object tbauxrdpf: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    TableName = 'RDPF.DB'
    Left = 376
    Top = 408
    object tbauxrdpfControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbauxrdpfTipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
    object tbauxrdpfNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object tbauxrdpfData: TDateField
      FieldName = 'Data'
    end
    object tbauxrdpfEstabe: TStringField
      FieldName = 'Estabe'
      Size = 60
    end
    object tbauxrdpfMod: TStringField
      FieldName = 'Mod'
      Size = 3
    end
    object tbauxrdpfComplex: TStringField
      FieldName = 'Complex'
      Size = 5
    end
    object tbauxrdpfPonto: TFloatField
      FieldName = 'Ponto'
    end
    object tbauxrdpfHomologado: TStringField
      FieldName = 'Homologado'
      Size = 3
    end
    object tbauxrdpfDoc: TStringField
      FieldName = 'Doc'
      Size = 80
    end
    object tbauxrdpfCnae: TStringField
      FieldName = 'Cnae'
      Size = 9
    end
    object tbauxrdpfOS: TIntegerField
      FieldName = 'OS'
    end
    object tbauxrdpfTIPOOS: TStringField
      FieldName = 'TIPOOS'
      Size = 30
    end
  end
  object dsauxrdpf: TDataSource
    DataSet = tbauxrdpf
    Left = 376
    Top = 400
  end
  object tbcnae: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorSubclasse'
    MasterFields = 'ATIVIDADE'
    MasterSource = dsvisitas
    TableName = 'cnae.DB'
    Left = 208
    Top = 400
    object tbcnaeSubclasse: TStringField
      FieldName = 'Subclasse'
      Size = 9
    end
    object tbcnaeClasse: TStringField
      FieldName = 'Classe'
      Size = 7
    end
    object tbcnaeAtividade: TStringField
      FieldName = 'Atividade'
      Size = 254
    end
    object tbcnaeEquipe: TStringField
      FieldName = 'Equipe'
      Size = 2
    end
    object tbcnaeComplexidade: TStringField
      FieldName = 'Complexidade'
      Size = 5
    end
  end
  object tbos: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorOS'
    MasterFields = 'OS'
    MasterSource = dsvisitas
    TableName = 'requerimento.DB'
    Left = 160
    Top = 400
    object tbosCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbosOS: TIntegerField
      FieldName = 'OS'
    end
    object tbosDt_encaminha: TDateField
      FieldName = 'Dt_encaminha'
    end
    object tbosPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tbosMotivo: TStringField
      FieldName = 'Motivo'
      Size = 25
    end
  end
  object tbden: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorDenuncia'
    MasterFields = 'Denuncia'
    MasterSource = dsvisitas
    TableName = 'denuncia.DB'
    Left = 128
    Top = 400
    object tbdenDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbdenPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tbdenDtEncaminha: TDateField
      FieldName = 'DtEncaminha'
    end
  end
  object tboficio: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorOficio'
    MasterFields = 'Oficio'
    MasterSource = dsvisitas
    TableName = 'oficio.DB'
    Left = 96
    Top = 400
    object tboficioOficio: TIntegerField
      FieldName = 'Oficio'
    end
    object tboficioDtencaminha: TDateField
      FieldName = 'Dtencaminha'
    end
    object tboficioPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tboficioOrdem: TStringField
      FieldName = 'Ordem'
      Size = 120
    end
  end
  object tbtramita: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorPtDt'
    TableName = 'tramitacao.DB'
    Left = 56
    Top = 400
    object tbtramitaProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbtramitaData: TDateField
      FieldName = 'Data'
    end
    object tbtramitaDestino: TStringField
      FieldName = 'Destino'
      Size = 40
    end
    object tbtramitaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 40
    end
  end
  object tbauxoficio: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorOficio'
    TableName = 'oficio.DB'
    Left = 104
    Top = 376
    object tbauxoficioDtencaminha: TDateField
      FieldName = 'Dtencaminha'
    end
    object tbauxoficioPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tbauxoficioOficio: TIntegerField
      FieldName = 'Oficio'
    end
    object tbauxoficioFiscalencaminha: TStringField
      FieldName = 'Fiscalencaminha'
      Size = 60
    end
    object tbauxoficioDtatendimento: TDateField
      FieldName = 'Dtatendimento'
    end
    object tbauxoficioArchive: TBooleanField
      FieldName = 'Archive'
    end
    object tbauxoficioCancela: TBooleanField
      FieldName = 'Cancela'
    end
    object tbauxoficioMotivo: TStringField
      FieldName = 'Motivo'
      Size = 25
    end
  end
  object tbplanta: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigoProtocolo'
    TableName = 'planta.DB'
    Left = 64
    Top = 392
    object tbplantaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbplantaProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbplantaCarga: TStringField
      FieldName = 'Carga'
      Size = 40
    end
  end
  object tbauxden: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorDenuncia'
    TableName = 'denuncia.DB'
    Left = 144
    Top = 408
    object tbauxdenDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbauxdenFiscalEncaminha: TStringField
      FieldName = 'FiscalEncaminha'
      Size = 60
    end
  end
  object tbauxos: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigoOS'
    TableName = 'requerimento.DB'
    Left = 160
    Top = 360
    object tbauxosCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbauxosOS: TIntegerField
      FieldName = 'OS'
    end
    object tbauxosFiscal_Encaminha: TStringField
      FieldName = 'Fiscal_Encaminha'
      Size = 60
    end
  end
end
