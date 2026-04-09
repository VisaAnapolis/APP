object frmconcatena: Tfrmconcatena
  Left = 322
  Top = 331
  Width = 761
  Height = 283
  Caption = 'frmconcatena'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 729
    Height = 217
    TabOrder = 0
    object Lfantasia: TLabel
      Left = 24
      Top = 69
      Width = 62
      Height = 20
      Caption = 'Fantasia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Lbcodigo: TLabel
      Left = 128
      Top = 37
      Width = 65
      Height = 20
      Caption = 'Lbcodigo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LRT1: TLabel
      Left = 24
      Top = 93
      Width = 39
      Height = 20
      Caption = 'LRT1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LObs: TLabel
      Left = 24
      Top = 117
      Width = 38
      Height = 20
      Caption = 'LObs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 264
      Top = 120
      Width = 56
      Height = 24
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 264
      Top = 160
      Width = 56
      Height = 24
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 152
      Top = 160
      Width = 56
      Height = 24
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbcpf: TLabel
      Left = 408
      Top = 149
      Width = 22
      Height = 20
      Caption = 'cpf'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbcpffan: TLabel
      Left = 408
      Top = 173
      Width = 57
      Height = 20
      Caption = 'fantasia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 16
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Proceed'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 144
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object arrumacpf: TButton
      Left = 400
      Top = 120
      Width = 75
      Height = 25
      Caption = 'arrumacpf'
      TabOrder = 2
      OnClick = arrumacpfClick
    end
    object Button3: TButton
      Left = 576
      Top = 128
      Width = 75
      Height = 25
      Caption = 'hor'#225'rio'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object tbmatricula: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    TableName = 'CONTRIB.DB'
    Left = 504
    Top = 24
    object tbmatriculaCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbmatriculaCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbmatriculaPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 4
    end
    object tbmatriculaCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object tbmatriculaCGC: TStringField
      FieldName = 'CGC'
      Size = 18
    end
    object tbmatriculaAGREGADO: TBooleanField
      FieldName = 'AGREGADO'
    end
    object tbmatriculaRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
    object tbmatriculaFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object tbmatriculaREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 40
    end
    object tbmatriculaCPFREPRES: TStringField
      FieldName = 'CPFREPRES'
      Size = 14
    end
    object tbmatriculaATIVIDADE: TIntegerField
      FieldName = 'ATIVIDADE'
    end
    object tbmatriculaAREA: TIntegerField
      FieldName = 'AREA'
    end
    object tbmatriculaGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbmatriculaMUNICIPAL: TStringField
      FieldName = 'MUNICIPAL'
      Size = 6
    end
    object tbmatriculaLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 40
    end
    object tbmatriculaCOMPLEMENT: TStringField
      FieldName = 'COMPLEMENT'
      Size = 30
    end
    object tbmatriculaBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object tbmatriculaCDBAI: TIntegerField
      FieldName = 'CDBAI'
    end
    object tbmatriculaZONA: TSmallintField
      FieldName = 'ZONA'
    end
    object tbmatriculaCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object tbmatriculaFONE: TStringField
      FieldName = 'FONE'
      Size = 9
    end
    object tbmatriculaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object tbmatriculaTAXA: TBooleanField
      FieldName = 'TAXA'
    end
    object tbmatriculaINATIVIDADE: TBooleanField
      FieldName = 'INATIVIDADE'
    end
    object tbmatriculaOBS: TMemoField
      FieldName = 'OBS'
      BlobType = ftMemo
      Size = 10
    end
    object tbmatriculaPendoc: TBooleanField
      FieldName = 'Pendoc'
    end
    object tbmatriculaDt_cadastro: TDateField
      FieldName = 'Dt_cadastro'
    end
    object tbmatriculaUser: TStringField
      FieldName = 'User'
      Size = 30
    end
    object tbmatriculaDt_alter: TDateField
      FieldName = 'Dt_alter'
    end
    object tbmatriculaH_alter: TTimeField
      FieldName = 'H_alter'
    end
  end
  object dsmatricula: TDataSource
    DataSet = tbmatricula
    Left = 504
    Top = 56
  end
  object tbcnpj: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCGC'
    TableName = 'CONTRIB.DB'
    Left = 464
    Top = 24
    object tbcnpjCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbcnpjCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcnpjPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 4
    end
    object tbcnpjCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object tbcnpjCGC: TStringField
      FieldName = 'CGC'
      Size = 18
    end
    object tbcnpjAGREGADO: TBooleanField
      FieldName = 'AGREGADO'
    end
    object tbcnpjRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
    object tbcnpjFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object tbcnpjREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 40
    end
    object tbcnpjCPFREPRES: TStringField
      FieldName = 'CPFREPRES'
      Size = 14
    end
    object tbcnpjATIVIDADE: TIntegerField
      FieldName = 'ATIVIDADE'
    end
    object tbcnpjAREA: TIntegerField
      FieldName = 'AREA'
    end
    object tbcnpjGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbcnpjMUNICIPAL: TStringField
      FieldName = 'MUNICIPAL'
      Size = 6
    end
    object tbcnpjLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 40
    end
    object tbcnpjCOMPLEMENT: TStringField
      FieldName = 'COMPLEMENT'
      Size = 30
    end
    object tbcnpjBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object tbcnpjCDBAI: TIntegerField
      FieldName = 'CDBAI'
    end
    object tbcnpjZONA: TSmallintField
      FieldName = 'ZONA'
    end
    object tbcnpjCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object tbcnpjFONE: TStringField
      FieldName = 'FONE'
      Size = 9
    end
    object tbcnpjEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object tbcnpjTAXA: TBooleanField
      FieldName = 'TAXA'
    end
    object tbcnpjINATIVIDADE: TBooleanField
      FieldName = 'INATIVIDADE'
    end
    object tbcnpjOBS: TMemoField
      FieldName = 'OBS'
      BlobType = ftMemo
      Size = 10
    end
    object tbcnpjPendoc: TBooleanField
      FieldName = 'Pendoc'
    end
    object tbcnpjDt_cadastro: TDateField
      FieldName = 'Dt_cadastro'
    end
    object tbcnpjUser: TStringField
      FieldName = 'User'
      Size = 30
    end
    object tbcnpjDt_alter: TDateField
      FieldName = 'Dt_alter'
    end
    object tbcnpjH_alter: TTimeField
      FieldName = 'H_alter'
    end
  end
  object dscgc: TDataSource
    DataSet = tbcnpj
    Left = 464
    Top = 56
  end
  object rtcontr: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'rt.DB'
    Left = 424
    Top = 24
    object rtcontrControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object rtcontrCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object rtcontrNomeResp1: TStringField
      FieldName = 'NomeResp1'
      Size = 40
    end
    object rtcontrConsResp1: TStringField
      FieldName = 'ConsResp1'
    end
    object rtcontrUFResp1: TStringField
      FieldName = 'UFResp1'
      Size = 2
    end
    object rtcontrRegResp1: TStringField
      FieldName = 'RegResp1'
    end
    object rtcontrNomeResp2: TStringField
      FieldName = 'NomeResp2'
      Size = 40
    end
    object rtcontrConsResp2: TStringField
      FieldName = 'ConsResp2'
    end
    object rtcontrUFResp2: TStringField
      FieldName = 'UFResp2'
      Size = 2
    end
    object rtcontrRegResp2: TStringField
      FieldName = 'RegResp2'
    end
    object rtcontrRepresentante: TStringField
      FieldName = 'Representante'
      Size = 40
    end
    object rtcontrCPFRepres: TStringField
      FieldName = 'CPFRepres'
      Size = 14
    end
    object rtcontrAtividade: TStringField
      FieldName = 'Atividade'
      Size = 80
    end
  end
  object tbcontrib: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCPF'
    TableName = 'CONTRIB.DB'
    Left = 384
    Top = 24
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
    object tbcontribAGREGADO: TBooleanField
      FieldName = 'AGREGADO'
    end
    object tbcontribRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
    object tbcontribFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object tbcontribREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 40
    end
    object tbcontribCPFREPRES: TStringField
      FieldName = 'CPFREPRES'
      Size = 14
    end
    object tbcontribATIVIDADE: TIntegerField
      FieldName = 'ATIVIDADE'
    end
    object tbcontribAREA: TIntegerField
      FieldName = 'AREA'
    end
    object tbcontribGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbcontribMUNICIPAL: TStringField
      FieldName = 'MUNICIPAL'
      Size = 6
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
    object tbcontribZONA: TSmallintField
      FieldName = 'ZONA'
    end
    object tbcontribCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object tbcontribFONE: TStringField
      FieldName = 'FONE'
      Size = 9
    end
    object tbcontribEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object tbcontribTAXA: TBooleanField
      FieldName = 'TAXA'
    end
    object tbcontribINATIVIDADE: TBooleanField
      FieldName = 'INATIVIDADE'
    end
    object tbcontribOBS: TMemoField
      FieldName = 'OBS'
      BlobType = ftMemo
      Size = 10
    end
    object tbcontribPendoc: TBooleanField
      FieldName = 'Pendoc'
    end
    object tbcontribDt_cadastro: TDateField
      FieldName = 'Dt_cadastro'
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
    object tbcontribHORARIO: TStringField
      FieldName = 'HORARIO'
      Size = 15
    end
  end
  object dscontrib: TDataSource
    DataSet = tbcontrib
    Left = 384
    Top = 56
  end
  object rtmatri: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dsmatricula
    TableName = 'rt.DB'
    Left = 424
    Top = 56
    object rtmatriControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object rtmatriCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object rtmatriNomeResp1: TStringField
      FieldName = 'NomeResp1'
      Size = 40
    end
    object rtmatriConsResp1: TStringField
      FieldName = 'ConsResp1'
    end
    object rtmatriUFResp1: TStringField
      FieldName = 'UFResp1'
      Size = 2
    end
    object rtmatriRegResp1: TStringField
      FieldName = 'RegResp1'
    end
    object rtmatriNomeResp2: TStringField
      FieldName = 'NomeResp2'
      Size = 40
    end
    object rtmatriConsResp2: TStringField
      FieldName = 'ConsResp2'
    end
    object rtmatriUFResp2: TStringField
      FieldName = 'UFResp2'
      Size = 2
    end
    object rtmatriRegResp2: TStringField
      FieldName = 'RegResp2'
    end
    object rtmatriRepresentante: TStringField
      FieldName = 'Representante'
      Size = 40
    end
    object rtmatriCPFRepres: TStringField
      FieldName = 'CPFRepres'
      Size = 14
    end
    object rtmatriAtividade: TStringField
      FieldName = 'Atividade'
      Size = 80
    end
  end
  object tbvisitas: TTable
    Active = True
    DatabaseName = 'wcvs'
    Filtered = True
    IndexName = 'PORCODIGO'
    TableName = 'VISITAS.DB'
    Left = 568
    Top = 24
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
    object tbvisitasH_visita: TTimeField
      FieldName = 'H_visita'
    end
    object tbvisitasH_fim: TTimeField
      FieldName = 'H_fim'
    end
    object tbvisitasItens: TSmallintField
      FieldName = 'Itens'
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
    object tbvisitasDenuncia: TIntegerField
      FieldName = 'Denuncia'
    end
    object tbvisitasNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 6
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
  end
  object dsvisitas: TDataSource
    DataSet = tbvisitas
    Left = 568
    Top = 56
  end
  object tbcpf: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCPF'
    TableName = 'CONTRIB.DB'
    Left = 632
    Top = 32
    object tbcpfCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbcpfCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcpfPESSOA: TStringField
      FieldName = 'PESSOA'
      Size = 4
    end
    object tbcpfCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object tbcpfCGC: TStringField
      FieldName = 'CGC'
      Size = 18
    end
    object tbcpfAGREGADO: TBooleanField
      FieldName = 'AGREGADO'
    end
    object tbcpfRAZAO: TStringField
      FieldName = 'RAZAO'
      Size = 50
    end
    object tbcpfFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 40
    end
    object tbcpfREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 40
    end
    object tbcpfCPFREPRES: TStringField
      FieldName = 'CPFREPRES'
      Size = 14
    end
    object tbcpfATIVIDADE: TIntegerField
      FieldName = 'ATIVIDADE'
    end
    object tbcpfAREA: TIntegerField
      FieldName = 'AREA'
    end
    object tbcpfGRUPO: TIntegerField
      FieldName = 'GRUPO'
    end
    object tbcpfMUNICIPAL: TStringField
      FieldName = 'MUNICIPAL'
      Size = 6
    end
    object tbcpfLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 40
    end
    object tbcpfCOMPLEMENT: TStringField
      FieldName = 'COMPLEMENT'
      Size = 30
    end
    object tbcpfBAIRRO: TStringField
      FieldName = 'BAIRRO'
    end
    object tbcpfCDBAI: TIntegerField
      FieldName = 'CDBAI'
    end
    object tbcpfZONA: TSmallintField
      FieldName = 'ZONA'
    end
    object tbcpfCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object tbcpfFONE: TStringField
      FieldName = 'FONE'
      Size = 9
    end
    object tbcpfEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object tbcpfTAXA: TBooleanField
      FieldName = 'TAXA'
    end
    object tbcpfINATIVIDADE: TBooleanField
      FieldName = 'INATIVIDADE'
    end
    object tbcpfOBS: TMemoField
      FieldName = 'OBS'
      BlobType = ftMemo
      Size = 10
    end
    object tbcpfPendoc: TBooleanField
      FieldName = 'Pendoc'
    end
    object tbcpfDt_cadastro: TDateField
      FieldName = 'Dt_cadastro'
    end
    object tbcpfUser: TStringField
      FieldName = 'User'
      Size = 30
    end
    object tbcpfDt_alter: TDateField
      FieldName = 'Dt_alter'
    end
    object tbcpfH_alter: TTimeField
      FieldName = 'H_alter'
    end
  end
  object dscpf: TDataSource
    DataSet = tbcpf
    Left = 632
    Top = 64
  end
  object tbcaracter: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    TableName = 'caracter.DB'
    Left = 680
    Top = 32
    object tbcaracterCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbcaracterCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbcaracterHOSTEL: TIntegerField
      FieldName = 'HOSTEL'
    end
    object tbcaracterFUNCIONARIO: TIntegerField
      FieldName = 'FUNCIONARIO'
    end
    object tbcaracterPISCINA: TBooleanField
      FieldName = 'PISCINA'
    end
    object tbcaracterRADIO: TBooleanField
      FieldName = 'RADIO'
    end
    object tbcaracterCIRUGIA: TBooleanField
      FieldName = 'CIRUGIA'
    end
    object tbcaracterSALA: TBooleanField
      FieldName = 'SALA'
    end
    object tbcaracterDISPENSA: TBooleanField
      FieldName = 'DISPENSA'
    end
    object tbcaracterFARMACEUTICOS: TBooleanField
      FieldName = 'FARMACEUTICOS'
    end
    object tbcaracterHORARIO: TStringField
      FieldName = 'HORARIO'
      Size = 15
    end
  end
  object dscaracter: TDataSource
    DataSet = tbcaracter
    Left = 680
    Top = 64
  end
end
