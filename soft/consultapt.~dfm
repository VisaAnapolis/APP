object frmconpt: Tfrmconpt
  Left = 781
  Top = 492
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Consulta Protocolo'
  ClientHeight = 423
  ClientWidth = 762
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
  object GroupBox1: TGroupBox
    Left = 4
    Top = 5
    Width = 749
    Height = 412
    Caption = 'Consulta Protocolo'
    TabOrder = 0
    object BtOK: TButton
      Left = 169
      Top = 372
      Width = 150
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = BtOKClick
    end
    object Button3: TButton
      Left = 453
      Top = 371
      Width = 150
      Height = 25
      Caption = 'Fecha'
      TabOrder = 2
      OnClick = Button3Click
    end
    object GroupBox4: TGroupBox
      Left = 10
      Top = 23
      Width = 727
      Height = 322
      Caption = 'Informe o n'#250'meor do protocolo:'
      TabOrder = 0
      object c_num: TEdit
        Left = 8
        Top = 25
        Width = 65
        Height = 24
        Hint = 'Digite aqui o CNPJ do Contribuinte'
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object DBGTramita: TDBGrid
        Left = 8
        Top = 67
        Width = 713
        Height = 246
        Color = clMoneyGreen
        DataSource = dstramita
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
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
            Width = 148
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
      object DBEdit31: TDBEdit
        Left = 413
        Top = 25
        Width = 70
        Height = 24
        TabStop = False
        Color = clMoneyGreen
        DataField = 'Data'
        DataSource = dsprotocolo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object DBERazao: TDBEdit
        Left = 157
        Top = 25
        Width = 249
        Height = 24
        CharCase = ecUpperCase
        Color = clMoneyGreen
        DataField = 'RAZAO'
        DataSource = dscontrib
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit1: TDBEdit
        Left = 85
        Top = 25
        Width = 65
        Height = 24
        TabStop = False
        Color = clMoneyGreen
        DataField = 'Protocolo'
        DataSource = dsprotocolo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object DBEdit2: TDBEdit
        Left = 490
        Top = 25
        Width = 231
        Height = 24
        CharCase = ecUpperCase
        Color = clMoneyGreen
        DataField = 'Assunto'
        DataSource = dsprotocolo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
    end
  end
  object tbprotocolo: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorProtocolo'
    TableName = 'planta.DB'
    Left = 48
    Top = 368
    object tbprotocoloCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbprotocoloProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbprotocoloData: TDateField
      FieldName = 'Data'
    end
    object tbprotocoloAssunto: TStringField
      FieldName = 'Assunto'
      Size = 40
    end
  end
  object tbtramita: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorProtocolo'
    MasterFields = 'Protocolo'
    MasterSource = dsprotocolo
    TableName = 'tramitacao.DB'
    Left = 112
    Top = 368
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
    object tbtramitaUsuario: TStringField
      FieldName = 'Usuario'
      Size = 40
    end
    object tbtramitaHora: TTimeField
      FieldName = 'Hora'
    end
    object tbtramitaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 40
    end
  end
  object dsprotocolo: TDataSource
    DataSet = tbprotocolo
    Left = 56
    Top = 384
  end
  object dstramita: TDataSource
    DataSet = tbtramita
    Left = 120
    Top = 384
  end
  object tbcontrib: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'Codigo'
    MasterSource = dsprotocolo
    TableName = 'CONTRIB.DB'
    Left = 8
    Top = 368
    object tbcontribCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcontribRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
  end
  object dscontrib: TDataSource
    DataSet = tbcontrib
    Left = 16
    Top = 384
  end
end
