unit denuncia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Buttons, ToolWin, ComCtrls, DB,
  DBTables, Mask, Grids, DBGrids, ShellAPI, DBIProcs, jpeg;

type
  Tfrmdenuncia = class(TForm)
    GBrecl: TGroupBox;
    barraferra: TToolBar;
    btnovo: TSpeedButton;
    btaltera: TSpeedButton;
    btlocden: TSpeedButton;
    btgrava: TSpeedButton;
    btcancel: TSpeedButton;
    btdeleta: TSpeedButton;
    btprn: TSpeedButton;
    btfecha: TSpeedButton;
    bthelp: TSpeedButton;
    navegador: TDBNavigator;
    Label2: TLabel;
    Label3: TLabel;
    DBEreclamado: TDBEdit;
    Label4: TLabel;
    DBElogradouro: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEReferencia: TDBEdit;
    tbdenuncia: TTable;
    tbdenunciaControle: TAutoIncField;
    tbdenunciaDenuncia: TIntegerField;
    tbdenunciaData: TDateField;
    tbdenunciaReclamado: TStringField;
    tbdenunciaLogradouro: TStringField;
    tbdenunciaReferencia: TStringField;
    tbdenunciaArea: TStringField;
    tbdenunciaObjeto1: TStringField;
    dsdenuncia: TDataSource;
    dssequencia: TDataSource;
    tbsequencia: TTable;
    tbsequenciaNumero: TIntegerField;
    tbsequenciaDoc: TIntegerField;
    tbsequenciaDen: TIntegerField;
    StatusBar1: TStatusBar;
    GBDen: TGroupBox;
    DBCArea: TDBComboBox;
    DBCOb1: TDBComboBox;
    Label7: TLabel;
    tbdenunciaCdbai: TSmallintField;
    tbbairro: TTable;
    dsbairro: TDataSource;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    DBLBairro: TDBLookupComboBox;
    Proto: TDBEdit;
    tbdenunciaCpf: TStringField;
    tbdenunciaCnpj: TStringField;
    Label8: TLabel;
    tbdenunciaDescricao: TStringField;
    DBEDescri: TDBEdit;
    DBEdata: TDBEdit;
    tbdenunciaArchive: TBooleanField;
    tbdenunciaUser: TStringField;
    tbsinavisa: TTable;
    tbsinavisaCONTROLE: TAutoIncField;
    tbsinavisaDELE: TBooleanField;
    tbsinavisaCOMPLEXIDADE: TStringField;
    tbsinavisaCODIGO: TIntegerField;
    tbsinavisaPROCEDIMENTO: TStringField;
    dssinavisa: TDataSource;
    tbdenunciaSINAVISA: TIntegerField;
    tbdenunciaMeio: TStringField;
    tbdenunciaSatatus: TStringField;
    tbdenunciaEmissao: TStringField;
    tbdenunciaDtEmite: TDateField;
    tbdenunciaDtEncaminha: TDateField;
    tbdenunciaFiscalEncaminha: TStringField;
    EdArquivo: TEdit;
    BtProcura: TButton;
    DBEcnpj: TDBEdit;
    Label1: TLabel;
    tbcontrib: TTable;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribFANTASIA: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribATIVIDADE: TSmallintField;
    tbcontribCGC: TStringField;
    tbcontribMUNICIPAL: TStringField;
    tbcontribINATIVIDADE: TBooleanField;
    tbcontribRAZAO: TStringField;
    tbcontribCDBAI: TIntegerField;
    tbcontribBAIRRO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribPESSOA: TStringField;
    tbcontribCPF: TStringField;
    dscontrib: TDataSource;
    Label17: TLabel;
    DBEPonto: TDBEdit;
    tbdenunciaPrazo: TDateField;
    tbdenunciaPonto: TStringField;
    tbdenunciaFiscalAtend: TStringField;
    pgAnexos: TPageControl;
    tabAnexos: TTabSheet;
    DBGridAnexos: TDBGrid;
    PnlBotoesAnexo: TPanel;
    BtAddImg: TButton;
    BtAddPdf: TButton;
    BtRemAnexo: TButton;
    BtAbreAnexo: TButton;
    tbimgden: TTable;
    tbimgdenCONTROLE: TAutoIncField;
    tbimgdenDENUNCIA: TIntegerField;
    tbimgdenARQUIVO: TStringField;
    tbimgdenTIPO: TStringField;
    tbimgdenDESCRICAO: TStringField;
    dsimgden: TDataSource;
    dlgAnexo: TOpenDialog;
    imgAnexo: TImage;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnovoClick(Sender: TObject);
    procedure btfechaClick(Sender: TObject);
    procedure btalteraClick(Sender: TObject);
    procedure btgravaClick(Sender: TObject);
    procedure btcancelClick(Sender: TObject);
    procedure btprnClick(Sender: TObject);
    procedure bthelpClick(Sender: TObject);
    procedure btdeletaClick(Sender: TObject);
    procedure tbdenunciaAfterScroll(DataSet: TDataSet);
    procedure tbdenunciaBeforeScroll(DataSet: TDataSet);
    procedure dsdenunciaStateChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btlocdenClick(Sender: TObject);
    procedure DBCOb1Change(Sender: TObject);
    procedure BtProcuraClick(Sender: TObject);
    procedure BtAddImgClick(Sender: TObject);
    procedure BtAddPdfClick(Sender: TObject);
    procedure BtRemAnexoClick(Sender: TObject);
    procedure BtAbreAnexoClick(Sender: TObject);
    procedure dsimgdenDataChange(Sender: TObject; Field: TField);
  private
    procedure CriarTabelaImgDen;
    procedure AdicionarAnexo(const TipoFiltro, TipoCod: string);
  public
    { Public declarations }

  end;

var
  frmdenuncia: Tfrmdenuncia;

implementation

uses login, reldenuncia, sobre, locden, LOCPRO2 ;

{$R *.dfm}

procedure Tfrmdenuncia.FormActivate(Sender: TObject);
begin


tbcontrib.Open;
tbsinavisa.open;
CriarTabelaImgDen;
tbdenuncia.Open;
tbdenuncia.last;
tbsequencia.open;
tbbairro.Open;
tbimgden.Open;
if not tbdenuncia.IsEmpty then
begin
  tbimgden.Filter := 'DENUNCIA = ' + IntToStr(tbdenunciaDenuncia.Value);
  tbimgden.Filtered := True;
end;

//navegador.setfocus;
//if frmlogin.c_grp='ADM' then navegador.Enabled:=true else navegador.Enabled:=false;
if tbdenunciaarchive.Value=true then EdArquivo.text:='Arquivada' else EdArquivo.text:='         ';
end;

procedure Tfrmdenuncia.FormClose(Sender: TObject;
  var  Action: TCloseAction);

begin
tbcontrib.Close;
tbbairro.close;
tbsinavisa.close;
tbimgden.Close;
tbdenuncia.Close;
tbsequencia.close;
end;

procedure Tfrmdenuncia.btnovoClick(Sender: TObject);
var
den:integer;
begin
    if (frmlogin.c_grp = 'DEN') or
       (frmlogin.c_grp = 'CAD') or
       (frmlogin.c_grp = 'ADM') or
       (frmlogin.c_grp = 'FIS') then
    begin
        tbdenuncia.Insert;
        tbsequencia.edit;
        den:=tbsequenciaDen.value+1;
        tbdenunciadenuncia.value:=den;
        tbsequenciaDen.value:=den;
        tbsequencia.post;
        tbdenunciaData.Value:=date;
        BTPROCURA.setfocus;
        tbdenunciauser.value := frmlogin.c_user;
    end
    else showmessage('Função permitida somente para pessoal administrativo');
end;

procedure Tfrmdenuncia.btfechaClick(Sender: TObject);
begin
close;
end;

procedure Tfrmdenuncia.btalteraClick(Sender: TObject);
begin
if tbdenunciaarchive.value = true then
begin
    showmessage('Denúncia Arquivada. Impossível alterar!');
    exit;
end;

    if (frmlogin.c_grp = 'DEN') or
       (frmlogin.c_grp = 'CAD') or
       (frmlogin.c_grp = 'ADM') or
       (frmlogin.c_grp = 'FIS') then
    begin
        tbdenuncia.Edit;
        DBEdata.setfocus;
    end
    else showmessage('Usuário não autorizado');
end;

procedure Tfrmdenuncia.btgravaClick(Sender: TObject);
begin

if  tbsequencia.state <> dsbrowse then tbsequencia.post;

        if tbdenunciadata.IsNull then
        begin
            showmessage('Caro Usuário, favor informar A Data da Denúncia');
            DBEdata.setfocus;
            exit;
        end;

        if tbdenuncialogradouro.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o Logradouro do Reclamado');
            DBElogradouro.setfocus;
            exit;
        end;

        if tbdenunciareferencia.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o Complemento do endereço');
            DBEreferencia.setfocus;
            exit;
        end;

        if tbdenunciaponto.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o Complemento do endereço');
            DBEponto.setfocus;
            exit;
        end;

        if tbdenunciareclamado.IsNull then
        begin
            showmessage('Caro Usuário, favor informar o nome do reclamado');
            DBEdata.setfocus;
            exit;
        end;

        if tbdenunciaobjeto1.IsNull then
        begin
            showmessage('Caro Usuário, favor Classificar a denúncia');
            DBCOb1.setfocus;
            exit;
        end;

        if tbdenunciadescricao.IsNull then
        begin
            showmessage('Caro Usuário, favor informar a descrição');
            DBCOb1.setfocus;
            exit;
        end;

  {if tbdenunciasinavisa.IsNull then
        begin
            showmessage('Caro Usuário, indicar a correspondêcia da tabela de procedimentos SINAVISA');
            DBCmeio.setfocus;
            exit;
        end;   }

tbdenuncia.post;
navegador.setfocus;
{LbDen.caption:=' '+inttostr(tbdenunciaDenuncia.value);}
end;

procedure Tfrmdenuncia.btcancelClick(Sender: TObject);
begin
{tbsequencia.cancel;}
tbdenuncia.Cancel;
navegador.setfocus;
end;

procedure Tfrmdenuncia.btprnClick(Sender: TObject);
begin
    if (frmlogin.c_grp = 'DEN') or
       (frmlogin.c_grp = 'CAD') or
       (frmlogin.c_grp = 'ADM') or
       (frmlogin.c_grp = 'FIS') then
    begin
        rel_ptden.tbbairro.open;
        rel_ptden.tbsinavisa.open;
        rel_ptden.tbdenuncia.open;
        rel_ptden.tbdenuncia.findkey([tbdenunciacontrole.value]);
        rel_ptden.repdenuncia.preview;
        rel_ptden.tbbairro.Close;
        rel_ptden.tbsinavisa.close;
        rel_ptden.tbdenuncia.Close;
        rel_ptden.Close;
        navegador.setfocus;
        tbdenuncia.edit;
        tbdenunciaemissao.value:=frmlogin.c_user;
        tbdenunciadtemite.value:=date;
        tbdenuncia.post;
    end
    else showmessage('Função permitida somente para setor de denúncias');
end;

procedure Tfrmdenuncia.bthelpClick(Sender: TObject);
begin
aboutbox.showmodal;
end;

procedure Tfrmdenuncia.btdeletaClick(Sender: TObject);
begin
     if messagedlg('Confirma a Exclusão da Denúncia'+#13+inttostr(tbdenunciaDenuncia.value)+'?',mtconfirmation,[mbyes,mbno],0)=mryes then
     if (frmlogin.c_grp = 'ADM') then tbdenuncia.Delete else showmessage('Exclusão: Favor Encaminhar Para o Setor de Cadastro');
     navegador.setfocus;

end;

procedure Tfrmdenuncia.tbdenunciaAfterScroll(DataSet: TDataSet);
begin
if tbdenunciaarchive.Value=true then EdArquivo.text:='Arquivada' else EdArquivo.text:='         ';
imgAnexo.Picture.Assign(nil);
if tbimgden.Active and not tbdenuncia.IsEmpty then
begin
  tbimgden.DisableControls;
  try
    tbimgden.Filter := 'DENUNCIA = ' + IntToStr(tbdenunciaDenuncia.Value);
    tbimgden.Filtered := True;
    tbimgden.First;
  finally
    tbimgden.EnableControls;
  end;
end;
end;

procedure Tfrmdenuncia.tbdenunciaBeforeScroll(DataSet: TDataSet);
begin
{LbDen.caption:=' '+inttostr(tbdenunciaDenuncia.value);}
end;

procedure Tfrmdenuncia.dsdenunciaStateChange(Sender: TObject);
begin


if tbdenuncia.state=dsbrowse then statusbar1.panels[0].text:=' [F1] Ajuda   [F2] Pesquisa   [F3] Inclusão   [F4] Alteração   [F5] Emite Protocolo' else statusbar1.panels[0].text:=' [F6] Grava   [ESC] Cancela';
btprocura.Enabled    := tbdenuncia.state =  dsinsert;
btnovo.enabled       := tbdenuncia.state =  dsbrowse;
btaltera.enabled     := tbdenuncia.state =  dsbrowse;
btlocden.enabled     := tbdenuncia.state =  dsbrowse;
btgrava.enabled      := tbdenuncia.state <> dsbrowse;
btcancel.enabled     := tbdenuncia.state <> dsbrowse;
btdeleta.enabled     := tbdenuncia.state =  dsbrowse;
btprn.enabled        := tbdenuncia.state =  dsbrowse;
btfecha.enabled      := tbdenuncia.state =  dsbrowse;
bthelp.enabled       := tbdenuncia.state =  dsbrowse;
proto.Visible        := tbdenuncia.state =  dsbrowse;
{LbDen.caption:=' '+inttostr(tbdenunciaDenuncia.value);}
navegador.enabled    := tbdenuncia.state =  dsbrowse;
BtAddImg.Enabled     := tbdenuncia.State =  dsBrowse;
BtAddPdf.Enabled     := tbdenuncia.State =  dsBrowse;
BtRemAnexo.Enabled   := tbdenuncia.State =  dsBrowse;
BtAbreAnexo.Enabled  := tbdenuncia.State =  dsBrowse;
 end;

procedure Tfrmdenuncia.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = chr(13) then
        begin
                key:=chr(0);
                perform(Wm_nextdlgctl,0,0);
        end;

end;

procedure Tfrmdenuncia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin


case key of
        vk_escape:
        begin
          if tbdenuncia.state<>dsbrowse then btcancelClick(Sender)  else close;
        end;

        vk_F6:
        begin
          if tbdenuncia.state<>dsbrowse then  btgravaClick(Sender)  else showmessage('Funcao nao suportada aqui');
        end;

        vk_F3:
        begin
            if tbdenuncia.state=dsbrowse then btnovoClick(Sender)  else showmessage('Funcao nao suportada aqui');
        end;

        vk_F2:
        begin
             if tbdenuncia.state=dsbrowse then  btlocdenClick(Sender)  else  showmessage('Funcao nao suportada aqui');
        end;

        vk_F1:
        begin
            if tbdenuncia.state=dsbrowse then bthelpClick(Sender) else  showmessage('Funcao nao suportada aqui');
        end;

        vk_F4:
        begin
             if tbdenuncia.state=dsbrowse then btalteraClick(Sender) else showmessage('Funcao nao suportada aqui');
        end;

        vk_F5:
        begin
        if tbdenuncia.state=dsbrowse then  btprnClick(Sender)   else showmessage('Funcao nao suportada aqui');
        end;

end;





end;

procedure Tfrmdenuncia.btlocdenClick(Sender: TObject);
begin
{  messagedlg('Módulo em desenvolvimento',mtwarning,[mbok],0);
    navegador.setfocus;}

   frmlocden.ShowModal;
   tbdenuncia.findkey([frmlocden.lugarden]);

end;



procedure Tfrmdenuncia.DBCOb1Change(Sender: TObject);
begin
perform(Wm_nextdlgctl,0,0);
end;

procedure Tfrmdenuncia.BtProcuraClick(Sender: TObject);
begin
frmlocpro2.showmodal;
end;

procedure Tfrmdenuncia.CriarTabelaImgDen;
var
  T: TTable;
begin
  T := TTable.Create(nil);
  try
    T.DatabaseName := 'wcvs';
    T.TableName := 'IMAGEM_DEN.DB';
    if not T.Exists then
    begin
      T.TableType := ttParadox;
      T.FieldDefs.Clear;
      T.FieldDefs.Add('CONTROLE',  ftAutoInc, 0,  False);
      T.FieldDefs.Add('DENUNCIA',  ftInteger, 0,  False);
      T.FieldDefs.Add('ARQUIVO',   ftString,  80, False);
      T.FieldDefs.Add('TIPO',      ftString,  5,  False);
      T.FieldDefs.Add('DESCRICAO', ftString,  60, False);
      T.IndexDefs.Clear;
      T.IndexDefs.Add('', 'CONTROLE', [ixPrimary, ixUnique]);
      T.CreateTable;
    end;
  finally
    T.Free;
  end;
  ForceDirectories('\\192.168.1.2\WCVS\data\img');
  ForceDirectories('\\192.168.1.2\WCVS\data\pdf');
end;

procedure Tfrmdenuncia.AdicionarAnexo(const TipoFiltro, TipoCod: string);
var
  DestDir, DestFile, Ext: string;
begin
  if tbdenuncia.State <> dsBrowse then
  begin
    ShowMessage('Grave a denúncia antes de adicionar anexos.');
    Exit;
  end;
  dlgAnexo.Filter := TipoFiltro;
  dlgAnexo.FileName := '';
  if not dlgAnexo.Execute then Exit;

  Ext := LowerCase(ExtractFileExt(dlgAnexo.FileName));

  if TipoCod = 'IMG' then
    DestDir := '\\192.168.1.2\WCVS\data\img\'
  else
    DestDir := '\\192.168.1.2\WCVS\data\pdf\';

  DestFile := 'den_' + IntToStr(tbdenunciaDenuncia.Value) + '_' +
              FormatDateTime('yyyymmddhhnnss', Now) + Ext;

  ForceDirectories(DestDir);
  if not CopyFile(PChar(dlgAnexo.FileName), PChar(DestDir + DestFile), False) then
  begin
    ShowMessage('Erro ao copiar arquivo: ' + SysErrorMessage(GetLastError));
    Exit;
  end;

  tbimgden.Insert;
  tbimgdenDENUNCIA.Value  := tbdenunciaDenuncia.Value;
  tbimgdenARQUIVO.Value   := DestFile;
  tbimgdenTIPO.Value      := TipoCod;
  tbimgdenDESCRICAO.Value := ExtractFileName(dlgAnexo.FileName);
  tbimgden.Post;
  DBISaveChanges(tbimgden.Handle);
end;

procedure Tfrmdenuncia.BtAddImgClick(Sender: TObject);
begin
  AdicionarAnexo('Imagens (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png', 'IMG');
end;

procedure Tfrmdenuncia.BtAddPdfClick(Sender: TObject);
begin
  AdicionarAnexo('PDF (*.pdf)|*.pdf', 'PDF');
end;

procedure Tfrmdenuncia.BtRemAnexoClick(Sender: TObject);
var
  NomeArq, Dir: string;
begin
  if tbimgden.IsEmpty or (tbimgden.State <> dsBrowse) then Exit;
  if MessageDlg('Remover o anexo "' + tbimgdenARQUIVO.Value + '"?',
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
  NomeArq := tbimgdenARQUIVO.Value;
  if tbimgdenTIPO.Value = 'IMG' then
    Dir := '\\192.168.1.2\WCVS\data\img\'
  else
    Dir := '\\192.168.1.2\WCVS\data\pdf\';
  tbimgden.Delete;
  DBISaveChanges(tbimgden.Handle);
  DeleteFile(Dir + NomeArq);
end;

procedure Tfrmdenuncia.BtAbreAnexoClick(Sender: TObject);
var
  FullPath: string;
begin
  if tbimgden.IsEmpty then Exit;
  if tbimgdenTIPO.Value <> 'PDF' then Exit;
  FullPath := '\\192.168.1.2\WCVS\data\pdf\' + tbimgdenARQUIVO.Value;
  if FileExists(FullPath) then
    ShellExecute(Handle, 'open', PChar(FullPath), nil, nil, SW_SHOWNORMAL)
  else
    ShowMessage('Arquivo não encontrado: ' + FullPath);
end;

procedure Tfrmdenuncia.dsimgdenDataChange(Sender: TObject; Field: TField);
var
  FullPath: string;
begin
  imgAnexo.Picture.Assign(nil);
  if tbimgden.IsEmpty then Exit;
  if tbimgdenTIPO.Value <> 'IMG' then Exit;
  FullPath := '\\192.168.1.2\WCVS\data\img\' + tbimgdenARQUIVO.Value;
  if FileExists(FullPath) then
    imgAnexo.Picture.LoadFromFile(FullPath);
end;

end.
