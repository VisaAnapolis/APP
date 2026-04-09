object rel_especifica: Trel_especifica
  Left = 291
  Top = 320
  Width = 1174
  Height = 697
  Caption = 'Contribuintes por atividade/bairro'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 120
  TextHeight = 13
  object QRativ: TQuickRep
    Left = 8
    Top = 8
    Width = 1403
    Height = 992
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = tbcontrib
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Values = (
      100.0125
      2100
      100.0125
      2970
      100.0125
      100.0125
      0)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = Pixels
    Zoom = 100
    object QRBand1: TQRBand
      Left = 47
      Top = 47
      Width = 1309
      Height = 104
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        220.133333333333
        2770.71666666667)
      BandType = rbPageHeader
      object QRLabel1: TQRLabel
        Left = 10
        Top = 16
        Width = 358
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          21.1666666666667
          33.8666666666667
          757.766666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Rela'#231#227'o de Contribuintes por atividade/bairro'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRSysData1: TQRSysData
        Left = 1250
        Top = 0
        Width = 60
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          2645.83333333333
          0
          127)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsPageNumber
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        FontSize = 10
      end
      object QRSysData4: TQRSysData
        Left = 1020
        Top = 0
        Width = 87
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          2159
          0
          184.15)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 30
        Top = 53
        Width = 97
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          63.5
          112.183333333333
          205.316666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Raz'#227'o Social'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel4: TQRLabel
        Left = 1190
        Top = 0
        Width = 40
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.45
          2518.83333333333
          0
          84.6666666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'P'#225'g.:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 875
        Top = 53
        Width = 72
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          1852.08333333333
          112.183333333333
          152.4)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Endere'#231'o'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 450
        Top = 53
        Width = 133
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          952.5
          112.183333333333
          281.516666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Nome de Fantasia'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRShape1: TQRShape
        Left = 30
        Top = 90
        Width = 1271
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          63.5
          190.5
          2690.8125)
        Shape = qrsHorLine
      end
      object QRLabel7: TQRLabel
        Left = 450
        Top = 72
        Width = 154
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          952.5
          152.4
          325.966666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Atividade Econ'#244'mica'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRBand2: TQRBand
      Left = 47
      Top = 151
      Width = 1309
      Height = 80
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        169.333333333333
        2770.71666666667)
      BandType = rbDetail
      object QRDBText1: TQRDBText
        Left = 30
        Top = 10
        Width = 55
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          63.5
          21.1666666666667
          116.416666666667)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = True
        Color = clWhite
        DataSet = tbcontrib
        DataField = 'RAZAO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText2: TQRDBText
        Left = 450
        Top = 10
        Width = 80
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          952.5
          21.1666666666667
          169.333333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = tbcontrib
        DataField = 'FANTASIA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText3: TQRDBText
        Left = 875
        Top = 10
        Width = 114
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          1852.08333333333
          21.1666666666667
          241.3)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = tbcontrib
        DataField = 'LOGRADOURO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 875
        Top = 30
        Width = 113
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          1852.08333333333
          63.5
          239.183333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = tbcontrib
        DataField = 'COMPLEMENT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText7: TQRDBText
        Left = 875
        Top = 54
        Width = 48
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          1852.08333333333
          114.3
          101.6)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = tbbairro
        DataField = 'NOME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText5: TQRDBText
        Left = 450
        Top = 30
        Width = 48
        Height = 23
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          48.6833333333333
          952.5
          63.5
          101.6)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        DataSet = tbativi
        DataField = 'NOME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object QRBand3: TQRBand
      Left = 47
      Top = 231
      Width = 1309
      Height = 50
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333
        2770.71666666667)
      BandType = rbSummary
      object QRLabel3: TQRLabel
        Left = 30
        Top = 20
        Width = 354
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.45
          63.5
          42.3333333333333
          749.3)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Total de contribuintes ativos nesta atividade:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRSysData2: TQRSysData
        Left = 450
        Top = 20
        Width = 107
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.45
          952.5
          42.3333333333333
          226.483333333333)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsDetailCount
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        FontSize = 10
      end
      object QRShape2: TQRShape
        Left = 30
        Top = 0
        Width = 1271
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          63.5
          0
          2690.8125)
        Shape = qrsHorLine
      end
    end
  end
  object tbcontrib: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    IndexName = 'PorRazao'
    TableName = 'CONTRIB.DB'
    Left = 768
    Top = 272
    object tbcontribCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbcontribCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcontribPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 4
    end
    object tbcontribCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object tbcontribCGC: TStringField
      FieldName = 'CGC'
      Size = 18
    end
    object tbcontribRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
    object tbcontribFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object tbcontribATIVIDADE: TIntegerField
      FieldName = 'ATIVIDADE'
    end
    object tbcontribGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbcontribLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 40
    end
    object tbcontribCOMPLEMENT: TStringField
      FieldName = 'COMPLEMENT'
      Size = 30
    end
    object tbcontribBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object tbcontribCDBAI: TIntegerField
      FieldName = 'CDBAI'
    end
    object tbcontribINATIVIDADE: TBooleanField
      FieldName = 'INATIVIDADE'
    end
  end
  object dscontrib: TDataSource
    DataSet = tbcontrib
    Left = 754
    Top = 267
  end
  object tbativi: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PORNUMERO'
    MasterFields = 'ATIVIDADE'
    MasterSource = dscontrib
    TableName = 'ATIVI.DB'
    Left = 819
    Top = 320
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
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CDBAI'
    MasterSource = dscontrib
    TableName = 'bairro.DB'
    Left = 816
    Top = 272
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
end
