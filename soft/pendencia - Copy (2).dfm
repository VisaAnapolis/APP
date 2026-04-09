object frmpendencia: Tfrmpendencia
  Left = 358
  Top = 289
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Caixa de Entrada'
  ClientHeight = 474
  ClientWidth = 707
  Color = clWhite
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 20
  object sgPendencias: TStringGrid
    Left = 10
    Top = 10
    Width = 687
    Height = 455
    ColCount = 6
    DefaultColWidth = 80
    DefaultRowHeight = 30
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 0
    OnDrawCell = sgPendenciasDrawCell
    ColWidths = (
      75
      60
      100
      220
      80
      125)
  end
  object tbdenuncia: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    IndexName = 'PorDenuncia'
    TableName = 'denuncia.DB'
    Left = 32
    Top = 344
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
    object tbdenunciaPrazo: TDateField
      FieldName = 'Prazo'
    end
    object tbdenunciaLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
  end
  object dsdenuncia: TDataSource
    DataSet = tbdenuncia
    Left = 80
    Top = 344
  end
  object tboficio: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    IndexName = 'PorOficio'
    TableName = 'oficio.DB'
    Left = 128
    Top = 344
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
  end
  object dsoficio: TDataSource
    AutoEdit = False
    DataSet = tboficio
    Left = 176
    Top = 344
  end
  object tbreq: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    IndexFieldNames = 'OS'
    TableName = 'requerimento.DB'
    Left = 224
    Top = 344
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
    object tbreqPrazo: TDateField
      FieldName = 'Prazo'
    end
  end
  object dsreq: TDataSource
    AutoEdit = False
    DataSet = tbreq
    Left = 272
    Top = 344
  end
  object tbplanta: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    TableName = 'planta.DB'
    Left = 320
    Top = 344
    object tbplantaProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbplantaCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbplantaCarga: TStringField
      FieldName = 'Carga'
      Size = 40
    end
    object tbplantaAssunto: TStringField
      FieldName = 'Assunto'
      Size = 40
    end
  end
  object dsplanta: TDataSource
    AutoEdit = False
    DataSet = tbplanta
    Left = 368
    Top = 344
  end
  object tbtramitacao: TTable
    DatabaseName = 'wcvs'
    Filtered = True
    TableName = 'tramitacao.DB'
    Left = 416
    Top = 344
    object tbtramitacaoProtocolo: TIntegerField
      FieldName = 'Protocolo'
    end
    object tbtramitacaoData: TDateField
      FieldName = 'Data'
    end
    object tbtramitacaoHora: TTimeField
      FieldName = 'Hora'
    end
    object tbtramitacaoDestino: TStringField
      FieldName = 'Destino'
      Size = 40
    end
  end
  object dstramitacao: TDataSource
    AutoEdit = False
    DataSet = tbtramitacao
    Left = 464
    Top = 344
  end
  object tbcontrib: TTable
    DatabaseName = 'wcvs'
    IndexFieldNames = 'Codigo'
    TableName = 'contrib.DB'
    Left = 512
    Top = 344
    object tbcontribCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object tbcontribRazao: TStringField
      FieldName = 'Razao'
      Size = 50
    end
  end
  object dscontrib: TDataSource
    AutoEdit = False
    DataSet = tbcontrib
    Left = 560
    Top = 344
  end
end
