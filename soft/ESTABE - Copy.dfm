object frmestabe: Tfrmestabe
  Left = 380
  Top = 190
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Ficha Sanit'#225'ria do Regulado'
  ClientHeight = 633
  ClientWidth = 783
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label122: TLabel
    Left = 337
    Top = 11
    Width = 93
    Height = 13
    Caption = 'Autoridade Sanit'#225'ra'
  end
  object Label123: TLabel
    Left = 345
    Top = 19
    Width = 93
    Height = 13
    Caption = 'Autoridade Sanit'#225'ra'
  end
  object Label129: TLabel
    Left = 157
    Top = 15
    Width = 105
    Height = 13
    Caption = 'A'#231#227'o Fiscal Realizada'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 609
    Width = 783
    Height = 24
    Panels = <
      item
        Text = '  '
        Width = 50
      end>
    SimplePanel = False
  end
  object barraferra: TToolBar
    Left = 0
    Top = 0
    Width = 783
    Height = 39
    ButtonHeight = 31
    Color = clBtnFace
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    Indent = 5
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    object btnovo: TSpeedButton
      Left = 5
      Top = 2
      Width = 45
      Height = 31
      Hint = 'Inclui Contribuinte'
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
      Left = 50
      Top = 2
      Width = 45
      Height = 31
      Hint = 'Altera Contribuinte'
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
      Left = 95
      Top = 2
      Width = 45
      Height = 31
      Hint = 'Localiza Contribuinte'
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
      Left = 140
      Top = 2
      Width = 45
      Height = 31
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
      Left = 185
      Top = 2
      Width = 45
      Height = 31
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
      Left = 230
      Top = 2
      Width = 45
      Height = 31
      Hint = 'Exclui Contribuinte'
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
      Visible = False
      OnClick = btdeletaClick
    end
    object btprn: TSpeedButton
      Left = 275
      Top = 2
      Width = 45
      Height = 31
      Hint = 'Impress'#227'o do Cadastro'
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
      Left = 320
      Top = 2
      Width = 45
      Height = 31
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
    object bthelp: TSpeedButton
      Left = 365
      Top = 2
      Width = 45
      Height = 31
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
    object TextoATV: TStaticText
      Left = 410
      Top = 2
      Width = 159
      Height = 31
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Caption = 'Desativado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object Texto_horario2: TStaticText
      Left = 569
      Top = 2
      Width = 128
      Height = 31
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Caption = 'Noturno'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
    end
  end
  object Panel1: TPanel
    Left = 3
    Top = 38
    Width = 771
    Height = 52
    Caption = 'Panel1'
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 10
      Width = 45
      Height = 13
      Caption = 'Matr'#237'cula'
      FocusControl = DBEcodigo
    end
    object Label1: TLabel
      Left = 93
      Top = 10
      Width = 63
      Height = 13
      Caption = 'Raz'#227'o Social'
    end
    object DBEcodigo: TDBEdit
      Left = 8
      Top = 12
      Width = 70
      Height = 24
      Color = clMoneyGreen
      DataField = 'CODIGO'
      DataSource = dscontrib
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit84: TDBEdit
      Left = 545
      Top = 12
      Width = 73
      Height = 24
      Color = clInfoBk
      DataField = 'MUNICIPAL'
      DataSource = dscontrib
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object DBErazao: TDBEdit
      Left = 85
      Top = 12
      Width = 452
      Height = 24
      CharCase = ecUpperCase
      DataField = 'RAZAO'
      DataSource = dscontrib
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 5
    Top = 92
    Width = 771
    Height = 517
    Hint = 'Protocolo Interno da Vigil'#226'ncia Sanit'#225'ria'
    ActivePage = Tabident
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Style = tsFlatButtons
    TabIndex = 0
    TabOrder = 1
    OnChange = PageControl1Change
    object Tabident: TTabSheet
      Caption = 'Cadastro'
      object anvisa: TImage
        Left = 641
        Top = 8
        Width = 117
        Height = 99
        Cursor = crHandPoint
        AutoSize = True
        IncrementalDisplay = True
        Picture.Data = {
          0A544A504547496D616765A70B0000FFD8FFE000104A46494600010101006000
          600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C191213
          0F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F2739
          3D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232
          3232323232323232323232323232323232323232323232323232323232323232
          32323232323232323232323232FFC00011080063007503012200021101031101
          FFC4001F0000010501010101010100000000000000000102030405060708090A
          0BFFC400B5100002010303020403050504040000017D01020300041105122131
          410613516107227114328191A1082342B1C11552D1F02433627282090A161718
          191A25262728292A3435363738393A434445464748494A535455565758595A63
          6465666768696A737475767778797A838485868788898A92939495969798999A
          A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
          D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
          01010101010101010000000000000102030405060708090A0BFFC400B5110002
          0102040403040705040400010277000102031104052131061241510761711322
          328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
          292A35363738393A434445464748494A535455565758595A636465666768696A
          737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
          A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
          E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F5BC
          518A5A0027A0AEA3904C5263240A9044C69EB036EA571D98A9122C65E475441D
          598E00A90C08E9BA37575F5539A8758B7F37C3B7D16324C2C47E0335C6FC3D9F
          6EAB756E4FCB243B80F707FF00AF5C95310E15630B6E7356C57B2C442838E92E
          A75AC9B5A9319381566E530DD299026E619AEBBE874DB519E5363BD3082BD6AB
          6B5E268341BE8ADAE2CDE48E440C24461EB83C1AD69E35640E9F758645671AD1
          949C56E888CE1394A317AC772952E28031C52D6A5098A314B45003A31D68A58F
          BD152F7296C2C71173D2AD88A3857748C00F7A1992D603230E7B0F535CA78C2E
          B53B3B5B59603207958EE2899D80741ED5E5E371F3A72F65463CD2DDF64BBBFD
          1752AA3850A2EB54D976DDFA1D47DB21E91C6EFF004141BDDBD6DA41F85797C7
          E36D7AD405377903B4912FF855B8BE24EAC9FEB21B497FE0247F235E72AB8996
          B2AF67E5056FC5B670433EC13DE0D7F5E47A0CB7F0C913C6D1B80EA54E7DC571
          3E1AD26FB48F11433CE8BF67C3233AB8200238E3AF5C52C7F12F7F173A4C6C3B
          EC97FC45645A78AEEDF5750CF9B49A7C6C70094527A023D335CB889E3E328CE9
          D48CEDDD72935B1B95D7A94E72E64D3D2DFADD7E47AB111CE328EADF434C4B7D
          AD5465D3E784EE8CEF03BAF5A48B509E2386F9C0ECDD6B58F114A84FD9E3A938
          3EFBAFEBD2E7BEF08A4AF4DDCC2F88B69BF4EB4BB0398A4284FB30FF00115B5E
          1DBAFB7F862CA5272CB1F96DF55E3FA545E23316A9E19BE893FD6AC7E62A9EB9
          5E7FA563FC35BCF3AC2F6C89C989C48A3D9860FEA2BD4A188A552BAA94A49C64
          BA791E0CA12A19959AB73C7F15FF000C744E30C692AFC96B939A8CDA9F4AF554
          91DEE0CA98A31523C25698055264D87463AD14E8C75A2A5BD4A459961F3E685C
          B0D89C91EA6A669C2D52F3180A69249EB5853C3429CE538EF2777F758D2551B4
          9762D3B4128C490C6E3FDA506AA4BA468D719F374CB46CF7F2852FE340CE7AD6
          8E9C5EE8C9A8CBE24994E4F07F8726EBA6C6BFEE332FF2354E4F87FE1F2C1A35
          B9888391B66271F9D74510F90B1E8064D3D9772865390464560E8D172E5695C8
          784A1257705F712230C05049C0EA6A29ECA3B91964C37F7875A46736F6D2CDB4
          B7968CDB477C0CE2BE6497C43AF788AFE6D4E6D66F229D98B22453B22C63B2A8
          071815D31CBA38E8BA7349AF334A9895874A4F43E82BEB496D54965DF19E370F
          EB5C04FE19D53FB45DB4167C11BB624DB197DBA8C8ABDF0BBC7F77AE5CCDE1ED
          724135F4519920B82066641D437FB43AE7B8FA577179A4FD9A75BEB1C868CEE6
          8BD477C7F857CB56C8E796D7F6941B70EB1EB6EEBBDBEF37AD1A398524AAEEB6
          68F3A11FC42B1FBA353C0F46F307F5A7AF8B3C6D65C4F0CE40FF009ED67FD40A
          F59F3418D5C7461914CFB4FBD7B4B0CED78CD9E53CBE50F82AC97CCC8F0F6AAF
          AE68115DDC204B904A4AA14A80C3DBE98AB2461AACC93647155CF5CD77534E31
          B33B526A293777DC7463AD14B1F7A29BDC690DC64E2A78EDCB0E94C41F3D6278
          E6E66B4F0FC72DBCD244DE7A82C8C54E307D2A2AD4F67172EC675AA2A34A551A
          BD8E8BECBED47D9B9AF1A5F116AABD353BA1FF006D4D4CBE2AD657A6A973FF00
          7DE6BCFF00ED28F63C859F51EB07F81EC8A815707BD66C574D672B4320DC8A7F
          115E669E2FD717A6A729FAE0FF004AD1D27C593CD79E5EA73EF57E165200DA7D
          F1DABC8CDB1352518D7C2DD4E1F8A7BAFC8EFC167B85A951529A694BABB5AFF7
          9E9B1C91CA9B9086535F3CF8EFE1A6BBE1FD5AE6FF0040B496FB499DCC823806
          E9202792A547247A115ECF1CEF0B6F8DF1FC8D69DBEAB13E1653E5BFAF635D39
          3F14D2A8D46A7B93FC1FCFA7CCF671181BADAE8F0EF841E11D7A4F18C7AFEA16
          37165676B1B8067428656618C0079C73926BDFB773C0A76770CE720F7ACDD72F
          67D3345B9BDB58D249615DDB5F38233CF4F6AFA0AD5B9DB9C8E47CB4A0DF445C
          7425700607A0AAE6139AE047C4DBF1F7B4FB53F46614F1F14A71F7B4A84FD253
          FE15C71C751D933CFF00ED5C24BED7E0CEF5602695A01838C1C75AE0FF00E16B
          01F7B48FCA7FFEB5755E1BD4BFB66CE7D4044D0ACCC1846C738E3D68FAEC2552
          308EB7FF0026CEBC3E228622FECE57B7A9755704D15263E634576336433A1A94
          88A68FCB9A24913AED75047EB4CC518F7A6D5C910D869A7AD85AFF00DF95FF00
          0A69D2F4A3D74EB43FF6C57FC29F83EB460FAD47B38F6172C3F957DC45FD8DA3
          B75D32D3FEFC8AC7F15E85A6C7E18BE9ADAC2DE296340E1D23008C119FD2B786
          411CD335487ED5A15F41D77C0EBFF8E9ACAAD28F2B4919D5A14E74E51E55B3E8
          79A783352BABFD43FB25E6054C6CD117E7691DB3E98AE9AF20BDB227CF8582FF
          007D795FCEBCF3C1D746D7C65A639380D2F967FE0408FEB5EEECC00C1AF9C791
          61B171725EECBCBFC859263AAFD5F964EF67F81C45AEB13DB1FDD4BF2FF74F22
          B5CEB505FD94D6B73115F3636425791C8C568CFA569B744B4B6A9B8FF12FCA7F
          4AA87C33644E639664F6DC0D453CB734C1AE5A15138F67FE4F6F933D7955A155
          5A68F3BD034354D7521D66CB759BAB2EF2D85071C1C83EDFAD764DE16F06E326
          1B703FEBE1BFC6B8FF0012EAF71A1F8865D3DA357B742A439CEE284024FD7AD7
          7D0F8574B64590B4D2AB00C097C020FD2B7C1FD7ECE12A71BAF3FF00873C7C2E
          132E8F35387BD67D52BFE47357FA0784D985BE9DA7BDCDD3F081257DA0FBF35D
          8691A6268FA72C0092ED82FCE541C6381D854F6B6565A7A916B02464F561D4FE
          34E790B1AF5B0D849C67ED6ADB9BA5B65FD773AB9295356A51B0D072C68A541D
          68AF41890628C53B14629886E28C53B1462801B8A9E301D0A9E8462A122A686A
          65B0D1F3F1CE9DAF2B7436F740FF00DF2DFF00D6AFA05C8740C3A11915E1DE2F
          B616FE26D4631C7EF9987E3CFF005AF65D1EE3ED9E1FD3EE01CF996E873EF815
          E7609DA5289E2E50F967529F625E735246E734DC726950106BD267B48F33F8B1
          641350B1BD03896231B1F75391FA1AED7C197FFDA3E0FD3E6272E91F94DF55E3
          FA0AA9F103469F58F0E2ADA40D35CC332BAA20E483C1FE7FA556F875A7EA9A5E
          977767A8D9CB6EBE689222F8E72391FA7EB5C314E3887A68CF3E9C254F1D2B2D
          248EA1B25A8C548E9934C2A4577267A0D0AA3AD14A9DE8A4C10B45145300A69E
          B451400A05491F5A28A4C11149A3E9B71334F3585B49337DE778C127F3AB091C
          7146238D15114615546001F4A28A8492D8AE58A77484C0F4A5007A5145318FA2
          8A2801303D298E063A5145081910EA68A28AA251FFD9}
        OnClick = anvisaClick
      end
      object Bevel7: TBevel
        Left = 640
        Top = 120
        Width = 117
        Height = 74
      end
      object Bevel8: TBevel
        Left = 640
        Top = 200
        Width = 117
        Height = 81
      end
      object DBUser: TDBText
        Left = 646
        Top = 228
        Width = 103
        Height = 18
        DataField = 'User'
        DataSource = dscontrib
      end
      object DBDt_alter: TDBText
        Left = 646
        Top = 246
        Width = 65
        Height = 17
        DataField = 'Dt_alter'
        DataSource = dscontrib
      end
      object DBTH_alter: TDBText
        Left = 646
        Top = 264
        Width = 65
        Height = 15
        DataField = 'H_alter'
        DataSource = dscontrib
      end
      object LbTimestamp: TLabel
        Left = 640
        Top = 382
        Width = 117
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '(n'#227'o gerado)'
      end
      object GroupBox2: TGroupBox
        Left = 2
        Top = 3
        Width = 635
        Height = 392
        Caption = 'Estabelecimento'
        TabOrder = 0
        object Bevel6: TBevel
          Left = 303
          Top = 121
          Width = 30
          Height = 21
        end
        object Bevel5: TBevel
          Left = 532
          Top = 213
          Width = 94
          Height = 21
        end
        object Label5: TLabel
          Left = 13
          Top = 16
          Width = 48
          Height = 15
          Caption = 'Fantasia'
        end
        object Label4: TLabel
          Left = 13
          Top = 61
          Width = 64
          Height = 15
          Caption = 'Logradouro'
        end
        object Label6: TLabel
          Left = 351
          Top = 61
          Width = 79
          Height = 15
          Caption = 'Complemento'
        end
        object Label14: TLabel
          Left = 550
          Top = 106
          Width = 47
          Height = 15
          Caption = 'Telefone'
        end
        object Label13: TLabel
          Left = 550
          Top = 61
          Width = 25
          Height = 15
          Caption = 'CEP'
        end
        object Label11: TLabel
          Left = 304
          Top = 106
          Width = 29
          Height = 15
          Caption = 'Setor'
        end
        object Label12: TLabel
          Left = 550
          Top = 16
          Width = 78
          Height = 15
          Caption = 'Insc Municipal'
        end
        object Label3: TLabel
          Left = 404
          Top = 16
          Width = 59
          Height = 15
          Caption = 'CPF/CNPJ'
        end
        object Label16: TLabel
          Left = 13
          Top = 280
          Width = 73
          Height = 15
          Caption = 'Observa'#231#245'es'
        end
        object Label52: TLabel
          Left = 351
          Top = 106
          Width = 111
          Height = 15
          Caption = 'Endere'#231'o Eletr'#244'nico'
        end
        object Label54: TLabel
          Left = 13
          Top = 106
          Width = 33
          Height = 15
          Caption = 'Bairro'
        end
        object Label59: TLabel
          Left = 532
          Top = 197
          Width = 66
          Height = 15
          Caption = 'Dt Cadastro'
        end
        object Label60: TLabel
          Left = 351
          Top = 16
          Width = 49
          Height = 15
          Caption = 'Natureza'
        end
        object DBTDt_cadastro: TDBText
          Left = 540
          Top = 216
          Width = 65
          Height = 15
          DataField = 'Dt_cadastro'
          DataSource = dscontrib
        end
        object DBTSetor: TDBText
          Left = 307
          Top = 124
          Width = 18
          Height = 15
          DataField = 'SETOR'
          DataSource = dsbairro
        end
        object Label55: TLabel
          Left = 13
          Top = 151
          Width = 116
          Height = 15
          Caption = 'Representante Legal'
        end
        object Label56: TLabel
          Left = 351
          Top = 151
          Width = 24
          Height = 15
          Caption = 'CPF'
        end
        object Label39: TLabel
          Left = 351
          Top = 243
          Width = 149
          Height = 15
          Caption = 'Per'#237'odo de Funcionamento'
        end
        object Label53: TLabel
          Left = 13
          Top = 197
          Width = 169
          Height = 15
          Caption = 'Segundo Representante Legal'
        end
        object Label7: TLabel
          Left = 532
          Top = 151
          Width = 40
          Height = 15
          Caption = 'Celular'
        end
        object Label48: TLabel
          Left = 351
          Top = 197
          Width = 24
          Height = 15
          Caption = 'CPF'
        end
        object DBEfantasia: TDBEdit
          Left = 13
          Top = 31
          Width = 320
          Height = 23
          CharCase = ecUpperCase
          DataField = 'FANTASIA'
          DataSource = dscontrib
          TabOrder = 0
        end
        object DBElogra: TDBEdit
          Left = 13
          Top = 77
          Width = 320
          Height = 23
          CharCase = ecUpperCase
          DataField = 'LOGRADOURO'
          DataSource = dscontrib
          TabOrder = 5
        end
        object DBEcomple: TDBEdit
          Left = 351
          Top = 77
          Width = 178
          Height = 23
          DataField = 'COMPLEMENT'
          DataSource = dscontrib
          TabOrder = 6
        end
        object DBEfone: TDBEdit
          Left = 550
          Top = 121
          Width = 76
          Height = 23
          DataField = 'FONE'
          DataSource = dscontrib
          TabOrder = 10
        end
        object DBEcep: TDBEdit
          Left = 550
          Top = 77
          Width = 76
          Height = 23
          DataField = 'CEP'
          DataSource = dscontrib
          TabOrder = 7
        end
        object DBmunicipal: TDBEdit
          Left = 550
          Top = 31
          Width = 73
          Height = 23
          DataField = 'MUNICIPAL'
          DataSource = dscontrib
          TabOrder = 4
        end
        object DBEcgc: TDBEdit
          Left = 408
          Top = 32
          Width = 121
          Height = 23
          DataField = 'CGC'
          DataSource = dscontrib
          TabOrder = 3
          OnExit = DBEcgcExit
          OnKeyDown = DBEcgcKeyDown
        end
        object DBMObsestabe: TDBMemo
          Left = 13
          Top = 296
          Width = 613
          Height = 77
          DataField = 'Obs'
          DataSource = dscontrib
          TabOrder = 19
          OnExit = DBMObsestabeExit
        end
        object DBCinativ: TDBCheckBox
          Left = 15
          Top = 256
          Width = 78
          Height = 18
          TabStop = False
          Caption = 'Desativado'
          DataField = 'INATIVIDADE'
          DataSource = dscontrib
          TabOrder = 16
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBEmail: TDBEdit
          Left = 351
          Top = 121
          Width = 178
          Height = 23
          DataField = 'EMAIL'
          DataSource = dscontrib
          TabOrder = 9
        end
        object DBLBairro: TDBLookupComboBox
          Left = 13
          Top = 121
          Width = 288
          Height = 23
          DataField = 'CDBAI'
          DataSource = dscontrib
          KeyField = 'CODIGO'
          ListField = 'NOME'
          ListFieldIndex = 3
          ListSource = dsbairro
          TabOrder = 8
          OnExit = DBLareaExit
        end
        object DBCPessoa: TDBComboBox
          Left = 351
          Top = 31
          Width = 50
          Height = 23
          DataField = 'PESSOA'
          DataSource = dscontrib
          ItemHeight = 15
          Items.Strings = (
            'CPF'
            'CNPJ')
          TabOrder = 1
          OnChange = DBCPessoaChange
          OnExit = DBCPessoaExit
        end
        object DBECPF: TDBEdit
          Left = 404
          Top = 31
          Width = 125
          Height = 23
          DataField = 'CPF'
          DataSource = dscontrib
          TabOrder = 2
          OnExit = DBECPFExit
          OnKeyDown = DBECPFKeyDown
        end
        object DBEdit1: TDBEdit
          Left = 13
          Top = 166
          Width = 320
          Height = 23
          CharCase = ecUpperCase
          DataField = 'REPRESENTANTE'
          DataSource = dscontrib
          TabOrder = 11
        end
        object DBEdit2: TDBEdit
          Left = 351
          Top = 166
          Width = 157
          Height = 23
          DataField = 'CPFREPRES'
          DataSource = dscontrib
          TabOrder = 12
        end
        object DBCarquivo: TDBCheckBox
          Left = 183
          Top = 256
          Width = 149
          Height = 17
          TabStop = False
          Caption = 'Pend'#234'ncia Cadastral'
          DataField = 'Pendoc'
          DataSource = dscontrib
          TabOrder = 17
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCHora: TDBComboBox
          Left = 351
          Top = 259
          Width = 157
          Height = 23
          CharCase = ecUpperCase
          DataField = 'HORARIO'
          DataSource = dscontrib
          ItemHeight = 15
          Items.Strings = (
            'COMERCIAL'
            'MATUTINO'
            'VESPERTINO'
            'NOTURNO'
            'EVENTUAL'
            'FINAIS DE SEMANA'
            '24 HORAS')
          TabOrder = 18
          OnChange = DBCCons2Change
          OnExit = DBCHoraExit
        end
        object DBEdit5: TDBEdit
          Left = 13
          Top = 213
          Width = 320
          Height = 23
          CharCase = ecUpperCase
          DataField = 'REPRESENTANTE2'
          DataSource = dscontrib
          TabOrder = 14
        end
        object DBEdit16: TDBEdit
          Left = 532
          Top = 168
          Width = 94
          Height = 23
          DataField = 'CELULAR'
          DataSource = dscontrib
          TabOrder = 13
        end
        object DBEdit19: TDBEdit
          Left = 351
          Top = 213
          Width = 157
          Height = 23
          DataField = 'CPFREPRES2'
          DataSource = dscontrib
          TabOrder = 15
        end
      end
      object StaticText1: TStaticText
        Left = 644
        Top = 126
        Width = 51
        Height = 19
        Caption = 'Usu'#225'rio:'
        TabOrder = 1
      end
      object STuser: TStaticText
        Left = 646
        Top = 150
        Width = 44
        Height = 19
        Caption = 'STuser'
        TabOrder = 2
      end
      object Stdata: TStaticText
        Left = 646
        Top = 174
        Width = 39
        Height = 19
        Caption = 'Stdata'
        TabOrder = 3
      end
      object Sthora: TStaticText
        Left = 702
        Top = 174
        Width = 39
        Height = 19
        Caption = 'Sthota'
        TabOrder = 4
      end
      object StaticText2: TStaticText
        Left = 644
        Top = 208
        Width = 97
        Height = 19
        Caption = #218'ltima Altera'#231#227'o:'
        TabOrder = 5
      end
      object BtAPI: TButton
        Left = 640
        Top = 298
        Width = 117
        Height = 30
        Caption = 'Exporta APP VISA'
        Enabled = False
        TabOrder = 6
        OnClick = BtAPIClick
      end
      object Btimporta: TButton
        Left = 640
        Top = 346
        Width = 117
        Height = 30
        Caption = 'Importa SIM'
        Enabled = False
        TabOrder = 7
        OnClick = BtimportaClick
      end
    end
    object TabCarac: TTabSheet
      Caption = 'CNAEs'
      ImageIndex = 1
      OnShow = TabCaracShow
      object GroupBox6: TGroupBox
        Left = 2
        Top = 3
        Width = 754
        Height = 240
        Caption = 'Cadastro de Atividades Econ'#244'micas '
        TabOrder = 0
        object Label50: TLabel
          Left = 243
          Top = 56
          Width = 62
          Height = 15
          Caption = 'Subclasse '
        end
        object Label61: TLabel
          Left = 243
          Top = 109
          Width = 250
          Height = 15
          Caption = 'Cadastro Nacional de Atividades Econ'#244'micas'
        end
        object Label31: TLabel
          Left = 344
          Top = 56
          Width = 114
          Height = 15
          Caption = 'Principal/Secund'#225'ria'
        end
        object Label166: TLabel
          Left = 484
          Top = 55
          Width = 80
          Height = 15
          Caption = 'Complexidade'
        end
        object Label21: TLabel
          Left = 583
          Top = 55
          Width = 39
          Height = 15
          Caption = 'Equipe'
        end
        object PainelCAE: TPanel
          Left = 8
          Top = 18
          Width = 724
          Height = 34
          TabOrder = 5
          object btnovocae: TSpeedButton
            Left = 4
            Top = 4
            Width = 40
            Height = 27
            Hint = 'Inclui Atividade Econ'#244'mica'
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
            OnClick = btnovocaeClick
          end
          object btaltcae: TSpeedButton
            Left = 44
            Top = 4
            Width = 40
            Height = 27
            Hint = 'Altera '
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
            OnClick = btaltcaeClick
          end
          object btgravacae: TSpeedButton
            Left = 84
            Top = 4
            Width = 40
            Height = 27
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
            OnClick = btgravacaeClick
          end
          object btcancelcae: TSpeedButton
            Left = 124
            Top = 4
            Width = 40
            Height = 27
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
            OnClick = btcancelcaeClick
          end
          object btdelecae: TSpeedButton
            Left = 164
            Top = 4
            Width = 40
            Height = 27
            Hint = 'Exclui '
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
            OnClick = btdelecaeClick
          end
          object DBNavCAE: TDBNavigator
            Left = 332
            Top = 4
            Width = 380
            Height = 27
            Hint = 'Navega Entre as Atividaes Cadastradas'
            DataSource = dsrt
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
          object BtSinc: TBitBtn
            Left = 206
            Top = 4
            Width = 123
            Height = 27
            Caption = 'Sincroniza com SIM'
            TabOrder = 1
            OnClick = BtSincClick
          end
        end
        object DBLdescri: TDBLookupComboBox
          Left = 243
          Top = 125
          Width = 501
          Height = 24
          DataField = 'Subclasse'
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'Subclasse'
          ListField = 'Atividade'
          ListSource = dscnae
          ParentFont = False
          TabOrder = 2
          OnEnter = DBLAtivEnter
        end
        object DBComboBox1: TDBComboBox
          Left = 344
          Top = 72
          Width = 121
          Height = 24
          DataField = 'Tipo'
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'Principal'
            'Secund'#225'ria')
          ParentFont = False
          TabOrder = 1
          OnChange = DBComboBox1Change
        end
        object dblsub: TDBLookupComboBox
          Left = 243
          Top = 72
          Width = 85
          Height = 24
          DataField = 'Subclasse'
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'Subclasse'
          ListField = 'Subclasse'
          ListFieldIndex = 1
          ListSource = dscnae
          ParentFont = False
          TabOrder = 0
          OnEnter = DBLAtivEnter
        end
        object DBGrid3: TDBGrid
          Left = 8
          Top = 56
          Width = 225
          Height = 176
          TabStop = False
          Color = clMoneyGreen
          Ctl3D = True
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -18
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'Subclasse'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -12
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Width = 81
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Tipo'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              Title.Caption = 'Principal/Secund'#225'ria'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -12
              Title.Font.Name = 'Arial'
              Title.Font.Style = []
              Width = 109
              Visible = True
            end>
        end
        object DBEdit41: TDBEdit
          Left = 483
          Top = 71
          Width = 82
          Height = 24
          Hint = 
            'Informa'#231#245'es de Atividade Secund'#225'rio, Ve'#237'culo de Transporte ou Lo' +
            'cal Alterantivo'
          Color = clMoneyGreen
          DataField = 'Complexidade'
          DataSource = dscnae
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object DBCequipe: TDBComboBox
          Left = 583
          Top = 71
          Width = 50
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Equipe'
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'IA'
            'AG'
            'ED'
            'OS'
            'SS'
            'OD'
            'ED'
            'CS'
            'AM'
            'VT'
            'BI'
            'LP'
            'AO'
            'TR'
            'FU'
            'DR'
            'MD')
          ParentFont = False
          TabOrder = 4
        end
      end
      object GroupBox13: TGroupBox
        Left = 2
        Top = 244
        Width = 753
        Height = 240
        Caption = 'CNAEs Receita Municipal'
        TabOrder = 1
      end
      object GroupBox8: TGroupBox
        Left = 243
        Top = 162
        Width = 503
        Height = 73
        Caption = 'Responsabilidade T'#233'cnica'
        TabOrder = 2
        object Label20: TLabel
          Left = 8
          Top = 22
          Width = 119
          Height = 15
          Caption = 'Respons'#225'vel T'#233'cnico'
        end
        object Label22: TLabel
          Left = 345
          Top = 22
          Width = 54
          Height = 15
          Caption = 'Conselho'
        end
        object Label23: TLabel
          Left = 410
          Top = 22
          Width = 47
          Height = 15
          Caption = 'Registro'
        end
        object DBENomeResp1: TDBEdit
          Left = 8
          Top = 38
          Width = 329
          Height = 24
          CharCase = ecUpperCase
          DataField = 'NomeResp1'
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object DBCCons1: TDBComboBox
          Left = 345
          Top = 38
          Width = 56
          Height = 24
          CharCase = ecUpperCase
          DataField = 'ConsResp1'
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'COREN'
            'CRBIO'
            'CRBM'
            'CREF'
            'CREFITO'
            'CRF'
            'CRM'
            'CRN'
            'CRMV'
            'CRO'
            'CROO'
            'CRQ'
            'CRP'
            'CRFA'
            'CREA')
          ParentFont = False
          TabOrder = 1
          OnChange = DBCCons1Change
        end
        object DBERegResp1: TDBEdit
          Left = 410
          Top = 38
          Width = 79
          Height = 24
          DataField = 'RegResp1'
          DataSource = dsrt
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object TabHist: TTabSheet
      Caption = 'Hist'#243'rico'
      ImageIndex = 3
      object GroupBox1: TGroupBox
        Left = 2
        Top = 3
        Width = 758
        Height = 464
        Caption = 'Inspe'#231#245'es e demais ocorr'#234'ncias'
        TabOrder = 0
        object Bevel1: TBevel
          Left = 8
          Top = 416
          Width = 745
          Height = 42
        end
        object Label8: TLabel
          Left = 497
          Top = 67
          Width = 51
          Height = 15
          Caption = 'Data Doc'
        end
        object Label9: TLabel
          Left = 229
          Top = 67
          Width = 109
          Height = 15
          Caption = 'Documento Emitido'
        end
        object Label15: TLabel
          Left = 582
          Top = 67
          Width = 31
          Height = 15
          Caption = 'Prazo'
        end
        object Label19: TLabel
          Left = 412
          Top = 67
          Width = 70
          Height = 15
          Caption = 'N'#250'mero Doc'
        end
        object Label18: TLabel
          Left = 8
          Top = 373
          Width = 125
          Height = 15
          Caption = 'Autoridades Sanit'#225'rias'
        end
        object Label46: TLabel
          Left = 8
          Top = 67
          Width = 121
          Height = 15
          Caption = 'A'#231#227'o Fiscal Realizada'
        end
        object Label49: TLabel
          Left = 497
          Top = 20
          Width = 53
          Height = 15
          Caption = 'Den'#250'ncia'
          FocusControl = DBEDen
        end
        object Label63: TLabel
          Left = 8
          Top = 112
          Width = 192
          Height = 15
          Caption = 'Atividade Econ'#244'mica Inspecionada'
        end
        object Label24: TLabel
          Left = 15
          Top = 419
          Width = 87
          Height = 14
          Caption = 'Usu'#225'rio - Inclus'#227'o'
          FocusControl = DBEdit10
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label25: TLabel
          Left = 263
          Top = 420
          Width = 80
          Height = 14
          Caption = 'Data da Inclus'#227'o'
          FocusControl = DBEdit11
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label67: TLabel
          Left = 658
          Top = 420
          Width = 81
          Height = 14
          Caption = 'Data Atualiza'#231#227'o'
          FocusControl = DBEdit11
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label68: TLabel
          Left = 407
          Top = 419
          Width = 93
          Height = 14
          Caption = 'Usu'#225'rio - Altera'#231#227'o'
          FocusControl = DBEdit10
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label69: TLabel
          Left = 352
          Top = 419
          Width = 24
          Height = 14
          Caption = 'Perfil'
          FocusControl = DBEdit10
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label120: TLabel
          Left = 582
          Top = 111
          Width = 71
          Height = 14
          Caption = 'Gera Retorno?'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label128: TLabel
          Left = 667
          Top = 67
          Width = 47
          Height = 14
          Caption = #193'rea (m'#178')'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label182: TLabel
          Left = 229
          Top = 20
          Width = 78
          Height = 15
          Caption = 'Origem da OS'
        end
        object Label183: TLabel
          Left = 412
          Top = 20
          Width = 79
          Height = 15
          Caption = 'Requerimento'
        end
        object Label167: TLabel
          Left = 582
          Top = 20
          Width = 78
          Height = 15
          Caption = 'Of'#237'cio/Retorno'
        end
        object Label35: TLabel
          Left = 667
          Top = 20
          Width = 52
          Height = 15
          Caption = 'Protocolo'
        end
        object Label165: TLabel
          Left = 667
          Top = 111
          Width = 77
          Height = 14
          Caption = 'Meio locomo'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBGrid2: TDBGrid
          Left = 8
          Top = 156
          Width = 704
          Height = 215
          TabStop = False
          Color = clMoneyGreen
          Ctl3D = True
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 26
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'DT_VISITA'
              Title.Caption = 'Data'
              Width = 71
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Atividade'
              Width = 69
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TIPO'
              Title.Caption = 'Documento Emitido'
              Width = 145
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'NUMERO'
              Title.Caption = 'N'#250'mero'
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Fiscal1'
              Title.Caption = 'Autoridade Sanit'#225'ria'
              Width = 118
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Fiscal2'
              Title.Caption = 'Autoridade Sanit'#225'ria'
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Fiscal3'
              Title.Caption = 'Autoridade Sanit'#225'ria'
              Width = 174
              Visible = True
            end>
        end
        object PainelTermo: TPanel
          Left = 8
          Top = 156
          Width = 707
          Height = 215
          TabOrder = 19
          Visible = False
          object GroupBox3: TGroupBox
            Left = 7
            Top = 7
            Width = 693
            Height = 203
            Caption = 'Conte'#250'do do documento'
            TabOrder = 0
            object Label33: TLabel
              Left = 10
              Top = 59
              Width = 84
              Height = 15
              Caption = 'Especifica'#231#245'es'
            end
            object Label34: TLabel
              Left = 10
              Top = 16
              Width = 91
              Height = 15
              Caption = 'Dispositivo legal'
            end
            object DBMhistorico: TDBMemo
              Left = 9
              Top = 76
              Width = 672
              Height = 118
              DataField = 'DESCR'
              DataSource = dshistorico
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 1
            end
            object DBMDisp: TDBMemo
              Left = 9
              Top = 30
              Width = 672
              Height = 26
              DataField = 'DISPOSITIVO'
              DataSource = dshistorico
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
            end
          end
        end
        object DBEnumero: TDBEdit
          Left = 412
          Top = 83
          Width = 80
          Height = 24
          DataField = 'NUMERO'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object DBEnewpz: TDBEdit
          Left = 582
          Top = 83
          Width = 80
          Height = 24
          DataField = 'PZ_RETORNO'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object PainelVisita: TPanel
          Left = 716
          Top = 156
          Width = 33
          Height = 215
          TabOrder = 20
          object btnovvisita: TSpeedButton
            Left = 2
            Top = 32
            Width = 30
            Height = 29
            Hint = 'Inclui Ocorr'#234'ncia'
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
            Left = 2
            Top = 62
            Width = 30
            Height = 30
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
            Left = 2
            Top = 92
            Width = 30
            Height = 29
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
            Left = 2
            Top = 121
            Width = 30
            Height = 29
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
            Left = 2
            Top = 150
            Width = 30
            Height = 29
            Hint = 'Exclui Visita'
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
          object bitdoc: TSpeedButton
            Left = 2
            Top = 3
            Width = 30
            Height = 29
            Hint = 'Exibe/Oculta conte'#250'do do documento'
            Flat = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
              0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
              00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
              00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
              F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
              F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
              FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
              0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
              00337777FFFF77FF7733EEEE0000000003337777777777777333}
            Layout = blGlyphBottom
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = bitdocClick
          end
          object btprndoc: TSpeedButton
            Left = 2
            Top = 181
            Width = 30
            Height = 29
            Hint = 'Emite o Documento'
            Flat = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
              00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
              8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
              8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
              8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
              03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
              03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
              33333337FFFF7733333333300000033333333337777773333333}
            Layout = blGlyphBottom
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = btprndocClick
          end
        end
        object DBCtipo: TDBComboBox
          Left = 229
          Top = 83
          Width = 180
          Height = 24
          CharCase = ecUpperCase
          DataField = 'TIPO'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'ATO ADMINISTRATIVO DA GER'#202'NCIA'
            'AUTO DE IMPOSI'#199#195'O DE PENALIDADE'
            'AUTO DE INFRA'#199#195'O'
            'CERTID'#195'O'
            'CONFER'#202'NCIA DE BALAN'#199'O'
            'MANIFESTA'#199#195'O DO FISCAL ATUANTE'
            'ORIENTA'#199#195'O SANIT'#193'RIA'
            'AN'#193'LISE DE PAS'
            'AN'#193'LISE DE RPA'
            'PRORROGA'#199#195'O'
            'RELAT'#211'RIO T'#201'CNICO'
            'RELAT'#211'RIO HARMONIZADO'
            'TERMO DE COLETA DE AMOSTRA'
            'TERMO DE INTIMA'#199#195'O'
            'TERMO DE NOTIFICA'#199#195'O')
          ParentFont = False
          TabOrder = 7
          OnChange = DBCtipoChange
          OnExit = DBCtipoExit
        end
        object DBCFiscal1: TDBComboBox
          Left = 8
          Top = 388
          Width = 245
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Fiscal1'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
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
          ParentFont = False
          Sorted = True
          TabOrder = 16
          OnChange = DBCFiscal1Change
        end
        object DBCFiscal2: TDBComboBox
          Left = 259
          Top = 388
          Width = 244
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Fiscal2'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
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
          ParentFont = False
          Sorted = True
          TabOrder = 17
          OnChange = DBCFiscal2Change
        end
        object DBCFiscal3: TDBComboBox
          Left = 509
          Top = 388
          Width = 244
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Fiscal3'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
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
          ParentFont = False
          Sorted = True
          TabOrder = 18
          TabStop = False
          OnChange = DBCFiscal3Change
        end
        object DBCacao: TDBComboBox
          Left = 8
          Top = 83
          Width = 212
          Height = 24
          CharCase = ecUpperCase
          DataField = 'ACAO'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'INSPE'#199#195'O SANIT'#193'RIA'
            'DOCUMENTO EXTRA INSPE'#199#195'O'
            'OUTRAS A'#199#213'ES EM VIGIL'#194'NCIA '
            'PROCESSO ADMINISTRATIVO'
            'PLANT'#195'O FISCAL')
          ParentFont = False
          TabOrder = 6
          OnChange = DBCacaoChange
        end
        object DBEDen: TDBEdit
          Left = 497
          Top = 35
          Width = 80
          Height = 24
          DataField = 'Denuncia'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object DBNavHist: TDBNavigator
          Left = 8
          Top = 20
          Width = 212
          Height = 38
          DataSource = dsvisitas
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
        object DBEDataV: TDBEdit
          Left = 497
          Top = 83
          Width = 80
          Height = 24
          DataField = 'DT_VISITA'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnExit = DBEDataVExit
        end
        object DBLookupComboBox4: TDBLookupComboBox
          Left = 8
          Top = 127
          Width = 84
          Height = 24
          DataField = 'Atividade'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'Subclasse'
          ListField = 'Subclasse'
          ListFieldIndex = 1
          ListSource = dscnae
          ParentFont = False
          TabOrder = 12
          OnEnter = DBLAtivEnter
        end
        object DBEdit10: TDBEdit
          Left = 15
          Top = 432
          Width = 245
          Height = 22
          TabStop = False
          Color = clInfoBk
          DataField = 'Us_inclu'
          DataSource = dsvisitas
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
        end
        object DBEdit11: TDBEdit
          Left = 263
          Top = 433
          Width = 84
          Height = 22
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_inclu'
          DataSource = dsvisitas
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 22
        end
        object DBEdit13: TDBEdit
          Left = 407
          Top = 432
          Width = 245
          Height = 22
          TabStop = False
          Color = clInfoBk
          DataField = 'Us_altera'
          DataSource = dsvisitas
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 24
        end
        object DBEdit14: TDBEdit
          Left = 352
          Top = 432
          Width = 33
          Height = 22
          TabStop = False
          Color = clInfoBk
          DataField = 'Gr_inclu'
          DataSource = dsvisitas
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 23
        end
        object DBEdit12: TDBEdit
          Left = 658
          Top = 432
          Width = 86
          Height = 22
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_altera'
          DataSource = dsvisitas
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 25
        end
        object DBCLibera: TDBComboBox
          Left = 582
          Top = 126
          Width = 80
          Height = 24
          Hint = 'Informar se houve ou n'#227'o libera'#231#227'o de alvar'#225' no TI ou TN emitido'
          DataField = 'Libera'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'Sim'
            'N'#227'o')
          ParentFont = False
          TabOrder = 14
          OnChange = DBCLiberaChange
        end
        object DBComboBox7: TDBComboBox
          Left = 667
          Top = 83
          Width = 80
          Height = 24
          Hint = 'Informar se houve ou n'#227'o libera'#231#227'o de alvar'#225' no TI ou TN emitido'
          DataField = 'Area'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'At'#233' 101'
            '101-399'
            '> 399  ')
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
          TabStop = False
          OnChange = DBCLiberaChange
        end
        object DbCordem: TDBComboBox
          Left = 229
          Top = 35
          Width = 180
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Modalidade'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'REQUERIMENTO'
            'DEN'#218'NCIA'
            'DE OF'#205'CIO'
            'PROTOCOLO')
          ParentFont = False
          TabOrder = 1
          OnChange = DbCordemChange
          OnExit = DbCordemExit
        end
        object DBLookupComboBox3: TDBLookupComboBox
          Left = 91
          Top = 127
          Width = 486
          Height = 24
          DataField = 'Atividade'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'Subclasse'
          ListField = 'Atividade'
          ListSource = dscnae
          ParentFont = False
          TabOrder = 13
          OnEnter = DBLAtivEnter
        end
        object DBEOs: TDBEdit
          Left = 412
          Top = 35
          Width = 80
          Height = 24
          Hint = 'Informe a Unidade/Setor da Empresa se for o caso'
          CharCase = ecUpperCase
          DataField = 'OS'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object DBEOf: TDBEdit
          Left = 582
          Top = 35
          Width = 80
          Height = 24
          DataField = 'Oficio'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object DBEProto: TDBEdit
          Left = 667
          Top = 35
          Width = 80
          Height = 24
          DataField = 'Protocolo'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object DBCMeio: TDBComboBox
          Left = 667
          Top = 126
          Width = 80
          Height = 24
          Hint = 'Informar se houve ou n'#227'o libera'#231#227'o de alvar'#225' no TI ou TN emitido'
          DataField = 'Meio'
          DataSource = dsvisitas
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 16
          Items.Strings = (
            'Pr'#243'prio'
            'Oficial'
            'Outro')
          ParentFont = False
          TabOrder = 15
          OnChange = DBCLiberaChange
        end
      end
    end
    object TabAnexo: TTabSheet
      Caption = 'Anexo'
      ImageIndex = 5
      object GroupBox4: TGroupBox
        Left = 2
        Top = 11
        Width = 319
        Height = 449
        Caption = 'Pr'#233' Visualiza'#231#227'o'
        TabOrder = 0
        object AcroPDF1: TAcroPDF
          Left = 7
          Top = 16
          Width = 305
          Height = 425
          TabOrder = 0
          ControlData = {000E0000861F0000ED2B0000}
        end
      end
      object GroupBox10: TGroupBox
        Left = 344
        Top = 11
        Width = 385
        Height = 357
        Caption = 'Inspe'#231#245'es'
        TabOrder = 1
        object DBNavanexos: TDBNavigator
          Left = 10
          Top = 23
          Width = 364
          Height = 41
          DataSource = dsvisitas
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
        object DBGrid1: TDBGrid
          Left = 10
          Top = 72
          Width = 365
          Height = 273
          TabStop = False
          Color = clMoneyGreen
          Ctl3D = True
          DataSource = dsvisitas
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'DT_VISITA'
              Title.Caption = 'Data'
              Width = 67
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TIPO'
              Title.Caption = 'Documento Emitido'
              Width = 155
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'NUMERO'
              Title.Caption = 'N'#250'mero'
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NDOC'
              Width = 49
              Visible = True
            end>
        end
      end
      object GroupBox11: TGroupBox
        Left = 344
        Top = 381
        Width = 385
        Height = 79
        Caption = 'Arquivos PDF'
        TabOrder = 2
        object BtAnexaPDF: TButton
          Left = 10
          Top = 28
          Width = 100
          Height = 33
          Caption = 'PDF'
          TabOrder = 0
        end
        object BtGrasvaPDF: TButton
          Left = 138
          Top = 28
          Width = 100
          Height = 33
          Caption = 'Salvar'
          TabOrder = 1
        end
        object BtMaxPDF: TButton
          Left = 268
          Top = 28
          Width = 100
          Height = 33
          Caption = 'Maximizar'
          TabOrder = 2
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'OS'
      ImageIndex = 5
      object GroupBox16: TGroupBox
        Left = 2
        Top = 3
        Width = 760
        Height = 374
        Caption = 'Ordens de Servi'#231'os Requeridas pelo Regulado'
        TabOrder = 0
        object Label169: TLabel
          Left = 223
          Top = 65
          Width = 65
          Height = 15
          Caption = 'Requerente'
        end
        object Label171: TLabel
          Left = 12
          Top = 65
          Width = 38
          Height = 15
          Caption = 'Dt Req'
        end
        object Label172: TLabel
          Left = 87
          Top = 65
          Width = 34
          Height = 15
          Caption = 'Motivo'
        end
        object Label175: TLabel
          Left = 87
          Top = 113
          Width = 73
          Height = 15
          Caption = 'Observa'#231#245'es'
        end
        object Label173: TLabel
          Left = 420
          Top = 65
          Width = 46
          Height = 15
          Caption = 'Data OS'
        end
        object Label174: TLabel
          Left = 12
          Top = 113
          Width = 31
          Height = 15
          Caption = 'Prazo'
        end
        object Label170: TLabel
          Left = 420
          Top = 113
          Width = 69
          Height = 15
          Caption = 'Atendimento'
        end
        object Label176: TLabel
          Left = 500
          Top = 65
          Width = 107
          Height = 15
          Caption = 'Fiscal Encarregado'
        end
        object Label178: TLabel
          Left = 144
          Top = 592
          Width = 17
          Height = 15
          Caption = 'OS'
          FocusControl = DBEdit73
        end
        object Label179: TLabel
          Left = 144
          Top = 960
          Width = 34
          Height = 15
          Caption = 'Motivo'
          FocusControl = DBEdit74
        end
        object Label180: TLabel
          Left = 144
          Top = 1328
          Width = 53
          Height = 15
          Caption = 'Obs_Req'
          FocusControl = DBEdit75
        end
        object Label181: TLabel
          Left = 144
          Top = 1696
          Width = 42
          Height = 15
          Caption = 'Dt_Req'
          FocusControl = DBEdit76
        end
        object Label184: TLabel
          Left = 144
          Top = 2064
          Width = 31
          Height = 15
          Caption = 'Prazo'
          FocusControl = DBEdit77
        end
        object Label185: TLabel
          Left = 144
          Top = 2432
          Width = 103
          Height = 15
          Caption = 'Fiscal_Encaminha'
          FocusControl = DBEdit78
        end
        object Label186: TLabel
          Left = 144
          Top = 2800
          Width = 81
          Height = 15
          Caption = 'Dt_encaminha'
          FocusControl = DBEdit79
        end
        object Label187: TLabel
          Left = 144
          Top = 3168
          Width = 50
          Height = 15
          Caption = 'Dt_Atend'
          FocusControl = DBEdit80
        end
        object Label188: TLabel
          Left = 144
          Top = 3720
          Width = 65
          Height = 15
          Caption = 'Requerente'
          FocusControl = DBEdit81
        end
        object Label189: TLabel
          Left = 144
          Top = 4088
          Width = 71
          Height = 15
          Caption = 'Fiscal_Atend'
          FocusControl = DBEdit82
        end
        object Panel3: TPanel
          Left = 12
          Top = 16
          Width = 734
          Height = 44
          BevelInner = bvRaised
          TabOrder = 0
          object Bevel10: TBevel
            Left = 408
            Top = 3
            Width = 137
            Height = 38
          end
          object DBText3: TDBText
            Left = 413
            Top = 8
            Width = 126
            Height = 28
            DataField = 'OS'
            DataSource = dsos
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -27
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DBNavigator2: TDBNavigator
            Left = 3
            Top = 3
            Width = 396
            Height = 38
            Hint = 'Navega Tabela de Protocolo'
            DataSource = dsos
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object DBEdit64: TDBEdit
          Left = 500
          Top = 81
          Width = 245
          Height = 23
          Hint = 'Celular da pesoa que est'#225'  registrando a entrada'
          DataField = 'Fiscal_Encaminha'
          DataSource = dsos
          Enabled = False
          ReadOnly = True
          TabOrder = 3
        end
        object DBEdit65: TDBEdit
          Left = 223
          Top = 81
          Width = 186
          Height = 23
          Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
          CharCase = ecUpperCase
          DataField = 'Requerente'
          DataSource = dsos
          Enabled = False
          ReadOnly = True
          TabOrder = 2
        end
        object DBEdit67: TDBEdit
          Left = 12
          Top = 81
          Width = 69
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_Req'
          DataSource = dsos
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnExit = DBEDtreqExit
        end
        object DBMemo6: TDBMemo
          Left = 87
          Top = 129
          Width = 323
          Height = 24
          DataField = 'Obs_Req'
          DataSource = dsos
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 4
        end
        object DBGrid5: TDBGrid
          Left = 12
          Top = 168
          Width = 733
          Height = 193
          Color = clMoneyGreen
          DataSource = dsos
          ReadOnly = True
          TabOrder = 5
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'Dt_Req'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Motivo'
              Width = 127
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Fiscal_Encaminha'
              Width = 257
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Dt_encaminha'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Prazo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Dt_Atend'
              Visible = True
            end>
        end
        object DBEdit70: TDBEdit
          Left = 87
          Top = 81
          Width = 130
          Height = 23
          Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
          CharCase = ecUpperCase
          DataField = 'Motivo'
          DataSource = dsos
          Enabled = False
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit68: TDBEdit
          Left = 12
          Top = 129
          Width = 69
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Prazo'
          DataSource = dsos
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          OnExit = DBEDtreqExit
        end
        object DBEdit69: TDBEdit
          Left = 420
          Top = 81
          Width = 69
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_encaminha'
          DataSource = dsos
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          OnExit = DBEDtreqExit
        end
        object DBEdit72: TDBEdit
          Left = 420
          Top = 129
          Width = 69
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_Atend'
          DataSource = dsos
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          OnExit = DBEDtreqExit
        end
        object DBEdit71: TDBEdit
          Left = 144
          Top = 400
          Width = 134
          Height = 23
          DataField = 'Codigo'
          DataSource = dsos
          TabOrder = 10
        end
        object DBEdit73: TDBEdit
          Left = 144
          Top = 768
          Width = 134
          Height = 23
          DataField = 'OS'
          DataSource = dsos
          TabOrder = 11
        end
        object DBEdit74: TDBEdit
          Left = 144
          Top = 1136
          Width = 329
          Height = 23
          DataField = 'Motivo'
          DataSource = dsos
          TabOrder = 12
        end
        object DBEdit75: TDBEdit
          Left = 144
          Top = 1504
          Width = 784
          Height = 23
          DataField = 'Obs_Req'
          DataSource = dsos
          TabOrder = 13
        end
        object DBEdit76: TDBEdit
          Left = 144
          Top = 1872
          Width = 134
          Height = 23
          DataField = 'Dt_Req'
          DataSource = dsos
          TabOrder = 14
        end
        object DBEdit77: TDBEdit
          Left = 144
          Top = 2240
          Width = 134
          Height = 23
          DataField = 'Prazo'
          DataSource = dsos
          TabOrder = 15
        end
        object DBEdit78: TDBEdit
          Left = 144
          Top = 2608
          Width = 784
          Height = 23
          DataField = 'Fiscal_Encaminha'
          DataSource = dsos
          TabOrder = 16
        end
        object DBEdit79: TDBEdit
          Left = 144
          Top = 2976
          Width = 134
          Height = 23
          DataField = 'Dt_encaminha'
          DataSource = dsos
          TabOrder = 17
        end
        object DBEdit80: TDBEdit
          Left = 144
          Top = 3344
          Width = 134
          Height = 23
          DataField = 'Dt_Atend'
          DataSource = dsos
          TabOrder = 18
        end
        object DBCheckBox1: TDBCheckBox
          Left = 144
          Top = 3536
          Width = 97
          Height = 17
          Caption = 'Cancelado'
          DataField = 'Cancelado'
          DataSource = dsos
          TabOrder = 19
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBEdit81: TDBEdit
          Left = 144
          Top = 3896
          Width = 524
          Height = 23
          DataField = 'Requerente'
          DataSource = dsos
          TabOrder = 20
        end
        object DBEdit82: TDBEdit
          Left = 144
          Top = 4264
          Width = 524
          Height = 23
          DataField = 'Fiscal_Atend'
          DataSource = dsos
          TabOrder = 21
        end
        object DBCheckBox2: TDBCheckBox
          Left = 500
          Top = 136
          Width = 97
          Height = 17
          Caption = 'Atendido'
          DataField = 'Atendimento'
          DataSource = dsos
          ReadOnly = True
          TabOrder = 22
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object DBCheckBox3: TDBCheckBox
          Left = 644
          Top = 136
          Width = 97
          Height = 17
          Caption = 'Cancelado'
          DataField = 'Cancelado'
          DataSource = dsos
          ReadOnly = True
          TabOrder = 23
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
    end
    object TabAlvara: TTabSheet
      Hint = 'Inclu Alvara'
      Caption = 'Alvar'#225
      ImageIndex = 2
      object GroupBox7: TGroupBox
        Left = 2
        Top = 3
        Width = 752
        Height = 478
        Caption = 'Alvar'#225' Sanit'#225'rio'
        TabOrder = 0
        object Label28: TLabel
          Left = 151
          Top = 58
          Width = 48
          Height = 15
          Caption = 'N'#186' Alvar'#225
        end
        object Label29: TLabel
          Left = 12
          Top = 58
          Width = 49
          Height = 15
          Caption = 'Exerc'#237'cio'
        end
        object Label32: TLabel
          Left = 12
          Top = 276
          Width = 125
          Height = 15
          Caption = 'Observa'#231#245'es do Alvar'#225
        end
        object Label37: TLabel
          Left = 71
          Top = 58
          Width = 29
          Height = 15
          Caption = 'Data '
        end
        object Label45: TLabel
          Left = 12
          Top = 383
          Width = 52
          Height = 14
          Caption = 'Emitido por'
          FocusControl = DBEemite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label47: TLabel
          Left = 523
          Top = 383
          Width = 65
          Height = 14
          Caption = 'Data Emiss'#227'o'
          FocusControl = DBEDtemite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 620
          Top = 355
          Width = 64
          Height = 14
          Caption = 'Autentica'#231#227'o'
          FocusControl = DBEdit6
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label41: TLabel
          Left = 12
          Top = 412
          Width = 76
          Height = 14
          Caption = 'Reimpresso por'
          FocusControl = DBEdit7
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label43: TLabel
          Left = 523
          Top = 412
          Width = 88
          Height = 14
          Caption = 'Data Reimpress'#227'o'
          FocusControl = DBEdit8
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label70: TLabel
          Left = 620
          Top = 383
          Width = 66
          Height = 14
          Caption = 'Data Validade'
          FocusControl = DBEDtemite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label51: TLabel
          Left = 12
          Top = 441
          Width = 70
          Height = 14
          Caption = 'Cancelado por'
          FocusControl = DBEdit7
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label82: TLabel
          Left = 523
          Top = 441
          Width = 93
          Height = 14
          Caption = 'Data Cancelamento'
          FocusControl = DBEdit8
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label91: TLabel
          Left = 231
          Top = 99
          Width = 47
          Height = 15
          Caption = 'Validade'
        end
        object Label92: TLabel
          Left = 12
          Top = 99
          Width = 87
          Height = 15
          Caption = 'Status do Alvar'#225
        end
        object Label40: TLabel
          Left = 12
          Top = 355
          Width = 60
          Height = 14
          Caption = 'Alterado por'
          FocusControl = DBEemite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 523
          Top = 355
          Width = 71
          Height = 14
          Caption = 'Data Altera'#231#227'o'
          FocusControl = DBEDtemite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Label26: TLabel
          Left = 231
          Top = 58
          Width = 53
          Height = 15
          Caption = 'Taxa VISA'
        end
        object Label27: TLabel
          Left = 307
          Top = 58
          Width = 49
          Height = 15
          Caption = 'Exerc'#237'cio'
        end
        object Label30: TLabel
          Left = 359
          Top = 58
          Width = 108
          Height = 15
          Caption = 'Complexidade/'#225'rea'
        end
        object Label36: TLabel
          Left = 479
          Top = 58
          Width = 64
          Height = 15
          Caption = 'Vencimento'
        end
        object Label38: TLabel
          Left = 559
          Top = 58
          Width = 27
          Height = 15
          Caption = 'Valor'
        end
        object Label64: TLabel
          Left = 647
          Top = 58
          Width = 48
          Height = 15
          Caption = 'Situa'#231#227'o'
        end
        object DBEalvara: TDBEdit
          Left = 151
          Top = 73
          Width = 74
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Numero'
          DataSource = dsalvara
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object PainelAlvara: TPanel
          Left = 12
          Top = 15
          Width = 733
          Height = 40
          BevelInner = bvRaised
          TabOrder = 0
          object btnovalvara: TSpeedButton
            Left = 4
            Top = 3
            Width = 81
            Height = 35
            Hint = 'Inclui Alvar'#225
            Caption = 'Novo Alvar'#225
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = btnovalvaraClick
          end
          object btaltalvara: TSpeedButton
            Left = 86
            Top = 3
            Width = 40
            Height = 35
            Hint = 'Altera Alvar'#225
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = btaltalvaraClick
          end
          object btgravalvara: TSpeedButton
            Left = 126
            Top = 3
            Width = 40
            Height = 35
            Hint = 'Grava'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = btgravalvaraClick
          end
          object btcancalvara: TSpeedButton
            Left = 166
            Top = 3
            Width = 41
            Height = 35
            Hint = 'Cancela'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = btcancalvaraClick
          end
          object btdelalvara: TSpeedButton
            Left = 207
            Top = 3
            Width = 39
            Height = 35
            Hint = 'Cancela Alvar'#225' Emitido'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
              555557777F777555F55500000000555055557777777755F75555005500055055
              555577F5777F57555555005550055555555577FF577F5FF55555500550050055
              5555577FF77577FF555555005050110555555577F757777FF555555505099910
              555555FF75777777FF555005550999910555577F5F77777775F5500505509990
              3055577F75F77777575F55005055090B030555775755777575755555555550B0
              B03055555F555757575755550555550B0B335555755555757555555555555550
              BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
              50BB555555555555575F555555555555550B5555555555555575}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = btdelalvaraClick
          end
          object navalvara: TDBNavigator
            Left = 247
            Top = 3
            Width = 176
            Height = 35
            DataSource = dsalvara
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = navalvaraClick
          end
          object Btemitenovo: TButton
            Left = 584
            Top = 3
            Width = 65
            Height = 35
            Hint = 'Emiss'#227'o nos termos do '#167' 2'#186'  Art 79 da LC 377/18'
            Caption = 'Emiss'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = BtemitenovoClick
          end
          object Btreemite: TButton
            Left = 649
            Top = 3
            Width = 82
            Height = 35
            Hint = 'Reimprime Alvar'#225' Mantendo data de emiss'#227'o'
            Caption = 'Reimpress'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = BtreemiteClick
          end
          object Btprovisorio: TButton
            Left = 433
            Top = 3
            Width = 65
            Height = 35
            Hint = 'Libera'#231#227'o do Alvar'#225' Provis'#243'rio'
            Caption = 'Provis'#243'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = BtprovisorioClick
          end
          object Btevento: TButton
            Left = 499
            Top = 3
            Width = 65
            Height = 35
            Hint = 'Libera'#231#227'o do Alvar'#225' Provis'#243'rio'
            Caption = 'Evento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = BteventoClick
          end
        end
        object DBMobsalvara: TDBMemo
          Left = 12
          Top = 291
          Width = 731
          Height = 62
          DataField = 'Obs'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object DBEemite: TDBEdit
          Left = 12
          Top = 395
          Width = 501
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Emitente'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object DBEDtemite: TDBEdit
          Left = 523
          Top = 395
          Width = 85
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Dt_emite'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object DBEDtreq: TDBEdit
          Left = 70
          Top = 73
          Width = 75
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_duam'
          DataSource = dsalvara
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnExit = DBEDtreqExit
        end
        object GroupBox5: TGroupBox
          Left = 12
          Top = 138
          Width = 733
          Height = 138
          Caption = 'Libera'#231#227'o de Atividades Econ'#244'micas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial Narrow'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 14
          object Label62: TLabel
            Left = 8
            Top = 56
            Width = 144
            Height = 16
            Caption = 'Atividade Econ'#244'mica Liberada '
          end
          object Label58: TLabel
            Left = 250
            Top = 100
            Width = 65
            Height = 14
            Caption = 'Data Registro'
            FocusControl = DBEDtlibera
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label57: TLabel
            Left = 8
            Top = 100
            Width = 191
            Height = 14
            Caption = 'Respons'#225'vel pelo Registo da Libera'#231#227'o'
            FocusControl = DBEliberante
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Label121: TLabel
            Left = 337
            Top = 11
            Width = 165
            Height = 16
            Caption = 'Autoridade que Liberou a Atividade'
          end
          object Label124: TLabel
            Left = 583
            Top = 11
            Width = 41
            Height = 16
            Caption = 'N'#186' TI/TN'
          end
          object Label125: TLabel
            Left = 648
            Top = 11
            Width = 20
            Height = 16
            Caption = 'Data'
          end
          object Label126: TLabel
            Left = 648
            Top = 56
            Width = 80
            Height = 15
            Caption = 'Complexidade'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object DBLsuclasse: TDBLookupComboBox
            Left = 8
            Top = 72
            Width = 85
            Height = 24
            DataField = 'Atividade'
            DataSource = dsalvlib
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'Subclasse'
            ListField = 'Subclasse'
            ListFieldIndex = 1
            ListSource = dsrt
            ParentFont = False
            TabOrder = 4
            OnEnter = DBLAtivEnter
          end
          object DBLookupComboBox6: TDBLookupComboBox
            Left = 90
            Top = 72
            Width = 552
            Height = 24
            DataField = 'Atividade'
            DataSource = dsalvlib
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'Subclasse'
            ListField = 'Atividade'
            ListSource = dscnae
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
            TabStop = False
            OnEnter = DBLAtivEnter
          end
          object PainelAutoriza: TPanel
            Left = 8
            Top = 16
            Width = 324
            Height = 35
            TabOrder = 6
            object btnovautor: TSpeedButton
              Left = 4
              Top = 3
              Width = 30
              Height = 29
              Hint = 'Inclui Atividade Econ'#244'mica'
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
              OnClick = btnovautorClick
            end
            object btgravautor: TSpeedButton
              Left = 35
              Top = 3
              Width = 30
              Height = 29
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
              OnClick = btgravautorClick
            end
            object btcancautor: TSpeedButton
              Left = 66
              Top = 3
              Width = 30
              Height = 29
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
              OnClick = btcancautorClick
            end
            object btdelautor: TSpeedButton
              Left = 97
              Top = 3
              Width = 29
              Height = 29
              Hint = 'Exclui '
              Flat = True
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
                555557777F777555F55500000000555055557777777755F75555005500055055
                555577F5777F57555555005550055555555577FF577F5FF55555500550050055
                5555577FF77577FF555555005050110555555577F757777FF555555505099910
                555555FF75777777FF555005550999910555577F5F77777775F5500505509990
                3055577F75F77777575F55005055090B030555775755777575755555555550B0
                B03055555F555757575755550555550B0B335555755555757555555555555550
                BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
                50BB555555555555575F555555555555550B5555555555555575}
              Layout = blGlyphBottom
              NumGlyphs = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = btdelautorClick
            end
            object navautor: TDBNavigator
              Left = 137
              Top = 3
              Width = 180
              Height = 29
              Hint = 'Navega Entre as Atividaes Autoriuzadas'
              DataSource = dsalvlib
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
          end
          object DBEliberante: TDBEdit
            Left = 8
            Top = 113
            Width = 233
            Height = 18
            TabStop = False
            AutoSize = False
            Color = clMoneyGreen
            DataField = 'Autoridade'
            DataSource = dsalvlib
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object DBEDtlibera: TDBEdit
            Left = 250
            Top = 113
            Width = 85
            Height = 18
            TabStop = False
            AutoSize = False
            Color = clMoneyGreen
            DataField = 'Data'
            DataSource = dsalvlib
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnExit = DBEDtliberaExit
          end
          object DBEdit43: TDBEdit
            Left = 583
            Top = 26
            Width = 58
            Height = 24
            Hint = 
              'Informar o N'#250'mero da Termo que Documenta Libera'#231#227'o da atividade ' +
              'econ'#244'mica'
            DataField = 'Documento'
            DataSource = dsalvlib
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object DBEdit44: TDBEdit
            Left = 648
            Top = 26
            Width = 74
            Height = 24
            DataField = 'Dt_documento'
            DataSource = dsalvlib
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object DBCAutoridade: TDBComboBox
            Left = 337
            Top = 26
            Width = 240
            Height = 24
            Hint = 
              'Selecionar a Autoridade Sanit'#225'ria que relizou a inspe'#231#227'o e liber' +
              'ou a atividade econ'#244'mica'
            CharCase = ecUpperCase
            DataField = 'Liberante'
            DataSource = dsalvlib
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 16
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
            ParentFont = False
            Sorted = True
            TabOrder = 1
            OnChange = DBCFiscal1Change
          end
          object DBEdit40: TDBEdit
            Left = 648
            Top = 72
            Width = 74
            Height = 24
            TabStop = False
            AutoSize = False
            Color = clMoneyGreen
            DataField = 'Complexidade'
            DataSource = dscnae
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial Narrow'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            OnExit = DBEDtliberaExit
          end
        end
        object DBEdit6: TDBEdit
          Left = 620
          Top = 367
          Width = 123
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Autenticador'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
        end
        object DBEdit7: TDBEdit
          Left = 12
          Top = 424
          Width = 501
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Reemitente'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object DBEdit8: TDBEdit
          Left = 523
          Top = 424
          Width = 85
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Dt_reemite'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
        end
        object DBMDuam: TDBMemo
          Left = 311
          Top = 115
          Width = 432
          Height = 24
          DataField = 'Ob_duam'
          DataSource = dsalvara
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object DBEDtvalidade: TDBEdit
          Left = 620
          Top = 395
          Width = 123
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Dt_validade'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object DBCProvisorio: TDBCheckBox
          Left = 12
          Top = 115
          Width = 77
          Height = 26
          TabStop = False
          Caption = 'Provis'#243'rio'
          DataField = 'Tipo'
          DataSource = dsalvara
          ReadOnly = True
          TabOrder = 10
          ValueChecked = 'True'
          ValueUnchecked = 'True'
        end
        object DBEdit22: TDBEdit
          Left = 12
          Top = 453
          Width = 501
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Cancelador'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
        end
        object DBEdit28: TDBEdit
          Left = 523
          Top = 453
          Width = 85
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Dt_cancela'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 23
        end
        object DBCeventos: TDBCheckBox
          Left = 89
          Top = 115
          Width = 58
          Height = 26
          TabStop = False
          Caption = 'Evento'
          DataField = 'Evento'
          DataSource = dsalvara
          ReadOnly = True
          TabOrder = 11
          ValueChecked = 'True'
          ValueUnchecked = 'True'
        end
        object DBEVal: TDBEdit
          Left = 231
          Top = 115
          Width = 74
          Height = 24
          TabStop = False
          DataField = 'Dt_validade'
          DataSource = dsalvara
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
          OnExit = DBEValExit
        end
        object DBCcancela: TDBCheckBox
          Left = 148
          Top = 115
          Width = 81
          Height = 26
          TabStop = False
          Caption = 'Cancelado'
          DataField = 'Cancela'
          DataSource = dsalvara
          ReadOnly = True
          TabOrder = 12
          ValueChecked = 'True'
          ValueUnchecked = 'True'
        end
        object DBEdit3: TDBEdit
          Left = 12
          Top = 367
          Width = 501
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Alteracao'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 24
        end
        object DBEdit4: TDBEdit
          Left = 523
          Top = 367
          Width = 85
          Height = 18
          TabStop = False
          AutoSize = False
          Color = clMoneyGreen
          DataField = 'Dt_altera'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          ParentFont = False
          TabOrder = 25
        end
        object DBExercicio: TDBEdit
          Left = 12
          Top = 73
          Width = 49
          Height = 26
          TabStop = False
          Color = clMoneyGreen
          DataField = 'Exercicio'
          DataSource = dsalvara
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial Black'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 26
        end
        object DBEdit42: TDBEdit
          Left = 424
          Top = 73
          Width = 41
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'AREA'
          DataSource = dstaxa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit45: TDBEdit
          Left = 559
          Top = 73
          Width = 74
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'VALOR'
          DataSource = dstaxa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object DBEdit46: TDBEdit
          Left = 647
          Top = 73
          Width = 98
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'SITUACAO'
          DataSource = dstaxa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object DBEdit47: TDBEdit
          Left = 307
          Top = 73
          Width = 41
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'EXERCICIO'
          DataSource = dstaxa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit9: TDBEdit
          Left = 360
          Top = 73
          Width = 49
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'COMPLEXIDADE'
          DataSource = dstaxa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit66: TDBEdit
          Left = 479
          Top = 73
          Width = 74
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'DT_VENC'
          DataSource = dstaxa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit83: TDBEdit
          Left = 231
          Top = 73
          Width = 66
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'INSCRICAO'
          DataSource = dstaxa
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 27
        end
      end
    end
    object TabVeiculo: TTabSheet
      Caption = 'Veicular'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 4
      ParentFont = False
      object GroupBox9: TGroupBox
        Left = 2
        Top = 3
        Width = 752
        Height = 454
        Caption = 'Alvar'#225' Veicular'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label71: TLabel
          Left = 239
          Top = 59
          Width = 45
          Height = 15
          Caption = 'N'#250'mero'
        end
        object Label72: TLabel
          Left = 12
          Top = 59
          Width = 49
          Height = 15
          Caption = 'Exerc'#237'cio'
        end
        object Label74: TLabel
          Left = 164
          Top = 59
          Width = 29
          Height = 15
          Caption = 'Data '
        end
        object Label75: TLabel
          Left = 88
          Top = 59
          Width = 34
          Height = 15
          Caption = 'DUAM'
        end
        object Label76: TLabel
          Left = 12
          Top = 364
          Width = 63
          Height = 15
          Caption = 'Emitido por'
          FocusControl = DBEdit17
        end
        object Label78: TLabel
          Left = 617
          Top = 407
          Width = 70
          Height = 15
          Caption = 'Autentica'#231#227'o'
          FocusControl = DBEdit23
        end
        object Label79: TLabel
          Left = 12
          Top = 407
          Width = 90
          Height = 15
          Caption = 'Reimpresso por'
          FocusControl = DBEdit24
        end
        object Label81: TLabel
          Left = 311
          Top = 59
          Width = 244
          Height = 15
          Caption = 'Respons'#225'vel pelo Protoco do Requerimento'
        end
        object Label83: TLabel
          Left = 619
          Top = 364
          Width = 93
          Height = 15
          Caption = 'Data da Validade'
          FocusControl = DBEdit18
        end
        object Label85: TLabel
          Left = 12
          Top = 324
          Width = 78
          Height = 15
          Caption = 'Autorizado por'
          FocusControl = DBEdit20
        end
        object Label86: TLabel
          Left = 523
          Top = 312
          Width = 3
          Height = 15
          FocusControl = DBEdit21
        end
        object Label44: TLabel
          Left = 12
          Top = 98
          Width = 75
          Height = 15
          Caption = 'Ve'#237'culo/Marca'
        end
        object Label84: TLabel
          Left = 163
          Top = 98
          Width = 40
          Height = 15
          Caption = 'Modelo'
        end
        object Label87: TLabel
          Left = 387
          Top = 98
          Width = 21
          Height = 15
          Caption = 'Ano'
        end
        object Label88: TLabel
          Left = 432
          Top = 98
          Width = 31
          Height = 15
          Caption = 'Placa'
        end
        object Label89: TLabel
          Left = 501
          Top = 98
          Width = 40
          Height = 15
          Caption = 'Chassi'
        end
        object Label73: TLabel
          Left = 12
          Top = 137
          Width = 76
          Height = 15
          Caption = 'Observa'#231#245'es:'
        end
        object Label90: TLabel
          Left = 312
          Top = 98
          Width = 20
          Height = 15
          Caption = 'Cor'
        end
        object DBEdit15: TDBEdit
          Left = 239
          Top = 74
          Width = 65
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Numero'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object PainelVeiculo: TPanel
          Left = 12
          Top = 15
          Width = 733
          Height = 40
          BevelInner = bvRaised
          TabOrder = 0
          object btnovoveiculo: TSpeedButton
            Left = 4
            Top = 3
            Width = 81
            Height = 35
            Hint = 'Inclui Alvar'#225
            Caption = 'Requerimento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5000555555555555577755555555555550B0555555555555F7F7555555555550
              00B05555555555577757555555555550B3B05555555555F7F557555555555000
              3B0555555555577755755555555500B3B0555555555577555755555555550B3B
              055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
              555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
              55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
              555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
              55555575FFFF7755555555570000755555555557777775555555}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = btnovoveiculoClick
          end
          object Btalteraveiculo: TSpeedButton
            Left = 86
            Top = 3
            Width = 40
            Height = 35
            Hint = 'Altera Alvar'#225
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtalteraveiculoClick
          end
          object btgravaveiculo: TSpeedButton
            Left = 126
            Top = 3
            Width = 40
            Height = 35
            Hint = 'Grava'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = btgravaveiculoClick
          end
          object btcancelaveiculo: TSpeedButton
            Left = 166
            Top = 3
            Width = 41
            Height = 35
            Hint = 'Cancela'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = btcancelaveiculoClick
          end
          object btdeletaveiculo: TSpeedButton
            Left = 207
            Top = 3
            Width = 39
            Height = 35
            Hint = 'Exclui'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = btdeletaveiculoClick
          end
          object navveiculo: TDBNavigator
            Left = 247
            Top = 3
            Width = 176
            Height = 35
            DataSource = dsveiculo
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = navveiculoClick
          end
          object btemite: TButton
            Left = 533
            Top = 3
            Width = 99
            Height = 35
            Hint = 'Emite Alvar'#225' Criando um novo n'#250'mero'
            Caption = 'Emiss'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = btemiteClick
          end
          object btimprime: TButton
            Left = 633
            Top = 3
            Width = 99
            Height = 35
            Hint = 'Reemite Alvar'#225' Mantendo n'#250'mero original'
            Caption = 'Reimpress'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = btimprimeClick
          end
          object Btliberav: TButton
            Left = 433
            Top = 3
            Width = 99
            Height = 35
            Hint = 'Emite Alvar'#225' Criando um novo n'#250'mero'
            Caption = 'Libera'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = BtliberavClick
          end
        end
        object DBEDuaveic: TDBEdit
          Left = 88
          Top = 74
          Width = 65
          Height = 24
          DataField = 'Duam'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object DBEdit17: TDBEdit
          Left = 12
          Top = 381
          Width = 501
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Emissor'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object DBEdit18: TDBEdit
          Left = 523
          Top = 381
          Width = 85
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_emite'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object DBEReqveic: TDBEdit
          Left = 163
          Top = 74
          Width = 65
          Height = 24
          DataField = 'Dt_req'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnExit = DBEReqveicExit
        end
        object DBEExveic: TDBEdit
          Left = 12
          Top = 74
          Width = 68
          Height = 26
          TabStop = False
          Color = clMoneyGreen
          DataField = 'Exercicio'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial Black'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit23: TDBEdit
          Left = 617
          Top = 424
          Width = 126
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Atenticador'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 21
        end
        object DBEdit24: TDBEdit
          Left = 12
          Top = 424
          Width = 501
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Impressao'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object DBEdit25: TDBEdit
          Left = 523
          Top = 424
          Width = 85
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_impressao'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
        end
        object DBEdit26: TDBEdit
          Left = 311
          Top = 74
          Width = 432
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Responsavel_req'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit27: TDBEdit
          Left = 619
          Top = 381
          Width = 85
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_validade'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object DBEdit20: TDBEdit
          Left = 12
          Top = 339
          Width = 501
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Autorizante'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object DBEdit21: TDBEdit
          Left = 523
          Top = 339
          Width = 85
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Dt_autor'
          DataSource = dsveiculo
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object DBEMarca: TDBEdit
          Left = 12
          Top = 116
          Width = 146
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Marca'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object DBEModelo: TDBEdit
          Left = 163
          Top = 116
          Width = 141
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Modelo'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object DBEAno: TDBEdit
          Left = 387
          Top = 116
          Width = 37
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Ano'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object DBEPlaca: TDBEdit
          Left = 431
          Top = 116
          Width = 63
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Placa'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object DBEChasi: TDBEdit
          Left = 500
          Top = 116
          Width = 141
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Chassi'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object DBMObsveiculo: TDBMemo
          Left = 12
          Top = 153
          Width = 731
          Height = 44
          DataField = 'Obs'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object DBECor: TDBEdit
          Left = 311
          Top = 116
          Width = 69
          Height = 24
          CharCase = ecUpperCase
          DataField = 'Cor'
          DataSource = dsveiculo
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object DBGrid4: TDBGrid
          Left = 12
          Top = 204
          Width = 731
          Height = 117
          TabStop = False
          Color = clMoneyGreen
          Ctl3D = True
          DataSource = dsveiculo
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 13
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'Exercicio'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Numero'
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Marca'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Modelo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Cor'
              Width = 98
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Ano'
              Width = 47
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Placa'
              Width = 95
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Autorizacao'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Dt_validade'
              Title.Caption = 'Validade'
              Visible = True
            end>
        end
      end
    end
    object TabPlanta: TTabSheet
      Caption = 'Protocolo'
      ImageIndex = 7
      object GroupBox12: TGroupBox
        Left = 2
        Top = 3
        Width = 760
        Height = 453
        Caption = 'Protocolo de Documentos dos Regulados'
        TabOrder = 0
        object Label93: TLabel
          Left = 12
          Top = 113
          Width = 40
          Height = 15
          Caption = 'Celular'
        end
        object Label94: TLabel
          Left = 535
          Top = 68
          Width = 65
          Height = 15
          Caption = 'Requerente'
        end
        object Label95: TLabel
          Left = 130
          Top = 113
          Width = 34
          Height = 15
          Caption = 'E-Mail'
        end
        object Label96: TLabel
          Left = 12
          Top = 65
          Width = 26
          Height = 15
          Caption = 'Data'
        end
        object Label98: TLabel
          Left = 128
          Top = 66
          Width = 45
          Height = 15
          Caption = 'Assunto'
        end
        object Label77: TLabel
          Left = 85
          Top = 65
          Width = 27
          Height = 15
          Caption = 'Hora'
        end
        object Label80: TLabel
          Left = 675
          Top = 65
          Width = 69
          Height = 15
          Caption = 'Identifica'#231#227'o'
        end
        object Label100: TLabel
          Left = 198
          Top = 113
          Width = 73
          Height = 15
          Caption = 'Observa'#231#245'es'
        end
        object Label104: TLabel
          Left = 416
          Top = 67
          Width = 108
          Height = 15
          Caption = 'Tipo de Documento'
        end
        object Label101: TLabel
          Left = 535
          Top = 113
          Width = 179
          Height = 15
          Caption = 'Fiscal Previamente Encarregado'
        end
        object PainelProtocolo: TPanel
          Left = 12
          Top = 16
          Width = 734
          Height = 44
          BevelInner = bvRaised
          TabOrder = 0
          object Bevel2: TBevel
            Left = 600
            Top = 3
            Width = 129
            Height = 38
          end
          object Btregistra: TSpeedButton
            Left = 4
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Protocola'
            Caption = 'Registra'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5000555555555555577755555555555550B0555555555555F7F7555555555550
              00B05555555555577757555555555550B3B05555555555F7F557555555555000
              3B0555555555577755755555555500B3B0555555555577555755555555550B3B
              055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
              555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
              55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
              555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
              55555575FFFF7755555555570000755555555557777775555555}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtregistraClick
          end
          object Brgravaproto: TSpeedButton
            Left = 154
            Top = 3
            Width = 40
            Height = 38
            Hint = 'Grava'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BrgravaprotoClick
          end
          object Btcancelaproto: TSpeedButton
            Left = 194
            Top = 3
            Width = 41
            Height = 38
            Hint = 'Cancela'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtcancelaprotoClick
          end
          object Btdeletaproto: TSpeedButton
            Left = 235
            Top = 3
            Width = 39
            Height = 38
            Hint = 'Exclui'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdeletaprotoClick
          end
          object Btandamento: TSpeedButton
            Left = 54
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Tramita Processo'
            Caption = 'Tramita'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
              BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
              BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
              BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
              BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
              EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
              EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
              EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
              EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtandamentoClick
          end
          object Btprotocolo: TSpeedButton
            Left = 431
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Protocolo/Capa do Processo'
            Caption = 'Protocolo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
              00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
              8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
              8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
              8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
              03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
              03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
              33333337FFFF7733333333300000033333333337777773333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtprotocoloClick
          end
          object Btdespacho: TSpeedButton
            Left = 104
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Anexa novo documento ao processo existente'
            Caption = 'Juntada'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
              FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
              00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
              F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
              00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
              F033777777777337F73309999990FFF0033377777777FFF77333099999000000
              3333777777777777333333399033333333333337773333333333333903333333
              3333333773333333333333303333333333333337333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdespachoClick
          end
          object BtRemessa: TSpeedButton
            Left = 486
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'Remesa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
              333333333333337FF3333333333333903333333333333377FF33333333333399
              03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
              99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
              99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
              03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
              33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
              33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
              3333777777333333333333333333333333333333333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtRemessaClick
          end
          object DBText1: TDBText
            Left = 603
            Top = 8
            Width = 126
            Height = 28
            DataField = 'Protocolo'
            DataSource = dsplanta
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -27
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object BitPtJuntada: TSpeedButton
            Left = 541
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'PT Juntada'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BitPtJuntadaClick
          end
          object DBNProto: TDBNavigator
            Left = 275
            Top = 3
            Width = 156
            Height = 38
            Hint = 'Navega Tabela de Protocolo'
            DataSource = dsplanta
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object DBEcelular: TDBEdit
          Left = 12
          Top = 129
          Width = 110
          Height = 23
          Hint = 'Celular da pesoa que est'#225'  registrando a entrada'
          DataField = 'Celular'
          DataSource = dsplanta
          TabOrder = 7
        end
        object DBEptnome: TDBEdit
          Left = 535
          Top = 81
          Width = 130
          Height = 23
          Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
          CharCase = ecUpperCase
          DataField = 'Protocolante'
          DataSource = dsplanta
          TabOrder = 5
        end
        object DBEptmail: TDBEdit
          Left = 129
          Top = 129
          Width = 61
          Height = 23
          Hint = 'Email da pesoa que est'#225'  registrando a entrada'
          CharCase = ecLowerCase
          DataField = 'Email'
          DataSource = dsplanta
          TabOrder = 8
        end
        object DBEdit31: TDBEdit
          Left = 12
          Top = 81
          Width = 69
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Data'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnExit = DBEDtreqExit
        end
        object DBCassunto: TDBComboBox
          Left = 128
          Top = 81
          Width = 258
          Height = 23
          DataField = 'Assunto'
          DataSource = dsplanta
          ItemHeight = 15
          Items.Strings = (
            'REGULARIDADE DE PRODUTO ALIMENT'#205'CIO'
            'PROCESSO ADMINISTRATIVO SANIT'#193'RIO'
            'PROJETO ARQUITET'#212'NICO SANIT'#193'RIO')
          TabOrder = 3
          OnChange = DBCassuntoChange
        end
        object DBEdit33: TDBEdit
          Left = 85
          Top = 81
          Width = 38
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Hora'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnExit = DBEDtreqExit
        end
        object DBEdoc: TDBEdit
          Left = 675
          Top = 81
          Width = 70
          Height = 23
          Hint = 
            'Matr'#237'cula/RG/CPF/OAB/CREA da pesoa que est'#225'  registrando a entra' +
            'da'
          CharCase = ecUpperCase
          DataField = 'Documento'
          DataSource = dsplanta
          TabOrder = 6
        end
        object DBCcomplemento: TDBComboBox
          Left = 390
          Top = 81
          Width = 135
          Height = 23
          DataField = 'Complemento'
          DataSource = dsplanta
          ItemHeight = 15
          Items.Strings = (
            'CIFA - Comunicado'
            'CVLEA - Certid'#227'o'
            'PAS - Autua'#231#227'o'
            'Projeto - Abertura'
            'Projeto - Amplia'#231#227'o'
            'Projeto - An'#225'lise'
            'Projeto - Evento'
            'Projeto - Reforma')
          TabOrder = 4
          OnChange = DBCcomplementoChange
        end
        object DBMemo3: TDBMemo
          Left = 198
          Top = 129
          Width = 327
          Height = 23
          DataField = 'Observa'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 9
        end
        object GBTramita: TGroupBox
          Left = 12
          Top = 160
          Width = 733
          Height = 287
          Caption = 'Tramita'#231#245'es/Juntada'
          TabOrder = 11
          object Bevel3: TBevel
            Left = 384
            Top = 14
            Width = 337
            Height = 50
            Shape = bsFrame
            Style = bsRaised
          end
          object Label99: TLabel
            Left = 8
            Top = 17
            Width = 100
            Height = 15
            Caption = 'Descri'#231#227'o da fase'
          end
          object Label102: TLabel
            Left = 203
            Top = 17
            Width = 115
            Height = 15
            Caption = 'Destino do processo'
          end
          object Label97: TLabel
            Left = 8
            Top = 62
            Width = 130
            Height = 15
            Caption = 'Conte'#250'do/Observa'#231#245'es'
          end
          object Label10: TLabel
            Left = 392
            Top = 17
            Width = 111
            Height = 15
            Caption = 'Ducumento Juntado'
          end
          object Label103: TLabel
            Left = 545
            Top = 17
            Width = 48
            Height = 15
            Caption = 'Part'#237'cipe'
          end
          object DBCdescric: TDBComboBox
            Left = 8
            Top = 33
            Width = 188
            Height = 23
            DataField = 'Descricao'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'Para An'#225'lise'
              'Para Arquivo'
              'Para Decis'#227'o'
              'Para Julgamento'
              'Para Manifesta'#231#227'o'
              'Para Notificar o Regulado'
              'Para Provid'#234'ncias'
              'Para Rean'#225'lise')
            Sorted = True
            TabOrder = 0
            OnChange = DBCdescricChange
          end
          object DBCdestino: TDBComboBox
            Left = 203
            Top = 33
            Width = 174
            Height = 23
            CharCase = ecUpperCase
            DataField = 'Destino'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'DIRETORIA'
              'GER'#202'NCIA'
              'N'#218'CLEO DE ENGENHARIA'
              'N'#218'CLEO DO PAS'
              'N'#218'CLEO DO RPA'
              'SERVI'#199'O DE NOTIFICA'#199#195'O'
              'TURMA JULGADORA'
              'ARQUIVO'
              'OUTRA REPARTI'#199#195'O'
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
            TabOrder = 1
            OnChange = DBCdestinoChange
          end
          object DBMemo2: TDBMemo
            Left = 8
            Top = 78
            Width = 713
            Height = 67
            DataField = 'Despacho'
            DataSource = dstramitacao
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 4
          end
          object DBGTramita: TDBGrid
            Left = 8
            Top = 152
            Width = 713
            Height = 129
            Color = clMoneyGreen
            DataSource = dstramitacao
            ReadOnly = True
            TabOrder = 5
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'Protocolo'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Data'
                Width = 68
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Hora'
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Descricao'
                Width = 193
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Destino'
                Width = 192
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Usuario'
                Width = 147
                Visible = True
              end>
          end
          object DBCJuntada: TDBComboBox
            Left = 391
            Top = 33
            Width = 146
            Height = 23
            DataField = 'Juntada'
            DataSource = dstramitacao
            Enabled = False
            ItemHeight = 15
            Items.Strings = (
              'Despacho da Ger'#234'ncia'
              'PAS - Defesa'
              'PAS - Recurso'
              'Projeto para rean'#225'lise'
              'Outro documento')
            TabOrder = 2
            OnChange = DBCJuntadaChange
          end
          object DBEInteressado: TDBEdit
            Left = 545
            Top = 33
            Width = 169
            Height = 23
            Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
            CharCase = ecUpperCase
            DataField = 'Interessado'
            DataSource = dstramitacao
            Enabled = False
            TabOrder = 3
          end
        end
        object DBEdit29: TDBEdit
          Left = 535
          Top = 129
          Width = 209
          Height = 23
          Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
          TabStop = False
          CharCase = ecUpperCase
          Color = clInfoBk
          DataField = 'Ecarregado'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
        end
      end
    end
    object TabProjeto: TTabSheet
      Caption = 'PA'
      ImageIndex = 8
      object GroupBox18: TGroupBox
        Left = 2
        Top = 3
        Width = 760
        Height = 453
        Caption = 'Hist'#243'rico de Projeto Arquitet'#244'nico'
        TabOrder = 0
        object Label135: TLabel
          Left = 500
          Top = 65
          Width = 40
          Height = 15
          Caption = 'Celular'
        end
        object Label136: TLabel
          Left = 214
          Top = 65
          Width = 65
          Height = 15
          Caption = 'Requerente'
        end
        object Label137: TLabel
          Left = 605
          Top = 65
          Width = 111
          Height = 15
          Caption = 'Endere'#231'o Eletr'#244'nico'
        end
        object Label138: TLabel
          Left = 12
          Top = 65
          Width = 26
          Height = 15
          Caption = 'Data'
        end
        object Label139: TLabel
          Left = 12
          Top = 112
          Width = 45
          Height = 15
          Caption = 'Assunto'
        end
        object Label140: TLabel
          Left = 53
          Top = 65
          Width = 27
          Height = 15
          Caption = 'Hora'
        end
        object Label141: TLabel
          Left = 393
          Top = 65
          Width = 63
          Height = 15
          Caption = 'Identica'#231#227'o'
        end
        object Label142: TLabel
          Left = 93
          Top = 65
          Width = 55
          Height = 15
          Caption = 'Atendente'
        end
        object Label143: TLabel
          Left = 393
          Top = 112
          Width = 73
          Height = 15
          Caption = 'Observa'#231#245'es'
        end
        object Label144: TLabel
          Left = 214
          Top = 112
          Width = 108
          Height = 15
          Caption = 'Tipo de Documento'
        end
        object Panel4: TPanel
          Left = 12
          Top = 16
          Width = 734
          Height = 44
          BevelInner = bvRaised
          TabOrder = 0
          object Bevel12: TBevel
            Left = 600
            Top = 3
            Width = 129
            Height = 38
          end
          object SpeedButton19: TSpeedButton
            Left = 4
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Protocola'
            Caption = 'Registra'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5000555555555555577755555555555550B0555555555555F7F7555555555550
              00B05555555555577757555555555550B3B05555555555F7F557555555555000
              3B0555555555577755755555555500B3B0555555555577555755555555550B3B
              055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
              555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
              55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
              555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
              55555575FFFF7755555555570000755555555557777775555555}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtregistraClick
          end
          object SpeedButton20: TSpeedButton
            Left = 154
            Top = 3
            Width = 40
            Height = 38
            Hint = 'Grava'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BrgravaprotoClick
          end
          object SpeedButton21: TSpeedButton
            Left = 194
            Top = 3
            Width = 41
            Height = 38
            Hint = 'Cancela'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtcancelaprotoClick
          end
          object SpeedButton22: TSpeedButton
            Left = 235
            Top = 3
            Width = 39
            Height = 38
            Hint = 'Exclui'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdeletaprotoClick
          end
          object SpeedButton23: TSpeedButton
            Left = 54
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Tramita Processo'
            Caption = 'Tramita'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
              BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
              BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
              BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
              BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
              EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
              EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
              EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
              EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtandamentoClick
          end
          object SpeedButton24: TSpeedButton
            Left = 431
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Protocolo/Capa do Processo'
            Caption = 'Protocolo'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
              00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
              8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
              8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
              8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
              03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
              03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
              33333337FFFF7733333333300000033333333337777773333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton25: TSpeedButton
            Left = 104
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Anexa novo documento ao processo existente'
            Caption = 'Juntada'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
              FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
              00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
              F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
              00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
              F033777777777337F73309999990FFF0033377777777FFF77333099999000000
              3333777777777777333333399033333333333337773333333333333903333333
              3333333773333333333333303333333333333337333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdespachoClick
          end
          object SpeedButton26: TSpeedButton
            Left = 486
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'Remesa'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
              333333333333337FF3333333333333903333333333333377FF33333333333399
              03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
              99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
              99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
              03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
              33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
              33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
              3333777777333333333333333333333333333333333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtRemessaClick
          end
          object DBText4: TDBText
            Left = 603
            Top = 8
            Width = 126
            Height = 28
            DataField = 'Protocolo'
            DataSource = dsplanta
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -27
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SpeedButton27: TSpeedButton
            Left = 541
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'PT Juntada'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BitPtJuntadaClick
          end
          object DBNavigator3: TDBNavigator
            Left = 275
            Top = 3
            Width = 156
            Height = 38
            Hint = 'Navega Tabela de Protocolo'
            DataSource = dsplanta
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object DBEdit48: TDBEdit
          Left = 500
          Top = 81
          Width = 98
          Height = 23
          Hint = 'Celular da pesoa que est'#225'  registrando a entrada'
          Color = clInfoBk
          DataField = 'Celular'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit49: TDBEdit
          Left = 214
          Top = 81
          Width = 174
          Height = 23
          Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
          CharCase = ecUpperCase
          Color = clInfoBk
          DataField = 'Protocolante'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit50: TDBEdit
          Left = 604
          Top = 81
          Width = 141
          Height = 23
          Hint = 'Email da pesoa que est'#225'  registrando a entrada'
          CharCase = ecLowerCase
          Color = clInfoBk
          DataField = 'Email'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit51: TDBEdit
          Left = 12
          Top = 81
          Width = 38
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Data'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnExit = DBEDtreqExit
        end
        object DBComboBox12: TDBComboBox
          Left = 12
          Top = 128
          Width = 197
          Height = 23
          Color = clInfoBk
          DataField = 'Assunto'
          DataSource = dsplanta
          ItemHeight = 15
          ReadOnly = True
          TabOrder = 8
          OnChange = DBCassuntoChange
        end
        object DBEdit52: TDBEdit
          Left = 53
          Top = 81
          Width = 38
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Hora'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnExit = DBEDtreqExit
        end
        object DBEdit53: TDBEdit
          Left = 393
          Top = 81
          Width = 102
          Height = 23
          Hint = 
            'Matr'#237'cula/RG/CPF/OAB/CREA da pesoa que est'#225'  registrando a entra' +
            'da'
          CharCase = ecUpperCase
          Color = clInfoBk
          DataField = 'Documento'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 5
        end
        object DBComboBox13: TDBComboBox
          Left = 214
          Top = 128
          Width = 175
          Height = 23
          Color = clInfoBk
          DataField = 'Complemento'
          DataSource = dsplanta
          ItemHeight = 15
          Items.Strings = (
            'CIFA - Documentos'
            'PAS - Autua'#231#227'o'
            'Projeto - Abertura'
            'Projeto - Amplia'#231#227'o'
            'Projeto - An'#225'lise'
            'Projeto - Evento'
            'Projeto - Reforma'
            'Diversos')
          ReadOnly = True
          TabOrder = 9
          OnChange = DBCcomplementoChange
        end
        object DBMemo8: TDBMemo
          Left = 393
          Top = 128
          Width = 352
          Height = 23
          Color = clInfoBk
          DataField = 'Observa'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 10
        end
        object GroupBox19: TGroupBox
          Left = 12
          Top = 160
          Width = 733
          Height = 287
          Caption = 'Tramita'#231#245'es/Juntada'
          TabOrder = 11
          object Bevel13: TBevel
            Left = 384
            Top = 14
            Width = 337
            Height = 50
            Shape = bsFrame
            Style = bsRaised
          end
          object Label145: TLabel
            Left = 8
            Top = 17
            Width = 100
            Height = 15
            Caption = 'Descri'#231#227'o da fase'
          end
          object Label146: TLabel
            Left = 203
            Top = 17
            Width = 115
            Height = 15
            Caption = 'Destino do processo'
          end
          object Label147: TLabel
            Left = 8
            Top = 62
            Width = 186
            Height = 15
            Caption = 'Despacho/Detalhes/Observa'#231#245'es'
          end
          object Label148: TLabel
            Left = 392
            Top = 17
            Width = 111
            Height = 15
            Caption = 'Ducumento Juntado'
          end
          object Label149: TLabel
            Left = 545
            Top = 17
            Width = 48
            Height = 15
            Caption = 'Part'#237'cipe'
          end
          object DBComboBox14: TDBComboBox
            Left = 8
            Top = 33
            Width = 188
            Height = 23
            Color = clInfoBk
            DataField = 'Descricao'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'Para An'#225'lise'
              'Para Arquivo'
              'Para Decis'#227'o'
              'Para Julgamento'
              'Para Manifesta'#231#227'o'
              'Para Notificar o Regulado'
              'Para Provid'#234'ncias'
              'Para Rean'#225'lise')
            ReadOnly = True
            Sorted = True
            TabOrder = 0
            OnChange = DBCdescricChange
          end
          object DBComboBox15: TDBComboBox
            Left = 203
            Top = 33
            Width = 174
            Height = 23
            CharCase = ecUpperCase
            Color = clInfoBk
            DataField = 'Destino'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'DIRETORIA'
              'GER'#202'NCIA'
              'CIFA'
              'N'#218'CLEO DO PAS'
              'N'#218'CLEO DE ENGENHARIA'
              'SERVI'#199'O DE NOTIFICA'#199#195'O'
              'TURMA JULGADORA'
              'ARQUIVO'
              'OUTRA REPARTI'#199#195'O'
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
              'GILSON REGINALDO'
              'GLEICIANE MARIA JOS'#201' DA SILVA'
              'G'#218'BIO DIAS PEREIRA'
              'JO'#195'O BATISTA LUCAS DA SILVA REIS'
              'JOS'#201' GERALDO DINIZ'
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
            OnChange = DBCdestinoChange
          end
          object DBMemo9: TDBMemo
            Left = 8
            Top = 78
            Width = 713
            Height = 67
            Color = clInfoBk
            DataField = 'Despacho'
            DataSource = dstramitacao
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 4
          end
          object DBGrid8: TDBGrid
            Left = 8
            Top = 152
            Width = 713
            Height = 129
            Color = clMoneyGreen
            DataSource = dstramitacao
            ReadOnly = True
            TabOrder = 5
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'Protocolo'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Data'
                Width = 68
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Hora'
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Descricao'
                Width = 193
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Destino'
                Width = 192
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Usuario'
                Width = 147
                Visible = True
              end>
          end
          object DBComboBox16: TDBComboBox
            Left = 391
            Top = 33
            Width = 146
            Height = 23
            Color = clInfoBk
            DataField = 'Juntada'
            DataSource = dstramitacao
            Enabled = False
            ItemHeight = 15
            Items.Strings = (
              'Despacho da Ger'#234'ncia'
              'PAS - Defesa'
              'PAS - Recurso'
              'Projeto para rean'#225'lise'
              'Outro documento')
            ReadOnly = True
            TabOrder = 2
            OnChange = DBCJuntadaChange
          end
          object DBEdit54: TDBEdit
            Left = 545
            Top = 33
            Width = 169
            Height = 23
            Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
            CharCase = ecUpperCase
            Color = clInfoBk
            DataField = 'Interessado'
            DataSource = dstramitacao
            Enabled = False
            ReadOnly = True
            TabOrder = 3
          end
        end
        object DBEdit55: TDBEdit
          Left = 93
          Top = 81
          Width = 114
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Usuario'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnExit = DBEDtreqExit
        end
      end
    end
    object TabPas: TTabSheet
      Caption = 'PAS'
      ImageIndex = 7
      object GroupBox14: TGroupBox
        Left = 2
        Top = 3
        Width = 760
        Height = 453
        Caption = 'Hist'#243'rico  Administrativo Sanit'#225'rio'
        TabOrder = 0
        object Label105: TLabel
          Left = 500
          Top = 65
          Width = 40
          Height = 15
          Caption = 'Celular'
        end
        object Label106: TLabel
          Left = 214
          Top = 65
          Width = 65
          Height = 15
          Caption = 'Requerente'
        end
        object Label107: TLabel
          Left = 605
          Top = 65
          Width = 111
          Height = 15
          Caption = 'Endere'#231'o Eletr'#244'nico'
        end
        object Label108: TLabel
          Left = 12
          Top = 65
          Width = 26
          Height = 15
          Caption = 'Data'
        end
        object Label109: TLabel
          Left = 12
          Top = 112
          Width = 45
          Height = 15
          Caption = 'Assunto'
        end
        object Label110: TLabel
          Left = 53
          Top = 65
          Width = 27
          Height = 15
          Caption = 'Hora'
        end
        object Label111: TLabel
          Left = 393
          Top = 65
          Width = 63
          Height = 15
          Caption = 'Identica'#231#227'o'
        end
        object Label112: TLabel
          Left = 93
          Top = 65
          Width = 55
          Height = 15
          Caption = 'Atendente'
        end
        object Label113: TLabel
          Left = 393
          Top = 112
          Width = 73
          Height = 15
          Caption = 'Observa'#231#245'es'
        end
        object Label114: TLabel
          Left = 214
          Top = 112
          Width = 108
          Height = 15
          Caption = 'Tipo de Documento'
        end
        object Panel2: TPanel
          Left = 12
          Top = 16
          Width = 734
          Height = 44
          BevelInner = bvRaised
          TabOrder = 0
          object Bevel4: TBevel
            Left = 600
            Top = 3
            Width = 129
            Height = 38
          end
          object SpeedButton1: TSpeedButton
            Left = 4
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Protocola'
            Caption = 'Registra'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5000555555555555577755555555555550B0555555555555F7F7555555555550
              00B05555555555577757555555555550B3B05555555555F7F557555555555000
              3B0555555555577755755555555500B3B0555555555577555755555555550B3B
              055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
              555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
              55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
              555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
              55555575FFFF7755555555570000755555555557777775555555}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtregistraClick
          end
          object SpeedButton2: TSpeedButton
            Left = 154
            Top = 3
            Width = 40
            Height = 38
            Hint = 'Grava'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BrgravaprotoClick
          end
          object SpeedButton3: TSpeedButton
            Left = 194
            Top = 3
            Width = 41
            Height = 38
            Hint = 'Cancela'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtcancelaprotoClick
          end
          object SpeedButton4: TSpeedButton
            Left = 235
            Top = 3
            Width = 39
            Height = 38
            Hint = 'Exclui'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdeletaprotoClick
          end
          object SpeedButton5: TSpeedButton
            Left = 54
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Tramita Processo'
            Caption = 'Tramita'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
              BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
              BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
              BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
              BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
              EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
              EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
              EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
              EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtandamentoClick
          end
          object SpeedButton6: TSpeedButton
            Left = 431
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Protocolo/Capa do Processo'
            Caption = 'Protocolo'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
              00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
              8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
              8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
              8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
              03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
              03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
              33333337FFFF7733333333300000033333333337777773333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton7: TSpeedButton
            Left = 104
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Anexa novo documento ao processo existente'
            Caption = 'Juntada'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
              FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
              00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
              F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
              00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
              F033777777777337F73309999990FFF0033377777777FFF77333099999000000
              3333777777777777333333399033333333333337773333333333333903333333
              3333333773333333333333303333333333333337333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdespachoClick
          end
          object SpeedButton8: TSpeedButton
            Left = 486
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'Remesa'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
              333333333333337FF3333333333333903333333333333377FF33333333333399
              03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
              99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
              99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
              03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
              33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
              33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
              3333777777333333333333333333333333333333333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtRemessaClick
          end
          object DBText2: TDBText
            Left = 603
            Top = 8
            Width = 126
            Height = 28
            DataField = 'Protocolo'
            DataSource = dsplanta
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -27
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SpeedButton9: TSpeedButton
            Left = 541
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'PT Juntada'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BitPtJuntadaClick
          end
          object DBNavigator1: TDBNavigator
            Left = 275
            Top = 3
            Width = 156
            Height = 38
            Hint = 'Navega Tabela de Protocolo'
            DataSource = dsplanta
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object DBEdit30: TDBEdit
          Left = 500
          Top = 81
          Width = 98
          Height = 23
          Hint = 'Celular da pesoa que est'#225'  registrando a entrada'
          Color = clInfoBk
          DataField = 'Celular'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit32: TDBEdit
          Left = 214
          Top = 81
          Width = 174
          Height = 23
          Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
          CharCase = ecUpperCase
          Color = clInfoBk
          DataField = 'Protocolante'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit34: TDBEdit
          Left = 604
          Top = 81
          Width = 141
          Height = 23
          Hint = 'Email da pesoa que est'#225'  registrando a entrada'
          CharCase = ecLowerCase
          Color = clInfoBk
          DataField = 'Email'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit35: TDBEdit
          Left = 12
          Top = 81
          Width = 38
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Data'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnExit = DBEDtreqExit
        end
        object DBComboBox2: TDBComboBox
          Left = 12
          Top = 128
          Width = 197
          Height = 23
          Color = clInfoBk
          DataField = 'Assunto'
          DataSource = dsplanta
          ItemHeight = 15
          ReadOnly = True
          TabOrder = 8
          OnChange = DBCassuntoChange
        end
        object DBEdit36: TDBEdit
          Left = 53
          Top = 81
          Width = 38
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Hora'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnExit = DBEDtreqExit
        end
        object DBEdit37: TDBEdit
          Left = 393
          Top = 81
          Width = 102
          Height = 23
          Hint = 
            'Matr'#237'cula/RG/CPF/OAB/CREA da pesoa que est'#225'  registrando a entra' +
            'da'
          CharCase = ecUpperCase
          Color = clInfoBk
          DataField = 'Documento'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 5
        end
        object DBComboBox3: TDBComboBox
          Left = 214
          Top = 128
          Width = 175
          Height = 23
          Color = clInfoBk
          DataField = 'Complemento'
          DataSource = dsplanta
          ItemHeight = 15
          Items.Strings = (
            'CIFA - Documentos'
            'PAS - Autua'#231#227'o'
            'Projeto - Abertura'
            'Projeto - Amplia'#231#227'o'
            'Projeto - An'#225'lise'
            'Projeto - Evento'
            'Projeto - Reforma'
            'Diversos')
          ReadOnly = True
          TabOrder = 9
          OnChange = DBCcomplementoChange
        end
        object DBMemo4: TDBMemo
          Left = 393
          Top = 128
          Width = 352
          Height = 23
          Color = clInfoBk
          DataField = 'Observa'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 10
        end
        object GroupBox15: TGroupBox
          Left = 12
          Top = 160
          Width = 733
          Height = 287
          Caption = 'Tramita'#231#245'es/Juntada'
          TabOrder = 11
          object Bevel9: TBevel
            Left = 384
            Top = 14
            Width = 337
            Height = 50
            Shape = bsFrame
            Style = bsRaised
          end
          object Label115: TLabel
            Left = 8
            Top = 17
            Width = 100
            Height = 15
            Caption = 'Descri'#231#227'o da fase'
          end
          object Label116: TLabel
            Left = 203
            Top = 17
            Width = 115
            Height = 15
            Caption = 'Destino do processo'
          end
          object Label117: TLabel
            Left = 8
            Top = 62
            Width = 186
            Height = 15
            Caption = 'Despacho/Detalhes/Observa'#231#245'es'
          end
          object Label118: TLabel
            Left = 392
            Top = 17
            Width = 111
            Height = 15
            Caption = 'Ducumento Juntado'
          end
          object Label119: TLabel
            Left = 545
            Top = 17
            Width = 48
            Height = 15
            Caption = 'Part'#237'cipe'
          end
          object DBComboBox4: TDBComboBox
            Left = 8
            Top = 33
            Width = 188
            Height = 23
            Color = clInfoBk
            DataField = 'Descricao'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'Para An'#225'lise'
              'Para Arquivo'
              'Para Decis'#227'o'
              'Para Julgamento'
              'Para Manifesta'#231#227'o'
              'Para Notificar o Regulado'
              'Para Provid'#234'ncias'
              'Para Rean'#225'lise')
            ReadOnly = True
            Sorted = True
            TabOrder = 0
            OnChange = DBCdescricChange
          end
          object DBComboBox5: TDBComboBox
            Left = 203
            Top = 33
            Width = 174
            Height = 23
            CharCase = ecUpperCase
            Color = clInfoBk
            DataField = 'Destino'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'DIRETORIA'
              'GER'#202'NCIA'
              'CIFA'
              'N'#218'CLEO DO PAS'
              'N'#218'CLEO DE ENGENHARIA'
              'SERVI'#199'O DE NOTIFICA'#199#195'O'
              'TURMA JULGADORA'
              'ARQUIVO'
              'OUTRA REPARTI'#199#195'O'
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
              'GILSON REGINALDO'
              'GLEICIANE MARIA JOS'#201' DA SILVA'
              'G'#218'BIO DIAS PEREIRA'
              'JO'#195'O BATISTA LUCAS DA SILVA REIS'
              'JOS'#201' GERALDO DINIZ'
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
            OnChange = DBCdestinoChange
          end
          object DBMemo5: TDBMemo
            Left = 8
            Top = 78
            Width = 713
            Height = 67
            Color = clInfoBk
            DataField = 'Despacho'
            DataSource = dstramitacao
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 4
          end
          object DBGrid6: TDBGrid
            Left = 8
            Top = 152
            Width = 713
            Height = 129
            Color = clMoneyGreen
            DataSource = dstramitacao
            ReadOnly = True
            TabOrder = 5
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'Protocolo'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Data'
                Width = 68
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Hora'
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Descricao'
                Width = 193
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Destino'
                Width = 192
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Usuario'
                Width = 147
                Visible = True
              end>
          end
          object DBComboBox6: TDBComboBox
            Left = 391
            Top = 33
            Width = 146
            Height = 23
            Color = clInfoBk
            DataField = 'Juntada'
            DataSource = dstramitacao
            Enabled = False
            ItemHeight = 15
            Items.Strings = (
              'Despacho da Ger'#234'ncia'
              'PAS - Defesa'
              'PAS - Recurso'
              'Projeto para rean'#225'lise'
              'Outro documento')
            ReadOnly = True
            TabOrder = 2
            OnChange = DBCJuntadaChange
          end
          object DBEdit38: TDBEdit
            Left = 545
            Top = 33
            Width = 169
            Height = 23
            Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
            CharCase = ecUpperCase
            Color = clInfoBk
            DataField = 'Interessado'
            DataSource = dstramitacao
            Enabled = False
            ReadOnly = True
            TabOrder = 3
          end
        end
        object DBEdit39: TDBEdit
          Left = 93
          Top = 81
          Width = 114
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Usuario'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnExit = DBEDtreqExit
        end
      end
    end
    object TabCan: TTabSheet
      Caption = 'RPA'
      ImageIndex = 9
      object GroupBox20: TGroupBox
        Left = 2
        Top = 3
        Width = 760
        Height = 453
        Caption = 'Hist'#243'rico de Comunica'#231#227'o de Alimento Novo e Exporta'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label150: TLabel
          Left = 500
          Top = 65
          Width = 40
          Height = 15
          Caption = 'Celular'
        end
        object Label151: TLabel
          Left = 214
          Top = 65
          Width = 65
          Height = 15
          Caption = 'Requerente'
        end
        object Label152: TLabel
          Left = 605
          Top = 65
          Width = 111
          Height = 15
          Caption = 'Endere'#231'o Eletr'#244'nico'
        end
        object Label153: TLabel
          Left = 12
          Top = 65
          Width = 26
          Height = 15
          Caption = 'Data'
        end
        object Label154: TLabel
          Left = 12
          Top = 112
          Width = 45
          Height = 15
          Caption = 'Assunto'
        end
        object Label155: TLabel
          Left = 53
          Top = 65
          Width = 27
          Height = 15
          Caption = 'Hora'
        end
        object Label156: TLabel
          Left = 393
          Top = 65
          Width = 63
          Height = 15
          Caption = 'Identica'#231#227'o'
        end
        object Label157: TLabel
          Left = 93
          Top = 65
          Width = 55
          Height = 15
          Caption = 'Atendente'
        end
        object Label158: TLabel
          Left = 393
          Top = 112
          Width = 73
          Height = 15
          Caption = 'Observa'#231#245'es'
        end
        object Label159: TLabel
          Left = 214
          Top = 112
          Width = 108
          Height = 15
          Caption = 'Tipo de Documento'
        end
        object Panel5: TPanel
          Left = 12
          Top = 16
          Width = 734
          Height = 44
          BevelInner = bvRaised
          TabOrder = 0
          object Bevel14: TBevel
            Left = 600
            Top = 3
            Width = 129
            Height = 38
          end
          object SpeedButton28: TSpeedButton
            Left = 4
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Protocola'
            Caption = 'Registra'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5000555555555555577755555555555550B0555555555555F7F7555555555550
              00B05555555555577757555555555550B3B05555555555F7F557555555555000
              3B0555555555577755755555555500B3B0555555555577555755555555550B3B
              055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
              555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
              55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
              555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
              55555575FFFF7755555555570000755555555557777775555555}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtregistraClick
          end
          object SpeedButton29: TSpeedButton
            Left = 154
            Top = 3
            Width = 40
            Height = 38
            Hint = 'Grava'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BrgravaprotoClick
          end
          object SpeedButton30: TSpeedButton
            Left = 194
            Top = 3
            Width = 41
            Height = 38
            Hint = 'Cancela'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtcancelaprotoClick
          end
          object SpeedButton31: TSpeedButton
            Left = 235
            Top = 3
            Width = 39
            Height = 38
            Hint = 'Exclui'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdeletaprotoClick
          end
          object SpeedButton32: TSpeedButton
            Left = 54
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Tramita Processo'
            Caption = 'Tramita'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033BBBBBBBBBB
              BB33337777777777777F33BB00BBBBBBBB33337F77333333F37F33BB0BBBBBB0
              BB33337F73F33337FF7F33BBB0BBBB000B33337F37FF3377737F33BBB00BB00B
              BB33337F377F3773337F33BBBB0B00BBBB33337F337F7733337F33BBBB000BBB
              BB33337F33777F33337F33EEEE000EEEEE33337F3F777FFF337F33EE0E80000E
              EE33337F73F77773337F33EEE0800EEEEE33337F37377F33337F33EEEE000EEE
              EE33337F33777F33337F33EEEEE00EEEEE33337F33377FF3337F33EEEEEE00EE
              EE33337F333377F3337F33EEEEEE00EEEE33337F33337733337F33EEEEEEEEEE
              EE33337FFFFFFFFFFF7F33EEEEEEEEEEEE333377777777777773}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtandamentoClick
          end
          object SpeedButton33: TSpeedButton
            Left = 431
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Protocolo/Capa do Processo'
            Caption = 'Protocolo'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
              00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
              8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
              8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
              8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
              03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
              03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
              33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
              33333337FFFF7733333333300000033333333337777773333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton34: TSpeedButton
            Left = 104
            Top = 3
            Width = 50
            Height = 38
            Hint = 'Anexa novo documento ao processo existente'
            Caption = 'Juntada'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
              FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
              00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
              F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
              00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
              F033777777777337F73309999990FFF0033377777777FFF77333099999000000
              3333777777777777333333399033333333333337773333333333333903333333
              3333333773333333333333303333333333333337333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtdespachoClick
          end
          object SpeedButton35: TSpeedButton
            Left = 486
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'Remesa'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
              333333333333337FF3333333333333903333333333333377FF33333333333399
              03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
              99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
              99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
              03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
              33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
              33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
              3333777777333333333333333333333333333333333333333333}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = BtRemessaClick
          end
          object DBText5: TDBText
            Left = 603
            Top = 8
            Width = 126
            Height = 28
            DataField = 'Protocolo'
            DataSource = dsplanta
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -27
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SpeedButton36: TSpeedButton
            Left = 541
            Top = 3
            Width = 55
            Height = 38
            Hint = 'Emite Termo de Remessa'
            Caption = 'PT Juntada'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
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
            ParentShowHint = False
            ShowHint = True
            OnClick = BitPtJuntadaClick
          end
          object DBNavigator4: TDBNavigator
            Left = 275
            Top = 3
            Width = 156
            Height = 38
            Hint = 'Navega Tabela de Protocolo'
            DataSource = dsplanta
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object DBEdit56: TDBEdit
          Left = 500
          Top = 81
          Width = 98
          Height = 23
          Hint = 'Celular da pesoa que est'#225'  registrando a entrada'
          Color = clInfoBk
          DataField = 'Celular'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit57: TDBEdit
          Left = 214
          Top = 81
          Width = 174
          Height = 23
          Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
          CharCase = ecUpperCase
          Color = clInfoBk
          DataField = 'Protocolante'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit58: TDBEdit
          Left = 604
          Top = 81
          Width = 141
          Height = 23
          Hint = 'Email da pesoa que est'#225'  registrando a entrada'
          CharCase = ecLowerCase
          Color = clInfoBk
          DataField = 'Email'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit59: TDBEdit
          Left = 12
          Top = 81
          Width = 38
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Data'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnExit = DBEDtreqExit
        end
        object DBComboBox17: TDBComboBox
          Left = 12
          Top = 128
          Width = 197
          Height = 23
          Color = clInfoBk
          DataField = 'Assunto'
          DataSource = dsplanta
          ItemHeight = 15
          ReadOnly = True
          TabOrder = 8
          OnChange = DBCassuntoChange
        end
        object DBEdit60: TDBEdit
          Left = 53
          Top = 81
          Width = 38
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Hora'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnExit = DBEDtreqExit
        end
        object DBEdit61: TDBEdit
          Left = 393
          Top = 81
          Width = 102
          Height = 23
          Hint = 
            'Matr'#237'cula/RG/CPF/OAB/CREA da pesoa que est'#225'  registrando a entra' +
            'da'
          CharCase = ecUpperCase
          Color = clInfoBk
          DataField = 'Documento'
          DataSource = dsplanta
          ReadOnly = True
          TabOrder = 5
        end
        object DBComboBox18: TDBComboBox
          Left = 214
          Top = 128
          Width = 175
          Height = 23
          Color = clInfoBk
          DataField = 'Complemento'
          DataSource = dsplanta
          ItemHeight = 15
          Items.Strings = (
            'CIFA - Documentos'
            'PAS - Autua'#231#227'o'
            'Projeto - Abertura'
            'Projeto - Amplia'#231#227'o'
            'Projeto - An'#225'lise'
            'Projeto - Evento'
            'Projeto - Reforma'
            'Diversos')
          ReadOnly = True
          TabOrder = 9
          OnChange = DBCcomplementoChange
        end
        object DBMemo10: TDBMemo
          Left = 393
          Top = 128
          Width = 352
          Height = 23
          Color = clInfoBk
          DataField = 'Observa'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 10
        end
        object GroupBox21: TGroupBox
          Left = 12
          Top = 160
          Width = 733
          Height = 287
          Caption = 'Tramita'#231#245'es/Juntada'
          TabOrder = 11
          object Bevel15: TBevel
            Left = 384
            Top = 14
            Width = 337
            Height = 50
            Shape = bsFrame
            Style = bsRaised
          end
          object Label160: TLabel
            Left = 8
            Top = 17
            Width = 100
            Height = 15
            Caption = 'Descri'#231#227'o da fase'
          end
          object Label161: TLabel
            Left = 203
            Top = 17
            Width = 115
            Height = 15
            Caption = 'Destino do processo'
          end
          object Label162: TLabel
            Left = 8
            Top = 62
            Width = 186
            Height = 15
            Caption = 'Despacho/Detalhes/Observa'#231#245'es'
          end
          object Label163: TLabel
            Left = 392
            Top = 17
            Width = 111
            Height = 15
            Caption = 'Ducumento Juntado'
          end
          object Label164: TLabel
            Left = 545
            Top = 17
            Width = 48
            Height = 15
            Caption = 'Part'#237'cipe'
          end
          object DBComboBox19: TDBComboBox
            Left = 8
            Top = 33
            Width = 188
            Height = 23
            Color = clInfoBk
            DataField = 'Descricao'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'Para An'#225'lise'
              'Para Arquivo'
              'Para Decis'#227'o'
              'Para Julgamento'
              'Para Manifesta'#231#227'o'
              'Para Notificar o Regulado'
              'Para Provid'#234'ncias'
              'Para Rean'#225'lise')
            ReadOnly = True
            Sorted = True
            TabOrder = 0
            OnChange = DBCdescricChange
          end
          object DBComboBox20: TDBComboBox
            Left = 203
            Top = 33
            Width = 174
            Height = 23
            CharCase = ecUpperCase
            Color = clInfoBk
            DataField = 'Destino'
            DataSource = dstramitacao
            ItemHeight = 15
            Items.Strings = (
              'DIRETORIA'
              'GER'#202'NCIA'
              'N'#218'CLEO DO RPA'
              'N'#218'CLEO DO PAS'
              'N'#218'CLEO DE ENGENHARIA'
              'SERVI'#199'O DE NOTIFICA'#199#195'O'
              'TURMA JULGADORA'
              'ARQUIVO'
              'OUTRA REPARTI'#199#195'O'
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
              'GILSON REGINALDO'
              'GLEICIANE MARIA JOS'#201' DA SILVA'
              'G'#218'BIO DIAS PEREIRA'
              'JO'#195'O BATISTA LUCAS DA SILVA REIS'
              'JOS'#201' GERALDO DINIZ'
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
            OnChange = DBCdestinoChange
          end
          object DBMemo11: TDBMemo
            Left = 8
            Top = 78
            Width = 713
            Height = 67
            Color = clInfoBk
            DataField = 'Despacho'
            DataSource = dstramitacao
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 4
          end
          object DBGrid9: TDBGrid
            Left = 8
            Top = 152
            Width = 713
            Height = 129
            Color = clMoneyGreen
            DataSource = dstramitacao
            ReadOnly = True
            TabOrder = 5
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'Protocolo'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Data'
                Width = 68
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Hora'
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Descricao'
                Width = 193
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Destino'
                Width = 192
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Usuario'
                Width = 147
                Visible = True
              end>
          end
          object DBComboBox21: TDBComboBox
            Left = 391
            Top = 33
            Width = 146
            Height = 23
            Color = clInfoBk
            DataField = 'Juntada'
            DataSource = dstramitacao
            Enabled = False
            ItemHeight = 15
            Items.Strings = (
              'Despacho da Ger'#234'ncia'
              'PAS - Defesa'
              'PAS - Recurso'
              'Projeto para rean'#225'lise'
              'Outro documento')
            ReadOnly = True
            TabOrder = 2
            OnChange = DBCJuntadaChange
          end
          object DBEdit62: TDBEdit
            Left = 545
            Top = 33
            Width = 169
            Height = 23
            Hint = 'Nome completo da pessoa que est'#225'  registrando a entrada'
            CharCase = ecUpperCase
            Color = clInfoBk
            DataField = 'Interessado'
            DataSource = dstramitacao
            Enabled = False
            ReadOnly = True
            TabOrder = 3
          end
        end
        object DBEdit63: TDBEdit
          Left = 93
          Top = 81
          Width = 114
          Height = 24
          TabStop = False
          Color = clInfoBk
          DataField = 'Usuario'
          DataSource = dsplanta
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnExit = DBEDtreqExit
        end
      end
    end
  end
  object dssequencia: TDataSource
    AutoEdit = False
    DataSet = tbsequencia
    Left = 660
    Top = 52
  end
  object tbsequencia: TTable
    DatabaseName = 'wcvs'
    TableName = 'sequencia.DB'
    Left = 668
    Top = 60
    object tbsequenciaNumero: TIntegerField
      FieldName = 'Numero'
    end
    object tbsequenciaDoc: TIntegerField
      FieldName = 'Doc'
    end
    object tbsequenciaDen: TIntegerField
      FieldName = 'Den'
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
    object tbsequenciaAlvara: TIntegerField
      FieldName = 'Alvara'
    end
    object tbsequenciaPt: TIntegerField
      FieldName = 'Pt'
    end
    object tbsequenciaVeiculo: TIntegerField
      FieldName = 'Veiculo'
    end
    object tbsequenciaProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbsequenciaOficio: TIntegerField
      FieldName = 'Oficio'
    end
  end
  object dscontrib: TDataSource
    AutoEdit = False
    DataSet = tbcontrib
    OnStateChange = dscontribStateChange
    Left = 696
    Top = 16
  end
  object tbcontrib: TTable
    BeforeScroll = tbcontribBeforeScroll
    AfterScroll = tbcontribAfterScroll
    DatabaseName = 'wcvs'
    Filtered = True
    IndexFieldNames = 'CONTROLE'
    TableName = 'CONTRIB.DB'
    Left = 656
    Top = 16
    object tbcontribCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbcontribCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcontribFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object tbcontribLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 40
    end
    object tbcontribATIVIDADE: TSmallintField
      FieldName = 'ATIVIDADE'
    end
    object tbcontribObs: TMemoField
      FieldName = 'Obs'
      BlobType = ftMemo
      Size = 10
    end
    object tbcontribCEP: TStringField
      FieldName = 'CEP'
      EditMask = '00\-000\-000;1;_'
      Size = 10
    end
    object tbcontribFONE: TStringField
      FieldName = 'FONE'
      EditMask = '0000-0000;1;_'
      Size = 9
    end
    object tbcontribTAXA: TBooleanField
      FieldName = 'TAXA'
    end
    object tbcontribCGC: TStringField
      FieldName = 'CGC'
      EditMask = '00\.000\.000\/0000\-00;1;_'
      Size = 18
    end
    object tbcontribMUNICIPAL: TStringField
      FieldName = 'MUNICIPAL'
      EditMask = '000.000;1;_'
      Size = 7
    end
    object tbcontribINATIVIDADE: TBooleanField
      FieldName = 'INATIVIDADE'
      OnChange = tbcontribINATIVIDADEChange
    end
    object tbcontribRAZAO: TStringField
      DisplayWidth = 40
      FieldName = 'RAZAO'
      FixedChar = True
      Size = 50
    end
    object tbcontribAREA: TIntegerField
      FieldName = 'AREA'
    end
    object tbcontribGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbcontribEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object tbcontribCDBAI: TIntegerField
      FieldName = 'CDBAI'
    end
    object tbcontribDt_cadastro: TDateField
      FieldName = 'Dt_cadastro'
      EditMask = '!99/99/0000;1;_'
    end
    object tbcontribBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object tbcontribCOMPLEMENT: TStringField
      DisplayWidth = 30
      FieldName = 'COMPLEMENT'
      Size = 30
    end
    object tbcontribPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 4
    end
    object tbcontribCPF: TStringField
      FieldName = 'CPF'
      EditMask = '000\.000\.000\-00;1;_'
      Size = 14
    end
    object tbcontribAGREGADO: TBooleanField
      FieldName = 'AGREGADO'
    end
    object tbcontribZONA: TSmallintField
      FieldName = 'ZONA'
    end
    object tbcontribUser: TStringField
      FieldName = 'User'
      Size = 30
    end
    object tbcontribDt_alter: TDateField
      FieldName = 'Dt_alter'
    end
    object tbcontribH_alter: TTimeField
      FieldName = 'H_alter'
    end
    object tbcontribPendoc: TBooleanField
      FieldName = 'Pendoc'
    end
    object tbcontribREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 40
    end
    object tbcontribCPFREPRES: TStringField
      FieldName = 'CPFREPRES'
      EditMask = '000\.000\.000\-00;1;_'
      Size = 14
    end
    object tbcontribHORARIO: TStringField
      FieldName = 'HORARIO'
      Size = 15
    end
    object tbcontribREPRESENTANTE2: TStringField
      FieldName = 'REPRESENTANTE2'
      Size = 40
    end
    object tbcontribCPFREPRES2: TStringField
      FieldName = 'CPFREPRES2'
      EditMask = '000\.000\.000\-00;1;_'
      Size = 14
    end
    object tbcontribCELULAR: TStringField
      FieldName = 'CELULAR'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 14
    end
  end
  object tbvisitas: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodVisita'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'VISITAS.DB'
    Left = 704
    Top = 64
    object tbvisitasCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbvisitasCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbvisitasDT_VISITA: TDateField
      FieldName = 'DT_VISITA'
      EditMask = '!99/99/0000;1;_'
    end
    object tbvisitasPZ_RETORNO: TSmallintField
      FieldName = 'PZ_RETORNO'
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
    object tbvisitasTIPO: TStringField
      DisplayWidth = 35
      FieldName = 'TIPO'
      Size = 35
    end
    object tbvisitasACAO: TStringField
      DefaultExpression = #39'INSPE'#199#195'O SANIT'#193'RIA'#39
      FieldName = 'ACAO'
      Size = 35
    end
    object tbvisitasDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbvisitasNUMERO: TStringField
      FieldName = 'NUMERO'
      EditMask = '000\.000;0;_'
      Size = 6
    end
    object tbvisitasAtividade: TStringField
      FieldName = 'Atividade'
      Size = 9
    end
    object tbvisitasUs_inclu: TStringField
      FieldName = 'Us_inclu'
      Size = 40
    end
    object tbvisitasDt_inclu: TDateField
      FieldName = 'Dt_inclu'
      EditMask = '!99/99/0000;1;_'
    end
    object tbvisitasGr_inclu: TStringField
      FieldName = 'Gr_inclu'
      Size = 3
    end
    object tbvisitasUs_altera: TStringField
      FieldName = 'Us_altera'
      Size = 40
    end
    object tbvisitasDt_altera: TDateField
      FieldName = 'Dt_altera'
      EditMask = '!99/99/0000;1;_'
    end
    object tbvisitasOS: TIntegerField
      FieldName = 'OS'
    end
    object tbvisitasPRIORIDADE: TBooleanField
      FieldName = 'PRIORIDADE'
    end
    object tbvisitasEntrega: TBooleanField
      FieldName = 'Entrega'
    end
    object tbvisitasLibera: TStringField
      FieldName = 'Libera'
      Size = 12
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
    object tbvisitasMeio: TStringField
      FieldName = 'Meio'
      Size = 7
    end
  end
  object dsvisitas: TDataSource
    AutoEdit = False
    DataSet = tbvisitas
    OnStateChange = dsvisitasStateChange
    Left = 696
    Top = 48
  end
  object tbativi: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'NOME'
    TableName = 'ATIVI.DB'
    Left = 264
    Top = 40
    object tbativiCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbativiNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object tbativiNOME: TStringField
      FieldName = 'NOME'
    end
    object tbativiGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbativiAREA: TStringField
      FieldName = 'AREA'
    end
    object tbativiSINAVISA: TIntegerField
      FieldName = 'SINAVISA'
    end
    object tbativiVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
  end
  object dsativi: TDataSource
    AutoEdit = False
    DataSet = tbativi
    Left = 272
    Top = 48
  end
  object dshistorico: TDataSource
    AutoEdit = False
    DataSet = tbhistorico
    Left = 384
    Top = 8
  end
  object tbhistorico: TTable
    DatabaseName = 'wcvs'
    IndexName = 'porndoc'
    MasterFields = 'NDOC'
    MasterSource = dsvisitas
    TableName = 'HISTORICO.DB'
    Left = 456
    Top = 8
    object tbhistoricoCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbhistoricoNDOC: TIntegerField
      FieldName = 'NDOC'
    end
    object tbhistoricoDESCR: TMemoField
      FieldName = 'DESCR'
      BlobType = ftMemo
      Size = 32
    end
    object tbhistoricoDISPOSITIVO: TMemoField
      FieldName = 'DISPOSITIVO'
      BlobType = ftMemo
      Size = 10
    end
  end
  object tbalvara: TTable
    DatabaseName = 'WCVS'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'alvara.db'
    Left = 480
    Top = 8
    object tbalvaraControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbalvaraCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbalvaraExercicio: TIntegerField
      FieldName = 'Exercicio'
    end
    object tbalvaraNumero: TIntegerField
      FieldName = 'Numero'
    end
    object tbalvaraDuam: TIntegerField
      FieldName = 'Duam'
    end
    object tbalvaraDt_duam: TDateField
      FieldName = 'Dt_duam'
      EditMask = '!99/99/0000;1;_'
    end
    object tbalvaraObs: TMemoField
      FieldName = 'Obs'
      BlobType = ftMemo
      Size = 10
    end
    object tbalvaraUnidade: TStringField
      DefaultExpression = #39'GERAL'#39
      FieldName = 'Unidade'
    end
    object tbalvaraLibera: TBooleanField
      FieldName = 'Libera'
    end
    object tbalvaraAutoridade: TStringField
      FieldName = 'Autoridade'
      Size = 40
    end
    object tbalvaraDt_libera: TDateField
      FieldName = 'Dt_libera'
      EditMask = '!99/99/0000;1;_'
    end
    object tbalvaraDt_emite: TDateField
      FieldName = 'Dt_emite'
      EditMask = '!99/99/0000;1;_'
    end
    object tbalvaraEmitente: TStringField
      FieldName = 'Emitente'
      Size = 40
    end
    object tbalvaraAutenticador: TStringField
      FieldName = 'Autenticador'
      Size = 10
    end
    object tbalvaraDt_reemite: TDateField
      FieldName = 'Dt_reemite'
    end
    object tbalvaraReemitente: TStringField
      FieldName = 'Reemitente'
      Size = 40
    end
    object tbalvaraRequerente: TStringField
      FieldName = 'Requerente'
      Size = 40
    end
    object tbalvaraOb_duam: TMemoField
      FieldName = 'Ob_duam'
      BlobType = ftMemo
      Size = 10
    end
    object tbalvaraDt_validade: TDateField
      FieldName = 'Dt_validade'
    end
    object tbalvaraTipo: TBooleanField
      FieldName = 'Tipo'
    end
    object tbalvaraCancela: TBooleanField
      FieldName = 'Cancela'
    end
    object tbalvaraCancelador: TStringField
      FieldName = 'Cancelador'
      Size = 40
    end
    object tbalvaraDt_cancela: TDateField
      FieldName = 'Dt_cancela'
    end
    object tbalvaraEvento: TBooleanField
      FieldName = 'Evento'
    end
    object tbalvaraAlteracao: TStringField
      FieldName = 'Alteracao'
      Size = 40
    end
    object tbalvaraDt_altera: TDateField
      FieldName = 'Dt_altera'
    end
  end
  object dsalvara: TDataSource
    AutoEdit = False
    DataSet = tbalvara
    OnStateChange = dsalvaraStateChange
    Left = 504
    Top = 16
  end
  object tbrt: TTable
    DatabaseName = 'WCVS'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'rt.DB'
    Left = 580
    Top = 48
    object tbrtControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbrtCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbrtNomeResp1: TStringField
      FieldName = 'NomeResp1'
      Size = 40
    end
    object tbrtConsResp1: TStringField
      FieldName = 'ConsResp1'
    end
    object tbrtUFResp1: TStringField
      FieldName = 'UFResp1'
      Size = 2
    end
    object tbrtRegResp1: TStringField
      FieldName = 'RegResp1'
    end
    object tbrtNomeResp2: TStringField
      FieldName = 'NomeResp2'
      Size = 40
    end
    object tbrtConsResp2: TStringField
      FieldName = 'ConsResp2'
    end
    object tbrtUFResp2: TStringField
      FieldName = 'UFResp2'
      Size = 2
    end
    object tbrtRegResp2: TStringField
      FieldName = 'RegResp2'
    end
    object tbrtAtividade: TStringField
      FieldName = 'Atividade'
      Size = 80
    end
    object tbrtSubclasse: TStringField
      FieldName = 'Subclasse'
      Size = 9
    end
    object tbrtTipo: TStringField
      FieldName = 'Tipo'
      Size = 10
    end
    object tbrtEquipe: TStringField
      FieldName = 'Equipe'
      Size = 2
    end
  end
  object dsrt: TDataSource
    AutoEdit = False
    DataSet = tbrt
    OnStateChange = dsrtStateChange
    Left = 592
    Top = 64
  end
  object dsarea: TDataSource
    AutoEdit = False
    DataSet = tbarea
    Left = 344
    Top = 40
  end
  object tbarea: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Nome'
    MasterSource = dscontrib
    TableName = 'area.db'
    Left = 376
    Top = 56
    object tbareaCod: TIntegerField
      FieldName = 'Cod'
    end
    object tbareaNome: TStringField
      FieldName = 'Nome'
    end
  end
  object tbgrupo: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'DESCRICAO'
    MasterSource = dscontrib
    TableName = 'grupo.DB'
    Left = 296
    Top = 40
    object tbgrupoCOD: TIntegerField
      FieldName = 'COD'
    end
    object tbgrupoGRUPO: TStringField
      FieldName = 'GRUPO'
      Size = 3
    end
    object tbgrupoAREA: TIntegerField
      FieldName = 'AREA'
    end
    object tbgrupoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 115
    end
    object tbgrupoVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
    object tbgrupoPORTE: TStringField
      FieldName = 'PORTE'
      Size = 10
    end
  end
  object dsgrupo: TDataSource
    AutoEdit = False
    DataSet = tbgrupo
    Left = 304
    Top = 48
  end
  object dsbairro: TDataSource
    AutoEdit = False
    DataSet = tbbairro
    Left = 512
  end
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'bairro.db'
    Left = 480
    object tbbairroCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbbairroNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object tbbairroSETOR: TIntegerField
      FieldName = 'SETOR'
    end
    object tbbairroCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
  object tbsinavisa: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'SINAVISA'
    MasterSource = dsativi
    TableName = 'COMPLE.DB'
    Left = 216
    Top = 40
    object tbsinavisaCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbsinavisaCOMPLEXIDADE: TStringField
      FieldName = 'COMPLEXIDADE'
      Size = 5
    end
    object tbsinavisaCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbsinavisaPROCEDIMENTO: TStringField
      FieldName = 'PROCEDIMENTO'
      Size = 254
    end
  end
  object dssinavisa: TDataSource
    AutoEdit = False
    DataSet = tbsinavisa
    Left = 232
    Top = 48
  end
  object tbauxcontrib: TTable
    BeforeScroll = tbcontribBeforeScroll
    AfterScroll = tbcontribAfterScroll
    DatabaseName = 'wcvs'
    Filtered = True
    IndexName = 'PorCGC'
    TableName = 'CONTRIB.DB'
    Left = 336
    Top = 56
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
  object dsaux: TDataSource
    AutoEdit = False
    DataSet = tbauxcontrib
    Left = 352
    Top = 56
  end
  object Timeadmim: TTimer
    Interval = 10000
    OnTimer = TimeadmimTimer
    Left = 648
    Top = 56
  end
  object tbauxvisita: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    IndexName = 'PorVisita'
    TableName = 'VISITAS.DB'
    Left = 592
    Top = 56
    object tbauxvisitaCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbauxvisitaCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbauxvisitaDT_VISITA: TDateField
      FieldName = 'DT_VISITA'
    end
    object tbauxvisitaTIPO: TStringField
      FieldName = 'TIPO'
      Size = 35
    end
    object tbauxvisitaNDOC: TIntegerField
      FieldName = 'NDOC'
    end
    object tbauxvisitaFiscal1: TStringField
      FieldName = 'Fiscal1'
      Size = 40
    end
    object tbauxvisitaFiscal2: TStringField
      FieldName = 'Fiscal2'
      Size = 40
    end
    object tbauxvisitaFiscal3: TStringField
      FieldName = 'Fiscal3'
      Size = 40
    end
    object tbauxvisitaNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 6
    end
  end
  object dsauxvisita: TDataSource
    AutoEdit = False
    DataSet = tbauxvisita
    Left = 608
    Top = 40
  end
  object tbcnae: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorSubclasse'
    TableName = 'cnae.DB'
    Left = 624
    Top = 16
    object tbcnaeSubclasse: TStringField
      FieldName = 'Subclasse'
      Size = 9
    end
    object tbcnaeAtividade: TStringField
      FieldName = 'Atividade'
      Size = 254
    end
    object tbcnaeComplexidade: TStringField
      FieldName = 'Complexidade'
      Size = 5
    end
    object tbcnaeControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbcnaeClasse: TStringField
      FieldName = 'Classe'
      Size = 7
    end
    object tbcnaeEquipe: TStringField
      FieldName = 'Equipe'
      Size = 2
    end
  end
  object dscnae: TDataSource
    AutoEdit = False
    DataSet = tbcnae
    Left = 624
  end
  object tbauxrt: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'rt.DB'
    Left = 720
    object tbauxrtControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbauxrtCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbauxrtSubclasse: TStringField
      FieldName = 'Subclasse'
      Size = 9
    end
    object tbauxrtTipo: TStringField
      FieldName = 'Tipo'
      Size = 10
    end
  end
  object dsauxrt: TDataSource
    AutoEdit = False
    DataSet = tbauxrt
    Left = 728
    Top = 24
  end
  object tbalvlib: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorAlvara'
    MasterFields = 'Numero'
    MasterSource = dsalvara
    TableName = 'alvlib.db'
    Left = 560
    Top = 8
    object tbalvlibControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbalvlibAlvara: TIntegerField
      FieldName = 'Alvara'
    end
    object tbalvlibData: TDateField
      FieldName = 'Data'
      EditMask = '!99/99/0000;1;_'
    end
    object tbalvlibAtividade: TStringField
      FieldName = 'Atividade'
      Size = 9
    end
    object tbalvlibAutoridade: TStringField
      FieldName = 'Autoridade'
      Size = 40
    end
    object tbalvlibAutenticador: TStringField
      FieldName = 'Autenticador'
      Size = 10
    end
    object tbalvlibLiberante: TStringField
      FieldName = 'Liberante'
      Size = 40
    end
    object tbalvlibDocumento: TStringField
      FieldName = 'Documento'
      EditMask = '000\.000;0;_'
      Size = 6
    end
    object tbalvlibDt_documento: TDateField
      FieldName = 'Dt_documento'
      EditMask = '!99/99/0000;1;_'
    end
  end
  object dsalvlib: TDataSource
    AutoEdit = False
    DataSet = tbalvlib
    OnStateChange = dsalvlibStateChange
    Left = 592
    Top = 8
  end
  object tbalvrt: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    IndexName = 'PorCodigo'
    TableName = 'rt.DB'
    Left = 616
    Top = 48
    object tbalvrtControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbalvrtCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbalvrtAtividade: TStringField
      FieldName = 'Atividade'
      Size = 80
    end
    object tbalvrtSubclasse: TStringField
      FieldName = 'Subclasse'
      Size = 9
    end
    object tbalvrtTipo: TStringField
      FieldName = 'Tipo'
      Size = 10
    end
  end
  object dsalvrt: TDataSource
    AutoEdit = False
    DataSet = tbalvrt
    Left = 616
    Top = 48
  end
  object tbauxlib: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorAlvara'
    MasterFields = 'Numero'
    MasterSource = dsalvara
    TableName = 'alvlib.DB'
    Left = 744
    Top = 64
    object tbauxlibControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbauxlibAlvara: TIntegerField
      FieldName = 'Alvara'
    end
    object tbauxlibData: TDateField
      FieldName = 'Data'
      EditMask = '!99/99/0000;1;_'
    end
    object tbauxlibAtividade: TStringField
      FieldName = 'Atividade'
      Size = 9
    end
  end
  object dsauxlib: TDataSource
    DataSet = tbauxlib
    Left = 736
    Top = 56
  end
  object tbveiculo: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'veiculo.DB'
    Left = 824
    Top = 32
    object tbveiculoContole: TAutoIncField
      FieldName = 'Contole'
      ReadOnly = True
    end
    object tbveiculoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbveiculoExercicio: TIntegerField
      FieldName = 'Exercicio'
    end
    object tbveiculoDuam: TIntegerField
      FieldName = 'Duam'
    end
    object tbveiculoDt_req: TDateField
      FieldName = 'Dt_req'
    end
    object tbveiculoNumero: TIntegerField
      FieldName = 'Numero'
    end
    object tbveiculoResponsavel_req: TStringField
      FieldName = 'Responsavel_req'
      Size = 40
    end
    object tbveiculoMarca: TStringField
      FieldName = 'Marca'
    end
    object tbveiculoModelo: TStringField
      FieldName = 'Modelo'
    end
    object tbveiculoCor: TStringField
      FieldName = 'Cor'
      Size = 10
    end
    object tbveiculoAno: TIntegerField
      FieldName = 'Ano'
    end
    object tbveiculoPlaca: TStringField
      FieldName = 'Placa'
      Size = 10
    end
    object tbveiculoChassi: TStringField
      FieldName = 'Chassi'
    end
    object tbveiculoAutorizante: TStringField
      FieldName = 'Autorizante'
      Size = 40
    end
    object tbveiculoDt_autor: TDateField
      FieldName = 'Dt_autor'
    end
    object tbveiculoEmissor: TStringField
      FieldName = 'Emissor'
      Size = 40
    end
    object tbveiculoDt_emite: TDateField
      FieldName = 'Dt_emite'
    end
    object tbveiculoDt_validade: TDateField
      FieldName = 'Dt_validade'
    end
    object tbveiculoImpressao: TStringField
      FieldName = 'Impressao'
      Size = 40
    end
    object tbveiculoDt_impressao: TDateField
      FieldName = 'Dt_impressao'
    end
    object tbveiculoObs: TMemoField
      FieldName = 'Obs'
      BlobType = ftMemo
      Size = 10
    end
    object tbveiculoAtenticador: TStringField
      FieldName = 'Atenticador'
      Size = 10
    end
    object tbveiculoAutorizacao: TBooleanField
      FieldName = 'Autorizacao'
    end
  end
  object dsveiculo: TDataSource
    AutoEdit = False
    DataSet = tbveiculo
    OnStateChange = dsveiculoStateChange
    Left = 872
    Top = 40
  end
  object tbreq: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'OS'
    TableName = 'requerimento.DB'
    Left = 136
    Top = 40
    object tbreqControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbreqCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbreqOS: TIntegerField
      FieldName = 'OS'
    end
    object tbreqArea: TStringField
      FieldName = 'Area'
      Size = 25
    end
    object tbreqMotivo: TStringField
      FieldName = 'Motivo'
      Size = 25
    end
    object tbreqVeiculos: TSmallintField
      FieldName = 'Veiculos'
    end
    object tbreqRequerente: TStringField
      FieldName = 'Requerente'
      Size = 40
    end
    object tbreqObs_Req: TStringField
      FieldName = 'Obs_Req'
      Size = 60
    end
    object tbreqDt_Req: TDateField
      FieldName = 'Dt_Req'
    end
    object tbreqFiscal_Encaminha: TStringField
      FieldName = 'Fiscal_Encaminha'
      Size = 40
    end
    object tbreqRecebedor: TStringField
      FieldName = 'Recebedor'
      Size = 40
    end
    object tbreqDt_encaminha: TDateField
      FieldName = 'Dt_encaminha'
    end
    object tbreqEncaminhador: TStringField
      FieldName = 'Encaminhador'
      Size = 40
    end
    object tbreqFiscal_Atend: TStringField
      FieldName = 'Fiscal_Atend'
      Size = 40
    end
    object tbreqDt_Atend: TDateField
      FieldName = 'Dt_Atend'
    end
    object tbreqTipo_Documento: TStringField
      FieldName = 'Tipo_Documento'
    end
    object tbreqObs_Atend: TStringField
      FieldName = 'Obs_Atend'
      Size = 60
    end
    object tbreqEncaminhamento: TBooleanField
      FieldName = 'Encaminhamento'
    end
    object tbreqAtendimento: TBooleanField
      FieldName = 'Atendimento'
    end
    object tbreqNum_Documento: TStringField
      FieldName = 'Num_Documento'
      Size = 6
    end
    object tbreqCancelado: TBooleanField
      FieldName = 'Cancelado'
    end
    object tbreqComplexidade: TStringField
      FieldName = 'Complexidade'
      Size = 5
    end
    object tbreqPrioridade: TBooleanField
      FieldName = 'Prioridade'
    end
  end
  object dsreq: TDataSource
    AutoEdit = False
    DataSet = tbreq
    Left = 152
    Top = 48
  end
  object tbimagem: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'imagem.db'
    Left = 80
    Top = 65528
    object tbimagemControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbimagemCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbimagemFoto: TGraphicField
      FieldName = 'Foto'
      BlobType = ftGraphic
    end
  end
  object dsimagem: TDataSource
    AutoEdit = False
    DataSet = tbimagem
    Left = 72
    Top = 8
  end
  object OpenPictureDialog1: TOpenPictureDialog
    InitialDir = 'C:\'
    Left = 693
    Top = 65532
  end
  object tbplanta: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Codigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'planta.DB'
    Left = 48
    Top = 32
    object tbplantaControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbplantaData: TDateField
      FieldName = 'Data'
    end
    object tbplantaEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object tbplantaCelular: TStringField
      FieldName = 'Celular'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 14
    end
    object tbplantaHora: TTimeField
      FieldName = 'Hora'
    end
    object tbplantaAssunto: TStringField
      FieldName = 'Assunto'
      Size = 40
    end
    object tbplantaUsuario: TStringField
      FieldName = 'Usuario'
      Size = 40
    end
    object tbplantaProtocolante: TStringField
      FieldName = 'Protocolante'
      Size = 40
    end
    object tbplantaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbplantaDocumento: TStringField
      FieldName = 'Documento'
      Size = 25
    end
    object tbplantaProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbplantaComplemento: TStringField
      FieldName = 'Complemento'
      Size = 40
    end
    object tbplantaObserva: TStringField
      FieldName = 'Observa'
      Size = 80
    end
    object tbplantaCarga: TStringField
      FieldName = 'Carga'
      Size = 40
    end
    object tbplantaEcarregado: TStringField
      FieldName = 'Ecarregado'
      Size = 40
    end
  end
  object dsplanta: TDataSource
    AutoEdit = False
    DataSet = tbplanta
    OnStateChange = dsplantaStateChange
    Left = 40
    Top = 8
  end
  object tbtramitacao: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Protocolo'
    MasterFields = 'Protocolo'
    MasterSource = dsplanta
    TableName = 'tramitacao.db'
    Left = 32
    Top = 24
    object tbtramitacaoControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbtramitacaoProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbtramitacaoData: TDateField
      FieldName = 'Data'
    end
    object tbtramitacaoHora: TTimeField
      FieldName = 'Hora'
    end
    object tbtramitacaoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 40
    end
    object tbtramitacaoDestino: TStringField
      FieldName = 'Destino'
      Size = 40
    end
    object tbtramitacaoDespacho: TMemoField
      FieldName = 'Despacho'
      BlobType = ftMemo
      Size = 240
    end
    object tbtramitacaoUsuario: TStringField
      FieldName = 'Usuario'
      Size = 40
    end
    object tbtramitacaoJuntada: TStringField
      FieldName = 'Juntada'
      Size = 25
    end
    object tbtramitacaoInteressado: TStringField
      FieldName = 'Interessado'
      Size = 40
    end
  end
  object dstramitacao: TDataSource
    AutoEdit = False
    DataSet = tbtramitacao
    OnStateChange = dstramitacaoStateChange
    Left = 8
    Top = 40
  end
  object tbrmpf: TTable
    DatabaseName = 'wcvs'
    TableName = 'rmpf.DB'
    Left = 408
    Top = 8
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
    object tbrmpfMes: TSmallintField
      FieldName = 'Mes'
    end
    object tbrmpfAno: TSmallintField
      FieldName = 'Ano'
    end
    object tbrmpfPonto: TFloatField
      FieldName = 'Ponto'
    end
    object tbrmpfHomologado: TStringField
      FieldName = 'Homologado'
      Size = 3
    end
  end
  object dsrmpf: TDataSource
    DataSet = tbrmpf
    Left = 400
  end
  object tboficio: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorOficio'
    TableName = 'oficio.DB'
    Left = 128
    Top = 56
    object tboficioOficio: TIntegerField
      FieldName = 'Oficio'
    end
    object tboficioData: TDateField
      FieldName = 'Data'
    end
    object tboficioFiscalencaminha: TStringField
      FieldName = 'Fiscalencaminha'
      Size = 60
    end
    object tboficioDtencaminha: TDateField
      FieldName = 'Dtencaminha'
    end
    object tboficioPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tboficioDtatendimento: TDateField
      FieldName = 'Dtatendimento'
    end
    object tboficioUser: TStringField
      FieldName = 'User'
      Size = 60
    end
    object tboficioArchive: TBooleanField
      FieldName = 'Archive'
    end
    object tboficioCancela: TBooleanField
      FieldName = 'Cancela'
    end
    object tboficioEmitente: TStringField
      FieldName = 'Emitente'
      Size = 60
    end
    object tboficioMotivo: TStringField
      FieldName = 'Motivo'
      Size = 25
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
    object tboficioOrdem: TStringField
      FieldName = 'Ordem'
      Size = 120
    end
    object tboficioCpf: TStringField
      FieldName = 'Cpf'
      Size = 14
    end
    object tboficioCnpj: TStringField
      FieldName = 'Cnpj'
      Size = 18
    end
    object tboficioControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tboficioOrigem: TStringField
      FieldName = 'Origem'
      Size = 10
    end
    object tboficioTerceiro: TBooleanField
      FieldName = 'Terceiro'
    end
  end
  object dsoficio: TDataSource
    AutoEdit = False
    DataSet = tboficio
    Left = 136
    Top = 72
  end
  object tbauxplanta: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigoProtocolo'
    TableName = 'planta.DB'
    Left = 184
    Top = 48
    object tbauxplantaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbauxplantaProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbauxplantaCarga: TStringField
      FieldName = 'Carga'
      Size = 40
    end
  end
  object dsauxplanta: TDataSource
    AutoEdit = False
    DataSet = tbauxplanta
    OnStateChange = dsplantaStateChange
    Left = 192
    Top = 56
  end
  object tbrdpf: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorData'
    TableName = 'RDPF.DB'
    Left = 392
    Top = 65528
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
    end
    object tbrdpfEntrega: TBooleanField
      FieldName = 'Entrega'
    end
    object tbrdpfHomologado: TStringField
      FieldName = 'Homologado'
      Size = 3
    end
    object tbrdpfFecha: TBooleanField
      FieldName = 'Fecha'
    end
    object tbrdpfEstabe: TStringField
      FieldName = 'Estabe'
      Size = 60
    end
    object tbrdpfControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbrdpfOS: TIntegerField
      FieldName = 'OS'
    end
    object tbrdpfTIPOOS: TStringField
      FieldName = 'TIPOOS'
      Size = 30
    end
    object tbrdpfMotivo: TStringField
      FieldName = 'Motivo'
      Size = 10
    end
    object tbrdpfData_os: TDateField
      FieldName = 'Data_os'
    end
    object tbrdpfPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tbrdpfAcao: TStringField
      FieldName = 'Acao'
      Size = 35
    end
    object tbrdpfDoc: TStringField
      FieldName = 'Doc'
      Size = 80
    end
    object tbrdpfNdoc: TStringField
      FieldName = 'Ndoc'
      Size = 6
    end
    object tbrdpfMeio: TStringField
      FieldName = 'Meio'
      Size = 7
    end
    object tbrdpfMod: TStringField
      FieldName = 'Mod'
      Size = 3
    end
    object tbrdpfCnae: TStringField
      FieldName = 'Cnae'
      Size = 9
    end
    object tbrdpfComplex: TStringField
      FieldName = 'Complex'
      Size = 5
    end
    object tbrdpfArea: TStringField
      FieldName = 'Area'
      Size = 7
    end
    object tbrdpfDupla: TBooleanField
      FieldName = 'Dupla'
    end
    object tbrdpfPonto: TFloatField
      FieldName = 'Ponto'
    end
    object tbrdpfNegativo: TFloatField
      FieldName = 'Negativo'
    end
    object tbrdpfComply: TStringField
      FieldName = 'Comply'
      Size = 12
    end
    object tbrdpfUser_homoloda: TStringField
      FieldName = 'User_homoloda'
      Size = 60
    end
    object tbrdpfData_homologa: TDateField
      FieldName = 'Data_homologa'
    end
    object tbrdpfUsuario: TStringField
      FieldName = 'Usuario'
      Size = 60
    end
    object tbrdpfData_altera: TDateField
      FieldName = 'Data_altera'
    end
    object tbrdpfData_fecha: TDateField
      FieldName = 'Data_fecha'
    end
    object tbrdpfUsr_fecha: TStringField
      FieldName = 'Usr_fecha'
      Size = 60
    end
  end
  object dsrdpf: TDataSource
    DataSet = tbrdpf
    Left = 456
    Top = 8
  end
  object tbcifa: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'cifa.db'
    Left = 744
    Top = 112
    object tbcifaControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbcifaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbcifaData: TDateField
      FieldName = 'Data'
    end
    object tbcifaProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbcifaArea: TStringField
      FieldName = 'Area'
      Size = 10
    end
    object tbcifaCategoria: TStringField
      FieldName = 'Categoria'
      Size = 250
    end
    object tbcifaDesigna: TStringField
      FieldName = 'Designa'
      Size = 80
    end
    object tbcifaMarca: TStringField
      FieldName = 'Marca'
      Size = 30
    end
    object tbcifaEmbalagem: TStringField
      FieldName = 'Embalagem'
    end
    object tbcifaPrazo: TStringField
      FieldName = 'Prazo'
      Size = 6
    end
    object tbcifaRegistro: TStringField
      FieldName = 'Registro'
      Size = 15
    end
  end
  object dscifa: TDataSource
    AutoEdit = False
    DataSet = tbcifa
    Left = 704
    Top = 120
  end
  object tbcategoria: TTable
    DatabaseName = 'wcvs'
    TableName = 'categorias.DB'
    Left = 672
    Top = 128
    object tbcategoriaControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbcategoriaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbcategoriaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 250
    end
  end
  object dscategoria: TDataSource
    AutoEdit = False
    DataSet = tbcategoria
    Left = 656
    Top = 136
  end
  object tbdenuncia: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorDenuncia'
    TableName = 'denuncia.DB'
    Left = 72
    Top = 8
    object tbdenunciaDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbdenunciaArchive: TBooleanField
      FieldName = 'Archive'
    end
    object tbdenunciaFiscalEncaminha: TStringField
      FieldName = 'FiscalEncaminha'
      Size = 60
    end
  end
  object dsdenuncia: TDataSource
    DataSet = tbdenuncia
    Left = 88
    Top = 48
  end
  object tbauxoficio: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorOrigem'
    TableName = 'oficio.DB'
    Left = 432
    Top = 8
    object tbauxoficioControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbauxoficioOficio: TIntegerField
      FieldName = 'Oficio'
    end
    object tbauxoficioOrigem: TStringField
      FieldName = 'Origem'
      Size = 10
    end
    object tbauxoficioTerceiro: TBooleanField
      FieldName = 'Terceiro'
    end
  end
  object dsauxoficio: TDataSource
    DataSet = tbauxoficio
    Left = 448
  end
  object tbos: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigoOS'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'requerimento.DB'
    Left = 624
    Top = 88
    object tbosCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbosOS: TIntegerField
      FieldName = 'OS'
    end
    object tbosMotivo: TStringField
      FieldName = 'Motivo'
      Size = 25
    end
    object tbosObs_Req: TStringField
      FieldName = 'Obs_Req'
      Size = 60
    end
    object tbosDt_Req: TDateField
      FieldName = 'Dt_Req'
    end
    object tbosPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tbosFiscal_Encaminha: TStringField
      FieldName = 'Fiscal_Encaminha'
      Size = 60
    end
    object tbosDt_encaminha: TDateField
      FieldName = 'Dt_encaminha'
    end
    object tbosDt_Atend: TDateField
      FieldName = 'Dt_Atend'
    end
    object tbosCancelado: TBooleanField
      FieldName = 'Cancelado'
    end
    object tbosRequerente: TStringField
      FieldName = 'Requerente'
      Size = 40
    end
    object tbosFiscal_Atend: TStringField
      FieldName = 'Fiscal_Atend'
      Size = 40
    end
    object tbosAtendimento: TBooleanField
      FieldName = 'Atendimento'
    end
  end
  object dsos: TDataSource
    DataSet = tbos
    Left = 648
    Top = 104
  end
  object OpenDialog1: TOpenDialog
    Left = 640
    Top = 32
  end
  object TimerInatividade: TTimer
    Enabled = False
    Interval = 6000
    OnTimer = TimerInatividadeTimer
    Left = 176
    Top = 24
  end
  object tbtaxa: TTable
    DatabaseName = 'wcvs'
    TableName = 'SIMTAXA.DB'
    Left = 96
    Top = 16
    object tbtaxaCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbtaxaINSCRICAO: TStringField
      FieldName = 'INSCRICAO'
    end
    object tbtaxaEXERCICIO: TSmallintField
      FieldName = 'EXERCICIO'
    end
    object tbtaxaVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object tbtaxaDT_VENC: TDateField
      FieldName = 'DT_VENC'
    end
    object tbtaxaSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Size = 30
    end
    object tbtaxaPAGO: TBooleanField
      FieldName = 'PAGO'
    end
    object tbtaxaCOMPLEXIDADE: TStringField
      FieldName = 'COMPLEXIDADE'
      Size = 10
    end
    object tbtaxaAREA: TFloatField
      FieldName = 'AREA'
    end
  end
  object dstaxa: TDataSource
    DataSet = tbtaxa
    Left = 120
    Top = 8
  end
end
