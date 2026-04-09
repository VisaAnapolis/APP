unit ESTABE;

interface

uses
  DBIProcs, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBTables, ToolWin, ComCtrls, Buttons, StdCtrls,
  Mask, DBCtrls, dbcgrids, Grids, DBGrids, ExtCtrls, ActnMan, ActnCtrls,
  jpeg, dateutils, ImgList, ExtDlgs, OleServer, Word2000, OleCtrls, SHDocVw,
  VCFI, AcroPDFLib_TLB, uExportarJsonCVS_Shared, uExportarMenor, uExportCSV;


type
  Tfrmestabe = class(TForm)
    StatusBar1: TStatusBar;
    barraferra: TToolBar;
    btnovo: TSpeedButton;
    btgrava: TSpeedButton;
    btcancel: TSpeedButton;
    btprn: TSpeedButton;
    btfecha: TSpeedButton;
    bthelp: TSpeedButton;
    btaltera: TSpeedButton;
    btlocpro: TSpeedButton;
    PageControl1: TPageControl;
    Tabident: TTabSheet;
    TabCarac: TTabSheet;
    dssequencia: TDataSource;
    tbsequencia: TTable;
    tbsequenciaNumero: TIntegerField;
    dscontrib: TDataSource;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribFANTASIA: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbvisitas: TTable;
    dsvisitas: TDataSource;
    tbcontrib: TTable;
    tbcontribATIVIDADE: TSmallintField;
    tbativi: TTable;
    tbativiCONTROLE: TAutoIncField;
    tbativiNUMERO: TIntegerField;
    tbativiNOME: TStringField;
    dsativi: TDataSource;
    TabAlvara: TTabSheet;
    TabHist: TTabSheet;
    Panel1: TPanel;
    DBEcodigo: TDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    DBErazao: TDBEdit;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    DBGrid2: TDBGrid;
    DBEnumero: TDBEdit;
    DBEnewpz: TDBEdit;
    dshistorico: TDataSource;
    tbhistorico: TTable;
    Label19: TLabel;
    tbvisitasCONTROLE: TAutoIncField;
    tbvisitasCODIGO: TIntegerField;
    tbvisitasDT_VISITA: TDateField;
    tbvisitasPZ_RETORNO: TSmallintField;
    tbvisitasNDOC: TIntegerField;
    tbhistoricoCONTROLE: TAutoIncField;
    tbhistoricoNDOC: TIntegerField;
    tbhistoricoDESCR: TMemoField;
    btdeleta: TSpeedButton;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    DBEfantasia: TDBEdit;
    Label4: TLabel;
    DBElogra: TDBEdit;
    DBEcomple: TDBEdit;
    Label6: TLabel;
    DBEfone: TDBEdit;
    Label14: TLabel;
    Label13: TLabel;
    DBEcep: TDBEdit;
    Label11: TLabel;
    DBmunicipal: TDBEdit;
    Label12: TLabel;
    Label3: TLabel;
    DBEcgc: TDBEdit;
    GroupBox7: TGroupBox;
    tbalvara: TTable;
    dsalvara: TDataSource;
    DBEalvara: TDBEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label32: TLabel;
    PainelVisita: TPanel;
    btnovvisita: TSpeedButton;
    btaltvisita: TSpeedButton;
    btgravisita: TSpeedButton;
    btcanvisita: TSpeedButton;
    btdelvisita: TSpeedButton;
    tbvisitasFiscal1: TStringField;
    tbvisitasFiscal2: TStringField;
    tbvisitasFiscal3: TStringField;
    tbhistoricoDISPOSITIVO: TMemoField;
    tbvisitasTIPO: TStringField;
    DBCtipo: TDBComboBox;
    PainelAlvara: TPanel;
    btnovalvara: TSpeedButton;
    btaltalvara: TSpeedButton;
    btgravalvara: TSpeedButton;
    btcancalvara: TSpeedButton;
    btdelalvara: TSpeedButton;
    navalvara: TDBNavigator;
    tbrt: TTable;
    tbrtControle: TAutoIncField;
    tbrtCodigo: TIntegerField;
    tbrtNomeResp1: TStringField;
    tbrtConsResp1: TStringField;
    tbrtUFResp1: TStringField;
    tbrtRegResp1: TStringField;
    tbrtNomeResp2: TStringField;
    tbrtConsResp2: TStringField;
    tbrtUFResp2: TStringField;
    tbrtRegResp2: TStringField;
    dsrt: TDataSource;
    tbalvaraControle: TAutoIncField;
    tbalvaraCodigo: TIntegerField;
    tbalvaraExercicio: TIntegerField;
    tbalvaraNumero: TIntegerField;
    DBEDuam: TDBEdit;
    Label37: TLabel;
    Label38: TLabel;
    tbalvaraDuam: TIntegerField;
    tbalvaraDt_duam: TDateField;
    tbcontribObs: TMemoField;
    tbcontribCEP: TStringField;
    tbcontribFONE: TStringField;
    tbcontribTAXA: TBooleanField;
    GroupBox6: TGroupBox;
    DBMObsestabe: TDBMemo;
    Label16: TLabel;
    tbalvaraObs: TMemoField;
    DBMobsalvara: TDBMemo;
    DBCFiscal1: TDBComboBox;
    DBCFiscal2: TDBComboBox;
    DBCFiscal3: TDBComboBox;
    PainelTermo: TPanel;
    GroupBox3: TGroupBox;
    Label33: TLabel;
    Label34: TLabel;
    DBMhistorico: TDBMemo;
    DBMDisp: TDBMemo;
    Label18: TLabel;
    tbcontribCGC: TStringField;
    tbcontribMUNICIPAL: TStringField;
    tbcontribINATIVIDADE: TBooleanField;
    tbcontribRAZAO: TStringField;
    tbalvaraUnidade: TStringField;
    DBCacao: TDBComboBox;
    Label46: TLabel;
    tbvisitasACAO: TStringField;
    tbsequenciaDoc: TIntegerField;
    DBCinativ: TDBCheckBox;
    tbvisitasDenuncia: TIntegerField;
    Label49: TLabel;
    DBEDen: TDBEdit;
    DBNavHist: TDBNavigator;
    dsarea: TDataSource;
    tbarea: TTable;
    tbareaCod: TIntegerField;
    tbareaNome: TStringField;
    tbcontribAREA: TIntegerField;
    tbcontribGRUPO: TIntegerField;
    tbgrupo: TTable;
    dsgrupo: TDataSource;
    tbgrupoCOD: TIntegerField;
    tbgrupoGRUPO: TStringField;
    tbgrupoAREA: TIntegerField;
    tbgrupoDESCRICAO: TStringField;
    tbgrupoVALOR: TCurrencyField;
    Label52: TLabel;
    DBEmail: TDBEdit;
    tbativiGRUPO: TIntegerField;
    tbativiAREA: TStringField;
    tbcontribEMAIL: TStringField;
    Label54: TLabel;
    dsbairro: TDataSource;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    DBLBairro: TDBLookupComboBox;
    tbcontribCDBAI: TIntegerField;
    tbsinavisa: TTable;
    dssinavisa: TDataSource;
    tbsinavisaCONTROLE: TAutoIncField;
    tbsinavisaCOMPLEXIDADE: TStringField;
    tbsinavisaCODIGO: TIntegerField;
    tbsinavisaPROCEDIMENTO: TStringField;
    tbbairroCODIGO: TIntegerField;
    tbalvaraLibera: TBooleanField;
    tbalvaraAutoridade: TStringField;
    tbalvaraDt_libera: TDateField;
    tbcontribDt_cadastro: TDateField;
    Label59: TLabel;
    tbcontribBAIRRO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    Label45: TLabel;
    DBEemite: TDBEdit;
    Label47: TLabel;
    DBEDtemite: TDBEdit;
    tbalvaraDt_emite: TDateField;
    tbalvaraEmitente: TStringField;
    tbcontribPESSOA: TStringField;
    DBCPessoa: TDBComboBox;
    Label60: TLabel;
    DBECPF: TDBEdit;
    tbcontribCPF: TStringField;
    tbativiSINAVISA: TIntegerField;
    DBTDt_cadastro: TDBText;
    DBTSetor: TDBText;
    TextoATV: TStaticText;
    Bevel5: TBevel;
    Bevel6: TBevel;
    tbsequenciaDen: TIntegerField;
    tbsequenciaDisponibilidade: TBooleanField;
    anvisa: TImage;
    StaticText1: TStaticText;
    STuser: TStaticText;
    Bevel7: TBevel;
    Stdata: TStaticText;
    Sthora: TStaticText;
    tbgrupoPORTE: TStringField;
    tbcontribAGREGADO: TBooleanField;
    tbcontribZONA: TSmallintField;
    tbcontribUser: TStringField;
    Bevel8: TBevel;
    StaticText2: TStaticText;
    DBUser: TDBText;
    DBDt_alter: TDBText;
    tbcontribDt_alter: TDateField;
    tbcontribH_alter: TTimeField;
    DBTH_alter: TDBText;
    tbauxcontrib: TTable;
    dsaux: TDataSource;
    tbauxcontribCONTROLE: TAutoIncField;
    tbauxcontribCODIGO: TIntegerField;
    tbauxcontribPESSOA: TStringField;
    tbauxcontribCPF: TStringField;
    tbauxcontribCGC: TStringField;
    tbauxcontribRAZAO: TStringField;
    tbsequenciaVersao: TStringField;
    tbsequenciaDt_versao: TStringField;
    Timeadmim: TTimer;
    Texto_horario2: TStaticText;
    DBEDtreq: TDBEdit;
    DBEDataV: TDBEdit;
    tbcontribPendoc: TBooleanField;
    tbauxvisita: TTable;
    dsauxvisita: TDataSource;
    tbauxvisitaCONTROLE: TAutoIncField;
    tbauxvisitaCODIGO: TIntegerField;
    tbauxvisitaDT_VISITA: TDateField;
    tbauxvisitaTIPO: TStringField;
    tbauxvisitaNDOC: TIntegerField;
    tbauxvisitaFiscal1: TStringField;
    tbauxvisitaFiscal2: TStringField;
    tbauxvisitaFiscal3: TStringField;
    tbvisitasNUMERO: TStringField;
    tbauxvisitaNUMERO: TStringField;
    Btemitenovo: TButton;
    tbsequenciaAlvara: TIntegerField;
    tbsequenciaPt: TIntegerField;
    Btreemite: TButton;
    tbalvaraAutenticador: TStringField;
    tbcnae: TTable;
    tbcnaeSubclasse: TStringField;
    tbcnaeAtividade: TStringField;
    dscnae: TDataSource;
    Label55: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label56: TLabel;
    PainelCAE: TPanel;
    btnovocae: TSpeedButton;
    btaltcae: TSpeedButton;
    btgravacae: TSpeedButton;
    btcancelcae: TSpeedButton;
    btdelecae: TSpeedButton;
    DBNavCAE: TDBNavigator;
    tbcontribREPRESENTANTE: TStringField;
    tbcontribCPFREPRES: TStringField;
    tbrtAtividade: TStringField;
    Label50: TLabel;
    Label61: TLabel;
    DBLdescri: TDBLookupComboBox;
    DBCarquivo: TDBCheckBox;
    DBCHora: TDBComboBox;
    Label39: TLabel;
    tbrtSubclasse: TStringField;
    tbrtTipo: TStringField;
    Label31: TLabel;
    DBComboBox1: TDBComboBox;
    dblsub: TDBLookupComboBox;
    bitdoc: TSpeedButton;
    Label63: TLabel;
    tbvisitasAtividade: TStringField;
    DBLookupComboBox4: TDBLookupComboBox;
    tbauxrt: TTable;
    dsauxrt: TDataSource;
    tbauxrtControle: TAutoIncField;
    tbauxrtCodigo: TIntegerField;
    tbauxrtSubclasse: TStringField;
    tbauxrtTipo: TStringField;
    tbcontribHORARIO: TStringField;
    GroupBox5: TGroupBox;
    Label62: TLabel;
    DBLsuclasse: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    PainelAutoriza: TPanel;
    btnovautor: TSpeedButton;
    btgravautor: TSpeedButton;
    btcancautor: TSpeedButton;
    btdelautor: TSpeedButton;
    tbalvlib: TTable;
    dsalvlib: TDataSource;
    tbalvlibControle: TAutoIncField;
    tbalvlibAlvara: TIntegerField;
    tbalvlibData: TDateField;
    tbalvlibAtividade: TStringField;
    tbalvlibAutoridade: TStringField;
    DBEliberante: TDBEdit;
    Label58: TLabel;
    DBEDtlibera: TDBEdit;
    tbalvlibAutenticador: TStringField;
    navautor: TDBNavigator;
    tbalvrt: TTable;
    tbalvrtControle: TAutoIncField;
    tbalvrtCodigo: TIntegerField;
    tbalvrtAtividade: TStringField;
    tbalvrtSubclasse: TStringField;
    tbalvrtTipo: TStringField;
    dsalvrt: TDataSource;
    DBGrid3: TDBGrid;
    tbativiVALOR: TCurrencyField;
    tbauxlib: TTable;
    tbauxlibControle: TAutoIncField;
    tbauxlibAlvara: TIntegerField;
    tbauxlibData: TDateField;
    tbauxlibAtividade: TStringField;
    dsauxlib: TDataSource;
    Label17: TLabel;
    DBEdit6: TDBEdit;
    Label41: TLabel;
    DBEdit7: TDBEdit;
    Label43: TLabel;
    DBEdit8: TDBEdit;
    tbalvaraDt_reemite: TDateField;
    tbalvaraReemitente: TStringField;
    DBEdit9: TDBEdit;
    Label65: TLabel;
    tbalvaraRequerente: TStringField;
    Label66: TLabel;
    DBMemo1: TDBMemo;
    tbalvaraOb_duam: TMemoField;
    Label24: TLabel;
    DBEdit10: TDBEdit;
    Label25: TLabel;
    DBEdit11: TDBEdit;
    Label67: TLabel;
    DBEdit13: TDBEdit;
    Label68: TLabel;
    tbvisitasUs_inclu: TStringField;
    tbvisitasDt_inclu: TDateField;
    tbvisitasGr_inclu: TStringField;
    tbvisitasUs_altera: TStringField;
    tbvisitasDt_altera: TDateField;
    DBEdit14: TDBEdit;
    Label69: TLabel;
    DBEdit12: TDBEdit;
    tbalvaraDt_validade: TDateField;
    Label70: TLabel;
    DBEDtvalidade: TDBEdit;
    DBCProvisorio: TDBCheckBox;
    tbalvaraTipo: TBooleanField;
    TabVeiculo: TTabSheet;
    GroupBox9: TGroupBox;
    Label71: TLabel;
    Label72: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label81: TLabel;
    Label83: TLabel;
    DBEdit15: TDBEdit;
    PainelVeiculo: TPanel;
    btnovoveiculo: TSpeedButton;
    Btalteraveiculo: TSpeedButton;
    btgravaveiculo: TSpeedButton;
    btcancelaveiculo: TSpeedButton;
    btdeletaveiculo: TSpeedButton;
    navveiculo: TDBNavigator;
    btemite: TButton;
    btimprime: TButton;
    DBEDuaveic: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEReqveic: TDBEdit;
    DBEExveic: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    Label85: TLabel;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    Label86: TLabel;
    Label44: TLabel;
    DBEMarca: TDBEdit;
    DBEModelo: TDBEdit;
    Label84: TLabel;
    DBEAno: TDBEdit;
    Label87: TLabel;
    Label88: TLabel;
    DBEPlaca: TDBEdit;
    DBEChasi: TDBEdit;
    Label89: TLabel;
    Label73: TLabel;
    DBMObsveiculo: TDBMemo;
    Label90: TLabel;
    DBECor: TDBEdit;
    tbveiculo: TTable;
    dsveiculo: TDataSource;
    tbveiculoContole: TAutoIncField;
    tbveiculoCodigo: TIntegerField;
    tbveiculoExercicio: TIntegerField;
    tbveiculoDuam: TIntegerField;
    tbveiculoDt_req: TDateField;
    tbveiculoNumero: TIntegerField;
    tbveiculoResponsavel_req: TStringField;
    tbveiculoMarca: TStringField;
    tbveiculoModelo: TStringField;
    tbveiculoCor: TStringField;
    tbveiculoAno: TIntegerField;
    tbveiculoPlaca: TStringField;
    tbveiculoChassi: TStringField;
    tbveiculoAutorizante: TStringField;
    tbveiculoDt_autor: TDateField;
    tbveiculoEmissor: TStringField;
    tbveiculoDt_emite: TDateField;
    tbveiculoDt_validade: TDateField;
    tbveiculoImpressao: TStringField;
    tbveiculoDt_impressao: TDateField;
    tbveiculoObs: TMemoField;
    tbveiculoAtenticador: TStringField;
    DBGrid4: TDBGrid;
    tbveiculoAutorizacao: TBooleanField;
    Btliberav: TButton;
    tbsequenciaVeiculo: TIntegerField;
    Btprovisorio: TButton;
    Label53: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit16: TDBEdit;
    Label48: TLabel;
    DBEdit19: TDBEdit;
    tbcontribREPRESENTANTE2: TStringField;
    tbcontribCPFREPRES2: TStringField;
    tbcontribCELULAR: TStringField;
    tbalvaraCancela: TBooleanField;
    DBEdit22: TDBEdit;
    DBEdit28: TDBEdit;
    Label51: TLabel;
    Label82: TLabel;
    tbalvaraCancelador: TStringField;
    tbalvaraDt_cancela: TDateField;
    DBCeventos: TDBCheckBox;
    tbalvaraEvento: TBooleanField;
    Btevento: TButton;
    DBEVal: TDBEdit;
    Label91: TLabel;
    Label92: TLabel;
    btprndoc: TSpeedButton;
    TabAnexo: TTabSheet;
    DBCcancela: TDBCheckBox;
    tbreq: TTable;
    tbreqControle: TAutoIncField;
    tbreqCodigo: TIntegerField;
    tbreqOS: TIntegerField;
    tbreqArea: TStringField;
    tbreqMotivo: TStringField;
    tbreqVeiculos: TSmallintField;
    tbreqRequerente: TStringField;
    tbreqObs_Req: TStringField;
    tbreqDt_Req: TDateField;
    tbreqFiscal_Encaminha: TStringField;
    tbreqRecebedor: TStringField;
    tbreqDt_encaminha: TDateField;
    tbreqEncaminhador: TStringField;
    tbreqFiscal_Atend: TStringField;
    tbreqDt_Atend: TDateField;
    tbreqTipo_Documento: TStringField;
    tbreqObs_Atend: TStringField;
    dsreq: TDataSource;
    Bevel1: TBevel;
    tbvisitasOS: TIntegerField;
    TabPlanta: TTabSheet;
    tbimagem: TTable;
    tbimagemControle: TAutoIncField;
    tbimagemCodigo: TIntegerField;
    tbimagemFoto: TGraphicField;
    dsimagem: TDataSource;
    GroupBox4: TGroupBox;
    GroupBox10: TGroupBox;
    DBNavanexos: TDBNavigator;
    DBGrid1: TDBGrid;
    GroupBox11: TGroupBox;
    OpenPictureDialog1: TOpenPictureDialog;
    tbreqEncaminhamento: TBooleanField;
    tbreqAtendimento: TBooleanField;
    tbreqNum_Documento: TStringField;
    Label40: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label42: TLabel;
    tbalvaraAlteracao: TStringField;
    tbalvaraDt_altera: TDateField;
    DBExercicio: TDBEdit;
    GroupBox12: TGroupBox;
    PainelProtocolo: TPanel;
    Btregistra: TSpeedButton;
    Brgravaproto: TSpeedButton;
    Btcancelaproto: TSpeedButton;
    Btdeletaproto: TSpeedButton;
    DBNProto: TDBNavigator;
    Label93: TLabel;
    DBEcelular: TDBEdit;
    Label94: TLabel;
    DBEptnome: TDBEdit;
    Label95: TLabel;
    DBEptmail: TDBEdit;
    DBEdit31: TDBEdit;
    Label96: TLabel;
    Btandamento: TSpeedButton;
    Btprotocolo: TSpeedButton;
    Label98: TLabel;
    tbplanta: TTable;
    tbplantaControle: TAutoIncField;
    tbplantaData: TDateField;
    tbplantaEmail: TStringField;
    tbplantaCelular: TStringField;
    dsplanta: TDataSource;
    Btdespacho: TSpeedButton;
    DBCassunto: TDBComboBox;
    BtRemessa: TSpeedButton;
    tbplantaHora: TTimeField;
    tbplantaAssunto: TStringField;
    tbplantaUsuario: TStringField;
    tbplantaProtocolante: TStringField;
    tbplantaCodigo: TIntegerField;
    DBEdit33: TDBEdit;
    Label77: TLabel;
    DBEdoc: TDBEdit;
    Label80: TLabel;
    tbplantaDocumento: TStringField;
    tbplantaProtocolo: TIntegerField;
    DBText1: TDBText;
    tbsequenciaProtocolo: TIntegerField;
    tbtramitacao: TTable;
    tbtramitacaoControle: TAutoIncField;
    tbtramitacaoProtocolo: TIntegerField;
    tbtramitacaoData: TDateField;
    tbtramitacaoHora: TTimeField;
    tbtramitacaoDescricao: TStringField;
    tbtramitacaoDestino: TStringField;
    tbtramitacaoDespacho: TMemoField;
    tbtramitacaoUsuario: TStringField;
    dstramitacao: TDataSource;
    DBCcomplemento: TDBComboBox;
    tbplantaComplemento: TStringField;
    tbplantaObserva: TStringField;
    Label100: TLabel;
    DBMemo3: TDBMemo;
    Label104: TLabel;
    GBTramita: TGroupBox;
    Label99: TLabel;
    DBCdescric: TDBComboBox;
    DBCdestino: TDBComboBox;
    Label102: TLabel;
    Label97: TLabel;
    DBMemo2: TDBMemo;
    DBGTramita: TDBGrid;
    Bevel2: TBevel;
    DBCJuntada: TDBComboBox;
    Label10: TLabel;
    Label103: TLabel;
    DBEInteressado: TDBEdit;
    BitPtJuntada: TSpeedButton;
    tbtramitacaoJuntada: TStringField;
    tbtramitacaoInteressado: TStringField;
    Bevel3: TBevel;
    tbplantaCarga: TStringField;
    tbvisitasPRIORIDADE: TBooleanField;
    TabPas: TTabSheet;
    TabProjeto: TTabSheet;
    TabCan: TTabSheet;
    GroupBox14: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Panel2: TPanel;
    Bevel4: TBevel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    DBText2: TDBText;
    SpeedButton9: TSpeedButton;
    DBNavigator1: TDBNavigator;
    DBEdit30: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBComboBox2: TDBComboBox;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    DBComboBox3: TDBComboBox;
    DBMemo4: TDBMemo;
    GroupBox15: TGroupBox;
    Bevel9: TBevel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    DBComboBox4: TDBComboBox;
    DBComboBox5: TDBComboBox;
    DBMemo5: TDBMemo;
    DBGrid6: TDBGrid;
    DBComboBox6: TDBComboBox;
    DBEdit38: TDBEdit;
    DBEdit39: TDBEdit;
    GroupBox18: TGroupBox;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Panel4: TPanel;
    Bevel12: TBevel;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    DBText4: TDBText;
    SpeedButton27: TSpeedButton;
    DBNavigator3: TDBNavigator;
    DBEdit48: TDBEdit;
    DBEdit49: TDBEdit;
    DBEdit50: TDBEdit;
    DBEdit51: TDBEdit;
    DBComboBox12: TDBComboBox;
    DBEdit52: TDBEdit;
    DBEdit53: TDBEdit;
    DBComboBox13: TDBComboBox;
    DBMemo8: TDBMemo;
    GroupBox19: TGroupBox;
    Bevel13: TBevel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    DBComboBox14: TDBComboBox;
    DBComboBox15: TDBComboBox;
    DBMemo9: TDBMemo;
    DBGrid8: TDBGrid;
    DBComboBox16: TDBComboBox;
    DBEdit54: TDBEdit;
    DBEdit55: TDBEdit;
    GroupBox20: TGroupBox;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    Panel5: TPanel;
    Bevel14: TBevel;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    DBText5: TDBText;
    SpeedButton36: TSpeedButton;
    DBNavigator4: TDBNavigator;
    DBEdit56: TDBEdit;
    DBEdit57: TDBEdit;
    DBEdit58: TDBEdit;
    DBEdit59: TDBEdit;
    DBComboBox17: TDBComboBox;
    DBEdit60: TDBEdit;
    DBEdit61: TDBEdit;
    DBComboBox18: TDBComboBox;
    DBMemo10: TDBMemo;
    GroupBox21: TGroupBox;
    Bevel15: TBevel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    DBComboBox19: TDBComboBox;
    DBComboBox20: TDBComboBox;
    DBMemo11: TDBMemo;
    DBGrid9: TDBGrid;
    DBComboBox21: TDBComboBox;
    DBEdit62: TDBEdit;
    DBEdit63: TDBEdit;
    tbvisitasEntrega: TBooleanField;
    DBCLibera: TDBComboBox;
    Label120: TLabel;
    tbvisitasLibera: TStringField;
    Label57: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    DBEdit43: TDBEdit;
    Label125: TLabel;
    DBEdit44: TDBEdit;
    tbalvlibLiberante: TStringField;
    tbalvlibDocumento: TStringField;
    DBCAutoridade: TDBComboBox;
    tbalvlibDt_documento: TDateField;
    tbcnaeComplexidade: TStringField;
    DBEdit40: TDBEdit;
    Label126: TLabel;
    tbrmpf: TTable;
    dsrmpf: TDataSource;
    tbrmpfControle: TAutoIncField;
    tbrmpfNome: TStringField;
    tbrmpfData: TDateField;
    tbrmpfMes: TSmallintField;
    tbrmpfAno: TSmallintField;
    tbrmpfPonto: TFloatField;
    tbrmpfHomologado: TStringField;
    tbrtEquipe: TStringField;
    Label101: TLabel;
    DBEdit29: TDBEdit;
    tbplantaEcarregado: TStringField;
    Label128: TLabel;
    tbvisitasArea: TStringField;
    DBComboBox7: TDBComboBox;
    Label129: TLabel;
    tbvisitasModalidade: TStringField;
    DbCordem: TDBComboBox;
    Label182: TLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    Label183: TLabel;
    DBEOs: TDBEdit;
    Label167: TLabel;
    DBEOf: TDBEdit;
    tbvisitasProtocolo: TIntegerField;
    DBEProto: TDBEdit;
    Label35: TLabel;
    tbvisitasOficio: TIntegerField;
    tboficio: TTable;
    dsoficio: TDataSource;
    tboficioOficio: TIntegerField;
    tboficioData: TDateField;
    tboficioFiscalencaminha: TStringField;
    tboficioDtencaminha: TDateField;
    tboficioPrazo: TDateField;
    tboficioDtatendimento: TDateField;
    tboficioUser: TStringField;
    tboficioArchive: TBooleanField;
    tbauxplanta: TTable;
    dsauxplanta: TDataSource;
    tbauxplantaCodigo: TIntegerField;
    tbauxplantaProtocolo: TIntegerField;
    tbauxplantaCarga: TStringField;
    tboficioCancela: TBooleanField;
    tbrdpf: TTable;
    dsrdpf: TDataSource;
    tbrdpfTipo: TStringField;
    tbrdpfNome: TStringField;
    tbrdpfData: TDateField;
    tbrdpfEntrega: TBooleanField;
    tbrdpfHomologado: TStringField;
    tbrdpfFecha: TBooleanField;
    tbrdpfEstabe: TStringField;
    tbcifa: TTable;
    dscifa: TDataSource;
    tbcifaControle: TAutoIncField;
    tbcifaCodigo: TIntegerField;
    tbcifaData: TDateField;
    tbcifaProtocolo: TIntegerField;
    tbcifaArea: TStringField;
    tbcifaCategoria: TStringField;
    tbcifaDesigna: TStringField;
    tbcifaMarca: TStringField;
    tbcifaEmbalagem: TStringField;
    tbcifaPrazo: TStringField;
    tbcategoria: TTable;
    dscategoria: TDataSource;
    tbcategoriaControle: TAutoIncField;
    tbcategoriaCodigo: TIntegerField;
    tbcategoriaDescricao: TStringField;
    tbcifaRegistro: TStringField;
    Label165: TLabel;
    DBCMeio: TDBComboBox;
    tbvisitasMeio: TStringField;
    tboficioEmitente: TStringField;
    tboficioMotivo: TStringField;
    tboficioRegulado: TStringField;
    tboficioLogradouro: TStringField;
    tboficioCdbai: TSmallintField;
    tboficioOrdem: TStringField;
    tboficioCpf: TStringField;
    tboficioCnpj: TStringField;
    tbsequenciaOficio: TIntegerField;
    tbdenuncia: TTable;
    tbdenunciaDenuncia: TIntegerField;
    tbdenunciaArchive: TBooleanField;
    tbdenunciaFiscalEncaminha: TStringField;
    dsdenuncia: TDataSource;
    tbreqCancelado: TBooleanField;
    tbauxoficio: TTable;
    tbauxoficioControle: TAutoIncField;
    tbauxoficioOficio: TIntegerField;
    dsauxoficio: TDataSource;
    tbauxoficioOrigem: TStringField;
    tboficioControle: TAutoIncField;
    tboficioOrigem: TStringField;
    Label166: TLabel;
    DBEdit41: TDBEdit;
    tbreqComplexidade: TStringField;
    tbreqPrioridade: TBooleanField;
    tboficioTerceiro: TBooleanField;
    TabSheet1: TTabSheet;
    GroupBox16: TGroupBox;
    Label169: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label175: TLabel;
    Panel3: TPanel;
    Bevel10: TBevel;
    DBText3: TDBText;
    DBNavigator2: TDBNavigator;
    DBEdit64: TDBEdit;
    DBEdit65: TDBEdit;
    DBEdit67: TDBEdit;
    DBMemo6: TDBMemo;
    DBGrid5: TDBGrid;
    tbos: TTable;
    dsos: TDataSource;
    tbosCodigo: TIntegerField;
    tbosOS: TIntegerField;
    tbosMotivo: TStringField;
    tbosObs_Req: TStringField;
    tbosDt_Req: TDateField;
    tbosPrazo: TDateField;
    tbosFiscal_Encaminha: TStringField;
    tbosDt_encaminha: TDateField;
    tbosDt_Atend: TDateField;
    tbosCancelado: TBooleanField;
    DBEdit70: TDBEdit;
    tbosRequerente: TStringField;
    DBEdit68: TDBEdit;
    DBEdit69: TDBEdit;
    Label173: TLabel;
    Label174: TLabel;
    Label170: TLabel;
    DBEdit72: TDBEdit;
    tbosFiscal_Atend: TStringField;
    Label176: TLabel;
    DBEdit71: TDBEdit;
    Label178: TLabel;
    DBEdit73: TDBEdit;
    Label179: TLabel;
    DBEdit74: TDBEdit;
    Label180: TLabel;
    DBEdit75: TDBEdit;
    Label181: TLabel;
    DBEdit76: TDBEdit;
    Label184: TLabel;
    DBEdit77: TDBEdit;
    Label185: TLabel;
    DBEdit78: TDBEdit;
    Label186: TLabel;
    DBEdit79: TDBEdit;
    Label187: TLabel;
    DBEdit80: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label188: TLabel;
    DBEdit81: TDBEdit;
    Label189: TLabel;
    DBEdit82: TDBEdit;
    tbosAtendimento: TBooleanField;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    tbauxoficioTerceiro: TBooleanField;
    AcroPDF1: TAcroPDF;
    BtAnexaPDF: TButton;
    OpenDialog1: TOpenDialog;
    BtGrasvaPDF: TButton;
    BtMaxPDF: TButton;
    BtAPI: TButton;
    tbcnaeControle: TAutoIncField;
    tbcnaeClasse: TStringField;
    tbcnaeEquipe: TStringField;
    tbrdpfControle: TAutoIncField;
    tbrdpfOS: TIntegerField;
    tbrdpfTIPOOS: TStringField;
    tbrdpfMotivo: TStringField;
    tbrdpfData_os: TDateField;
    tbrdpfPrazo: TDateField;
    tbrdpfAcao: TStringField;
    tbrdpfDoc: TStringField;
    tbrdpfNdoc: TStringField;
    tbrdpfMeio: TStringField;
    tbrdpfMod: TStringField;
    tbrdpfCnae: TStringField;
    tbrdpfComplex: TStringField;
    tbrdpfArea: TStringField;
    tbrdpfDupla: TBooleanField;
    tbrdpfPonto: TFloatField;
    tbrdpfNegativo: TFloatField;
    tbrdpfComply: TStringField;
    tbrdpfUser_homoloda: TStringField;
    tbrdpfData_homologa: TDateField;
    tbrdpfUsuario: TStringField;
    tbrdpfData_altera: TDateField;
    tbrdpfData_fecha: TDateField;
    tbrdpfUsr_fecha: TStringField;
    GroupBox13: TGroupBox;
    GroupBox8: TGroupBox;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    DBENomeResp1: TDBEdit;
    DBCCons1: TDBComboBox;
    DBERegResp1: TDBEdit;
    Label21: TLabel;
    DBCequipe: TDBComboBox;
    BtSinc: TBitBtn;
    procedure btnovoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btgravaClick(Sender: TObject);
    procedure btcancelClick(Sender: TObject);
    procedure btprnClick(Sender: TObject);
    procedure btfechaClick(Sender: TObject);
    procedure bthelpClick(Sender: TObject);
    procedure btalteraClick(Sender: TObject);
    procedure DBEcodigoEnter(Sender: TObject);
    procedure DBEcodigoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btlocproClick(Sender: TObject);
    procedure DBClocalChange(Sender: TObject);
    procedure dscontribStateChange(Sender: TObject);
    procedure btnovvisitaClick(Sender: TObject);
    procedure btdeletaClick(Sender: TObject);
    procedure btcanvisitaClick(Sender: TObject);
    procedure btgravisitaClick(Sender: TObject);
    procedure btaltvisitaClick(Sender: TObject);
    procedure btdelvisitaClick(Sender: TObject);
    procedure dsvisitasStateChange(Sender: TObject);
    procedure btalvaraClick(Sender: TObject);
    procedure navalvaraClick(Sender: TObject; Button: TNavigateBtn);
    procedure btnovalvaraClick(Sender: TObject);
    procedure btaltalvaraClick(Sender: TObject);
    procedure btgravalvaraClick(Sender: TObject);
    procedure dsalvaraStateChange(Sender: TObject);
    procedure btcancalvaraClick(Sender: TObject);
    procedure btdelalvaraClick(Sender: TObject);
    procedure tbcontribCARACTERChange(Sender: TField);
    procedure BtdocClick(Sender: TObject);
    procedure tbcontribBeforeScroll(DataSet: TDataSet);
    procedure tbcontribAfterScroll(DataSet: TDataSet);
    procedure tbcontribINATIVIDADEChange(Sender: TField);
    procedure DBMObsestabeExit(Sender: TObject);
    procedure DBCacaoChange(Sender: TObject);
    procedure DBCtipoChange(Sender: TObject);
    procedure DBCFiscal1Change(Sender: TObject);
    procedure DBCFiscal2Change(Sender: TObject);
    procedure DBCFiscal3Change(Sender: TObject);
    procedure DBCExercicioChange(Sender: TObject);
    procedure DBSetorChange(Sender: TObject);
    procedure DBCCons1Change(Sender: TObject);
    procedure DBCCons2Change(Sender: TObject);
    procedure DBCUF1Change(Sender: TObject);
    procedure DBCUF2Change(Sender: TObject);
    procedure DBCNaturezaChange(Sender: TObject);
    procedure DBLareaExit(Sender: TObject);
    procedure DBLGrupoEnter(Sender: TObject);
    procedure DBLAtivEnter(Sender: TObject);
    procedure BtativClick(Sender: TObject);
    procedure BtliberaClick(Sender: TObject);
    procedure DBEcgcExit(Sender: TObject);
    procedure DBECPFExit(Sender: TObject);
    procedure DBCPessoaExit(Sender: TObject);
    procedure DBCPessoaChange(Sender: TObject);
    procedure TimeadmimTimer(Sender: TObject);
    procedure anvisaClick(Sender: TObject);
    procedure DBECPFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TabCaracShow(Sender: TObject);
    procedure DBCHoraExit(Sender: TObject);
    procedure DBEHfimExit(Sender: TObject);
    procedure DBEDataVExit(Sender: TObject);
    procedure DBCtipoExit(Sender: TObject);
    procedure DBEcgcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtemitenovoClick(Sender: TObject);
    procedure BtreemiteClick(Sender: TObject);
    procedure btnovocaeClick(Sender: TObject);
    procedure btaltcaeClick(Sender: TObject);
    procedure btcancelcaeClick(Sender: TObject);
    procedure btdelecaeClick(Sender: TObject);
    procedure btgravacaeClick(Sender: TObject);
    procedure dsrtStateChange(Sender: TObject);
    procedure bitdocClick(Sender: TObject);
    procedure dsalvlibStateChange(Sender: TObject);
    procedure btnovautorClick(Sender: TObject);
    procedure btgravautorClick(Sender: TObject);
    procedure btcancautorClick(Sender: TObject);
    procedure btdelautorClick(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure navveiculoClick(Sender: TObject; Button: TNavigateBtn);
    procedure dsveiculoStateChange(Sender: TObject);
    procedure btnovoveiculoClick(Sender: TObject);
    procedure BtalteraveiculoClick(Sender: TObject);
    procedure btgravaveiculoClick(Sender: TObject);
    procedure btcancelaveiculoClick(Sender: TObject);
    procedure btdeletaveiculoClick(Sender: TObject);
    procedure btemiteClick(Sender: TObject);
    procedure btimprimeClick(Sender: TObject);
    procedure DBEReqveicExit(Sender: TObject);
    procedure DBCAutorizaExit(Sender: TObject);
    procedure DBCProvisorioExit(Sender: TObject);
    procedure BtliberavClick(Sender: TObject);
    procedure BtprovisorioClick(Sender: TObject);
    procedure BteventoClick(Sender: TObject);
    procedure DBEValExit(Sender: TObject);
    procedure btprndocClick(Sender: TObject);
    procedure DBCExercicioExit(Sender: TObject);
    procedure DBEDtreqExit(Sender: TObject);
    procedure DBEDtliberaExit(Sender: TObject);
    procedure btanexaClick(Sender: TObject);
    procedure BtgravaanexoClick(Sender: TObject);
    procedure BtexibeanexoClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure dsplantaStateChange(Sender: TObject);
    procedure BtregistraClick(Sender: TObject);
    procedure BtandamentoClick(Sender: TObject);
    procedure BrgravaprotoClick(Sender: TObject);
    procedure BtcancelaprotoClick(Sender: TObject);
    procedure BtdeletaprotoClick(Sender: TObject);
    procedure dstramitacaoStateChange(Sender: TObject);
    procedure BtRemessaClick(Sender: TObject);
    procedure DBCdestinoChange(Sender: TObject);
    procedure DBCdescricChange(Sender: TObject);
    procedure DBCcomplementoChange(Sender: TObject);
    procedure DBCassuntoChange(Sender: TObject);
    procedure BtdespachoClick(Sender: TObject);
    procedure DBCJuntadaChange(Sender: TObject);
    procedure BitPtJuntadaClick(Sender: TObject);
    procedure DBCLiberaChange(Sender: TObject);
    procedure DBCAutoridadeChange(Sender: TObject);
    procedure DbCordemExit(Sender: TObject);
    procedure DbCordemChange(Sender: TObject);
    procedure BtprotocoloClick(Sender: TObject);
    procedure BtAnexaPDFClick(Sender: TObject);
    procedure BtGrasvaPDFClick(Sender: TObject);
    procedure SalvarPDFComo(const Origem, Destino: string);
    procedure BtMaxPDFClick(Sender: TObject);
    procedure DBNavanexosClick(Sender: TObject; Button: TNavigateBtn);
    procedure BtAPIClick(Sender: TObject);
    procedure BtAPISemClick(Sender: TObject);
    procedure BtAPICSVClick(Sender: TObject);
    procedure BtSincClick(Sender: TObject);

  private
    lugar:integer;
{    filtro:integer;}
    painel:string;
    complex:string;
    datavisita:tdatetime;
     juntada:boolean;


    FSimGrid: TStringGrid;
    FSimStatus: TLabel;
    FSimDivergente: Boolean;

    procedure InicializarPainelSIM;
    procedure LimparPainelSIM;

    function AliasPath(const AliasName: string): string;
    function ApenasNumeros(const S: string): string;
    function CampoCSV(const Linha: string; Indice: Integer): string;

    function CaminhoSIMBruto: string;
    function CaminhoSIMTabela: string;
    function PrecisaGerarSIMTabela: Boolean;
    function GerarSIMTabela: Boolean;
    procedure ValidarCNAESIM_Tabela;

    function ExisteDivergenciaCNAE: Boolean;
    function MascararDocumento(const Doc: string): string;

    procedure AtualizarStatusSincronizacaoSIM;
    procedure ValidarCNAESIM;


    procedure CarregarPDFAtual;

  public

  end;

var
  frmestabe: Tfrmestabe;

implementation

uses locpro, sobre, alvara, login, CPFeCGC, principal, alvnovo, alveicular,
  relvisita, r_doc, relprotocolo, relremessa, reljuntada ;

{$R *.dfm}

procedure Tfrmestabe.btnovoClick(Sender: TObject);
   var
        cont:integer;
   begin
     if( frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'DEN') or (frmlogin.c_grp = 'FIS') then
     begin
        frmlocpro.inclu := 1;
        tbcontrib.last;
        tbcontrib.insert;
//        tbrt.insert;
//        tbcaracter.insert;
        tbsequencia.edit;
{        tbativi.filtered := true;
        tbgrupo.filtered := true;}
        cont:=tbsequencianumero.value+1;
        tbcontribcodigo.value:=cont;
        tbsequencianumero.value:=cont;
        tbsequencia.Post;
        tbcontribdt_cadastro.value := date;
{       tbprocessoano.value:=strtoint(formatdatetime('yyyy',date));}
{       tbcontribdata.value:=date;}
{       tbvisitas.insert;
        tbhistorico.insert;
        tbvisitasdt_visita.value:=date;
        tbvisitashora.value:=time;}
        PageControl1.ActivePage:=Tabident;
        DBERAZAO.setfocus;
   end
   else showmessage('Funcao permitida somente para pessoal administrativo');

   end;

procedure Tfrmestabe.FormActivate(Sender: TObject);
begin

complex:='';
juntada := false;
Stuser.caption:=copy(frmlogin.c_user,1,15);
Stdata.Caption:=datetostr(date);
Sthora.Caption:=copy(timetostr(time),1,5);
{filtro := 0;}
{tbcontrib.Filter := 'inatividade <> true';}

//if painel = ' ' then
//   begin
        PageControl1.ActivePage:=Tabident;
//   end;

if frmlogin.c_user = 'CLAUDIO NASCIMENTO SILVA' then
begin
    btapi.Enabled := true;
end;
// if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'CAD') or (frmlogin.c_per = 'CAD') then painelcae.visible := true else painelcae.visible := false;    

if painel = 'alvara' then
    begin
        PageControl1.ActivePage:=Tabalvara;
        btemitenovo.setfocus;
        painel := ' ';
    end;

if painel = 'veiculo' then
     begin
        PageControl1.ActivePage:=Tabveiculo;
        btimprime.setfocus;
        painel := ' ';
     end;

if painel = 'documento' then
     begin
        PageControl1.ActivePage:=Tabhist;
        DBNavHist.setfocus;
        painel := ' ';
     end;
  if painel = 'anexo' then
     begin
        PageControl1.ActivePage:=tabanexo;
        DBNavanexos.setfocus;
        painel := ' ';
     end;

  if painel = 'protocolo' then
     begin
        PageControl1.ActivePage:=TabPlanta;
        DBNProto.setfocus;
        painel := ' ';
     end;

 if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'FIS') then else btregistra.Enabled      := false;


    if frmlogin.c_grp = 'ADM' then btprovisorio.enabled  :=true;
    if frmlogin.c_grp = 'ADM' then btevento.enabled      :=true;
    if frmlogin.c_grp = 'ADM' then dbeval.readonly       :=false;
    if frmlogin.c_grp = 'ADM' then DBEDtlibera.ReadOnly  :=false;
//    if frmlogin.c_grp = 'ADM' then DBCExercicio.ReadOnly :=false;

if (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'CON') then btliberav.Enabled:=false;
tbalvrt.Open;
tbarea.open;
tbgrupo.open;
tbativi.Open;
tbsinavisa.open;
tbsequencia.open;
tbcnae.open;
tbimagem.open;
tbcontrib.open;
tbreq.Open;
tboficio.open;
tbdenuncia.Open;
tbauxcontrib.open;
tbauxoficio.Open;
tbrmpf.open;
tbrdpf.open;
tbos.open;
{tbgrupo.Filter := 'area = ' + tbareacod.AsString;
tbativi.Filter := 'grupo = ' + tbgrupocod.AsString;}
{if length(inttostr(strtoint(tbcontribcgc.value))) = 18 then tbcontribcgc.EditMask := '00\.000\.000\/0000\-00;1;_' else tbcontribcgc.EditMask := '000\.000\.000\-00;1;_';}
{if lugar = 0 then tbcontrib.last else tbcontrib.findkey([lugar]);}
tbvisitas.open;
//tbauxvisita.Open;
tbauxlib.Open;
//tbcaracter.open;
tbhistorico.open;
tbrt.Open;
tbcifa.Open;
tbcategoria.Open;
tbauxrt.open;
tbbairro.Open;
tbalvara.open;
tbalvlib.open;
tbveiculo.Open;
tbPlanta.open;
tbauxplanta.Open;
tbtramitacao.Open;
    if frmlocpro.loc_pro = 1 then
        begin
          case frmlocpro.sele of
                0: tbcontrib.findkey([frmlocpro.tbcpfCONTROLE.value]);
                1: tbcontrib.findkey([frmlocpro.tbcgcCONTROLE.value]);
                2: tbcontrib.findkey([frmlocpro.tbccmCONTROLE.value]);
                3: tbcontrib.findkey([frmlocpro.tbinsCONTROLE.value]);
                4: tbcontrib.findkey([frmlocpro.tbrazCONTROLE.value]);
                5: tbcontrib.findkey([frmlocpro.tbfanCONTROLE.value]);
          end;
    end;

    if frmlocpro.inclu = 1 then btnovoClick(sender);

 //   ValidarCNAESIM;

{btlocpro.setfocus;}
{if tbcontribcaracter.value = true then TabCarac.TabVisible := true else TabCarac.TabVisible := false;}
end;

procedure Tfrmestabe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
lugar := 0;
frmlocpro.inclu:=0;
tbos.close;
tbalvrt.Close;
tbsinavisa.close;
tbhistorico.close;
tbvisitas.close;
//tbauxvisita.close;
tbveiculo.close;
tbalvlib.Close;
tbalvara.Close;
tbrt.close;
tbcifa.close;
tbcategoria.close;
tbauxrt.Close;
tbauxoficio.Close;
tbreq.close;
tboficio.close;
tbdenuncia.Close;
//tbcaracter.Close;
tbcnae.Close;
// tbcae.close;
tbrmpf.close;
tbrdpf.open;
tbcontrib.Close;
tbauxlib.Close;
tbauxcontrib.Close;
tbauxplanta.Close;
tbplanta.Close;
tbtramitacao.Close;
tbativi.close;
tbgrupo.Close;
tbarea.Close;
tbsequencia.Close;
tbbairro.close;
end;

procedure Tfrmestabe.btgravaClick(Sender: TObject);
begin

{    if (tbsinavisacomplexidade.value <> complex) and (complex <> '' ) and (frmlogin.c_grp <> 'ADM') then
         begin
            showmessage('Alteracao da Complexidade do Contribuinte nao autorizada para o usuario.');
            DBLGrupo.setfocus;
            exit;
      end;}

    if (tbcontribcgc.IsNull = false) and (tbcontribpessoa.value='CNPJ') then
    begin
       tbauxcontrib.indexname := 'PorCGC';
       tbauxcontrib.Findkey([tbcontribcgc.value]);
       if (tbauxcontribcgc.value = tbcontribcgc.value) and (tbauxcontribcodigo.value <> tbcontribcodigo.value) then
       begin
         if (frmlogin.c_grp <> 'ADM') and (tbcontribcgc.value <> '06.086.006/0001-00') and (tbcontribcgc.value <> '01.067.479/0001-46') and (tbcontribcgc.value <> '06.169.881/0001-55') then
         begin
          messagedlg('CNPJ: '+tbauxcontribcgc.asstring+' ja cadastrado! Contribuinte: '+tbauxcontribcodigo.asstring+'-'+tbauxcontribrazao.value+' - Usuario nao autorizado',mtwarning,[mbok],0);
//            if messagedlg('CNPJ: '+tbauxcontribcgc.asstring+' ja cadastrado! Contribuinte: '+tbauxcontribcodigo.asstring+'-'+tbauxcontribrazao.value+#13+'Confirma a multiplicacao do cadastro'+'?',mtconfirmation,[mbyes,mbno],0)=mryes then tbcontribrazao.value:=tbauxcontribrazao.value else exit;
           exit;
          end
          else if messagedlg('CNPJ: '+tbauxcontribcgc.asstring+' ja cadastrado! Contribuinte: '+tbauxcontribcodigo.asstring+'-'+tbauxcontribrazao.value+#13+'Confirma a multiplicacao do cadastro'+'?',mtconfirmation,[mbyes,mbno],0)=mryes then tbcontribrazao.value:=tbauxcontribrazao.value else exit;
       end;
    end;

    if (tbcontribcpf.IsNull = false) and (tbcontribpessoa.value='CPF') then
    begin
       tbauxcontrib.indexname := 'PorCPF';
       tbauxcontrib.Findkey([tbcontribcpf.value]);
       if (tbauxcontribcpf.value = tbcontribcpf.value) and (tbauxcontribcodigo.value <> tbcontribcodigo.value) then
       begin
         if (frmlogin.c_grp <> 'ADM') and (frmlogin.c_grp <> 'CAD') and (frmlogin.c_grp <> 'FIS') then
         begin
          messagedlg('CPF: '+tbauxcontribcpf.asstring+' ja cadastrado! Contribuinte: '+tbauxcontribcodigo.asstring+'-'+tbauxcontribrazao.value+' - Perfil nao autorizado',mtwarning,[mbok],0);
          exit;
         end
         else if messagedlg('CPF: '+tbauxcontribcpf.asstring+' ja cadastrado! Contribuinte: '+tbauxcontribcodigo.asstring+'-'+tbauxcontribrazao.value+#13+'Confirma a multiplicacao do cadastro'+'?',mtconfirmation,[mbyes,mbno],0)=mryes then tbcontribrazao.value:=tbauxcontribrazao.value else exit;
       end;
    end;


        if tbcontribcodigo.isnull then
        begin
           tbsequencianumero.value := tbsequencianumero.value + 1;
           tbcontribcodigo.value := tbsequencianumero.value;
        end;

        tbcontribrazao.value := removeacento(tbcontribrazao.value);
        tbcontribfantasia.value := removeacento(tbcontribfantasia.value);

        if tbcontribRAZAO.IsNull then
        begin
            showmessage('Caro Usuario, favor informar a Razao Social');
            exit;
        end;


        if tbcontribpessoa.isnull then
        begin
            showmessage('Caro Usuario, favor informar o tipo de Cadastro');
            exit;
        end;

        if tbcontribpessoa.value = 'CNPJ' then
            begin
                if tbcontribCGC.IsNull = true then
                begin
                    showmessage('Caro Usuario, favor informar o CNPJ');
                    exit;
                end;
                tbcontribcpf.value := '';
                If NOT CGC(tbcontribcgc.value) then
                Begin
                    messagebox(Application.Handle, Pchar ('O CNPJ ' +tbcontribcgc.value+ ' a invalido!'), 'Atencao', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                    exit;
                end;

          end

            else
            begin
                if tbcontribCPF.IsNull = true then
                begin
                    showmessage('Caro Usuario, favor informar o CPF');
                    exit;
                end;
                tbcontribcgc.value := '';
                  If NOT CPF(tbcontribCPF.value) then
                  Begin
                    messagebox(Application.Handle, Pchar ('O CPF ' +tbcontribcpf.value+ ' a invalido!'), 'Atencao', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                    exit;
                  end;
            end;

        if tbcontriblogradouro.IsNull then
        begin
            showmessage('Caro Usuario, favor informar o Logradouro');
            exit;
        end;


        if tbcontribCOMPLEMENT.IsNull then
        begin
            showmessage('Caro Usuario, favor informar o Endereco Completo');
            exit;
        end;

        if tbcontribhorario.value = '' then
        begin
            showmessage('Caro Usuario, favor informar o Periodo de Funcionamento');
            exit;
        end;


        if tbcontribcdbai.value = 0 then
        begin
            showmessage('Caro Usuario, favor Selecionar um Bairro');
            exit;
        end;

{        if tbcontribhorario.IsNull then
        begin
            showmessage('Caro Usuario, favor informar o horario de funcionamento');
            exit;
        end;}


{
        if (tbcontribarea.value <> tbgrupoarea.value) and (tbcontribinatividade.Value <> true) then
          begin
           showmessage('Caro Usuario, Grupo Economico selecionado divergente da area de Fiscalizacao');
           exit;
        end;
        if (tbcontribgrupo.value <> tbativigrupo.value) and (tbcontribinatividade.Value <> true) then
          begin
           showmessage('Caro Usuario, Atividade Economica selecionada divergente do Grupo Economico');
           exit;
        end;

        if (tbcontribarea.value = 0) and (tbcontribinatividade.Value <> true) then
        begin
            showmessage('Caro Usuario, favor Selecionar a area de Fiscalizacao relacionada');
            exit;
        end;

        if (tbcontribgrupo.value = 0) and (tbcontribinatividade.Value <> true) then
        begin
            showmessage('Caro Usuario, favor Selecionar o Grupo Economico relacionado');
            exit;
        end;}

{        if tbcontribatividade.value = 0 then
        begin
            showmessage('Caro Usuario, favor Selecionar a Atividade Economica relacionada');
            exit;
        end;    }  

        if tbcontribdt_cadastro.isnull then
        begin
           tbcontribdt_cadastro.value := date;
        end;

{  vasio:= false;
  tbrt.First;
  while not tbrt.Eof do
  begin
      if tbrtsubclasse.isnull then vasio:= true;
      if vasio = true then
      begin
          showmessage('Caro Usuario, favor completar a ficha CAE para todas as atividades cadastradas');
          exit;
      end;
      tbrt.Next;
  end;

        if (tbrt.Eof ) and (tbrt.Bof) then
        begin
            showmessage('Caro Usuario, favor preencher a ficha CAE');
            exit;
        end;}

//                if  (tbrt.state <> dsbrowse) and not (tbrt.Eof) then tbrt.post;
//                if  (tbcaracter.state <> dsbrowse) and not (tbcaracter.eof) then tbcaracter.Post;
{        end;
        if  (tbcontribcaracter.value = false) then
        begin
               if not (tbrt.eof) and not (tbcaracter.eof) then
                begin
                     showmessage('Atencao! Para salvar as Alteracoes nas "ESPECIFICACOES", marque a opcao "RT/CARACTERIZACAO".');
                     exit;
                end;
        end;
if (tbrt.eof) and (tbcaracter.eof) then tbcontribcaracter.value :=false else tbcontribcaracter.value :=true;}
if tbcontribinatividade.value = true then TextoATV.Visible:= TRUE else TextoATV.Visible:= FALSE;
if tbcontribhorario.Value = 'NOTURNO' then Texto_horario2.Visible := true else Texto_horario2.Visible := false;
     if  tbsequencia.state <> dsbrowse then tbsequencia.post;
     tbcontribuser.value := frmlogin.c_user;
     tbcontribdt_alter.value := date;
     tbcontribh_alter.value := time;
     tbcontrib.Post;
     complex:='';
     frmlocpro.inclu := 0;
{      tbarea.cancel;
      tbgrupo.cancel;
      tbativi.Cancel;}
//tbativi.filtered := false;
{tbgrupo.filtered := false;
tbgrupo.FindKey([tbcontribgrupo.value]);
tbgrupo.IndexFieldNames := 'COD';
tbgrupo.FindKey([tbcontribgrupo.value]);
tbgrupo.IndexFieldNames := 'DESCRICAO';
tbativi.IndexFieldNames := 'NUMERO';
tbativi.FindKey([tbcontribatividade.value]);
tbativi.IndexFieldNames := 'NOME';
//tbsinavisa.findkey([tbativisinavisa.value]);
tbativi.refresh;  }
//tbsinavisa.refresh;

{     dblocpro.setfocus;}
end;

procedure Tfrmestabe.btcancelClick(Sender: TObject);
begin
      complex:='';
      frmlocpro.inclu := 0;
//      tbgrupo.filtered := false;
//      tbativi.Filtered := false;
      tbhistorico.Cancel;
      tbvisitas.cancel;
//      tbrt.cancel;
//      tbcaracter.cancel;
      tbcontrib.cancel;
      {tbsequencia.Cancel;}
if tbcontribinatividade.value = true then TextoATV.Visible:= TRUE else TextoATV.Visible:= FALSE;
if tbcontribhorario.Value = 'NOTURNO' then Texto_horario2.Visible := true else Texto_horario2.Visible := false;
end;

procedure Tfrmestabe.btprnClick(Sender: TObject);
begin
  messagedlg('Modulo em desenvolvimento',mtwarning,[mbok],0);
{    btlocpro.setfocus;}
end;

procedure Tfrmestabe.btfechaClick(Sender: TObject);
begin
tbtramitacao.close;
tbplanta.Close;
tbsinavisa.close;
tbbairro.close;
tbativi.close;
tbgrupo.close;
tbarea.close;
tbrt.close;
tbimagem.close;
tbhistorico.close;
tbalvara.close;
tbvisitas.Close;
tbreq.Close;
tbcontrib.Close;
close;
frmlocpro.Close;
end;

procedure Tfrmestabe.bthelpClick(Sender: TObject);
begin
aboutbox.showmodal;
{    btlocpro.setfocus;}
end;

procedure Tfrmestabe.btalteraClick(Sender: TObject);
begin
  if (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'DEN') then
  begin
        complex:=tbsinavisacomplexidade.value;
        tbcontrib.Edit;
//        tbrt.Edit;
//        tbcaracter.Edit;
{        tbgrupo.filtered := true;
        tbgrupo.IndexFieldNames := 'cod';
        tbgrupo.FindKey([tbcontribgrupo.value]);
        tbgrupo.IndexFieldNames := 'descricao';
        tbativi.filtered := true;
        tbativi.IndexFieldNames := 'numero';
        tbativi.FindKey([tbcontribatividade.value]);
        tbativi.IndexFieldNames := 'nome';}
        if PageControl1.ActivePage=TabCarac then DBENomeResp1.setfocus else
        begin
              PageControl1.ActivePage:=TabIdent;
              DBErazao.setfocus;
        end;
    end
    else showmessage('Funcao permitida somente para pessoal administrativo');

end;

procedure Tfrmestabe.DBEcodigoEnter(Sender: TObject);
begin
statusbar1.panels[0].text:='Pressione [F2] para pesquisar Estabelecimento'
end;

procedure Tfrmestabe.DBEcodigoExit(Sender: TObject);
begin
statusbar1.panels[0].text:=''
end;

procedure Tfrmestabe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

  begin
case key of
        vk_escape:
        begin
          if tbveiculo.state<>dsbrowse then btcancelaveiculoClick(Sender) else
             if tbvisitas.state<>dsbrowse then btcanvisitaClick(Sender) else
                if tbalvara.state<>dsbrowse then btcancalvaraClick(Sender) else
                        begin
                                if tbcontrib.state<>dsbrowse then
                                  begin
                                   btcancelClick(Sender);
                                   end
                                else
                                  btfechaClick(Sender);
                        end;
        end;

        vk_F6:
        begin
           if tbveiculo.state<>dsbrowse then btgravaveiculoClick(sender) else
              if tbvisitas.state<>dsbrowse then btgravisitaClick(Sender) else
                if tbalvara.state<>dsbrowse then btgravalvaraClick(Sender) else
                    begin
                        if tbcontrib.state<>dsbrowse then
                              btgravaClick(Sender)
                        else
                              showmessage('F6 nao suportada em modo consulta');
                    end;

        end;

        vk_F3:
        begin
            if (tbvisitas.state=dsbrowse) and (tbalvara.state=dsbrowse) and (tbcontrib.state=dsbrowse) and (tbveiculo.state=dsbrowse) then
                      btnovoClick(Sender)
                  else
                      showmessage('F3 nao suportada em modo edicao');
        end;
        vk_F2:
        begin
             if (tbvisitas.state=dsbrowse) and (tbalvara.state=dsbrowse) and (tbcontrib.state=dsbrowse) and (tbveiculo.state=dsbrowse) then
                      btlocproClick(Sender)
                else
                      showmessage('F2 nao suportada em modo edicao');
        end;
        vk_F1:
        begin
         if (tbvisitas.state=dsbrowse) and (tbalvara.state=dsbrowse) and (tbcontrib.state=dsbrowse) and (tbveiculo.state=dsbrowse) then
                      bthelpClick(Sender)
                else
                      showmessage('F1 nao suportada em modo edicao');
        end;
        vk_F4:
        begin
             if (tbvisitas.state=dsbrowse) and (tbalvara.state=dsbrowse) and (tbcontrib.state=dsbrowse) and (tbveiculo.state=dsbrowse) then
                      btalteraClick(Sender)
                else
                      showmessage('F4 nao suportada em modo edicao');
        end;
        vk_F5:
        begin
        if (tbvisitas.state=dsbrowse) and (tbalvara.state=dsbrowse) and (tbcontrib.state=dsbrowse) and (tbveiculo.state=dsbrowse) then
                    PageControl1.ActivePage := TabAlvara
                else
                      showmessage('F5 nao suportada em modo edicao');
        end;

end;

end;


  procedure Tfrmestabe.FormKeyPress(Sender: TObject; var Key: Char);
begin
{        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;}
end;

procedure Tfrmestabe.btlocproClick(Sender: TObject);
begin
{ messagedlg('Modulo em desenvolvimento',mtwarning,[mbok],0);
    navegador.setfocus;}
    close;
{    if frmlocpro.loc_pro = 1 then
        begin
          case frmlocpro.sele of
                0: tbcontrib.findkey([frmlocpro.tbcpfCONTROLE.value]);
                1: tbcontrib.findkey([frmlocpro.tbcgcCONTROLE.value]);
                2: tbcontrib.findkey([frmlocpro.tbinsCONTROLE.value]);
                3: tbcontrib.findkey([frmlocpro.tbrazCONTROLE.value]);
                4: tbcontrib.findkey([frmlocpro.tbfanCONTROLE.value]);
          end;
    end;}
end;

procedure Tfrmestabe.DBClocalChange(Sender: TObject);
begin
{                perform(Wm_nextdlgctl,0,0);}
end;

procedure Tfrmestabe.dscontribStateChange(Sender: TObject);
begin
if (tbcontrib.state=dsbrowse) and  (tbvisitas.state=dsbrowse) and (tbalvara.state=dsbrowse) and (tbveiculo.state=dsbrowse) and (tbplanta.state=dsbrowse) then statusbar1.panels[0].text:=' [F1] Ajuda   [F2] Pesquisa   [F3] Inclusoo   [F4] Alteracao   [F5] Alvara' else statusbar1.panels[0].text:=' [F6] Grava   [ESC] Cancela';
btnovo.enabled          := tbcontrib.state =  dsbrowse;
btaltera.enabled        := tbcontrib.state =  dsbrowse;
painelvisita.enabled    := tbcontrib.state =  dsbrowse;
PainelProtocolo.enabled := tbcontrib.state =  dsbrowse;

//painelcae.Enabled    := tbcontrib.state =  dsbrowse;
DBNavHist.enabled    := tbcontrib.state =  dsbrowse;
Bitdoc.enabled       := tbcontrib.state =  dsbrowse;
if tbcontrib.state <> dsbrowse then painelvisita.Color := clmoneygreen;
if tbcontrib.state = dsbrowse  then painelvisita.Color := clbtnFace;
if tbcontribTAXA.value = true  then
begin
//    DBTufma.Visible:=false;
{    DBTtaxa.Visible:=false;}
end
else
begin
//    DBTufma.Visible:=true;
{    DBTtaxa.Visible:=true;}
end;
btlocpro.enabled        := tbcontrib.state =  dsbrowse;
btgrava.enabled         := tbcontrib.state <> dsbrowse;
btcancel.enabled        := tbcontrib.state <> dsbrowse;
btdeleta.enabled        := tbcontrib.state =  dsbrowse;
btprn.enabled           := tbcontrib.state =  dsbrowse;
btemite.Enabled         := tbcontrib.state =  dsbrowse;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') then btliberav.Enabled := tbcontrib.state=dsbrowse;
btreemite.Enabled       := tbcontrib.state =  dsbrowse;
btemitenovo.enabled     := tbcontrib.state =  dsbrowse;
btimprime.Enabled       := tbcontrib.state =  dsbrowse;
painelalvara.enabled    := tbcontrib.state =  dsbrowse;
painelveiculo.enabled   := tbcontrib.state =  dsbrowse;
painelautoriza.enabled  := tbcontrib.state =  dsbrowse;
if tbcontrib.state <> dsbrowse then painelalvara.Color := clmoneygreen;
if tbcontrib.state <> dsbrowse then painelveiculo.color := clmoneygreen;
if tbcontrib.state <> dsbrowse then painelautoriza.color := clmoneygreen;
if tbcontrib.state = dsbrowse  then painelalvara.Color := clBtnFace;
if tbcontrib.state = dsbrowse  then painelveiculo.color := clBtnFace;
if tbcontrib.state = dsbrowse  then painelautoriza.color := clBtnFace;
btfecha.enabled      := tbcontrib.state =  dsbrowse;
bthelp.enabled       := tbcontrib.state =  dsbrowse;
anvisa.enabled       := tbcontrib.state =  dsbrowse;
{navegador.enabled    := tbcontrib.state =  dsbrowse;}



end;


procedure Tfrmestabe.btnovvisitaClick(Sender: TObject);
var
        seqh:integer;
        vasio:boolean;
begin
  vasio:= false;
  tbrt.Refresh;
  tbrt.First;
  while not tbrt.Eof do
  begin
      if tbrtsubclasse.isnull then vasio:= true;
      if vasio = true then
      begin
          showmessage('Caro Usuario, favor completar a ficha CAE para todas as atividades cadastradas');
          exit;
      end;
      tbrt.Next;
  end;
        if (tbrt.Eof ) and (tbrt.Bof) then
        begin
            showmessage('Caro Usuario, favor preencher a ficha CAE');
            exit;
        end;

//**********************************
       if tbcontribRAZAO.IsNull then
        begin
            showmessage('Caro Usuario, favor informar a Razao Social');
            exit;
        end;


        if tbcontriblogradouro.IsNull then
        begin
            showmessage('Caro Usuario, favor informar o Logradouro');
            exit;
        end;

        if tbcontribCOMPLEMENT.IsNull then
        begin
            showmessage('Caro Usuario, favor informar o Endereco Completo');
            exit;
        end;

        if tbcontribcdbai.value = 0 then
        begin
            showmessage('Caro Usuario, favor Selecionar um Bairro');
            exit;
        end;

{        if (tbcontribarea.value <> tbgrupoarea.value) and (tbcontribinatividade.Value <> true) then
          begin
           showmessage('Caro Usuario, Grupo Economico selecionado divergente da area de Fiscalizacao');
           exit;
        end;
        if (tbcontribgrupo.value <> tbativigrupo.value) and (tbcontribinatividade.Value <> true) then
          begin
           showmessage('Caro Usuario, Atividade Economica selecionada divergente do Grupo Economico');
           exit;
        end;

        if (tbcontribarea.value = 0) and (tbcontribinatividade.Value <> true) then
        begin
            showmessage('Caro Usuario, favor Selecionar a area de Fiscalizacao relacionada');
            exit;
        end;

        if (tbcontribgrupo.value = 0) and (tbcontribinatividade.Value <> true) then
        begin
            showmessage('Caro Usuario, favor Selecionar o Grupo Economico relacionado');
            exit;
        end;}

     {   if tbcontribatividade.value = 0 then
        begin
            showmessage('Caro Usuario, favor Selecionar a Atividade Economica relacionada');
            exit;
        end;     }

//**********************************

if (frmlogin.c_grp = 'FIS') or
   (frmlogin.c_grp = 'ADM') or
   (frmlogin.c_grp = 'CAD')
then
begin

        PainelTermo.visible := false;
        tbvisitas.last;
        dbgrid2.enabled:=false;
        datavisita:=date;
        tbvisitas.insert;
  //      tbhistorico.insert; 
        tbsequencia.edit;
        seqh:=tbsequenciadoc.value+1;
        tbvisitasndoc.value:=seqh;
        tbsequenciadoc.value:=seqh;
        tbsequencia.post;
        tbvisitasdt_visita.value:=date;
        if frmlogin.c_grp = 'FIS' then tbvisitasfiscal1.value:=frmlogin.c_user;
        tbvisitasatividade.value := tbrtsubclasse.value;
        tbvisitasus_inclu.Value  := frmlogin.c_user;
        tbvisitasdt_inclu.Value  := date;
        tbvisitasgr_inclu.Value  := frmlogin.c_grp;
        tbvisitasatividade.value := '         ';
        tbvisitaslibera.Value    := 'Sim';
        tbvisitasarea.Value      := '> 399';
//        tbvisitaslibera.Value := 'Nao Liberado';
        DbCordem.setfocus;
{        tbvisitas.last;
        seqh:=tbvisitasndoc.value+1;
        tbvisitas.insert;
        tbvisitasndoc.value:=seqh;
        tbhistorico.Insert;
        tbhistoricondoc.value:=seqh;}
end
else showmessage ('Perfil nao autorizado');

end;

procedure Tfrmestabe.btdeletaClick(Sender: TObject);
begin

     if messagedlg('Confirma a Exclusao do Contribuinte'+#13+tbcontribRAZAO.value+'?',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin
             if (frmlogin.c_grp = 'ADM') then

             begin
                     while not tbhistorico.Eof do tbhistorico.Delete;
                     while not tbvisitas.Eof   do tbvisitas.Delete;
                     while not tbrt.Eof        do tbrt.delete;
//                     if not tbcaracter.eof      then tbcaracter.delete;
                     tbcontrib.Delete;
             end
             else showmessage('Exclusao: Favor Encaminhar Para o Setor de Cadastro');
     end;
{     btlocpro.setfocus;}
end;

procedure Tfrmestabe.btcanvisitaClick(Sender: TObject);
begin

      tbhistorico.Cancel;
      dbgrid2.enabled:=true;
      tbvisitas.cancel;
{      tbsequencia.cancel;}
{      btlocpro.setfocus;}
end;

procedure Tfrmestabe.btgravisitaClick(Sender: TObject);
var
ret:integer;
retorno:boolean;
begin
retorno := false;
      perform(Wm_nextdlgctl,0,0);
        if tbvisitasACAO.isnull then
        begin
                showmessage('Caro Usuario, favor informar Acao Fiscal');
                exit;
        end
        else
        begin
                if  tbvisitasACAO.Value= 'ATENDIMENTO a DENUNCIA' then
                begin
                        if tbvisitasDenuncia.value = 0 then
                        begin
                                showmessage('Caro Usuario, favor informar Numero da Denuncia');
                                exit;
                        end;
                end;
        end;

        if tbvisitastipo.isnull then
        begin
            showmessage('Caro Usuario, favor informar qual Documento Emitido');
            exit;
        end;
        if tbvisitasdt_visita.isnull then
        begin
            showmessage('Caro Usuario, favor informar a data do Documento' );
            DBEDataV.setfocus;
            exit;
        end;
        if (tbvisitasatividade.IsNull) and (frmlogin.c_grp = 'FIS') then
        begin
            showmessage('Caro Usuario, favor informar a atividade inspecionada' );
            DBEDataV.setfocus;
            exit;
        end;
        

        if (tbvisitastipo.Value = 'TERMO DE INTIMACAO') or (tbvisitastipo.Value = 'TERMO DE NOTIFICACAO') or (tbvisitastipo.Value = 'CERTIDAO') then
        begin
            if (tbvisitaslibera.value <> 'Sim') and (tbvisitaslibera.value <> 'Nao') then
            begin
                showmessage('Caro Usuario, favor informar se a OS necessita retorno' );
                DBCLibera.setfocus;
                exit;
            end;
        end;

         if tbvisitasmodalidade.isnull then
        begin
            if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'JUR') then
            else
            begin
                showmessage('Caro Usuario, favor informar a origem da OS' );
                DBCOrdem.setfocus;
                exit;
            end;
        end;




       if (tbvisitasmodalidade.value <> 'REQUERIMENTO') and (tbvisitasmodalidade.value <> 'DENUNCIA') and (tbvisitasmodalidade.value <> 'DE OFICIO') and (tbvisitasmodalidade.value <> 'PROTOCOLO') then
       begin
           if (frmlogin.c_grp = 'ADM') or (frmlogin.c_per = 'JUR') then
           else
           begin
                showmessage('Caro Usuario, favor selecionar uma das opcoes na origem da OS' );
                DBCOrdem.setfocus;
                exit;
           end;
       end;

        if tbvisitasmodalidade.value = 'DE OFICIO' then
        begin
            tbvisitasos.Clear;
            tbvisitasdenuncia.clear;
            tbvisitasprotocolo.Clear;
        end;

        if tbvisitasmodalidade.value = 'REQUERIMENTO' then
        begin
            tbvisitasoficio.Clear;
            tbvisitasdenuncia.clear;
            tbvisitasprotocolo.Clear;
        end;

        if tbvisitasmodalidade.value = 'DENUNCIA' then
        begin
            tbvisitasoficio.Clear;
            tbvisitasos.clear;
            tbvisitasprotocolo.Clear;
        end;

        if tbvisitasmodalidade.value = 'PROTOCOLO' then
        begin
            tbvisitasoficio.Clear;
            tbvisitasos.clear;
            tbvisitasdenuncia.Clear;
        end;

        if (tbvisitasmodalidade.value = 'REQUERIMENTO') and (tbvisitasos.IsNull) then
        begin
        showmessage('Caro Usuario, favor informar o numero da OS de requerimento' );
                DBEOs.setfocus;
                exit;
        end;

        if (tbvisitasmodalidade.value = 'DENUNCIA') and (tbvisitasdenuncia.IsNull) then
        begin
                showmessage('Caro Usuario, favor informar o numero da denuncia' );
                DBEDen.setfocus;
                exit;
        end;
        if (tbvisitasmodalidade.value = 'PROTOCOLO') and (tbvisitasprotocolo.IsNull) then
        begin
                showmessage('Caro Usuario, favor informar o numero do Protocolo' );
                DBEProto.setfocus;
                exit;
        end;
        if (tbvisitasmodalidade.value = 'DE OFICIO') and (tbvisitasoficio.IsNull) then
        begin
                showmessage('Caro Usuario, favor informar o numero da OS De Oficio.' );
                DBEOf.setfocus;
                exit;
        end;


//        if tbcnaecomplexidade.Value = 'BAIXA' then tbvisitaslibera.Value := 'Liberado';

//===============================================================================================
 { cae:= false;
  tbauxrt.refresh;
  tbauxrt.First;
  while not tbauxrt.Eof do
  begin
      if (tbvisitasatividade.Value = tbauxrtsubclasse.value) then cae:=true;
      tbauxrt.Next;
  end;
  if cae = false then
  begin
      showmessage('Atividade Economica inexistente na ficha CAE do contribuinte!');
      exit;
  end;
   }
//===============================================================================================

    tbrmpf.IndexName:='PorData';
    if tbrmpf.FindKey([tbvisitasdt_visita.value])then
    while not tbrmpf.Eof
    do
    begin
        if (tbrmpfnome.value=tbvisitasfiscal1.value) or (tbrmpfnome.value=tbvisitasfiscal2.value) or (tbrmpfnome.value=tbvisitasfiscal3.value) then
           begin
               if (tbvisitasdt_visita.value=tbrmpfdata.value) then
                  begin
                     messagedlg('Relatorio de Producao Homologado: '+datetostr(tbrmpfdata.value)+' - '+tbrmpfnome.value+'.',mtwarning,[mbok],0);
                     exit;
                  end;
           end;
        tbrmpf.Next;
    end;


//===============================================================================================



   if (tbvisitasdt_visita.value <> datavisita) and (frmlogin.c_grp <> 'ADM') then
   begin
       if dayofweek(date) = 2 then
        begin
         if (daysbetween(datavisita,tbvisitasdt_visita.value) > 30) then
         begin
            showmessage('Impossovel alterar a inspecao de '+ datetostr(datavisita) +' para '+datetostr(tbvisitasdt_visita.value));
            DBEDataV.setfocus;
            exit;
         end;
       end
       else
       begin
         if (daysbetween(datavisita,tbvisitasdt_visita.value) > 30) then
         begin
            showmessage('Impossovel alterar a inspecao de '+ datetostr(datavisita) +' para '+datetostr(tbvisitasdt_visita.value));
            DBEDataV.setfocus;
            exit;
         end;
       end;
   end;
        if (tbvisitasnumero.isnull) and (tbvisitastipo.value <> 'CERTIDAO')  then
        begin
            showmessage('Caro Usuario, favor informar o Numero do Documento');
            exit;
        end;

        if (tbvisitasfiscal1.isnull) and (tbvisitasfiscal2.isnull) and (tbvisitasfiscal3.isnull) then
        begin
            showmessage('Caro Usuario, favor informar Pelo menos uma Autoridade Emitente');
            exit;
        end;

{        if not (tbvisitasfiscal3.IsNull) and not (tbvisitasfiscal2.isnull) and not (tbvisitasfiscal3.isnull) and not tbvisitasporte = 'GRANDE' then
        begin
            showmessage('Nao permitido 3 (tres) autoridades por inspecao!');
            exit;
        end;
 }
        if tbvisitastipo.value = 'ATO ADMINISTRATIVO DA GERENCIA' then
        begin
           if (frmlogin.c_grp <> 'CAD' ) and  (frmlogin.c_grp <> 'ADM' ) then
           begin
               showmessage('Documento exclusivo para grupo de trabalho Administrativo');
               exit;
           end;
        end;

       if (tbvisitastipo.value <> 'ATO ADMINISTRATIVO DA GERENCIA') and (frmlogin.c_grp = 'CAD' ) then
       begin
             if messagedlg('Atencao!!'+#13+tbvisitastipo.Value+' a documento fiscal. Confirma a inclusoo da peca emitida pelo fiscal '+tbvisitasfiscal1.Value+' em carater excepcional, objetivando a atualizacao cadastral ?',mtconfirmation,[mbyes,mbno],0)=mrno then exit;
       end;


//**************************
{if (tbvisitastipo.Value<>'RELATORIO TECNICO') and (tbvisitastipo.Value<>'CERTIDAO') and (tbvisitastipo.Value<>'CONTRA RAZAO') and (tbvisitastipo.Value<>'PRORROGACAO') and (tbvisitastipo.Value<>'REPLICA FISCAL') and (tbvisitastipo.Value<>'ATO ADMINISTRATIVO DA GERENCIA') then
begin

       if tbvisitash_fim.value < tbvisitash_visita.value  then
        begin
              showmessage('Final da Inspecao Anterior ao inicio');
              exit;
        end;

       if tbvisitash_fim.value = tbvisitash_visita.value  then
        begin
              showmessage('Final da Inspecao igual ao inicio');
              exit;
        end;

       if secondsbetween(tbvisitash_visita.value,0) < 25200 then
        begin
              showmessage('Inicio da Inspecao anterior ao inicio do expediente');
              exit;
        end;

      if secondsbetween(tbvisitash_visita.value,0) > 79200 then
        begin
              showmessage('Inicio da Inspecao posterior ao final do expediente');
              exit;
        end;

       if secondsbetween(tbvisitash_fim.value,0) > 79200 then
        begin
              showmessage('Final da Inspecao posterior ao final do expediente');
              exit;
        end;
}

 if (tbvisitastipo.value = 'AUTO DE IMPOSICAO DE PENALIDADE') or
    (tbvisitastipo.value = 'AUTO DE INFRACAO')                or
    (tbvisitastipo.value = 'TERMO DE INTIMACAO')              or
    (tbvisitastipo.value = 'TERMO DE NOTIFICACAO')
 then
 begin

{       if tbvisitash_visita.isnull  then
        begin
              showmessage('Favor informar hora do inicio da inspecao');
              exit;
        end;

         if tbvisitash_fim.isnull  then
        begin
              showmessage('Favor informar hora do final da inspecao');
              exit;
        end;
 end;
}
    if tbvisitaspz_retorno.isnull then
        begin
              showmessage('Favor informar o prazo do documento emitido');
              exit;
        end;

 {  if (tbvisitash_fim.value > time) and (tbvisitasdt_visita.value = date) then
   begin
      showmessage('Hora do fim da visita invalida!');
      exit;
   end;
}
{   if (tbvisitasporte.isnull) and (tbvisitasacao.value='INSPECAO SANITARIA') then
   begin
        showmessage('Favor informar o porte da inspecao');
        DBCporte.setfocus;
        exit;
   end;    }


   if tbvisitasdt_visita.value > date then
   begin
        showmessage('Data da Inspecao invalida!');
        DBEDataV.setfocus;
        exit;
   end;

   if dayofweek(date) = 2 then
   begin
//     if (daysbetween(date,tbvisitasdt_visita.value) > 9) and (frmlogin.c_grp = 'FIS') then
     if (daysbetween(date,tbvisitasdt_visita.value) > 30)  then
     begin
        showmessage('Data retroativa para inclusoo/alteracao de inspecoes!');
        DBEDataV.setfocus;
        exit;
     end;
   end
   else
   begin
//     if (daysbetween(date,tbvisitasdt_visita.value) > 7) and (frmlogin.c_grp <> 'FIS') then
    if (daysbetween(date,tbvisitasdt_visita.value) > 30) then
     begin
        showmessage('Data retroativa para inclusoo/alteracao de inspecoes!');
        DBEDataV.setfocus;
        exit;
     end;
   end;

end;

//**********************************************************

        if tbvisitasmeio.isnull then
        begin
                if (tbvisitastipo.Value = 'TERMO DE NOTIFICACAO')            or
                   (tbvisitastipo.Value = 'TERMO DE INTIMACAO')              or
                   (tbvisitastipo.Value = 'TERMO DE COLETA DE AMOSTRA')      or
                   (tbvisitastipo.Value = 'CERTIDAO')                        or
                   (tbvisitastipo.Value = 'AUTO DE INFRACAO')                or
                   (tbvisitastipo.Value = 'AUTO DE IMPOSICAO DE PENALIDADE') then
               begin
                    showmessage('Caro Usuario, obrigaterio informar meio de locomocao para a atividade informada' );
                    DBCMeio.SetFocus;
                    exit;
               end;
        end;

        if (tbvisitasmeio.value = 'Proprio') and (tbvisitastipo.Value <> 'TERMO DE NOTIFICACAO')            and
                                                 (tbvisitastipo.Value <> 'TERMO DE INTIMACAO')              and
                                                 (tbvisitastipo.Value <> 'TERMO DE COLETA DE AMOSTRA')      and
                                                 (tbvisitastipo.Value <> 'CERTIDAO')                        and
                                                 (tbvisitastipo.Value <> 'AUTO DE INFRACAO')                and
                                                 (tbvisitastipo.Value <> 'AUTO DE IMPOSICAO DE PENALIDADE') then
        begin
            showmessage('Caro Usuario, meio de locomocao incompatevel com a atividade informada' );
            DBCMeio.SetFocus;
            exit;
        end;

{
ATO ADMINISTRATIVO DA GERENCIA
CONFERENCIA DE BALANAO
MANIFESTACAO DO FISCAL ATUANTE
ORIENTACAO SANITARIA
ANALISE DE PAS
PRORROGACAO
RELATORIO TECNICO
RELATORIO HARMONIZADO
 }

//**********************************************************





 {      tbauxvisita.findkey([tbvisitasdt_visita.value]);
       while not tbauxvisita.Eof
       do
       begin
            if (tbauxvisitadt_visita.value = tbvisitasdt_visita.Value) and (tbauxvisitacodigo.value <> tbvisitascodigo.value)  then
            begin
 //*******************************************
             if not tbvisitasfiscal1.IsNull then
             begin
                if (tbvisitasfiscal1.value = tbauxvisitafiscal1.value)  or (tbvisitasfiscal1.value = tbauxvisitafiscal2.value) or (tbvisitasfiscal1.value = tbauxvisitafiscal3.value) then
                begin
                     if (tbvisitash_visita.value > tbauxvisitah_visita.value) and (tbvisitash_visita.value < tbauxvisitah_fim.value) then
                     begin
                        messagedlg('Informacoes inconsistentes com outra entrada da tabela de inspecoes. Autoridade: '+tbauxvisitafiscal1.value+', Inscricao: '+tbauxvisitacodigo.asstring+', Periodo: '+tbauxvisitah_visita.asstring+' as '+ tbauxvisitah_fim.asstring+', Documento: '+tbauxvisitatipo.value+' na '+tbauxvisitanumero.value,mtwarning,[mbok],0);
                        exit;
                     end;

                     if (tbvisitasndoc.value <> tbauxvisitandoc.value) and (tbvisitash_fim.value > tbauxvisitah_visita.value) and (tbvisitash_visita.value < tbauxvisitah_fim.value) then
                     begin
                        messagedlg('Informacoes inconsistentes com outra entrada da tabela de inspecoes. Autoridade: '+tbauxvisitafiscal1.value+', Inscricao: '+tbauxvisitacodigo.asstring+', Periodo: '+tbauxvisitah_visita.asstring+' as '+ tbauxvisitah_fim.asstring+', Documento: '+tbauxvisitatipo.value+' na '+tbauxvisitanumero.value,mtwarning,[mbok],0);
                        exit;
                     end;
                end;
             end;
//**********************************************
             if not tbvisitasfiscal2.isnull then
             begin
                if (tbvisitasfiscal2.value = tbauxvisitafiscal1.value)  or (tbvisitasfiscal2.value = tbauxvisitafiscal2.value) or (tbvisitasfiscal2.value = tbauxvisitafiscal3.value) then
                begin
                     if (tbvisitash_visita.value > tbauxvisitah_visita.value) and (tbvisitash_visita.value < tbauxvisitah_fim.value) then
                     begin
                        messagedlg('Informacoes inconsistentes com outra entrada da tabela de inspecoes. Autoridade: '+tbauxvisitafiscal2.value+', Inscricao: '+tbauxvisitacodigo.asstring+', Periodo: '+tbauxvisitah_visita.asstring+' as '+ tbauxvisitah_fim.asstring+', Documento: '+tbauxvisitatipo.value+' na '+tbauxvisitanumero.value,mtwarning,[mbok],0);
                        exit;
                     end;

                     if (tbvisitasndoc.value <> tbauxvisitandoc.value) and (tbvisitash_fim.value > tbauxvisitah_visita.value) and (tbvisitash_visita.value < tbauxvisitah_fim.value) then
                     begin
                        messagedlg('Informacoes inconsistentes com outra entrada da tabela de inspecoes. Autoridade: '+tbauxvisitafiscal2.value+', Inscricao: '+tbauxvisitacodigo.asstring+', Periodo: '+tbauxvisitah_visita.asstring+' as '+ tbauxvisitah_fim.asstring+', Documento: '+tbauxvisitatipo.value+' na '+tbauxvisitanumero.value,mtwarning,[mbok],0);
                        exit;
                     end;
                end;
             end;
//**********************************************
             if not tbvisitasfiscal3.isnull then
             begin
                if (tbvisitasfiscal3.value = tbauxvisitafiscal1.value)  or (tbvisitasfiscal3.value = tbauxvisitafiscal2.value) or (tbvisitasfiscal3.value = tbauxvisitafiscal3.value) then
                begin
                     if (tbvisitash_visita.value > tbauxvisitah_visita.value) and (tbvisitash_visita.value < tbauxvisitah_fim.value) then
                     begin
                        messagedlg('Informacoes inconsistentes com outra entrada da tabela de inspecoes. Autoridade: '+tbauxvisitafiscal3.value+', Inscricao: '+tbauxvisitacodigo.asstring+', Periodo: '+tbauxvisitah_visita.asstring+' as '+ tbauxvisitah_fim.asstring+', Documento: '+tbauxvisitatipo.value+' na '+tbauxvisitanumero.value,mtwarning,[mbok],0);
                        exit;
                     end;

                     if (tbvisitasndoc.value <> tbauxvisitandoc.value) and (tbvisitash_fim.value > tbauxvisitah_visita.value) and (tbvisitash_visita.value < tbauxvisitah_fim.value) then
                     begin
                        messagedlg('Informacoes inconsistentes com outra entrada da tabela de inspecoes. Autoridade: '+tbauxvisitafiscal3.value+', Inscricao: '+tbauxvisitacodigo.asstring+', Periodo: '+tbauxvisitah_visita.asstring+' as '+ tbauxvisitah_fim.asstring+', Documento: '+tbauxvisitatipo.value+' na '+tbauxvisitanumero.value,mtwarning,[mbok],0);
                        exit;
                     end;
                end;
             end;
//**********************************************

            end;
            tbauxvisita.Next;
       end;
}

{     if messagedlg('Deseja Salvar Conteudo do '+#13+tbvisitastipo.value+' '+ tbvisitasnumero.AsString + '?',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin}

{     end;}

        if not tbvisitasos.IsNull then
        begin
            if tbreq.FindKey([tbvisitasos.value]) then
            begin
                if tbreqcodigo.Value = tbvisitascodigo.value then
                begin
                  if (tbreqencaminhamento.Value = true) or (tbreqdt_encaminha.Value < strtodate('10/04/2024')) then
                  begin
                    if (tbreqfiscal_encaminha.Value = tbvisitasfiscal1.Value) or (tbreqfiscal_encaminha.Value = tbvisitasfiscal2.Value) or (tbreqfiscal_encaminha.Value = tbvisitasfiscal3.Value) then
                    begin

       if   (tbreqprioridade.Value = true)  then
       else if tbvisitasfiscal3.Value <> '' then
       begin
           tbvisitasfiscal3.Value := '';
           showmessage('Atencao! Terceiro fiscal nao autorizado para esta OS');
           dbcordem.SetFocus;
           exit
       end;

                      if tbreqatendimento.Value = false then
                      begin
                          if (tbvisitastipo.Value <> 'CERTIDAO') or (tbreqcomplexidade.Value = 'BAIXA') then
                          begin
                              tbreq.Edit;
                              tbreqatendimento.value      := true;
                              tbreqfiscal_atend.Value     := tbvisitasfiscal1.Value;
                              tbreqdt_atend.Value         := tbvisitasdt_visita.Value;
                              tbreqtipo_documento.value   := tbvisitastipo.value;
                              tbreqnum_documento.value    := tbvisitasnumero.value;
                              tbreq.Post;
                              showmessage('Ordem de servico: ' + tbreqos.AsString+' Baixada com sucesso.');
                          end
                          else
                          begin
                              tbvisitaslibera.Value := 'Nao';
                              showmessage('Atencao! A Ordem de Requerimento: ' + tbreqos.AsString+' nao foi baixada pela certidao emitida. Necessorio reportar a Gerencia');
                          end;
                      end
                      else
                      begin
                          if tbvisitastipo.Value <> 'CERTIDAO' then
                          showmessage('Tudo bem! A OS '+ tbreqos.AsString+' ja foi baixada anteriormente.' )
                          else
                          begin
                              if tbreqcomplexidade.Value <> 'BAIXA' then
                              begin
                                  showmessage('Nao pode ser emitida certidao para Ordem de Requerimento: ' + tbreqos.AsString+' ja baixada.');
                                  DBCtipo.SetFocus;
                                  exit;
                              end;
                          end;
                      end;
                    end
                    else
                    begin
                        showmessage('Atencao. OS encaminhada para '+tbreqfiscal_encaminha.Value );
                        dbeos.SetFocus;
                        exit;
                    end;
                  end
                  else
                  begin
                    showmessage('Requerimento ainda nao a uma OS encaminhada pelo titular de vigilancia');
                    dbeos.SetFocus;
                    exit;
                  end;
                end
                else
                begin
                    showmessage('OS nao pertence a este regulado' );
                    dbeos.SetFocus;
                    exit;
                end;
            end
            else
            begin
               showmessage('OS nao encontrada' );
               dbeos.SetFocus;
               exit;
            end;
        end;


        if not tbvisitasoficio.IsNull then
        begin
            if tboficio.FindKey([tbvisitasoficio.value]) then
            begin
                if tboficiocancela.Value = true then
                begin
                    showmessage('Atencao! OS Cancelada '+ tboficiooficio.AsString);
                    dbeof.SetFocus;
                    exit;
                end;

                if tboficiodtencaminha.Value > tbvisitasdt_visita.Value  then
                begin
                    showmessage('Atencao! Impossovel registrar nesta data. A OS informada foi encaminhada em:'+ tboficiodtencaminha.AsString);
                    DBEDataV.SetFocus;
                    exit;
                end;




       if   (tboficioterceiro.Value = true)  then
       else if tbvisitasfiscal3.Value <> '' then
       begin
           tbvisitasfiscal3.Value := '';
           showmessage('Atencao! Terceiro fiscal nao autorizado para esta OS');
           dbcordem.SetFocus;
           exit
       end;

                if tboficiooficio.Value = tbvisitasoficio.value then
                begin
                    if (tboficiofiscalencaminha.Value <> tbvisitasfiscal1.Value)  then
                    begin
                        showmessage('Atencao! OS encaminhada ao fiscal '+tboficiofiscalencaminha.Value+'. Impossovel continuar');
                        dbeof.SetFocus;
                        exit;
                    end;
                    if (tboficiomotivo.Value = 'SERVICO TECNICO') or (tboficiomotivo.Value = 'OPERACAO FISCAL')  or (tboficiomotivo.Value = 'TREINAMENTO/REUNIAO')  then
                    begin
                        showmessage('Atencao! OS nao direcionada a inspecao. Impossovel continuar');
                        dbeof.SetFocus;
                        exit;
                    end;

                    if tboficioarchive.Value = false then
                    begin
                        tboficio.Edit;
                        tboficioarchive.value       := true;
                        tboficiouser.Value          := tbvisitasfiscal1.Value;
                        tboficiodtatendimento.Value := tbvisitasdt_visita.Value;
                        tboficio.Post;
                        showmessage('Ordem de servico: ' + tboficiooficio.AsString+' Baixada com sucesso.');
                    end
                    else
                    begin
                        showmessage('Atencao! OS '+ tboficiooficio.AsString+' ja baixada anteriormente.' );
                    end;
                end
                else
                begin
                    showmessage('Erro: tabela de OF diferente da tabela de VF');
                    dbeof.SetFocus;
                    exit;
                end;
            end
            else
            begin
               showmessage('OS nao encontrada' );
               dbeof.SetFocus;
               exit;
            end;
        end;

            if not tbvisitasprotocolo.IsNull then
            begin
                if not tbauxplanta.FindKey([tbvisitascodigo.value,tbvisitasprotocolo.value]) then
                begin
                    showmessage('N. de protocolo nao pertence ao regulado.');
                    dbeproto.SetFocus;
                    exit;
                end
//                else  showmessage('Achei protocolo '+inttostr(tbauxplantaprotocolo.value)+'  '+'regulado '+inttostr(tbauxplantacodigo.value))
            end;

            if not tbvisitasdenuncia.IsNull then
            begin
                if tbdenuncia.FindKey([tbvisitasdenuncia.value]) then
                begin
                    if tbdenunciaarchive.Value = true then
                    begin
                        showmessage('Atencao! Denuncia Arquivada:'+ tbdenunciadenuncia.AsString);
                        dbeden.SetFocus;
                        exit;
                    end;
                    if tbdenunciafiscalencaminha.Value <> frmlogin.c_user then
                    begin
                        showmessage('Atencao! Denuncia encaminhada para o fiscal:'+ tbdenunciafiscalencaminha.Value );
                        dbeden.SetFocus;
                        exit;
                    end;
                end
                else
                begin
                    showmessage('N. de denuncia nao encontrado.');
                    dbeden.SetFocus;
                    exit;
                end;
            end;

//======================================================
              if (tbvisitasmodalidade.Value='REQUERIMENTO') and (tbauxoficio.findkey(['OS'+inttostr(tbvisitasos.value)]))       then retorno := true;
              if (tbvisitasmodalidade.Value='DENUNCIA')     and (tbauxoficio.findkey(['DE'+inttostr(tbvisitasdenuncia.value)])) then retorno := true;
              if (tbvisitasmodalidade.Value='DE OFICIO')    and (tbauxoficio.findkey(['OF'+inttostr(tbvisitasoficio.value)]))   then retorno := true;

              if retorno = false then
              begin
                  if tbvisitaslibera.Value = 'Sim' then
                  begin
                      if messagedlg('Confirma a geracao automatica do Retorno para a OS '+tbvisitasos.AsString+tbvisitasoficio.AsString+tbvisitasdenuncia.AsString+' ?',mtconfirmation,[mbyes,mbno],0)=mryes  then
                      begin
                          if  (tbvisitasmodalidade.value <> 'PROTOCOLO') then
                          begin
                                tboficio.Insert;
                                tbsequencia.edit;
                                ret:=tbsequenciaoficio.value+1;
                                tboficiooficio.value:=ret;
                                tbsequenciaoficio.value:=ret;
                                tbsequencia.post;
                                tboficioData.Value:=date;
                                tboficiodtencaminha.value :=tbvisitasdt_visita.Value;
                                tboficioprazo.Value :=tbvisitasdt_visita.Value + tbvisitaspz_retorno.Value+30;
                                tboficiouser.Value := frmlogin.c_user;
                                tbOFICIOEMITENTE.value := 'GERENTE DE VIGILANCIA SANITARIA';
                                tboficiomotivo.value := 'RETORNO';
                                tboficioregulado.Value := tbcontribrazao.Value;
                                tboficiologradouro.Value := tbcontriblogradouro.Value;
                                tboficiocdbai.Value := tbcontribcdbai.Value;
                                if tbvisitasmodalidade.value = 'REQUERIMENTO' then
                                    begin
                                        tboficioorigem.value := 'OS'+inttostr(tbvisitasos.Value);
                                        tboficioordem.value := 'Retorno da Ordem de Requerimento '+tbvisitasos.AsString;
                                        tboficiofiscalencaminha.Value := tbreqfiscal_encaminha.Value;
                                        tboficioterceiro.Value := tbreqprioridade.Value;
                                    end;
                                if tbvisitasmodalidade.value = 'DENUNCIA'  then
                                    begin
                                        tboficioorigem.value := 'DE'+inttostr(tbvisitasdenuncia.Value);
                                        tboficioordem.value := 'Retorno da Denuncia '+tbvisitasdenuncia.AsString;
                                        tboficiofiscalencaminha.Value := tbdenunciafiscalencaminha.Value;
                                    end;
                                if tbvisitasmodalidade.value = 'DE OFICIO' then
                                    begin
                                       tboficioorigem.value := 'OF'+inttostr(tbvisitasoficio.Value);
                                       tboficioordem.value := 'Retorno da Ordem de Oficio '+tbvisitasoficio.AsString;
                                        tboficiofiscalencaminha.Value := tbvisitasfiscal1.Value;
                                        tboficioterceiro.Value := tbauxoficioterceiro.value;
                                    end;
                                tboficiocpf.Value   := tbcontribcpf.Value;
                                tboficiocnpj.value := tbcontribcgc.value;
                                tboficio.Post;
                                showmessage('Ordem de Retorno: ' + tboficiooficio.AsString+' gerada com sucesso.');
                          end;
                      end;
                  end;
              end
              else showmessage('Atencao! Retorno para OS ' + tbvisitasos.AsString + tbvisitasoficio.AsString + tbvisitasdenuncia.AsString + ' ja foi gerado anteriormente.');
//=================================================
{
       if  (tbvisitasmodalidade.Value = 'REQUERIMENTO') and (tbreqprioridade.Value = true) then
       else if tbvisitasfiscal3.Value <> '' then
       begin
           tbvisitasfiscal3.Value := '';
           showmessage('Atencao! Terceiro fiscal nao autorizado para esta OS');
       end;
 }




        if not tbhistorico.Eof then  tbhistorico.post;
        tbvisitas.post;
        dbgrid2.enabled:=true;


       if  tbsequencia.state <> dsbrowse then tbsequencia.post;
{        btlocpro.setfocus;}
end;

procedure Tfrmestabe.btaltvisitaClick(Sender: TObject);
var
        seqh:integer;
begin
{  vasio:= false;
  tbrt.First;
  while not tbrt.Eof do
  begin
      if tbrtsubclasse.isnull then vasio:= true;
      if vasio = true then
      begin
          showmessage('Caro Usuario, favor completar a ficha CAE para todas as atividades cadastradas');
          exit;
      end;
      tbrt.Next;
  end;

        if (tbrt.Eof ) and (tbrt.Bof) then
        begin
            showmessage('Caro Usuario, favor preencher a ficha CAE');
            exit;
        end;
{
        if tbrtsubclasse.isnull then
        begin
            showmessage('Caro Usuario, favor informar o CNAE na ficha CAE');
            exit;
        end;
 }


  {       if tbcontribatividade.value = 0 then
        begin
            showmessage('Caro Usuario, favor Selecionar a Atividade Economica relacionada');
            exit;
        end;  }

    tbrmpf.IndexName:='PorData';
    if tbrmpf.FindKey([tbvisitasdt_visita.value])then
    while not tbrmpf.Eof
    do
    begin
        if (tbrmpfnome.value=tbvisitasfiscal1.value) or (tbrmpfnome.value=tbvisitasfiscal2.value) or (tbrmpfnome.value=tbvisitasfiscal3.value) then
           begin
               if (tbvisitasdt_visita.value=tbrmpfdata.value) then
                  begin
                     messagedlg('Relatorio de Producao Homologado: '+datetostr(tbrmpfdata.value)+' - '+tbrmpfnome.value+'.',mtwarning,[mbok],0);
                     exit;
                  end;
           end;
        tbrmpf.Next;
    end;

    if tbrdpf.FindKey([tbvisitasdt_visita.value])then
    while not tbrdpf.Eof
    do
    begin
      if (tbrdpfnome.value=tbvisitasfiscal1.value) or (tbrdpfnome.value=tbvisitasfiscal2.value) or (tbrdpfnome.value=tbvisitasfiscal3.value) and (tbvisitasdt_visita.value=tbrdpfdata.value) then
      begin
         if (tbrdpfentrega.value = true) and (tbrdpftipo.value = 'O') and (tbrdpfestabe.value = tbcontribrazao.value) then
         begin
            messagedlg('Atencao! Reportar-se a gerencia devido a apontamento nesta data : '+datetostr(tbrdpfdata.value)+' - '+tbrdpfnome.value,mtwarning,[mbok],0);
            exit;
         end;
      end;
      tbrdpf.next;
   if tbrdpfdata.Value <> tbvisitasdt_visita.value then break;
    end;




{     if tbvisitasentrega.value = true then
     begin
        showmessage('Este documento ja esta anexado a um Relatorio de Producao Fiscal ja entregue a Administracao. Impossovel Alterar!');
        exit;
     end; }

 //    if frmlogin.c_grp = 'CAD' then
 //    begin


 {  if (tbvisitasdt_visita.value <> datavisita) and (frmlogin.c_grp <> 'ADM') then
   begin
       if dayofweek(date) = 2 then
        begin
         if (daysbetween(datavisita,tbvisitasdt_visita.value) > 35) then
         begin
            showmessage('Perfil nao autorizado alterar documento nesta data!');
          //  btaltvisita.setfocus;
            exit;
         end;
       end
       else                                      
       begin
         if (daysbetween(datavisita,tbvisitasdt_visita.value) > 34) then
         begin
            showmessage('Perfil nao autorizado alterar documento nesta data!');
      //      btaltvisita.setfocus;
            exit;
         end;
       end;
   end;

        }


 {
        if dayofweek(date) = 2 then
        begin
             if daysbetween(date,tbvisitasdt_visita.value) > 15  then
             begin
                showmessage('Perfil nao autorizado alterar documento nesta data!');
               exit;
            end;
        end
        else
        begin
             if daysbetween(date,tbvisitasdt_visita.value) > 14 then
             begin
                showmessage('Perfil nao autorizado alterar documento nesta data!');
               exit;
            end;
        end;
 //    end;
    }

if                      (frmlogin.c_user = tbvisitasfiscal1.value) or
                        (frmlogin.c_user = tbvisitasfiscal2.value) or
                        (frmlogin.c_user = tbvisitasfiscal3.value) or
                        (frmlogin.c_grp = 'ADM') or
                        (frmlogin.c_grp = 'CAD') and (tbvisitasgr_inclu.Value = 'CAD')
{(tbvisitastipo.value='ATO ADMINISTRATIVO DA GERENCIA')}
then
begin
        PainelTermo.visible := true;
        dbgrid2.enabled:=false;
        datavisita:=tbvisitasdt_visita.value;
        tbvisitas.edit;
        tbvisitasus_altera.Value := frmlogin.c_user;
        tbvisitasdt_altera.Value := date;
        if tbvisitasndoc.Value = 0
        then
        begin
                tbsequencia.edit;
                seqh:=tbsequenciadoc.value+1;
                tbvisitasndoc.value:=seqh;
                tbsequenciadoc.value:=seqh;
                tbsequencia.post;
                tbhistorico.insert;
        end
        else tbhistorico.edit;
        DbCordem.setfocus;
end
else
showmessage('Perfil nao autorizado!');
end;

procedure Tfrmestabe.btdelvisitaClick(Sender: TObject);

begin

    tbrmpf.IndexName:='PorData';
    if tbrmpf.FindKey([tbvisitasdt_visita.value])then
    while not tbrmpf.Eof
    do
    begin
        if (tbrmpfnome.value=tbvisitasfiscal1.value) or (tbrmpfnome.value=tbvisitasfiscal2.value) or (tbrmpfnome.value=tbvisitasfiscal3.value) then
           begin
               if (tbvisitasdt_visita.value=tbrmpfdata.value) then
                  begin
                     messagedlg('Relatorio de Producao Homologado: '+datetostr(tbrmpfdata.value)+' - '+tbrmpfnome.value+'.',mtwarning,[mbok],0);
                     exit;
                  end;
           end;
        tbrmpf.Next;
    end;

    if tbrdpf.FindKey([tbvisitasdt_visita.value])then
    while not tbrdpf.Eof
    do
    begin
      if (tbrdpfnome.value=tbvisitasfiscal1.value) or (tbrdpfnome.value=tbvisitasfiscal2.value) or (tbrdpfnome.value=tbvisitasfiscal3.value) and (tbvisitasdt_visita.value=tbrdpfdata.value) then
      begin
         if (tbrdpfentrega.value = true) and (tbrdpftipo.value = 'O') and (tbrdpfestabe.value = tbcontribrazao.value) then
         begin
            messagedlg('Atencao! Reportar-se a gerencia devido a apontamento nesta data : '+datetostr(tbrdpfdata.value)+' - '+tbrdpfnome.value,mtwarning,[mbok],0);
            exit;
         end;
      end;
      tbrdpf.next;
     if tbrdpfdata.Value <> tbvisitasdt_visita.value then break;
    end;

//    =======================

     if messagedlg('Confirma a Exclusao do Documento N..:'+#13+ tbvisitasnumero.AsString + '?',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin
             if (frmlogin.c_user = tbvisitasfiscal1.value) or (frmlogin.c_user = tbvisitasfiscal2.value) or (frmlogin.c_user = tbvisitasfiscal3.value) or (frmlogin.c_grp = 'ADM') then
             begin
            if (daysbetween(date,tbvisitasdt_visita.value) > 1) then
               begin
                 showmessage('Impossovel excluir a inspecao nesta data!');
                 DBEDataV.setfocus;
                 exit;
               end
               else
               begin
                    if not tbhistorico.Eof then tbhistorico.Delete else showmessage('Especificacoes nao digitadas para este Documento!');
                    if not tbvisitas.Eof   then tbvisitas.Delete   else showmessage('Nao Ha Documento a ser Excluido!');
                    Showmessage('Atencao. Lancamento excluido. a necessorio gerar novamente o Relatorio de Producao para esta data');
               end;
             end
             else showmessage('Perfil nao autorizado!');
     end;
{     btlocpro.setfocus;}

end;

procedure Tfrmestabe.dsvisitasStateChange(Sender: TObject);
begin
DBNavHist.Enabled    := tbvisitas.state =  dsbrowse;
bitdoc.Enabled      := tbvisitas.state =  dsbrowse;
btnovvisita.enabled := tbvisitas.state =  dsbrowse;
btaltvisita.enabled := tbvisitas.state =  dsbrowse;
btgravisita.enabled := tbvisitas.state <> dsbrowse;
btcanvisita.enabled := tbvisitas.state <> dsbrowse;
btdelvisita.enabled := tbvisitas.state =  dsbrowse;
barraferra.enabled   := tbvisitas.state =  dsbrowse;
panel1.enabled       := tbvisitas.state =  dsbrowse;
if tbvisitas.state   <> dsbrowse then barraferra.Color := clmoneygreen;
if tbvisitas.state   = dsbrowse then barraferra.Color := clBtnFace;
end;

procedure Tfrmestabe.btalvaraClick(Sender: TObject);
begin
if tbalvara.Eof then
begin
 showmessage('Alvara nao requerido para o exercicio!');
 exit;
end;

if tbalvaralibera.value <> true then
begin
 showmessage('Alvara nao liberado para o exercicio!');
 exit;
end;
painel:= 'alvara';
lugar:= tbcontribcontrole.value;
frmalvara.tbbairro.open;
frmalvara.tbativ.open;
frmalvara.tbgrupo.open;
frmalvara.tbrt.open;
frmalvara.tbalvara.open;
frmalvara.tbcontrib.open;
  frmalvara.tbalvara.findkey([tbalvaracontrole.value]);
  frmalvara.tbcontrib.findkey([tbcontribcontrole.value]);
  frmalvara.realvara.preview;
frmalvara.tbbairro.Close;
frmalvara.tbgrupo.close;
frmalvara.tbrt.Close;
frmalvara.tbalvara.Close;
frmalvara.tbcontrib.Close;
frmalvara.Close;
end;

procedure Tfrmestabe.navalvaraClick(Sender: TObject; Button: TNavigateBtn);
begin
DBEDuam.setfocus;
end;


procedure Tfrmestabe.btnovalvaraClick(Sender: TObject);
begin
 if (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') then
 begin
   tbalvara.last;
   if (tbalvaraexercicio.value = yearof(date)) and (tbalvaracancela.Value = false) and (tbalvaratipo.Value = false) then
    begin
 //      if messagedlg('Confirma a Requerimento de multiplos alvaras do contribuinte para o exercicio: '+tbalvaraexercicio.AsString +'?',mtconfirmation,[mbyes,mbno],0)= mbno then exit;
        showmessage('Atencao! Ja existe Alvara cadastrado para o contribuinte no exercicio');
        exit;
   end;
   tbalvara.insert;
   tbalvaradt_duam.value := date;
   tbalvaraexercicio.value := yearof(date);
   tbalvararequerente.value:=frmlogin.c_user;
   tbalvaratipo.Value :=false;
   tbalvaraevento.Value :=false;
   DBEduam.setfocus;
 end
 else showmessage('Perfil nao autorizado!');
end;

procedure Tfrmestabe.btaltalvaraClick(Sender: TObject);
begin
begin
if (frmlogin.c_grp <> 'CON') then
begin
        tbalvara.edit;
    //    if (frmlogin.c_grp = 'ADM') and (tbalvaraevento.Value = true) then dbeval.readonly := false;
        DBEDuam.setfocus;
        tbalvaraalteracao.Value := frmlogin.c_user;
        tbalvaradt_altera.value := date;
end
else
showmessage('Perfil nao autorizado');
end;
end;

procedure Tfrmestabe.btgravalvaraClick(Sender: TObject);
begin
{        if tbalvaranumero.value = 0 then
        begin
            showmessage('Caro Usuario, favor informar o Numero do Alvara');
            exit;
        end;}

        if tbalvaraexercicio.isnull = true  then
        begin
            showmessage('Caro Usuario, favor informar o Exercicio Fiscal');
            exit;
        end;

      if inttostr(tbalvaraexercicio.Value) <> formatdatetime('yyyy',tbalvaradt_duam.Value) then
      begin
         showmessage('Data do Requerimento invalida!');
         exit;
         DBEDtreq.setfocus;
      end;

 {        if tbalvaraexercicio.Value < 2022 then
   begin
      showmessage('Exercicio do Requerimento Expirado!');
         exit;
         DBCExercicio.setfocus;
   end;

         if tbalvaraexercicio.Value > 2022 then
   begin
      showmessage('Exercicio do Requerimento Invalido!');
         exit;
         DBCExercicio.setfocus;
   end;
        }


{   if tbalvaraexercicio.Value > strtoint(formatdatetime('yyyy',date)) then
    begin
      showmessage('Impossovel requerer Alvara para o exercicio seguinte!');
         exit;
         DBCExercicio.setfocus;
    end;
 }

{        if (tbalvaratipo.Value = true) and (frmlogin.c_grp <> 'ADM') then
        begin
                 showmessage('Usuario nao autorizado a liberacao de alvara provisorio!');
                 exit;
        end;    }


{        if tbalvaraunidade.value = ' ' then
        begin
            showmessage('Caro Usuario, favor informar a area para a qual o alvara esta sendo liberado');
            exit;
        end;}

//        dbeval.ReadOnly :=true;
        tbalvara.post;
        btemitenovo.setfocus;

end;

procedure Tfrmestabe.dsalvaraStateChange(Sender: TObject);
begin
// dbcprovisorio.Enabled := tbalvara.state <> dsbrowse;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') then DBMobsalvara.Enabled := tbalvara.state <> dsbrowse else DBMobsalvara.Enabled := false;
btnovalvara.enabled  := tbalvara.state =  dsbrowse;
btaltalvara.enabled  := tbalvara.state =  dsbrowse;
btgravalvara.enabled := tbalvara.state <> dsbrowse;
btcancalvara.enabled := tbalvara.state <> dsbrowse;
btdelalvara.enabled  := tbalvara.state =  dsbrowse;
btemitenovo.enabled  := tbalvara.state =  dsbrowse;
btreemite.enabled    := tbalvara.state =  dsbrowse;
//btautor.enabled    := tbalvara.state <>  dsbrowse;
barraferra.enabled   := tbalvara.state =  dsbrowse;
painelautoriza.enabled  := tbalvara.state =  dsbrowse;
navalvara.Enabled       := tbalvara.state =  dsbrowse;
if tbalvara.state    <> dsbrowse then barraferra.Color := clmoneygreen;
if tbalvara.state     = dsbrowse then barraferra.Color := clBtnFace;
if tbalvara.state    <> dsbrowse then painelautoriza.Color := clmoneygreen;
if tbalvara.state     = dsbrowse then painelautoriza.Color := clBtnFace;
end;

procedure Tfrmestabe.btcancalvaraClick(Sender: TObject);
begin
      tbalvara.Cancel;
      btemitenovo.setfocus;
end;

procedure Tfrmestabe.btdelalvaraClick(Sender: TObject);
begin
     if messagedlg('Confirma o Cancelamento do Alvara'+#13+ tbalvaranumero.AsString + ' de '+tbalvaraexercicio.AsString +'?',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin
             if (frmlogin.c_grp = 'ADM') then
             begin
             //    if not tbalvara.Eof then tbalvara.Delete else showmessage('Nao Ha Alvara Solicitado para este Contribuinte!');
                   if not tbalvara.Eof then
                   begin
                      // tbalvara.Delete
                      showmessage('Informar nas observacoes o motivo do cancelamento');
                      tbalvara.edit;
                      tbalvaracancela.Value := True;
                      tbalvaracancelador.Value := frmlogin.c_user;
                      tbalvaradt_cancela.Value := date;
                      tbalvara.Post;
                   end
                   else showmessage('Nao Ha Alvara Solicitado para este Contribuinte!');
             end
             else showmessage('Cancelamento nao autorizado');
     end;
     btemitenovo.setfocus;
end;

procedure Tfrmestabe.tbcontribCARACTERChange(Sender: TField);
begin
{if tbcontribcaracter.value = true then TabCarac.TabVisible := true else TabCarac.TabVisible := false;}
end;

procedure Tfrmestabe.BtdocClick(Sender: TObject);
begin
if PainelTermo.visible = true then PainelTermo.visible := false else PainelTermo.visible := true
end;

{procedure Tfrmestabe.DBENivelChange(Sender: TObject);
begin
if DBENivel.Text = 'B'  then
        DBENivel.Color := clLime;

if DBENivel.Text = 'M'  then
        DBENivel.Color := clYellow;

if DBENivel.Text = 'A'  then
        DBENivel.Color := clRed;

end;}

procedure Tfrmestabe.tbcontribBeforeScroll(DataSet: TDataSet);
begin
if tbcontribTAXA.value = true then
begin
//    DBTufma.Visible:=false;
{    DBTtaxa.Visible:=false;}
end
else
begin
//    DBTufma.Visible:=true;
{    DBTtaxa.Visible:=true;}
end;
    if tbcontribinatividade.value = true then TextoATV.Visible:= TRUE else TextoATV.Visible:= FALSE;
    if tbcontribhorario.Value = 'NOTURNO' then Texto_horario2.Visible := true else Texto_horario2.Visible := false;
    if tbcontribpendoc.value = true then showmessage('Atencao: Contribuinte com pendencia no arquivo. Solicitar documentacao. Obrigado!          SETOR DE CADASTROS.       ');
    if tbcontribpessoa.value = 'CNPJ' then
        begin
        DBECPF.Enabled  := false;
        DBECPF.Visible  := false;
        DBECGC.enabled  := true;
        DBECGC.visible := true;
        end;
     if tbcontribpessoa.value = 'CPF' then
        begin
        DBECPF.Enabled  := true;
        DBECPF.Visible  := true;
        DBECGC.enabled  := false;
        DBECGC.visible := false;
        end;

{      if tbcontribcaracter.value = true then TabCarac.TabVisible := true else TabCarac.TabVisible := false;}
end;

procedure Tfrmestabe.tbcontribAfterScroll(DataSet: TDataSet);
begin
if tbcontribTAXA.value = true then
begin
//    DBTufma.Visible:=false;
{    DBTtaxa.Visible:=false;{
end
else
begin
//    DBTufma.Visible:=true;
{    DBTtaxa.Visible:=true;}
end;
    if tbcontribinatividade.value = true then TextoATV.Visible:= TRUE else TextoATV.Visible:= FALSE;
    if tbcontribhorario.Value = 'NOTURNO' then Texto_horario2.Visible := true else Texto_horario2.Visible := false;
    if tbcontribpendoc.value = true then showmessage('Atencao: Contribuinte com pendencias no arquivo. Solicitar documentacao. Obrigado!          SETOR DE CADASTROS.       ');    
    if tbcontribpessoa.value = 'CNPJ' then
        begin
        DBECPF.Enabled  := false;
        DBECPF.Visible  := false;
        DBECGC.enabled  := true;
        DBECGC.visible := true;
        end;
     if tbcontribpessoa.value = 'CPF' then
        begin
        DBECPF.Enabled  := true;
        DBECPF.Visible  := true;
        DBECGC.enabled  := false;
        DBECGC.visible := false;
        end;  

      {      if tbcontribcaracter.value = true then TabCarac.TabVisible := true else TabCarac.TabVisible := false;}

 //         ValidarCNAESIM;
end;

procedure Tfrmestabe.tbcontribINATIVIDADEChange(Sender: TField);
begin
if tbcontribinatividade.value = true then TextoATV.Visible:= TRUE else TextoATV.Visible:= FALSE;
showmessage('Atencao! Alteracao do status de inatividade');
end;

procedure Tfrmestabe.DBMObsestabeExit(Sender: TObject);
begin
{    if frmlocpro.inclu = 1 then
    begin
        PageControl1.ActivePage := TabCarac;
        DBENomeResp1.setfocus;
    end;}

end;

procedure Tfrmestabe.DBCacaoChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCtipoChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCFiscal1Change(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCFiscal2Change(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCFiscal3Change(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCExercicioChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBSetorChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCCons1Change(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCCons2Change(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCUF1Change(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCUF2Change(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCNaturezaChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBLareaExit(Sender: TObject);
begin
end;

{procedure Tfrmestabe.DBLGrupoExit(Sender: TObject);
begin
tbativi.Filter := 'grupo = ' + tbgrupocod.AsString;
end;}

procedure Tfrmestabe.DBLGrupoEnter(Sender: TObject);
begin
{tbgrupo.filtered := true;
tbgrupo.Filter := 'area = ' + tbareacod.AsString;}
end;

procedure Tfrmestabe.DBLAtivEnter(Sender: TObject);
begin
{tbativi.filtered := true;
tbativi.Filter := 'grupo = ' + tbgrupocod.AsString;}
end;

procedure Tfrmestabe.BtativClick(Sender: TObject);
begin
showmessage('Modulo em desenvolvimento!');
{if filtro = 0 then
begin
        showmessage('Atencao! Exibicao: somente INATIVOS');
        tbcontrib.Filter := 'inatividade = true';
        filtro := 1;
end
else
begin
        showmessage('Atencao! Exibicao: somente ATIVOS');
        tbcontrib.Filter := 'inatividade <> true';
        filtro := 0;
end;}

end;

procedure Tfrmestabe.BtliberaClick(Sender: TObject);
begin
        if messagedlg('Confirma a Liberacao Alvara o Contribuinte'+#13+tbcontribRAZAO.value+'?',mtconfirmation,[mbyes,mbno],0)=mryes then
begin
  if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM')  then
    begin
       tbalvaralibera.Value := true;
       tbalvaraautoridade.value := frmlogin.c_user;
       tbalvaradt_libera.value := date;
       randomize;
       tbalvaraautenticador.value:=inttohex(random(10000000000),10);
       showmessage('Alvara liberado!');
    end
  else
     begin
       tbalvaralibera.Value := false;
       tbalvaraautoridade.value := ' ';
       showmessage('Funcao permitida somente para pessoal tecnico');
     end
  end
else tbalvaralibera.Value := false;
tbalvara.post;
end;

procedure Tfrmestabe.DBEcgcExit(Sender: TObject);

begin

  If NOT CGC(tbcontribcgc.value) then
  Begin
    messagebox(Application.Handle, Pchar ('O CNPJ ' +tbcontribcgc.value+ ' a invalido!'), 'Atencao', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
    DBECGC.setfocus;
  end;

end;

procedure Tfrmestabe.DBECPFExit(Sender: TObject);
begin
  If NOT CPF(tbcontribCPF.value) then
  Begin
     messagebox(Application.Handle, Pchar ('O CPF ' +tbcontribcpf.value+ ' a invalido!'), 'Atencao', MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
    DBECPF.setfocus ;
   end;
end;


procedure Tfrmestabe.DBCPessoaExit(Sender: TObject);
begin
    if tbcontribpessoa.value = 'CNPJ' then
        begin
        DBECPF.Enabled  := false;
        DBECPF.Visible  := false;
        DBECGC.enabled  := true;
        DBECGC.visible := true;
        DBECGC.setfocus;
        end;
    if tbcontribpessoa.value = 'CPF' then
        begin
        DBECPF.Enabled  := true;
        DBECPF.Visible  := true;
        DBECGC.enabled  := false;
        DBECGC.visible := false;
        DBECPF.setfocus;
        end;
end;

procedure Tfrmestabe.DBCPessoaChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.TimeadmimTimer(Sender: TObject);
begin
Sthora.Caption:=copy(timetostr(time),1,5);
frmprincipal.tbsequencia.Refresh;
if frmprincipal.tbsequenciadisponibilidade.value = false then showmessage('Caro Usuario, Sistema em manutencao, favor salvar os trabalhos e fechar (SAIR) o WCVS');
end;

procedure Tfrmestabe.anvisaClick(Sender: TObject);
begin
aboutbox.showmodal;
end;

procedure Tfrmestabe.DBECPFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{  var
  valida:boolean;}
begin
case key of
        vk_escape:
            begin
              frmlocpro.inclu := 0;
//              tbgrupo.filtered := false;
//              tbativi.Filtered := false;
              tbhistorico.Cancel;
              tbvisitas.cancel;
              tbrt.cancel;
//              tbcaracter.cancel;
              tbcontrib.cancel;
              tbsequencia.cancel;
              close;
             end;
end;             
end;

procedure Tfrmestabe.TabCaracShow(Sender: TObject);
begin
{if tbcaracterhorario.Value = 'NOTURNO' then Texto_horario.Visible := true else Texto_horario.Visible := false;}
 ValidarCNAESIM;
end;

procedure Tfrmestabe.DBCHoraExit(Sender: TObject);
begin
{if tbcaracterhorario.Value = 'NOTURNO' then Texto_horario.Visible := true else Texto_horario.Visible := false;}
end;

procedure Tfrmestabe.DBEHfimExit(Sender: TObject);
begin
{  if (tbvisitash_fim.value < tbvisitash_visita.value) and (tbvisitastipo.Value='CERTIDAO') and (tbvisitastipo.Value='CONTRA RAZAO') and (tbvisitastipo.Value='PRORROGACAO') and (tbvisitastipo.Value='REPLICA FISCAL') and (tbvisitastipo.Value='ATO ADMINISTRATIVO DA GERENCIA') then
        begin
              showmessage('Atencao: Final da Inspecao Anterior ao Inicio');
              exit;
        end;       }
//   if  SecondsBetween(tbvisitash_fim.value,tbvisitash_visita.value) > 10799 then showmessage('Atencao, inspecao de grande porte! Autorizacao da Gerencia Necessoria.');
end;

procedure Tfrmestabe.DBEDataVExit(Sender: TObject);
begin
   if tbvisitasdt_visita.value > date then
   begin
        showmessage('Data da Inspecao invalida!');
        DBEDataV.setfocus;
   end;

end;

procedure Tfrmestabe.DBCtipoExit(Sender: TObject);
begin
if (tbvisitastipo.Value = 'ATO ADMINISTRATIVO DA GERENCIA') and (frmlogin.c_grp <> 'FIS') then
    tbvisitasfiscal1.value:= 'GERENTE DE VIGILANCIA SANITARIA';
end;

procedure Tfrmestabe.DBEcgcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of
        vk_escape:
            begin
{        DBECPF.Enabled  := false;
        DBECPF.Visible  := false;
        DBECGC.enabled  := true;
        DBECGC.visible := true;}
              frmlocpro.inclu := 0;
//              tbgrupo.filtered := false;
//              tbativi.Filtered := false;
              tbhistorico.Cancel;
              tbvisitas.cancel;
              tbrt.cancel;
//              tbcaracter.cancel;
              tbcontrib.cancel;
              tbsequencia.cancel;
              close;
             end;
end;

end;

procedure Tfrmestabe.FormShow(Sender: TObject);
begin
   if tbcontribpessoa.value = 'CNPJ' then
        begin
        DBECPF.Enabled  := false;
        DBECPF.Visible  := false;
        DBECGC.enabled  := true;
        DBECGC.visible := true;
        end;
     if tbcontribpessoa.value = 'CPF' then
        begin
        DBECPF.Enabled  := true;
        DBECPF.Visible  := true;
        DBECGC.enabled  := false;
        DBECGC.visible := false;
        end;

end;

procedure Tfrmestabe.BtemitenovoClick(Sender: TObject);
// var
// vasio:boolean;
begin
if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'CON') or (frmlogin.c_grp = 'DEN') then
begin
 showmessage('Perfil nao autorizado!');
 exit;
end;

   ValidarCNAESIM;
  if ExisteDivergenciaCNAE then
  begin
    if frmlogin.c_grp = 'ADM' then
      begin
        if MessageDlg(
           'Atencao: os CNAEs do CVS divergem do arquivo do SIM.' + #13#10 +
           'Confirma a emissao do alvara assim mesmo?',
           mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         Exit;
      end
      else
      begin
         ShowMessage('Emissao bloqueada. Os CNAEs do CVS divergem do arquivo do SIM. Verifique a aba Complementar.');
         Exit;
      end;
    end;
{if (tbalvaratipo.Value = true) and (frmlogin.c_grp <> 'ADM') then
begin
 showmessage('Usuario nao autorizado a emitir alvara provisorio!');
 exit;
end;         }
  tbrt.First;
  while not tbrt.Eof do
  begin
   //   if tbrtsubclasse.isnull then vasio:= true;
//      if vasio = true then
     if tbrtsubclasse.isnull then 
      begin
          showmessage('Caro Usuario, favor completar a ficha CAE para todas as atividades cadastradas');
          exit;
      end;
      tbrt.Next;
  end;

        if (tbrt.Eof ) and (tbrt.Bof) then
        begin
            showmessage('Caro Usuario, favor preencher a ficha CAE');
            exit;
        end;

if (tbalvara.Eof) and (tbalvara.bof) then
begin
 showmessage('Exercicio nao requerido!');
 exit;
end;

if (tbalvlib.eof) and (tbalvlib.bof)  then
begin
 showmessage('Nao existe atividade liberada para o exercicio!');
 exit;
end;

if not tbalvaradt_emite.isnull then
begin
    showmessage('Alvara ja Emitido!');
    exit;
end;

{if tbalvaralibera.value <> true then
begin
 showmessage('Alvara nao liberado para o exercicio!');
 exit;
end;}

{if tbalvaranumero.value > 0 then
begin
    showmessage('Alvara ja expedido. Escolha Reemissao!');
    exit;
end;}

painel:= 'alvara';
lugar:= tbcontribcontrole.value;
{tbsequencia.edit;
tbalvara.edit;
tbsequenciaalvara.value:=tbsequenciaalvara.Value+1;
tbalvaranumero.value:=tbsequenciaalvara.value;
tbsequencia.post;}
tbalvara.edit;
tbalvaradt_emite.value := date;
tbalvaraemitente.value := frmlogin.c_user;
randomize;
tbalvaraautenticador.value:=inttohex(random(10000000000),10);
//modelo codigo 2018
//if tbalvaratipo.Value   = true then tbalvaradt_validade.Value:=date+59 else tbalvaradt_validade.Value:=date+364;
//if tbalvaraevento.Value = true then tbalvaradt_validade.Value:=date+29 else tbalvaradt_validade.Value:=date+364;

if tbalvaratipo.Value   = true then tbalvaradt_validade.Value:=date+59 else
if tbalvaraevento.Value = true then tbalvaradt_validade.Value:=date+29 else tbalvaradt_validade.Value:=date+364;


tbalvara.post;
frmalvnovo.tbcontrib.open;
frmalvnovo.tbbairro.open;
frmalvnovo.tbativ.open;
frmalvnovo.tbrt.open;
frmalvnovo.tbalvara.open;
frmalvnovo.tbalvlib.open;
frmalvnovo.tbgrupo.open;
frmalvnovo.tbcnae.open;
  frmalvnovo.tbrt.findkey([tbrtcontrole.value]);
  frmalvnovo.tbalvara.findkey([tbalvaracontrole.value]);
  frmalvnovo.tbcontrib.findkey([tbcontribcontrole.value]);
  frmalvnovo.realvara.preview;
frmalvnovo.tbcnae.close;
frmalvnovo.tbgrupo.close;
frmalvnovo.tbbairro.Close;
frmalvnovo.tbrt.Close;
frmalvnovo.tbalvlib.close;
frmalvnovo.tbalvara.Close;
frmalvnovo.tbcontrib.Close;
frmalvnovo.Close;
//tbalvara.edit;
//tbalvaradt_emite.Value:=date;
//tbalvara.post;
//tbalvara.edit;
// tbalvaraemitente.value := frmlogin.c_user;
//tbalvaradt_emite.value := date;
//tbalvara.post;

end;

procedure Tfrmestabe.BtreemiteClick(Sender: TObject);
var
vasio:boolean;
begin
if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'CON') or (frmlogin.c_grp = 'DEN') then
begin
 showmessage('Perfil nao autorizado!');
 exit;
end;

  ValidarCNAESIM;
  if ExisteDivergenciaCNAE then
  begin
    if frmlogin.c_grp = 'ADM' then
      begin
        if MessageDlg(
           'Atencao: os CNAEs do CVS divergem do arquivo do SIM.' + #13#10 +
           'Confirma a reemissao do alvara assim mesmo?',
           mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         Exit;
      end
      else
      begin
         ShowMessage('Reemissao bloqueada. Os CNAEs do CVS divergem do arquivo do SIM. Verifique a aba Complementar.');
         Exit;
      end;
    end;

  vasio:= false;
  tbrt.First;

  while not tbrt.Eof do
  begin
      if tbrtsubclasse.isnull then vasio:= true;
      if vasio = true then
      begin
          showmessage('Caro Usuario, favor completar a ficha CAE para todas as atividades cadastradas');
          exit;
      end;
      tbrt.Next;
  end;


        if (tbrt.Eof ) and (tbrt.Bof) then
        begin
            showmessage('Caro Usuario, favor preencher a ficha CAE');
            exit;
        end;

if (tbalvara.Eof) and (tbalvara.bof) then
begin
 showmessage('Alvara nao requerido para o exercicio!');
 exit;
end;

if (tbalvlib.eof) and (tbalvlib.bof)  then
begin
 showmessage('Nao existe atividade liberada para o exercicio!');
 exit;
end;

if tbalvaradt_emite.IsNull then
begin
    showmessage('Alvara nao Emitido!');
    exit;
end;


painel:= 'alvara';
lugar:= tbcontribcontrole.value;
{tbalvara.edit;
tbsequencia.edit;
tbsequenciaalvara.value:=tbsequenciaalvara.Value+1;
tbalvaranumero.value:=tbsequenciaalvara.value;
tbsequencia.post; }
//tbalvara.edit;
//randomize;
//tbalvaraautenticador.value:=inttohex(random(10000000000),10);
// tbalvara.post;
frmalvnovo.tbcontrib.open;
frmalvnovo.tbgrupo.open;
frmalvnovo.tbbairro.open;
frmalvnovo.tbativ.open;
frmalvnovo.tbrt.open;
frmalvnovo.tbalvara.open;
frmalvnovo.tbalvlib.open;
frmalvnovo.tbcnae.open;
//frmalvnovo.tbalvlib.filter:='alvara= '+inttostr(tbalvaranumero.value);
  frmalvnovo.tbrt.findkey([tbrtcontrole.value]);
  frmalvnovo.tbalvara.findkey([tbalvaracontrole.value]);
  frmalvnovo.tbcontrib.findkey([tbcontribcontrole.value]);
  frmalvnovo.realvara.preview;
frmalvnovo.tbgrupo.close;
frmalvnovo.tbbairro.Close;
frmalvnovo.tbrt.Close;
frmalvnovo.tbcnae.close;
frmalvnovo.tbalvlib.close;
frmalvnovo.tbalvara.Close;
frmalvnovo.tbcontrib.Close;
frmalvnovo.Close;
tbalvara.edit;
tbalvarareemitente.value := frmlogin.c_user;
tbalvaradt_reemite.value := date;
tbalvara.post;


end;

procedure Tfrmestabe.btnovocaeClick(Sender: TObject);
begin
  if (frmlogin.c_grp = 'FIS') or
     (frmlogin.c_grp = 'ADM') or
     (frmlogin.c_grp = 'CAD')
  then
  begin
      tbauxrt.First;
      while not tbauxrt.Eof do
      begin
          if (tbauxrtsubclasse.isnull) then
          begin
             showmessage('Ha pelo menos uma atividade economica cadastrada com a subclasse nao informada. Selecione alterar e complete o cadastro antes de incluir outra atividade economica!');
             exit;
          end;
          tbauxrt.Next;
      end;
      tbrt.insert;
      dblsub.setfocus;
  end
  else showmessage('Perfil Nao Autorizado!');
end;

procedure Tfrmestabe.btaltcaeClick(Sender: TObject);
begin
  if (frmlogin.c_grp = 'FIS') or
     (frmlogin.c_grp = 'ADM') or
     (frmlogin.c_grp = 'CAD')
  then
  begin
    tbrt.edit;
    dblsub.setfocus;
  end
  else showmessage('Perfil Nao Autorizado!');

end;

procedure Tfrmestabe.btcancelcaeClick(Sender: TObject);
begin
tbrt.cancel;
end;

procedure Tfrmestabe.btdelecaeClick(Sender: TObject);
begin
  if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'CAD') then
  begin
      if messagedlg('Confirma a Exclusao da Atividade: '+#13+tbrtsubclasse.value+' - '+tbcnaeatividade.value+'?',mtconfirmation,[mbyes,mbno],0)=mryes then tbrt.delete;
  end
  else showmessage('Perfil Nao Autorizado!');

end;

procedure Tfrmestabe.btgravacaeClick(Sender: TObject);
begin

  if tbrtsubclasse.isnull  then
  begin
     showmessage('Favor informar o codigo CNAE!');
     exit;
  end;

  if (tbrttipo.Value <> 'Principal') and (tbrttipo.Value <> 'Secundaria')then
  begin
     showmessage('Favor selecionar se a Atividade a Principal ou Secundaria!');
     exit;
  end;

  tbauxrt.refresh;
  tbauxrt.First;
  while not tbauxrt.Eof do
  begin
      if (tbrtsubclasse.Value = tbauxrtsubclasse.value) and (tbrtcontrole.value <> tbauxrtcontrole.value) then
      begin
          showmessage('Atividade ja cadastrada para contribuinte!');
          exit;
      end;
      if (tbrttipo.value = 'Principal') and (tbauxrttipo.value = 'Principal') and (tbrtcontrole.value <> tbauxrtcontrole.value) then
      begin
          showmessage('Atividade Principal ja cadastrada para contribuinte!');
          exit;
      end;
      tbauxrt.Next;
  end;
  tbrt.post;

end;

procedure Tfrmestabe.dsrtStateChange(Sender: TObject);
begin
    btnovocae.Enabled    := tbrt.state = dsbrowse;
    btaltcae.Enabled     := tbrt.state = dsbrowse;
    btdelecae.Enabled    := tbrt.state = dsbrowse;
    btgravacae.Enabled   := tbrt.state <> dsbrowse;
    btcancelcae.Enabled  := tbrt.State <> dsbrowse;
    BtSinc.Enabled       := tbrt.state = dsbrowse;
    dbnavcae.Enabled     := tbrt.state = dsbrowse;
    barraferra.enabled   := tbrt.state = dsbrowse;
    if tbrt.state        <> dsbrowse then barraferra.Color := clmoneygreen;
    if tbrt.state         = dsbrowse then barraferra.Color := clBtnFace;
end;

procedure Tfrmestabe.bitdocClick(Sender: TObject);
begin
if PainelTermo.visible = true then PainelTermo.visible := false else PainelTermo.visible := true

end;

procedure Tfrmestabe.dsalvlibStateChange(Sender: TObject);
begin
btnovautor.enabled   := tbalvlib.state =  dsbrowse;
navautor.enabled     := tbalvlib.state =  dsbrowse;
btgravautor.enabled  := tbalvlib.state <> dsbrowse;
btcancautor.enabled  := tbalvlib.state <> dsbrowse;
btdelautor.enabled   := tbalvlib.state =  dsbrowse;
//btautor.enabled      := tbalvlib.state <>  dsbrowse;
barraferra.enabled   := tbalvlib.state =  dsbrowse;
painelalvara.enabled  := tbalvlib.state =  dsbrowse;
if tbalvlib.state     <> dsbrowse then barraferra.Color := clmoneygreen;
if tbalvlib.state     = dsbrowse then barraferra.Color := clBtnFace;
if tbalvlib.state     <> dsbrowse then painelalvara.Color := clmoneygreen;
if tbalvlib.state     = dsbrowse then painelalvara.Color := clBtnFace;
end;

procedure Tfrmestabe.btnovautorClick(Sender: TObject);
var
vasio:boolean;
begin
{        if tbcontribatividade.value = 0 then
        begin
            showmessage('Caro Usuario, favor Selecionar a Atividade Economica relacionada');
            exit;
        end;    }

    if tbalvaraexercicio.value <> yearof(date) then
    begin
            if messagedlg('Atencao!!!!! Exercicio anterior. Confirma liberacao para o ano PASSADO ?  ',mtconfirmation,[mbyes,mbno],0)=mrno then  exit;
    //        showmessage('Exercicio Invalido');
//        exit;
    end;

     vasio:= false;
     tbrt.Refresh;
     tbrt.First;
     while not tbrt.Eof do
     begin
         if tbrtsubclasse.isnull then vasio:= true;
         if vasio = true then
         begin
             showmessage('Caro Usuario, favor completar a ficha CAE para todas as atividades cadastradas');
             exit;
         end;
         tbrt.Next;
     end;
  if (tbrt.Eof ) and (tbrt.Bof) then
  begin
       showmessage('Caro Usuario, favor preencher a ficha CAE');
       exit;
  end;
//  tbrt.First;
  if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM')  then
  begin
  if tbalvaranumero.value = 0 then
   begin
      tbsequencia.edit;
      tbalvara.edit;
      tbsequenciaalvara.value:=tbsequenciaalvara.Value+1;
      tbalvaranumero.value:=tbsequenciaalvara.value;
      tbsequencia.post;
      tbalvara.post;
   end;
   tbalvlib.insert;
   tbalvlibatividade.value:=tbrtsubclasse.value;    
   tbalvlibautoridade.value := frmlogin.c_user;
   tbalvlibdata.value := date;
   DBCAutoridade.setfocus;
  end
  else
  begin
     showmessage('Perfil Nao Autorizado');
     exit;
  end;

end;

procedure Tfrmestabe.btgravautorClick(Sender: TObject);
var
cae2:boolean;
digitado:boolean;
begin
  if tbalvlibatividade.isnull then
  begin
         showmessage('Caro Usuario, favor Informar a atividade a ser liberada.');
         exit;
  end;
  cae2:= false;
  tbauxrt.First;

  while not tbauxrt.Eof do
  begin
      if (tbalvlibatividade.Value = tbauxrtsubclasse.value) then cae2:=true;
      tbauxrt.Next;
  end;

  if cae2 = false then
  begin
      showmessage('Atividade Economica inexistente na ficha CAE do contribuinte!');
      exit;
  end;

 {     if inttostr(tbalvaraexercicio.Value) <> formatdatetime('yyyy',tbalvlibData.Value) then
      begin
         showmessage('Exercicio da liberacao diferente do exercicio requerido');
         exit;
         DBEDtlibera.setfocus;
      end;
         }

  if tbcnaecomplexidade.Value <> 'BAIXA' then
  begin

          if tbalvlibliberante.IsNull then
          begin
              showmessage('Atencao! Informar a autoridade que liberou a atividade economica');
              DBCAutoridade.SetFocus;
              exit;
          end;

          if tbalvlibDocumento.IsNull then
          begin
              showmessage('Atencao! Informar O documento de liberacao da atividade economica');
              DBCAutoridade.SetFocus;
              exit;
          end;

          if tbalvlibDt_documento.IsNull then
          begin
              showmessage('Atencao! Informar a data da liberacao da atividade economica');
              DBCAutoridade.SetFocus;
              exit;
          end;

          tbvisitas.First;
          digitado :=false;
          while not tbvisitas.Eof do
          begin
             if tbalvlibdt_documento.Value = tbvisitasdt_visita.value then
             begin
                 if (tbalvlibliberante.Value = tbvisitasfiscal1.value) or (tbalvlibliberante.Value = tbvisitasfiscal2.value) or (tbalvlibliberante.Value = tbvisitasfiscal3.value) then
                 begin
                     if tbalvlibdocumento.Value = tbvisitasnumero.Value then
                     begin
      //                 if (tbvisitaslibera.Value = 'Liberado') or (tbvisitaslibera.Value = 'Alguns CNAEs') then showmessage('ok');
                         if (tbvisitaslibera.Value = 'Nao Liberado') then
                         begin
                             showmessage('Atencao! A Autoridade Sanitaria relatou nao conformidade na inspecao')
                         end;
                         digitado := true;
                     end;
                 end;
             end;
          tbvisitas.Next;
          end;
          if digitado = false then showmessage ('Atencao!!! Documento de liberacao da atividade economica nao localizado. Click em Ok para continuar ...');

  end
  else showmessage('Baixa Complexidade. Liberacao Automatica');

tbauxlib.Refresh;
tbauxlib.first;
while not tbauxlib.eof do
begin
    if (tbauxlibcontrole.value <> tbalvlibcontrole.value) and
       (tbauxlibatividade.value = tbalvlibatividade.value) then
    begin
      showmessage('Atividade Economica ja liberada para o exercicio!');
      exit;
    end;
    tbauxlib.next;
end;

   tbalvlib.post;
   showmessage('Autorizacao de Atividade Concluida!');
end;

procedure Tfrmestabe.btcancautorClick(Sender: TObject);
begin
tbalvlib.Cancel;
end;

procedure Tfrmestabe.btdelautorClick(Sender: TObject);
begin
     if messagedlg('Confirma a Exclusao da Atividade: '+tbalvlibatividade.value+#13+' do Alvara: '+tbalvaranumero.AsString + ' de '+tbalvaraexercicio.AsString +'?',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin
             if (frmlogin.c_grp = 'ADM') then
             begin
                 if not tbalvaradt_emite.isnull then
                 begin
                     showmessage('Nao a possovel excluir. Alvara ja emitido!');
                     exit;
                 end;
                 if not tbalvlib.Eof then tbalvlib.Delete else showmessage('Nao Ha Atividade Liberada para este Contribuinte!');
             end
             else showmessage('Exclusao nao autorizada');
     end;
end;

procedure Tfrmestabe.DBComboBox1Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;
procedure Tfrmestabe.navveiculoClick(Sender: TObject;
  Button: TNavigateBtn);
begin
DBEDuaveic.setfocus
end;

procedure Tfrmestabe.dsveiculoStateChange(Sender: TObject);
begin
//        DBCAutoriza.enabled      := tbveiculo.state <> dsbrowse;
        btnovoveiculo.enabled    := tbveiculo.state =  dsbrowse;
        Btalteraveiculo.enabled  := tbveiculo.state =  dsbrowse;
        btgravaveiculo.enabled   := tbveiculo.state <> dsbrowse;
        btcancelaveiculo.enabled := tbveiculo.state <> dsbrowse;
        btdeletaveiculo.enabled  := tbveiculo.state =  dsbrowse;
        btemite.enabled          := tbveiculo.state =  dsbrowse;
       if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'FIS') then btliberav.Enabled := tbveiculo.state=dsbrowse;
        btimprime.enabled        := tbveiculo.state =  dsbrowse;
        barraferra.enabled       := tbveiculo.state =  dsbrowse;
        navveiculo.enabled       := tbveiculo.state =  dsbrowse;
        if tbveiculo.state       <> dsbrowse then barraferra.Color := clmoneygreen;
        if tbveiculo.state        = dsbrowse then barraferra.Color := clBtnFace;
end;

procedure Tfrmestabe.btnovoveiculoClick(Sender: TObject);
begin
 if (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'ADM') then
 begin
   tbsequencia.edit;
   tbsequenciaveiculo.value:=tbsequenciaveiculo.Value+1;
   tbsequencia.post;
   tbveiculo.last;
   tbveiculo.insert;
   tbveiculonumero.value          :=tbsequenciaveiculo.value;
   tbveiculodt_req.value          := date;
   tbveiculoexercicio.value       := yearof(date);
   tbveiculoresponsavel_req.value :=frmlogin.c_user;
   tbveiculoautorizacao.Value     :=false;
   DBEDuaveic.setfocus;
 end
 else showmessage('Perfil nao autorizado!');

end;

procedure Tfrmestabe.BtalteraveiculoClick(Sender: TObject);
begin
if (frmlogin.c_grp <> 'CON') then
begin
        tbveiculo.edit;
        DBEDuaveic.setfocus;
end
else showmessage('Perfil nao autorizado');
end;

procedure Tfrmestabe.btgravaveiculoClick(Sender: TObject);
begin
        if tbveiculoexercicio.isnull = true  then
        begin
            showmessage('Caro Usuario, favor informar o Exercicio Fiscal');
            exit;
        end;
{      if (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'CON') then
      begin
        if tbveiculoautorizacao.Value = true then
          begin
            showmessage('Usuario nao autorizado a liberacao veicular!');
            exit;
          end;
      end;}
        tbveiculo.post;
        btimprime.setfocus;
end;

procedure Tfrmestabe.btcancelaveiculoClick(Sender: TObject);
begin
      tbveiculo.Cancel;
      btimprime.setfocus;
end;

procedure Tfrmestabe.btdeletaveiculoClick(Sender: TObject);
begin
     if messagedlg('Confirma a Exclusao do Alvara '+tbveiculoexercicio.AsString +' do Veiculo '+ tbveiculomarca.value + ' Placa '+ tbveiculoplaca.value + '?',mtconfirmation,[mbyes,mbno],0)=mryes then
     begin
             if (frmlogin.c_grp = 'ADM') then
             begin
                 if not tbveiculo.Eof then tbveiculo.Delete else showmessage('Nao Ha Alvara Veicular Solicitado para este Contribuinte!');
             end
             else showmessage('Exclusao nao autorizada');
     end;
     btimprime.setfocus;
end;

procedure Tfrmestabe.btemiteClick(Sender: TObject);
begin

    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'CON') or (frmlogin.c_grp = 'DEN') then
    begin
      showmessage('Perfil nao autorizado!');
      exit;
    end;

    if (tbveiculo.Eof) and (tbveiculo.bof) then
    begin
       showmessage('Alvara Veicular nao requerido!');
       exit;
    end;

    if tbveiculoautorizacao.Value <> true then
    begin
      showmessage('Alvara Veicular nao autorizado!');
      exit;
    end;

    if not tbveiculodt_emite.isnull then
    begin
        showmessage('Alvara ja Emitido!');
        exit;
    end;

    painel := 'veiculo';
    lugar  := tbcontribcontrole.value;

        tbveiculo.edit;
        tbveiculodt_emite.value := date;
        tbveiculoemissor.value := frmlogin.c_user;
        randomize;
        tbveiculoatenticador.value:=inttohex(random(10000000000),10);
        //modelo codigo 2018
        tbveiculodt_validade.Value:=date+364;
        tbveiculo.post;
        frmalveicular.tbcontrib.open;
        frmalveicular.tbveiculo.open;
        frmalveicular.tbbairro.Open;
        frmalveicular.tbveiculo.findkey([tbveiculocontole.value]);
        frmalveicular.tbcontrib.findkey([tbcontribcontrole.value]);
        frmalveicular.realveic.preview;
        frmalveicular.tbbairro.close;
        frmalveicular.tbveiculo.Close;
        frmalveicular.tbcontrib.Close;
        frmalveicular.Close;
end;

procedure Tfrmestabe.btimprimeClick(Sender: TObject);
begin
// showmessage('em desenvolvimento');

    if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'CON') or (frmlogin.c_grp = 'DEN') then
    begin
      showmessage('Perfil nao autorizado!');
      exit;
    end;

    if (tbveiculo.Eof) and (tbveiculo.bof) then
    begin
       showmessage('Alvara Veicular nao requerido!');
       exit;
    end;

    if tbveiculoautorizacao.Value <> true then
    begin
      showmessage('Alvara Veicular nao autorizado!');
      exit;
    end;

    painel := 'veiculo';
    lugar  := tbcontribcontrole.value;

        tbveiculo.edit;
        tbveiculodt_impressao.value   := date;
        tbveiculoimpressao.value      := frmlogin.c_user;
//        randomize;
//        tbveiculoatenticador.value:=inttohex(random(10000000000),10);
//        tbveiculodt_validade.Value:=date+364;
        tbveiculo.post;
        frmalveicular.tbcontrib.open;
        frmalveicular.tbveiculo.open;
        frmalveicular.tbbairro.Open;
        frmalveicular.tbveiculo.findkey([tbveiculocontole.value]);
        frmalveicular.tbcontrib.findkey([tbcontribcontrole.value]);
        frmalveicular.realveic.preview;
        frmalveicular.tbbairro.close;
        frmalveicular.tbveiculo.Close;
        frmalveicular.tbcontrib.Close;
        frmalveicular.Close;

end;

procedure Tfrmestabe.DBEReqveicExit(Sender: TObject);
begin
   if formatdatetime('yyyy',tbveiculoDt_req.value) <> formatdatetime('yyyy',date) then
   begin
        showmessage('Data do Requerimento invalida!');
        DBEReqveic.setfocus;
   end;
end;

procedure Tfrmestabe.DBCAutorizaExit(Sender: TObject);
begin
{      if (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'CON') then
      begin
        if tbveiculoautorizacao.Value = true then
          begin
            showmessage('Usuario Nao autorizado a liberacao veicular!');
            DBCAutoriza.SetFocus;
          end;
      end;}
end;

procedure Tfrmestabe.DBCProvisorioExit(Sender: TObject);
begin
{        if (frmlogin.c_grp <> 'ADM') and (tbalvaratipo.Value = true) then
        begin
          showmessage('Usuario nao autorizado a liberacao de Alvara Provisorio!');
           DBCProvisorio.SetFocus;
        end;}
end;

procedure Tfrmestabe.BtliberavClick(Sender: TObject);
begin

  if (frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM')  then
  begin
      if tbveiculoautorizacao.Value = true then showmessage('Alvara Veicular Ja Liberado')
      else
      begin
          if messagedlg('Confirma a Liberacao do Alvara '+tbveiculoexercicio.AsString +' para o Veiculo '+ tbveiculomarca.value + ' Placa '+ tbveiculoplaca.value + '?',mtconfirmation,[mbyes,mbno],0)=mryes then
             begin
                 tbveiculo.edit;
                 tbveiculoautorizacao.Value := true;
                 tbveiculoautorizante.Value := frmlogin.c_user;
                 tbveiculodt_autor.value    := date;
                 tbveiculo.post;
                 btimprime.setfocus;
             end;
      end;
  end
  else
  begin
     showmessage('Perfil Nao Autorizado');
     exit;
  end;



end;

procedure Tfrmestabe.BtprovisorioClick(Sender: TObject);
begin
  if (frmlogin.c_grp = 'ADM') then
  begin

      tbalvara.last;
      if tbalvaraexercicio.value = yearof(date) then
      begin
          if not tbalvaradt_emite.isnull then
          begin
                 showmessage('Ja existe Alvara emitido para o contribuinte no exercicio');
                 exit;
          end;
      end;

   if not tbalvaraexercicio.value = yearof(date) then
   begin
        showmessage('impossovel emitir alvara provisorio para este exercicio');
        exit;
   end;

      if messagedlg('Confirma a Liberacao Provisoria para o Contribuinte'+#13+tbcontribRAZAO.value+'?',mtconfirmation,[mbyes,mbno],0)=mryes then
      begin
              tbalvara.edit;
              tbalvaratipo.Value:=true;
              tbalvara.Post;
              showmessage('Alvara Provisorio Liberado');
      end;
  end
  else
  begin
        showmessage('Perfil Nao autorizado');
        exit;
  end;
end;

procedure Tfrmestabe.BteventoClick(Sender: TObject);
begin
  if (frmlogin.c_grp = 'ADM') then
  begin
      tbalvara.last;
      if tbalvaraexercicio.value = yearof(date) then
      begin
          if not tbalvaradt_emite.isnull then
          begin
             showmessage('Ja existe Alvara emitido para o contribuinte no exercicio');
             exit;
          end;
      end;

   if not tbalvaraexercicio.value = yearof(date) then
   begin
        showmessage('impossovel emitir alvara eventual para este exercicio');
        exit;
   end;

      if messagedlg('Confirma a Liberacao de Alvara de Evento para o Contribuinte'+#13+tbcontribRAZAO.value+'?',mtconfirmation,[mbyes,mbno],0)=mryes then
      begin
              tbalvara.edit;
              tbalvaraevento.Value :=true;
              tbalvara.Post;
              showmessage('Alvara Eventual Liberado');
      end;
  end                                                                       
  else
  begin
        showmessage('Perfil Nao autorizado');
        exit;
  end;
end;

procedure Tfrmestabe.DBEValExit(Sender: TObject);
begin
//   if formatdatetime('yyyy',tbalvaraDt_validade.value) <> formatdatetime('yyyy',date) then
//  begin
//       showmessage('Data da Validade invalida!');
//        DBEDtreq.setfocus;
//   end;

end;

procedure Tfrmestabe.btprndocClick(Sender: TObject);
begin
     painel:= 'documento';
     rel_visita.tbestabe.open;
     rel_visita.tbvisita.open;
     rel_visita.tbhistorico.open;
     rel_visita.tbbairro.open;
          rel_visita.tbvisita.findkey([tbvisitascontrole.value]);
     rel_visita.tbestabe.findkey([tbcontribcontrole.value]);
     rel_visita.tbhistorico.findkey([tbhistoricocontrole.value]);
     rel_visita.QRvisita.preview;
     rel_visita.tbbairro.close;
     rel_visita.tbhistorico.close;
     rel_visita.tbvisita.close;
     rel_visita.tbestabe.close;
end;

procedure Tfrmestabe.DBCExercicioExit(Sender: TObject);
begin

{//   if inttostr(tbalvaraexercicio.Value) <> formatdatetime('yyyy',tbalvaradt_duam.Value) then
   if tbalvaraexercicio.Value < 2019 then
   begin
      showmessage('Data do Requerimento invalida - PASSADO!');
            DBCExercicio.setfocus;
   end;
  }

   if tbalvaraexercicio.Value > strtoint(formatdatetime('yyyy',date)) then
    begin
      showmessage('Data do Requerimento invalida - FUTURO!');
         DBEDuam.setfocus;
   end;
end;

procedure Tfrmestabe.DBEDtreqExit(Sender: TObject);
begin
   if tbalvaradt_duam.Value > date then
   begin
      showmessage('Data do requerimento invalida!');
      DBEDtreq.setfocus;
   end;
end;

procedure Tfrmestabe.DBEDtliberaExit(Sender: TObject);
begin
   if tbalvlibdata.Value > date then
   begin
      showmessage('Data da liberacao invalida!');
        DBEDtlibera.setfocus;
   end;
end;

{
///====== teste imagem inicio
Procedure Grava_Imagem_JPEG(tbimagem:TTable; fota:TBlobField;
Foto:TImage; Dialog:TOpenPictureDialog);
var BS:TBlobStream;
MinhaImagem:TJPEGImage;
Begin
Dialog.InitialDir := 'c:\temp';
Dialog.Execute;
if Dialog.FileName <> '' Then
Begin
if not (tbimagem.State in [dsEdit, dsInsert]) Then
tbimagem.edit;
tbimagemcodigo.value := tbvisitasndoc.value;
BS := TBlobStream.Create((fota as TBlobField), BMWRITE);
MinhaImagem := TJPEGImage.Create;
MinhaImagem.LoadFromFile(Dialog.FileName);
MinhaImagem.SaveToStream(BS);
Foto.Picture.Assign(MinhaImagem);
BS.Free;
MinhaImagem.Free;
Tbimagem.Post;
DBISaveChanges(Tbimagem.Handle);
End;
End;

procedure Tfrmestabe.btfotaClick(Sender: TObject);
begin
Grava_Imagem_JPEG(Tbimagem, tbimagemFoto, Image1, OpenPictureDialog1);
// TbClientes a o nome de alguma Tabela
// TbClientesCli_Foto a um variavel da tabela do tipo Blob
// Image1 a um componente
// OpenPictureDialog1 a o componente para abrir a figura
end;
///====== teste imagem inicio
   }

procedure Tfrmestabe.btanexaClick(Sender: TObject);
begin
// if OpenPictureDialog1.Execute then Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure Tfrmestabe.BtgravaanexoClick(Sender: TObject);
begin
//    image1.Picture.SaveToFile('\\10.171.78.11\WCVS\data\img\'+tbvisitasndoc.asstring+'.jpg');
// image1.Picture.SaveToFile('\\10.171.78.11\WCVS\data\img\'+tbvisitasndoc.asstring+'.jpg');
end;

procedure Tfrmestabe.BtexibeanexoClick(Sender: TObject);
begin
{     painel:= 'anexo';
     if fileexists('\\10.171.78.11\WCVS\data\img\'+tbvisitasndoc.asstring+'.jpg') then
        rel_doc.QRImage1.Picture.LoadFromFile('\\10.171.78.11\WCVS\data\img\'+tbvisitasndoc.asstring+'.jpg') else
        rel_doc.QRImage1.Picture.LoadFromFile('\\10.171.78.11WCVS\data\img\none.jpg') ;
     rel_doc.qrdoc.preview;
     pagecontrol1.ActivePage := tabanexo;     }
end;

procedure Tfrmestabe.PageControl1Change(Sender: TObject);
begin
 //   if pagecontrol1.activePage = TabAnexo   then showmessage('Modulo em fase de testes');
    if pagecontrol1.activePage = TabPlanta  then
    begin
//        showmessage('Atencao!!! Conferir o numero do processo (EM VERMELHO) que esta tramitando/consultanto');
        tbplanta.Filtered := false;
    end;
    if pagecontrol1.activePage = TabProjeto then
    begin
        tbplanta.Filtered := true;
        tbplanta.Filter := 'assunto='+quotedstr('PROJETO ARQUITETONICO SANITARIO');
    end;
    if pagecontrol1.activePage = TabPas then
    begin
        tbplanta.Filtered := true;
        tbplanta.Filter := 'assunto='+quotedstr('PROCESSO ADMINISTRATIVO SANITARIO');
    end;
    if pagecontrol1.activePage = TabCan then
    begin
        tbplanta.Filtered := true;
        tbplanta.Filter := 'assunto='+quotedstr('REGULARIDADE DE PRODUTO ALIMENTICIO');
    end;

        if (tbcontrib.state<>dsbrowse) or (tbrt.State<>dsbrowse) or (tbvisitas.state<>dsbrowse) or (tbhistorico.state<>dsbrowse) or (tbalvlib.state<>dsbrowse) or (tbalvara.state<>dsbrowse) or (tbveiculo.state<>dsbrowse) or (tbplanta.state<>dsbrowse) or  (tbtramitacao.state<>dsbrowse) then
    begin;
        showmessage('Atencao, salvar a edicao antes de mudar de aba. Os dados nao salvos serao perdidos. Cancelando a operacao...');
        tbtramitacao.Cancel;
        tbplanta.cancel;
        tbveiculo.Cancel;
        tbalvlib.Cancel;
        tbalvara.cancel;
        tbhistorico.cancel;
        tbvisitas.cancel;
        tbrt.cancel;
        tbcontrib.Cancel;
        exit;
    end;

end;

procedure Tfrmestabe.dsplantaStateChange(Sender: TObject);
begin
barraferra.enabled   := tbplanta.state =  dsbrowse;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'FIS') then
btregistra.Enabled      := tbplanta.state =  dsbrowse   else
btregistra.Enabled      := false;
Btandamento.enabled     := tbplanta.state =  dsbrowse;
Brgravaproto.enabled    := tbplanta.state <> dsbrowse;
Btcancelaproto.enabled  := tbplanta.state <> dsbrowse;
Btdeletaproto.enabled   := tbplanta.state =  dsbrowse;
Btprotocolo.enabled     := tbplanta.state =  dsbrowse;
Btdespacho.enabled      := tbplanta.state =  dsbrowse;
BtRemessa.enabled       := tbplanta.state =  dsbrowse;
DBNProto.Enabled        := tbplanta.state =  dsbrowse;
GBTramita.Enabled       := tbplanta.state =  dsbrowse;

end;

procedure Tfrmestabe.BtregistraClick(Sender: TObject);
begin
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'CAD') or (frmlogin.c_grp = 'FIS') then
begin
      tbsequencia.edit;
      tbplanta.Insert;
      tbsequenciaprotocolo.value:=tbsequenciaprotocolo.Value+1;
      tbsequencia.post;
      tbplantaprotocolo.value:=tbsequenciaprotocolo.value;
      tbplantadata.value := date;
      tbplantahora.Value := time;
      tbplantacarga.Value := 'PROTOCOLO';
      tbplantausuario.Value := frmlogin.c_user;

      DBCassunto.setfocus;

end
else showmessage('Perfil nao Autorizado');
end;

procedure Tfrmestabe.BtandamentoClick(Sender: TObject);
begin
  if (tbplanta.Bof) and (tbplanta.Eof) then showmessage('Nao existe protocolo pra este regulado') else
  begin
    if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'CAD') or (frmlogin.c_per = 'ORD') then
    begin
        if  (tbplantacarga.Value = 'PROTOCOLO') or (tbplantacarga.Value = 'ARQUIVO') or (tbplantacarga.Value = 'OUTRA REPARTICAO') or (tbplantacarga.Value = 'SERVICO DE NOTIFICACAO') or (tbplantacarga.Value = 'TURMA JULGADORA') or (tbplantacarga.Value = 'GERENCIA') or (tbplantacarga.Value = 'DIRETORIA') or (tbplantacarga.Value = 'NUCLEO DE ENGENHARIA') or (tbplantacarga.Value = 'NUCLEO DO PAS') or (tbplantacarga.Value = 'NUCLEO DO RPA') or (tbplantacarga.Value = frmlogin.c_user) then
        begin
            tbtramitacao.insert;
            tbtramitacaousuario.Value  := frmlogin.c_user;
            tbtramitacaodata.value     := date;
            tbtramitacaohora.Value     := time;
            DBCdescric.SetFocus;
        end
        else
            if (frmlogin.c_grp = 'ADM')  then
            begin
                showmessage('Atencao usuario administrador do sistema, o processo selecionado esta com carga para :   '+tbplantacarga.Value+'. Pra tramitacao forcada, utilize a funcao JUNTADA, informe o despacho justificando o motivo da quebra de fluxo processual no sistema e anexe-o ao processo fisico, .');
               { tbtramitacao.insert;
                tbtramitacaousuario.Value  := frmlogin.c_user;
                tbtramitacaodata.value     := date;
                tbtramitacaohora.Value     := time;
                DBCdescric.SetFocus;  }
            end
            else showmessage('Somente o usuario com a carga do processo pode tramitar:   '+tbplantacarga.Value);
    end
    else
    begin
        if (frmlogin.c_grp = 'FIS')  then
        begin
            if (tbplantacarga.Value = 'PROTOCOLO') or (tbplantacarga.Value = frmlogin.c_user) then
            begin
                tbtramitacao.insert;
                tbtramitacaousuario.Value  := frmlogin.c_user;
                tbtramitacaodata.value     := date;
                tbtramitacaohora.Value     := time;
                DBCdescric.SetFocus;
           end
           else
           showmessage('A carga do processo nao esta com o usuario');
        end;
    end;
  end;
end;

procedure Tfrmestabe.BrgravaprotoClick(Sender: TObject);
begin
    if tbplanta.state <> dsbrowse then
    begin
          if tbplantaassunto.IsNull then
          begin
             showmessage('Obrigaterio Escolher o Assunto');
             dbcassunto.SetFocus;
             exit;
          end;
          if tbplantacomplemento.IsNull then
          begin
              showmessage('Obrigaterio Informacoes Complementrares do Processo');
              DBCcomplemento.SetFocus;
              exit;
          end;

          if tbplantaprotocolante.IsNull then
          begin
              showmessage('Obrigaterio Informar o nome completo da pessoa que esta dando entrada no processo');
              DBEptnome.SetFocus;
              exit;
          end;

          if tbplantadocumento.IsNull then
          begin
              showmessage('Obrigaterio Informar um documento de identificacao da pessoa que esta dando entrada no processo');
              DBEdoc.SetFocus;
              exit;
          end;

          if tbplantacelular.IsNull then
          begin
              showmessage('Obrigaterio Informar o celular da pessoa que esta dando entrada no processo');
              DBEcelular.SetFocus;
              exit;
          end;

          tbplanta.Post;
      end;

    if tbtramitacao.state <> dsbrowse then
    begin
        if tbtramitacaodescricao.IsNull then
          begin
             showmessage('Obrigaterio Selecioanr a Descricao da fase');
             DBCdescric.SetFocus;
             exit;
          end;
          if tbtramitacaodestino.IsNull then
          begin
             showmessage('Obrigaterio Selecionar a destinacao do processo');
             DBCdestino.SetFocus;
             exit;
          end;

          if juntada = true then
          begin
                if tbtramitacaojuntada.isnull then
                begin
                    showmessage('Obrigaterio Informar o documento que esta sendo juntado ao processo');
                    DBCJuntada.SetFocus;
                    exit;
                end;
                if tbtramitacaointeressado.IsNull then
                begin
                    showmessage('Obrigaterio Informar o nome da pessoa que esta juntando documento ao processo');
                    DBEInteressado.SetFocus;
                    exit;
                end;
                if (tbtramitacaojuntada.Value = 'Despacho da Gerencia') and (frmlogin.c_grp <> 'ADM') then
                begin
                  showmessage('Opcao invalida para o perfil');
                  DBCJuntada.SetFocus;
                  exit;
                end;
          end;
          DBCJuntada.Enabled         := false;
          DBEInteressado.enabled     := false;
          tbtramitacao.post;
          juntada := false;
          tbplanta.edit;
          tbplantausuario.Value      := frmlogin.c_user;
          tbplantacarga.Value        := tbtramitacaodestino.Value;
          tbplanta.Post;
    end;
{          tbplanta.edit;
          tbplantausuario.Value      := frmlogin.c_user;
          tbplantacarga.Value        := tbtramitacaodestino.Value;
          tbplanta.Post;   }

    end;

procedure Tfrmestabe.BtcancelaprotoClick(Sender: TObject);
begin
    if tbplanta.state <> dsbrowse then tbplanta.cancel;
    if tbtramitacao.state <> dsbrowse then tbtramitacao.Cancel;
     DBCJuntada.Enabled         := false;
     DBEInteressado.enabled     := false;
//    juntada := false;
end;

procedure Tfrmestabe.BtdeletaprotoClick(Sender: TObject);
begin
    showmessage('funcao nao permitida para o perfil');
end;

procedure Tfrmestabe.dstramitacaoStateChange(Sender: TObject);
begin
barraferra.enabled   := tbtramitacao.state =  dsbrowse;
if (frmlogin.c_grp = 'ADM') or (frmlogin.c_grp = 'CAD')  or (frmlogin.c_grp = 'FIS') then
btregistra.Enabled      := tbtramitacao.state =  dsbrowse   else
btregistra.Enabled      := false;
Btandamento.enabled     := tbtramitacao.state =  dsbrowse;
Brgravaproto.enabled    := tbtramitacao.state <> dsbrowse;
Btcancelaproto.enabled  := tbtramitacao.state <> dsbrowse;
Btdeletaproto.enabled   := tbtramitacao.state =  dsbrowse;
Btprotocolo.enabled     := tbtramitacao.state =  dsbrowse;
Btdespacho.enabled      := tbtramitacao.state =  dsbrowse;
BtRemessa.enabled       := tbtramitacao.state =  dsbrowse;
DBGTramita.Enabled      := tbtramitacao.state =  dsbrowse;
DBNProto.Enabled        := tbtramitacao.state =  dsbrowse;

end;



procedure Tfrmestabe.BtRemessaClick(Sender: TObject);
begin
  if (tbtramitacao.Bof) and (tbtramitacao.Eof) then showmessage('Nao existe tramitacao pra este regulado') else
  begin
    if tbtramitacaousuario.Value <> frmlogin.c_user then showmessage('Somento o usuario que tramita pode emitir o termo de resssa') else
    begin
      if tbtramitacaojuntada.IsNull then
      begin
          painel := 'protocolo';
          rel_remessa.tbcontrib.open;
          rel_remessa.tbplanta.open;
          rel_remessa.tbtramitacao.open;
          rel_remessa.tbbairro.open;
          rel_remessa.tbcontrib.FindKey([tbcontribcontrole.value]);
          rel_remessa.tbplanta.FindKey([tbplantacontrole.value]);
          rel_remessa.tbtramitacao.FindKey([tbtramitacaocontrole.value]);
          rel_remessa.repremessa.preview;
          rel_remessa.tbtramitacao.close;
          rel_remessa.tbbairro.close;
          rel_remessa.tbplanta.close;
          rel_remessa.tbcontrib.close;
          dbnproto.setfocus;
      end
      else showmessage('O Registro selecionado nao a uma Tramitacao. a uma juntada de documentos');
    end;
  end;
end;

procedure Tfrmestabe.DBCdestinoChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCdescricChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCcomplementoChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCassuntoChange(Sender: TObject);
begin
      perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.BtdespachoClick(Sender: TObject);
begin
//showmessage('Funcao em desenvolvimento');
if (tbplanta.Bof) and (tbplanta.Eof) then showmessage('Nao existe protocolo pra este regulado') else
    begin
        if (frmlogin.c_grp = 'CAD') then
        begin
          if (tbplantacarga.IsNull) or (tbplantacarga.Value = frmlogin.c_user) or (tbplantacarga.Value = 'ARQUIVO') or (tbplantacarga.Value = 'OUTRA REPARTICAO') or (tbplantacarga.Value = 'SERVICO DE NOTIFICACAO') or (tbplantacarga.Value = 'TURMA JULGADORA') or (tbplantacarga.Value = 'GERENCIA') or (tbplantacarga.Value = 'DIRETORIA') or (tbplantacarga.Value = 'NUCLEO DO PAS') or (tbplantacarga.Value = 'NUCLEO DE ENGENHARIA') then
          begin
            juntada := true;
            tbtramitacao.insert;
            tbtramitacaousuario.Value  := frmlogin.c_user;
            tbtramitacaodata.value     := date;
            tbtramitacaohora.Value     := time;
            DBCJuntada.Enabled         := true;
            DBEInteressado.enabled     := true;
            DBCdescric.SetFocus;
          end
          else showmessage('Processo com carga para fiscalizacao. impossovel efetuar juntada de documento');
        end
        else
        if (frmlogin.c_grp = 'ADM') then
        begin
            juntada := true;
            tbtramitacao.insert;
            tbtramitacaousuario.Value  := frmlogin.c_user;
            tbtramitacaodata.value     := date;
            tbtramitacaohora.Value     := time;
            DBCJuntada.Enabled         := true;
            DBEInteressado.enabled     := true;
            DBCdescric.SetFocus;
        end
        else showmessage('Perfil nao Autorizado');
   end;
end;

procedure Tfrmestabe.DBCJuntadaChange(Sender: TObject);
begin
 perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.BitPtJuntadaClick(Sender: TObject);
begin
  if (tbtramitacao.Bof) and (tbtramitacao.Eof) then showmessage('Nao existe tramitacao pra este regulado') else
  begin
   if (frmlogin.c_grp = 'ADM') or  (frmlogin.c_grp = 'CAD') then
   begin
     if tbtramitacaojuntada.IsNull then showmessage('O Registro selecionado nao a uma Juntada de documentos. a uma tramitacao') else
     begin
        painel := 'protocolo';
        rel_juntada.tbcontrib.open;
        rel_juntada.tbplanta.open;
        rel_juntada.tbtramitacao.open;
        rel_juntada.tbbairro.open;
        rel_juntada.tbcontrib.FindKey([tbcontribcontrole.value]);
        rel_juntada.tbplanta.FindKey([tbplantacontrole.value]);
        rel_juntada.tbtramitacao.FindKey([tbtramitacaocontrole.value]);
        rel_juntada.repjuntada.preview;
        rel_juntada.tbtramitacao.close;
        rel_juntada.tbbairro.close;
        rel_juntada.tbplanta.close;
        rel_juntada.tbcontrib.close;
        dbnproto.setfocus;
     end;
   end
   else showmessage('Perfil nao autorizado');
  end;

end;

procedure Tfrmestabe.DBCLiberaChange(Sender: TObject);
begin
          perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DBCAutoridadeChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmestabe.DbCordemExit(Sender: TObject);
begin
    if tbvisitasmodalidade.value = 'REQUERIMENTO' then DBEOs.setfocus;
    if tbvisitasmodalidade.value = 'PROTOCOLO'    then DBEProto.setfocus;
    if tbvisitasmodalidade.value = 'DENUNCIA'     then DBEDen.setfocus;
    if tbvisitasmodalidade.value = 'DE OFICIO'    then DBEOf.setfocus;
end;

procedure Tfrmestabe.DbCordemChange(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

{procedure Tfrmestabe.Button1Click(Sender: TObject);
begin
   if OpenDialog1.Execute then webbrowser1.Navigate(OpenPictureDialog1.FileName);
end;

procedure Tfrmestabe.Button2Click(Sender: TObject);
begin
   painel:= 'anexo';
   rel_doc.webbrowser1.Navigate('d:\WCVS\data\img\bi.pdf');
   rel_doc.qrdoc.preview;
   pagecontrol1.ActivePage := tabanexo;

end;   }

procedure Tfrmestabe.BtprotocoloClick(Sender: TObject);
begin
  if (tbplanta.Bof) and (tbplanta.Eof) then showmessage('Nao existe protocolo pra este regulado') else
  begin
    painel := 'protocolo';
    rel_protocolo.tbcontrib.open;
    rel_protocolo.tbplanta.open;
    rel_protocolo.tbbairro.open;
    rel_protocolo.tbcontrib.FindKey([tbcontribcontrole.value]);
    rel_protocolo.tbplanta.FindKey([tbplantacontrole.value]);
    rel_protocolo.repprotocolo.preview;
    rel_protocolo.tbbairro.close;
    rel_protocolo.tbplanta.close;
    rel_protocolo.tbcontrib.close;
    dbnproto.setfocus;
  end;

end;


procedure Tfrmestabe.BtAnexaPDFClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Arquivos PDF (*.pdf)|*.pdf';
  OpenDialog1.Title  := 'Selecione o arquivo PDF';

  if OpenDialog1.Execute then
  begin
    // Aqui voca ja tem o arquivo escolhido
    ShowMessage('Voca escolheu: ' + OpenDialog1.FileName);

    // Se voca estiver usando o AcroPDF:
   AcroPDF1.LoadFile(OpenDialog1.FileName);
  end;
end;

procedure Tfrmestabe.SalvarPDFComo(const Origem, Destino: string);
begin
  CopyFile(PChar(Origem), PChar(Destino), False);
end;

procedure Tfrmestabe.BtGrasvaPDFClick(Sender: TObject);
begin
//  SalvarPDFComo(OpenDialog1.FileName, '\\10.171.78.11\WCVS\data\pdf\'+tbvisitasndoc.asstring+'.pdf');
SalvarPDFComo(OpenDialog1.FileName, '\\192.168.1.2\WCVS\data\pdf\'+tbvisitasndoc.asstring+'.pdf');
end;



{procedure Tfrmestabe.BtMaxPDFClick(Sender: TObject);
begin
     painel:= 'anexo';
     if fileexists('\\10.171.78.11\WCVS\data\pdf\'+tbvisitasndoc.asstring+'.pdf') then
        begin
           rel_doc.AcroPDF1.LoadFile('\\10.171.78.11\WCVS\data\pdf\'+tbvisitasndoc.asstring+'.pdf');
           rel_doc.AcroPDF1.setView('Fit');
           rel_doc.AcroPDF1.setShowToolbar(False);
           rel_doc.AcroPDF1.setShowScrollbars(True);
        end
        else
        rel_doc.AcroPDF1.LoadFile('\\10.171.78.11\WCVS\data\pdf\none.pdf') ;
        rel_doc.showmodal;
     pagecontrol1.ActivePage := tabanexo;

end;  }


procedure Tfrmestabe.BtMaxPDFClick(Sender: TObject);
begin
  painel := 'anexo';

  if FileExists('\\10.171.78.11\WCVS\data\pdf\' + tbvisitasndoc.AsString + '.pdf') then
  begin
    rel_doc.AcroPDF1.LoadFile('\\192.168.1.2\WCVS\data\pdf\' + tbvisitasndoc.AsString + '.pdf');
  end
  else
  begin
    rel_doc.AcroPDF1.LoadFile('\\192.168.1.2\WCVS\data\pdf\none.pdf');
  end;

  // Configura comportamento visual
  rel_doc.AcroPDF1.Align := alClient;
  rel_doc.AcroPDF1.setView('Fit');
  rel_doc.AcroPDF1.Show;

  // Maximiza e mostra
  rel_doc.WindowState := wsMaximized;
  rel_doc.AcroPDF1.Align := alClient;
  rel_doc.BorderStyle := bsSizeable;
  rel_doc.WindowState := wsMaximized;
  rel_doc.ShowModal;

  PageControl1.ActivePage := tabAnexo;
end;

procedure Tfrmestabe.CarregarPDFAtual;
var
  caminho: string;
begin
  caminho := '\\192.168.1.2\WCVS\data\pdf\' + tbvisitasndoc.AsString + '.pdf';
  if FileExists(caminho) then
    AcroPDF1.LoadFile(caminho)
  else
    AcroPDF1.LoadFile('\\192.168.1.2\WCVS\data\pdf\none.pdf');
end;


procedure Tfrmestabe.DBNavanexosClick(Sender: TObject;
  Button: TNavigateBtn);
begin
{     if fileexists('\\192.168.1.2\WCVS\data\pdf\'+tbvisitasndoc.asstring+'.pdf') then
        begin
           AcroPDF1.LoadFile('\\192.168.1.2\WCVS\data\pdf\'+tbvisitasndoc.asstring+'.pdf');
//           AcroPDF1.setView('Fit');
//           AcroPDF1.Show;
        end
        else
        AcroPDF1.LoadFile('\\192.168.1.2\WCVS\data\pdf\none.pdf') ;
 }
  CarregarPDFAtual;

end;


procedure Tfrmestabe.BtAPIClick(Sender: TObject);
var
  Erro: string;
begin
  Screen.Cursor := crHourGlass;
  Caption := 'Exportando CVS... Aguarde';
  Application.ProcessMessages;

  try
    if not ExportarJsonCVS_Shared('WCVS', '\\192.168.1.2\wcvs\repo\docs\data\', Erro) then
    begin
      ShowMessage('Erro:' + sLineBreak + Erro);
      Exit;
    end;

    ShowMessage('Exportacao concluida!');
  finally
    Screen.Cursor := crDefault;
    Caption := 'CVS';
  end;
end;

procedure Tfrmestabe.BtAPISemClick(Sender: TObject);
var
  Erro: string;
begin
  Screen.Cursor := crHourGlass;
  Caption := 'Exportando CVS... Aguarde';
  Application.ProcessMessages;

  try
    if not ExportarJsonCVS_Menor('WCVS', '\\192.168.1.2\wcvs\repo\docs\data\', Erro) then
    begin
      ShowMessage('Erro:' + sLineBreak + Erro);
      Exit;
    end;

    ShowMessage('Exportacao concluida!');
  finally
    Screen.Cursor := crDefault;
    Caption := 'CVS';
  end;
end;



procedure Tfrmestabe.BtAPICSVClick(Sender: TObject);
var
  Erro: string;
begin
  Screen.Cursor := crHourGlass;
  Caption := 'Exportando CSVs... Aguarde';
  Application.ProcessMessages;

  try
    if not ExportarCSVsCVS('\\192.168.1.2\wcvs\repo\docs\data\',
      tbContrib, tbVisitas, tbCnae, frmlogin.tbLogin, Erro) then
    begin
      ShowMessage('Erro:' + sLineBreak + Erro);
      Exit;
    end;

    if not ExportarCSVsDocsCVS('\\192.168.1.2\wcvs\repo\docs\data\',
  tbreq, tbtramitacao, tboficio, tbdenuncia,  tbplanta,  Erro) then
begin
  ShowMessage('Erro CSV (Requerimento/Tramitacao/Oficio/Denuncia/Planta):' + sLineBreak + Erro);
  Exit;
end;

 if not ExportarCSVsExtrasCVS('\\192.168.1.2\wcvs\repo\docs\data\',
  tbRDPF, tbBairro, Erro) then
begin
  ShowMessage('Erro CSV (Extras: RDPF/Bairros):' + sLineBreak + Erro);
  Exit;
end;

if not ExportarCSVsAlvarasCVS('\\192.168.1.2\wcvs\repo\docs\data\',
  tbAlvara, tbAlvLib, Erro) then
begin
  ShowMessage('Erro CSV (Alvara/Liberacao):' + sLineBreak + Erro);
  Exit;
end;


{    // Gera TRAMITACAO ENXUTA (sobrescreve tramitacao.csv com filtro + ultimo por protocolo)
    if not ExportarTramitacaoEnxuta('\\192.168.1.2\wcvs\repo\docs\data\',
      tbtramitacao, frmlogin.tbLogin, Erro) then
    begin
      ShowMessage('Erro CSV (Tramitacao Enxuta):' + sLineBreak + Erro);
      Exit;
    end;     }

     ShowMessage('Exportacao concluida!');
  finally
    Screen.Cursor := crDefault;
    Caption := 'CVS';
  end;
end;


//==============================

procedure Tfrmestabe.InicializarPainelSIM;
begin
  if FSimStatus = nil then
  begin
    FSimStatus := TLabel.Create(Self);
    FSimStatus.Parent := GroupBox13;
    FSimStatus.Left := 8;
    FSimStatus.Top := 16;
    FSimStatus.Caption := 'API SIM: nao disponivel';
    FSimStatus.Font.Style := [fsBold];
  end;

  if FSimGrid = nil then
  begin
    FSimGrid := TStringGrid.Create(Self);
    FSimGrid.Parent := GroupBox13;
    FSimGrid.Left := 8;
    FSimGrid.Top := 34;
    FSimGrid.Width := GroupBox13.Width - 16;
    FSimGrid.Height := GroupBox13.Height - 42;
    FSimGrid.Anchors := [akLeft, akTop, akRight, akBottom];
    FSimGrid.ColCount := 3;
    FSimGrid.RowCount := 2;
    FSimGrid.FixedRows := 1;
    FSimGrid.DefaultRowHeight := 18;
    FSimGrid.Options := FSimGrid.Options - [goEditing];
    FSimGrid.ColWidths[0] := 75;
    FSimGrid.ColWidths[1] := FSimGrid.Width - 190;
    FSimGrid.ColWidths[2] := 90;
  end;
end;

procedure Tfrmestabe.LimparPainelSIM;
begin
  InicializarPainelSIM;
  FSimGrid.RowCount := 2;
  FSimGrid.Cells[0,0] := 'CNAE SIM';
  FSimGrid.Cells[1,0] := 'Descricao';
  FSimGrid.Cells[2,0] := 'Status';
  FSimGrid.Cells[0,1] := '';
  FSimGrid.Cells[1,1] := '';
  FSimGrid.Cells[2,1] := '';
  FSimDivergente := False;
end;

function Tfrmestabe.AliasPath(const AliasName: string): string;
var
  SL: TStringList;
  i: Integer;
  S: string;
begin
  Result := '';
  SL := TStringList.Create;
  try
    Session.GetAliasParams(AliasName, SL);
    for i := 0 to SL.Count - 1 do
    begin
      S := UpperCase(Trim(SL[i]));
      if Pos('PATH=', S) = 1 then
      begin
        Result := Copy(SL[i], 6, Length(SL[i]));
        Break;
      end;
    end;
  finally
    SL.Free;
  end;
end;

function Tfrmestabe.ApenasNumeros(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    if S[i] in ['0'..'9'] then
      Result := Result + S[i];
end;

function Tfrmestabe.CampoCSV(const Linha: string; Indice: Integer): string;
var
  i, CampoAtual: Integer;
  EmAspas: Boolean;
  Temp: string;
begin
  Result := '';
  Temp := '';
  CampoAtual := 0;
  EmAspas := False;

  for i := 1 to Length(Linha) do
  begin
    if Linha[i] = '"' then
      EmAspas := not EmAspas
    else if (Linha[i] = ';') and (not EmAspas) then
    begin
      if CampoAtual = Indice then
      begin
        Result := Temp;
        Exit;
      end;
      Temp := '';
      Inc(CampoAtual);
    end
    else
      Temp := Temp + Linha[i];
  end;

  if CampoAtual = Indice then
    Result := Temp;
end;

function Tfrmestabe.CaminhoSIMBruto: string;
begin
  Result := IncludeTrailingPathDelimiter(AliasPath('WCVS')) + 'SIM\cnae.csv';
end;

function Tfrmestabe.CaminhoSIMTabela: string;
begin
  Result := IncludeTrailingPathDelimiter(AliasPath('WCVS')) + 'SIMAUX.DB';
end;

const
  { Ativar True para usar base auxiliar Paradox (SIMAUX) em vez de CSV; validar em casos reais antes de padronizar }
  UseSIMTabelaAuxiliar = True;

function Tfrmestabe.PrecisaGerarSIMTabela: Boolean;
var
  DtBruto, DtTabela: Integer;
  T: TTable;
begin
  { Regenerar SIMAUX quando: tabela nao existe, tabela vazia, ou cnae.csv mais novo que a tabela }
  Result := True;
  if not FileExists(CaminhoSIMBruto) then Exit;
  if not FileExists(CaminhoSIMTabela) then Exit;

  { Tabela vazia (ex.: criada a mao ou por CriarSIMAUX) deve ser preenchida pelo cnae.csv }
  T := TTable.Create(nil);
  try
    T.DatabaseName := 'wcvs';
    T.TableName := 'SIMAUX.DB';
    try
      T.Open;
      try
        if T.IsEmpty then
          Exit;
      finally
        T.Close;
      end;
    except
      Exit;
    end;
  finally
    T.Free;
  end;

  { Detectar alteracao de data/hora do cnae.csv: se o CSV for mais novo que a tabela, regenerar }
  DtBruto := FileAge(CaminhoSIMBruto);
  DtTabela := FileAge(CaminhoSIMTabela);
  if (DtBruto <> -1) and (DtTabela <> -1) and (DtTabela >= DtBruto) then
    Result := False;
end;

function Tfrmestabe.GerarSIMTabela: Boolean;
var
  ArqIn: TextFile;
  L, SitCSV, MunCSV, CNAECSV: string;
  Bloco: TStringList;
  ListaVisa: TStringList;
  TemCnaeVisa, BlocoAtivo: Boolean;
  T: TTable;
  TabelaExiste: Boolean;
  RegCount, LinhaCount, LinhaAtual: Integer;

  procedure GravarBlocoNaTabela;
  var
    k: Integer;
    Lin: string;
  begin
    if not (BlocoAtivo and TemCnaeVisa and (Bloco.Count > 0)) then Exit;
    for k := 0 to Bloco.Count - 1 do
    begin
      Lin := Bloco[k];
      if Trim(CampoCSV(Lin, 7)) = '' then Continue;
      if UpperCase(Trim(CampoCSV(Lin, 7))) <> 'ATIVO' then Continue;
      T.Append;
      T.FieldByName('INSCRICAO').AsString := ApenasNumeros(Trim(CampoCSV(Lin, 0)));
      T.FieldByName('DOCUMENTO').AsString := ApenasNumeros(Trim(CampoCSV(Lin, 5)));
      T.FieldByName('RAZAO').AsString := Copy(Trim(CampoCSV(Lin, 2)), 1, 100);
      T.FieldByName('CNAE').AsString := Trim(CampoCSV(Lin, 3));
      T.FieldByName('ATIVIDADE').AsString := Copy(Trim(CampoCSV(Lin, 6)), 1, 254);
      T.Post;
      Inc(RegCount);
      if (RegCount mod 500 = 0) and Assigned(FSimStatus) then
      begin
        FSimStatus.Caption := 'SIM: gravando registro ' + IntToStr(RegCount) + '...';
        Application.ProcessMessages;
      end;
    end;
  end;

begin
  Result := False;
  if not FileExists(CaminhoSIMBruto) then Exit;

  if not tbcnae.Active then
  begin
    try
      tbcnae.Open;
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao abrir CNAE.DB: ' + E.Message);
        Exit;
      end;
    end;
  end;

  Bloco := TStringList.Create;
  ListaVisa := TStringList.Create;
  try
    tbcnae.First;
    while not tbcnae.Eof do
    begin
      if Trim(tbcnaeSubclasse.AsString) <> '' then
        if ListaVisa.IndexOf(Trim(tbcnaeSubclasse.AsString)) < 0 then
          ListaVisa.Add(Trim(tbcnaeSubclasse.AsString));
      tbcnae.Next;
    end;

    TabelaExiste := FileExists(CaminhoSIMTabela);

    T := TTable.Create(nil);
    try
      T.DatabaseName := 'wcvs';
      T.TableName := 'SIMAUX.DB';
      T.Exclusive := True;

      if not TabelaExiste then
      begin
        T.FieldDefs.Clear;
        T.FieldDefs.Add('CONTROLE', ftAutoInc, 0, True);
        T.FieldDefs.Add('INSCRICAO', ftString, 20, False);
        T.FieldDefs.Add('DOCUMENTO', ftString, 20, False);
        T.FieldDefs.Add('RAZAO', ftString, 100, False);
        T.FieldDefs.Add('CNAE', ftString, 20, False);
        T.FieldDefs.Add('ATIVIDADE', ftString, 254, False);
        T.IndexDefs.Clear;
        T.IndexDefs.Add('', 'CONTROLE', [ixPrimary, ixUnique]);
        T.IndexDefs.Add('PorInscricao', 'INSCRICAO', []);
        T.IndexDefs.Add('PorDocumento', 'DOCUMENTO', []);
        T.CreateTable;
      end;

      T.Open;

      if Assigned(FSimStatus) then
      begin
        FSimStatus.Caption := 'SIM: limpando tabela...';
        Application.ProcessMessages;
      end;

      while not T.IsEmpty do
        T.Delete;

      RegCount := 0;
      LinhaCount := 0;
      LinhaAtual := 0;

      AssignFile(ArqIn, CaminhoSIMBruto);
      Reset(ArqIn);
      while not EOF(ArqIn) do
      begin
        ReadLn(ArqIn, L);
        Inc(LinhaCount);
      end;
      CloseFile(ArqIn);

      if Assigned(FSimStatus) then
      begin
        FSimStatus.Caption := 'SIM: gerando tabela (' + IntToStr(LinhaCount) + ' linhas)...';
        Application.ProcessMessages;
      end;

      AssignFile(ArqIn, CaminhoSIMBruto);
      Reset(ArqIn);
      try
        if not EOF(ArqIn) then
          ReadLn(ArqIn, L);

        MunCSV := '';
        TemCnaeVisa := False;
        BlocoAtivo := False;

        while not EOF(ArqIn) do
        begin
          ReadLn(ArqIn, L);
          Inc(LinhaAtual);

          if (LinhaAtual mod 500 = 0) and Assigned(FSimStatus) then
          begin
            FSimStatus.Caption := 'SIM: processando ' + IntToStr(LinhaAtual) + ' / ' + IntToStr(LinhaCount) + ' linhas...';
            Application.ProcessMessages;
          end;

          if Trim(L) = '' then Continue;

          if ApenasNumeros(Trim(CampoCSV(L, 0))) <> MunCSV then
          begin
            GravarBlocoNaTabela;
            Bloco.Clear;
            TemCnaeVisa := False;
            BlocoAtivo := False;
            MunCSV := ApenasNumeros(Trim(CampoCSV(L, 0)));
          end;

          SitCSV := Trim(CampoCSV(L, 7));
          CNAECSV := Trim(CampoCSV(L, 3));
          if UpperCase(SitCSV) = 'ATIVO' then
            BlocoAtivo := True;
          if ListaVisa.IndexOf(CNAECSV) >= 0 then
            TemCnaeVisa := True;
          Bloco.Add(L);
        end;

        GravarBlocoNaTabela;

        if Assigned(FSimStatus) then
        begin
          FSimStatus.Caption := 'SIM: reconstruindo indices...';
          Application.ProcessMessages;
        end;

        Result := True;
      finally
        CloseFile(ArqIn);
      end;

      // Fecha e reabre em exclusivo para garantir rebuild dos indices secundarios
      T.Close;
      T.Exclusive := True;
      T.Open;
      DbiRegenIndexes(T.Handle);
      T.Close;

      if Assigned(FSimStatus) then
      begin
        FSimStatus.Caption := 'SIM: tabela atualizada (' + IntToStr(RegCount) + ' registros)';
        Application.ProcessMessages;
      end;
    finally
      T.Free;
    end;
  finally
    Bloco.Free;
    ListaVisa.Free;
  end;
end;

procedure Tfrmestabe.BtSincClick(Sender: TObject);
var
  TSim: TTable;
  DocAtual, MunAtual: string;
  AchouInscricao, AchouDocumento: Boolean;
  ListaSIMCNAE, ListaRT, ListaIncluir, ListaExcluir: TStringList;
  i: Integer;
  Msg: string;
begin
  if frmlogin.c_grp <> 'ADM' then
  begin
    ShowMessage('Perfil nao autorizado!');
    Exit;
  end;

  if not FileExists(CaminhoSIMTabela) then
  begin
    ShowMessage('Tabela SIMAUX nao encontrada. Execute a validacao na aba Complementar primeiro.');
    Exit;
  end;

  if tbcontribPESSOA.AsString = 'CNPJ' then
    DocAtual := ApenasNumeros(tbcontribCGC.AsString)
  else
    DocAtual := ApenasNumeros(tbcontribCPF.AsString);
  MunAtual := ApenasNumeros(tbcontribMUNICIPAL.AsString);

  ListaSIMCNAE := TStringList.Create;
  ListaRT := TStringList.Create;
  ListaIncluir := TStringList.Create;
  ListaExcluir := TStringList.Create;
  try
    TSim := TTable.Create(nil);
    try
      TSim.DatabaseName := 'wcvs';
      TSim.TableName := 'SIMAUX.DB';
      TSim.Open;

      AchouInscricao := False;
      AchouDocumento := False;

      if MunAtual <> '' then
      begin
        TSim.IndexName := 'PorInscricao';
        TSim.SetRangeStart;
        TSim.FieldByName('INSCRICAO').AsString := MunAtual;
        TSim.SetRangeEnd;
        TSim.FieldByName('INSCRICAO').AsString := MunAtual;
        TSim.ApplyRange;
        TSim.First;
        while not TSim.Eof do
        begin
          AchouInscricao := True;
          if ListaSIMCNAE.IndexOf(Trim(TSim.FieldByName('CNAE').AsString)) < 0 then
            ListaSIMCNAE.Add(Trim(TSim.FieldByName('CNAE').AsString));
          TSim.Next;
        end;
        TSim.CancelRange;
      end;

      if (not AchouInscricao) and (DocAtual <> '') then
      begin
        TSim.IndexName := 'PorDocumento';
        TSim.SetRangeStart;
        TSim.FieldByName('DOCUMENTO').AsString := DocAtual;
        TSim.SetRangeEnd;
        TSim.FieldByName('DOCUMENTO').AsString := DocAtual;
        TSim.ApplyRange;
        TSim.First;
        while not TSim.Eof do
        begin
          AchouDocumento := True;
          if ListaSIMCNAE.IndexOf(Trim(TSim.FieldByName('CNAE').AsString)) < 0 then
            ListaSIMCNAE.Add(Trim(TSim.FieldByName('CNAE').AsString));
          TSim.Next;
        end;
        TSim.CancelRange;
      end;

      TSim.Close;
    finally
      TSim.Free;
    end;

    if (not AchouInscricao) and (not AchouDocumento) then
    begin
      ShowMessage('Cadastro nao localizado no SIM. Verifique inscricao municipal e CNPJ/CPF.');
      Exit;
    end;

    tbrt.First;
    while not tbrt.Eof do
    begin
      if Trim(tbrtSubclasse.AsString) <> '' then
        if ListaRT.IndexOf(Trim(tbrtSubclasse.AsString)) < 0 then
          ListaRT.Add(Trim(tbrtSubclasse.AsString));
      tbrt.Next;
    end;

    for i := 0 to ListaSIMCNAE.Count - 1 do
    begin
      if tbcnae.Locate('Subclasse', ListaSIMCNAE[i], []) then
        if ListaRT.IndexOf(ListaSIMCNAE[i]) < 0 then
          ListaIncluir.Add(ListaSIMCNAE[i]);
    end;

    for i := 0 to ListaRT.Count - 1 do
    begin
      if tbcnae.Locate('Subclasse', ListaRT[i], []) then
        if ListaSIMCNAE.IndexOf(ListaRT[i]) < 0 then
          ListaExcluir.Add(ListaRT[i]);
    end;

    if (ListaIncluir.Count = 0) and (ListaExcluir.Count = 0) then
    begin
      ShowMessage('Os CNAEs do regulado ja estao atualizados conforme o SIM.');
      Exit;
    end;

    Msg := 'ATENCAO: Esta operacao so deve ser realizada apos rigorosa' + #13#10 +
           'conferencia de inscricao municipal, endereco e CNPJ/CPF.' + #13#10 + #13#10;

    if ListaIncluir.Count > 0 then
    begin
      Msg := Msg + 'CNAEs a INCLUIR no CVS:' + #13#10;
      for i := 0 to ListaIncluir.Count - 1 do
        Msg := Msg + '  + ' + ListaIncluir[i] + #13#10;
      Msg := Msg + #13#10;
    end;

    if ListaExcluir.Count > 0 then
    begin
      Msg := Msg + 'CNAEs a EXCLUIR do CVS:' + #13#10;
      for i := 0 to ListaExcluir.Count - 1 do
        Msg := Msg + '  - ' + ListaExcluir[i] + #13#10;
      Msg := Msg + #13#10;
    end;

    Msg := Msg + 'Confirma a atualizacao?';

    if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    for i := 0 to ListaIncluir.Count - 1 do
    begin
      tbrt.Append;
      tbrtCodigo.AsInteger := tbcontribCODIGO.AsInteger;
      tbrtSubclasse.AsString := ListaIncluir[i];
      tbrt.Post;
    end;

    for i := 0 to ListaExcluir.Count - 1 do
    begin
      tbrt.First;
      while not tbrt.Eof do
      begin
        if Trim(tbrtSubclasse.AsString) = ListaExcluir[i] then
        begin
          tbrt.Delete;
          Break;
        end;
        tbrt.Next;
      end;
    end;

    DbiRegenIndexes(tbrt.Handle);
    tbrt.Refresh;

    ValidarCNAESIM_Tabela;

    ShowMessage('RT atualizada com sucesso!' + #13#10 +
                IntToStr(ListaIncluir.Count) + ' CNAE(s) incluido(s), ' +
                IntToStr(ListaExcluir.Count) + ' CNAE(s) excluido(s).');
  finally
    ListaSIMCNAE.Free;
    ListaRT.Free;
    ListaIncluir.Free;
    ListaExcluir.Free;
  end;
end;

function Tfrmestabe.MascararDocumento(const Doc: string): string;
begin
  if Length(Doc) = 14 then
    Result := Copy(Doc,1,2)+'.'+Copy(Doc,3,3)+'.'+Copy(Doc,6,3)+'/'+Copy(Doc,9,4)+'-'+Copy(Doc,13,2)
  else if Length(Doc) = 11 then
    Result := Copy(Doc,1,3)+'.'+Copy(Doc,4,3)+'.'+Copy(Doc,7,3)+'-'+Copy(Doc,10,2)
  else
    Result := Doc;
end;

procedure Tfrmestabe.ValidarCNAESIM_Tabela;
var
  ListaSIMCNAE, ListaSIMDESC, ListaRT: TStringList;
  TSim: TTable;
  DocAtual, MunAtual: string;
  AchouInscricao, AchouDocumento: Boolean;
  InscricaoMatch, DocumentoMatch, RazaoMatch: string;
  i: Integer;
begin
  InicializarPainelSIM;
  LimparPainelSIM;

  if PrecisaGerarSIMTabela then
  begin
    FSimStatus.Caption := 'API SIM: atualizando tabela...';
    Application.ProcessMessages;
    if not GerarSIMTabela then
    begin
      ValidarCNAESIM;
      Exit;
    end;
  end;

  AtualizarStatusSincronizacaoSIM;

  FSimGrid.ColCount := 3;
  FSimGrid.FixedRows := 1;
  FSimGrid.RowCount := 2;
  FSimGrid.Cells[0,0] := 'CNAE SIM';
  FSimGrid.Cells[1,0] := 'Descricao';
  FSimGrid.Cells[2,0] := 'Status';
  FSimGrid.Rows[1].Clear;

  ListaSIMCNAE := TStringList.Create;
  ListaSIMDESC := TStringList.Create;
  ListaRT := TStringList.Create;

  try
    if not FileExists(CaminhoSIMTabela) then
    begin
      ValidarCNAESIM;
      Exit;
    end;

    if tbcontribPESSOA.AsString = 'CNPJ' then
      DocAtual := ApenasNumeros(tbcontribCGC.AsString)
    else
      DocAtual := ApenasNumeros(tbcontribCPF.AsString);
    MunAtual := ApenasNumeros(tbcontribMUNICIPAL.AsString);

    TSim := TTable.Create(nil);
    try
      TSim.DatabaseName := 'wcvs';
      TSim.TableName := 'SIMAUX.DB';
      TSim.Open;

      AchouInscricao := False;
      AchouDocumento := False;
      InscricaoMatch := '';
      DocumentoMatch := '';
      RazaoMatch     := '';

      if MunAtual <> '' then
      begin
        TSim.IndexName := 'PorInscricao';
        TSim.SetRangeStart;
        TSim.FieldByName('INSCRICAO').AsString := MunAtual;
        TSim.SetRangeEnd;
        TSim.FieldByName('INSCRICAO').AsString := MunAtual;
        TSim.ApplyRange;
        TSim.First;
        while not TSim.Eof do
        begin
          AchouInscricao := True;
          if InscricaoMatch = '' then
          begin
            InscricaoMatch := Trim(TSim.FieldByName('INSCRICAO').AsString);
            DocumentoMatch := Trim(TSim.FieldByName('DOCUMENTO').AsString);
            RazaoMatch     := Trim(TSim.FieldByName('RAZAO').AsString);
          end;
          i := ListaSIMCNAE.IndexOf(Trim(TSim.FieldByName('CNAE').AsString));
          if i < 0 then
          begin
            ListaSIMCNAE.Add(Trim(TSim.FieldByName('CNAE').AsString));
            ListaSIMDESC.Add(Trim(TSim.FieldByName('ATIVIDADE').AsString));
          end
          else if (Trim(ListaSIMDESC[i]) = '') and (Trim(TSim.FieldByName('ATIVIDADE').AsString) <> '') then
            ListaSIMDESC[i] := Trim(TSim.FieldByName('ATIVIDADE').AsString);
          TSim.Next;
        end;
        TSim.CancelRange;
      end;

      if (not AchouInscricao) and (DocAtual <> '') then
      begin
        TSim.IndexName := 'PorDocumento';
        TSim.SetRangeStart;
        TSim.FieldByName('DOCUMENTO').AsString := DocAtual;
        TSim.SetRangeEnd;
        TSim.FieldByName('DOCUMENTO').AsString := DocAtual;
        TSim.ApplyRange;
        TSim.First;
        while not TSim.Eof do
        begin
          AchouDocumento := True;
          if DocumentoMatch = '' then
          begin
            InscricaoMatch := Trim(TSim.FieldByName('INSCRICAO').AsString);
            DocumentoMatch := Trim(TSim.FieldByName('DOCUMENTO').AsString);
            RazaoMatch     := Trim(TSim.FieldByName('RAZAO').AsString);
          end;
          i := ListaSIMCNAE.IndexOf(Trim(TSim.FieldByName('CNAE').AsString));
          if i < 0 then
          begin
            ListaSIMCNAE.Add(Trim(TSim.FieldByName('CNAE').AsString));
            ListaSIMDESC.Add(Trim(TSim.FieldByName('ATIVIDADE').AsString));
          end
          else if (Trim(ListaSIMDESC[i]) = '') and (Trim(TSim.FieldByName('ATIVIDADE').AsString) <> '') then
            ListaSIMDESC[i] := Trim(TSim.FieldByName('ATIVIDADE').AsString);
          TSim.Next;
        end;
        TSim.CancelRange;
      end;

      TSim.Close;
    finally
      TSim.Free;
    end;

    if (not AchouInscricao) and (not AchouDocumento) then
    begin
      AtualizarStatusSincronizacaoSIM;
      FSimStatus.Caption := FSimStatus.Caption + ' | Cadastro nao localizado';
      FSimGrid.RowCount := 1;
      FSimDivergente := True;
      Application.ProcessMessages;
      Exit;
    end;

    tbrt.First;
    while not tbrt.Eof do
    begin
      if Trim(tbrtSubclasse.AsString) <> '' then
        if ListaRT.IndexOf(Trim(tbrtSubclasse.AsString)) < 0 then
          ListaRT.Add(Trim(tbrtSubclasse.AsString));
      tbrt.Next;
    end;

    FSimGrid.RowCount := 1;
    for i := 0 to ListaSIMCNAE.Count - 1 do
    begin
      FSimGrid.RowCount := FSimGrid.RowCount + 1;
      FSimGrid.Cells[0, FSimGrid.RowCount - 1] := ListaSIMCNAE[i];
      FSimGrid.Cells[1, FSimGrid.RowCount - 1] := ListaSIMDESC[i];
      if Trim(FSimGrid.Cells[1, FSimGrid.RowCount - 1]) = '' then
      begin
        if tbcnae.Locate('Subclasse', ListaSIMCNAE[i], []) then
          FSimGrid.Cells[1, FSimGrid.RowCount - 1] := tbcnaeAtividade.AsString;
      end;
      if tbcnae.Locate('Subclasse', ListaSIMCNAE[i], []) then
      begin
        if ListaRT.IndexOf(ListaSIMCNAE[i]) >= 0 then
          FSimGrid.Cells[2, FSimGrid.RowCount - 1] := 'MANTER'
        else
          FSimGrid.Cells[2, FSimGrid.RowCount - 1] := 'INCLUIR';
      end
      else
        FSimGrid.Cells[2, FSimGrid.RowCount - 1] := 'NAO COMPETE';
    end;

    for i := 0 to ListaRT.Count - 1 do
    begin
      if ListaSIMCNAE.IndexOf(ListaRT[i]) < 0 then
      begin
        FSimGrid.RowCount := FSimGrid.RowCount + 1;
        FSimGrid.Cells[0, FSimGrid.RowCount - 1] := ListaRT[i];
        if tbcnae.Locate('Subclasse', ListaRT[i], []) then
        begin
          FSimGrid.Cells[1, FSimGrid.RowCount - 1] := tbcnaeAtividade.AsString;
          FSimGrid.Cells[2, FSimGrid.RowCount - 1] := 'EXCLUIR';
        end
        else
        begin
          FSimGrid.Cells[1, FSimGrid.RowCount - 1] := '';
          FSimGrid.Cells[2, FSimGrid.RowCount - 1] := 'NAO COMPETE';
        end;
      end;
    end;

    AtualizarStatusSincronizacaoSIM;
    if InscricaoMatch <> '' then
      FSimStatus.Caption := FSimStatus.Caption +
        ' | Inscricao: ' + InscricaoMatch +
        ' | Documento: ' + MascararDocumento(DocumentoMatch) +
        ' | ' + Copy(RazaoMatch, 1, 50);
  finally
    ListaSIMCNAE.Free;
    ListaSIMDESC.Free;
    ListaRT.Free;
  end;
end;

function Tfrmestabe.ExisteDivergenciaCNAE: Boolean;
var
  i: Integer;
begin
  Result := False;

  if not Assigned(FSimGrid) then Exit;

  if FSimDivergente then
  begin
    Result := True;
    Exit;
  end;

  for i := 1 to FSimGrid.RowCount - 1 do
  begin
    if (UpperCase(Trim(FSimGrid.Cells[2, i])) = 'INCLUIR') or
       (UpperCase(Trim(FSimGrid.Cells[2, i])) = 'EXCLUIR') then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure Tfrmestabe.AtualizarStatusSincronizacaoSIM;
var
  DtAux: Integer;
  DataAux: TDateTime;
begin
  if not Assigned(FSimStatus) then Exit;

  if FileExists(CaminhoSIMTabela) then
  begin
    DtAux := FileAge(CaminhoSIMTabela);
    if DtAux <> -1 then
    begin
      DataAux := FileDateToDateTime(DtAux);
      FSimStatus.Caption :=
        'API SIM: ' + FormatDateTime('dd/mm/yyyy hh:nn', DataAux);
      Exit;
    end;
  end;

  if FileExists(CaminhoSIMBruto) then
  begin
    DtAux := FileAge(CaminhoSIMBruto);
    if DtAux <> -1 then
    begin
      DataAux := FileDateToDateTime(DtAux);
      FSimStatus.Caption :=
        'API SIM: bruto ' + FormatDateTime('dd/mm/yyyy hh:nn', DataAux) + ' (tabela nao gerada)';
      Exit;
    end;
  end;

  FSimStatus.Caption := 'API SIM: nao disponivel';
end;

procedure Tfrmestabe.ValidarCNAESIM;
begin
  if UseSIMTabelaAuxiliar then
  begin
    try
      if PrecisaGerarSIMTabela then
      begin
        if Assigned(FSimStatus) then
          FSimStatus.Caption := 'API SIM: atualizando tabela...';
        Application.ProcessMessages;
        if GerarSIMTabela then
        begin
          ValidarCNAESIM_Tabela;
          Exit;
        end;
      end;
      if FileExists(CaminhoSIMTabela) then
      begin
        ValidarCNAESIM_Tabela;
        Exit;
      end;
    except
      on E: EDBEngineError do
        ;
    end;
  end;

  InicializarPainelSIM;
  LimparPainelSIM;
  if Assigned(FSimStatus) then
    FSimStatus.Caption := 'Tabela SIM nao disponivel. Atualize a tabela ou tente mais tarde.';
end;

end.
