object frmrelativ: Tfrmrelativ
  Left = 542
  Top = 337
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Gera Rela'#231#227'o de Licenciados por Atividade Econ'#244'mica'
  ClientHeight = 464
  ClientWidth = 664
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
  object Label3: TLabel
    Left = 178
    Top = 208
    Width = 103
    Height = 13
    Caption = 'Selecione o exerc'#237'cio'
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 649
    Height = 441
    Alignment = taRightJustify
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 159
      Height = 13
      Caption = 'Selecione a Atividade Econ'#244'mica'
    end
    object Label4: TLabel
      Left = 8
      Top = 248
      Width = 57
      Height = 13
      Caption = 'Localiza'#231#226'o'
    end
    object LbContagem: TLabel
      Left = 368
      Top = 361
      Width = 20
      Height = 24
      Caption = '__'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Button1: TButton
      Left = 424
      Top = 332
      Width = 169
      Height = 25
      Caption = 'OK'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 424
      Top = 388
      Width = 169
      Height = 25
      Caption = 'Cancela'
      TabOrder = 6
      OnClick = Button2Click
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 56
      Width = 617
      Height = 177
      DataSource = dscnae
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Subclasse'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Atividade'
          Visible = True
        end>
    end
    object CBAlvara: TCheckBox
      Left = 472
      Top = 24
      Width = 145
      Height = 17
      Caption = 'Filtro Alvar'#225' atualizado'
      TabOrder = 1
    end
    object DBGBairro: TDBGrid
      Left = 8
      Top = 264
      Width = 345
      Height = 160
      DataSource = dsbairroaux
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NOME'
          Visible = True
        end>
    end
    object RadioGroup1: TRadioGroup
      Left = 184
      Top = 8
      Width = 257
      Height = 41
      Caption = 'Ordem '
      Columns = 2
      Items.Strings = (
        'Atividade'
        'Subclasse')
      TabOrder = 0
    end
    object RGBairro: TRadioGroup
      Left = 368
      Top = 264
      Width = 257
      Height = 41
      Caption = 'Filtro por Bairro'
      Columns = 2
      Items.Strings = (
        'Por Bairro'
        'Geral')
      TabOrder = 4
    end
  end
  object dscnae: TDataSource
    AutoEdit = False
    DataSet = tbcnae
    Left = 224
    Top = 392
  end
  object tbcnae: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Atividade'
    TableName = 'cnae.DB'
    Left = 56
    Top = 408
    object tbcnaeControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbcnaeAtividade: TStringField
      FieldName = 'Atividade'
      Size = 254
    end
    object tbcnaeClasse: TStringField
      FieldName = 'Classe'
      Size = 7
    end
    object tbcnaeSubclasse: TStringField
      FieldName = 'Subclasse'
      Size = 9
    end
  end
  object tbaux: TTable
    DatabaseName = 'wcvs'
    Filter = 'bairro = '#39'BAIRRO JUNDIA'#205#39
    Exclusive = True
    IndexFieldNames = 'Razao'
    TableName = 'auxrelativ.db'
    Left = 280
    Top = 416
    object tbauxCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbauxControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbauxRazao: TStringField
      FieldName = 'Razao'
      Size = 50
    end
    object tbauxFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 50
    end
    object tbauxLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 40
    end
    object tbauxComplemento: TStringField
      FieldName = 'Complemento'
      Size = 60
    end
    object tbauxBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object tbauxNumero_alvara: TIntegerField
      FieldName = 'Numero_alvara'
    end
    object tbauxExercicio: TIntegerField
      FieldName = 'Exercicio'
    end
    object tbauxData_validade: TDateField
      FieldName = 'Data_validade'
    end
    object tbauxSubclasse: TStringField
      FieldName = 'Subclasse'
      Size = 9
    end
    object tbauxData_libera: TDateField
      FieldName = 'Data_libera'
    end
    object tbauxProvisorio: TStringField
      FieldName = 'Provisorio'
      Size = 10
    end
    object tbauxNovo: TBooleanField
      FieldName = 'Novo'
    end
    object tbauxCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 18
    end
    object tbauxCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object tbauxInatividade: TBooleanField
      FieldName = 'Inatividade'
    end
    object tbauxValidade: TBooleanField
      FieldName = 'Validade'
    end
  end
  object tbcontrib: TTable
    DatabaseName = 'wcvs'
    TableName = 'CONTRIB.DB'
    Left = 624
    Top = 360
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
    object tbcontribHORARIO: TStringField
      FieldName = 'HORARIO'
      Size = 15
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
    object tbcontribCDBAI: TIntegerField
      FieldName = 'CDBAI'
    end
    object tbcontribCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
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
  end
  object tbbairro: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CDBAI'
    MasterSource = dscontrib
    TableName = 'bairro.DB'
    Left = 576
    Top = 416
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
  object tbalvara: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorCodigo'
    MasterFields = 'CODIGO'
    MasterSource = dscontrib
    TableName = 'alvara.DB'
    Left = 464
    Top = 360
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
    object tbalvaraEvento: TBooleanField
      FieldName = 'Evento'
    end
    object tbalvaraTipo: TBooleanField
      FieldName = 'Tipo'
    end
    object tbalvaraUnidade: TStringField
      FieldName = 'Unidade'
    end
    object tbalvaraNumero: TIntegerField
      FieldName = 'Numero'
    end
    object tbalvaraLibera: TBooleanField
      FieldName = 'Libera'
    end
    object tbalvaraDt_libera: TDateField
      FieldName = 'Dt_libera'
    end
    object tbalvaraAutoridade: TStringField
      FieldName = 'Autoridade'
      Size = 40
    end
    object tbalvaraDt_emite: TDateField
      FieldName = 'Dt_emite'
    end
    object tbalvaraDt_validade: TDateField
      FieldName = 'Dt_validade'
    end
    object tbalvaraEmitente: TStringField
      FieldName = 'Emitente'
      Size = 40
    end
    object tbalvaraDt_reemite: TDateField
      FieldName = 'Dt_reemite'
    end
    object tbalvaraReemitente: TStringField
      FieldName = 'Reemitente'
      Size = 40
    end
    object tbalvaraAutenticador: TStringField
      FieldName = 'Autenticador'
      Size = 10
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
    object tbalvaraObs: TMemoField
      FieldName = 'Obs'
      BlobType = ftMemo
      Size = 10
    end
    object tbalvaraDuam: TIntegerField
      FieldName = 'Duam'
    end
    object tbalvaraDt_duam: TDateField
      FieldName = 'Dt_duam'
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
  end
  object tbalvlib: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorAlvara'
    MasterFields = 'Numero'
    MasterSource = dsalvara
    TableName = 'alvlib.DB'
    Left = 448
    Top = 400
    object tbalvlibControle: TAutoIncField
      FieldName = 'Controle'
      ReadOnly = True
    end
    object tbalvlibAlvara: TIntegerField
      FieldName = 'Alvara'
    end
    object tbalvlibData: TDateField
      FieldName = 'Data'
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
  end
  object dscontrib: TDataSource
    AutoEdit = False
    DataSet = tbcontrib
    Left = 608
    Top = 352
  end
  object dsalvara: TDataSource
    AutoEdit = False
    DataSet = tbalvara
    Left = 488
    Top = 368
  end
  object tbbairroaux: TTable
    DatabaseName = 'wcvs'
    IndexName = 'PorNome'
    TableName = 'bairro.DB'
    Left = 288
    Top = 376
    object tbbairroauxCONTROLE: TAutoIncField
      FieldName = 'CONTROLE'
      ReadOnly = True
    end
    object tbbairroauxCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tbbairroauxNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object tbbairroauxSETOR: TIntegerField
      FieldName = 'SETOR'
    end
  end
  object dsbairroaux: TDataSource
    DataSet = tbbairroaux
    Left = 312
    Top = 392
  end
end
