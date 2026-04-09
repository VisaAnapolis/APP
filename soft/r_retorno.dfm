object frmretorno: Tfrmretorno
  Left = 480
  Top = 331
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Inspe'#231#245'es'
  ClientHeight = 225
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 4
    Top = 5
    Width = 461
    Height = 212
    Caption = 'Gera relat'#243'rio de documentos emitidos por per'#237'odo'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 16
      Width = 107
      Height = 13
      Caption = 'Selecione a data inical'
    end
    object Label2: TLabel
      Left = 290
      Top = 16
      Width = 102
      Height = 13
      Caption = 'Selecione a data final'
    end
    object DTPini: TDateTimePicker
      Left = 10
      Top = 32
      Width = 151
      Height = 21
      CalAlignment = dtaLeft
      Date = 40909
      Time = 40909
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object DTPfim: TDateTimePicker
      Left = 292
      Top = 31
      Width = 151
      Height = 21
      CalAlignment = dtaLeft
      Date = 40909
      Time = 40909
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object BtOK: TButton
      Left = 10
      Top = 177
      Width = 150
      Height = 25
      Caption = 'OK'
      TabOrder = 4
      OnClick = BtOKClick
    end
    object Button3: TButton
      Left = 294
      Top = 176
      Width = 150
      Height = 25
      Caption = 'Fecha'
      TabOrder = 5
      OnClick = Button3Click
    end
    object GroupBox4: TGroupBox
      Left = 10
      Top = 120
      Width = 434
      Height = 49
      Caption = 'Selecione o fiscal signat'#225'rio do documento'
      TabOrder = 3
      object CbFiscal: TComboBox
        Left = 8
        Top = 20
        Width = 417
        Height = 21
        Enabled = False
        ItemHeight = 13
        TabOrder = 0
        TabStop = False
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
    end
    object GroupBox2: TGroupBox
      Left = 10
      Top = 64
      Width = 434
      Height = 49
      Caption = 'Selecione o tipo de documento emitido'
      TabOrder = 2
      object CBDoc: TComboBox
        Left = 8
        Top = 20
        Width = 417
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
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
      end
    end
  end
  object tbvisitas: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorVisita'
    TableName = 'VISITAS.DB'
    Left = 224
    Top = 16
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
    object tbvisitasPZ_RETORNO: TSmallintField
      FieldName = 'PZ_RETORNO'
    end
    object tbvisitasACAO: TStringField
      FieldName = 'ACAO'
      Size = 35
    end
    object tbvisitasTIPO: TStringField
      FieldName = 'TIPO'
      Size = 35
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
  end
  object dsvisitas: TDataSource
    AutoEdit = False
    DataSet = tbvisitas
    Left = 248
    Top = 40
  end
  object tbativi: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'ATIVI.DB'
    Left = 240
    Top = 32
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
    object tbativiAREA: TStringField
      FieldName = 'AREA'
    end
  end
  object dsativi: TDataSource
    AutoEdit = False
    DataSet = tbativi
    Left = 288
  end
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    TableName = 'bairro.DB'
    Left = 192
    Top = 40
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
    DataSet = tbbairro
    Left = 176
    Top = 32
  end
end
