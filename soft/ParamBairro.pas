unit ParamBairro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls;

type
  TfrmParamBairro = class(TForm)
    PanelTop: TPanel;
    BtnNovo: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    BtnFechar: TButton;
    PanelEdicao: TPanel;
    Grid: TDBGrid;
    Ds: TDataSource;
    Tb: TTable;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure DsStateChange(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
  private
    Cb: array[0..15] of TComboBox;   // 16 combos
    EdNomeBairro: TDBEdit;

    procedure AtualizaBotoes;
    procedure ApplyFieldRules;
    procedure EnterEditMode;
    procedure ExitEditMode;

    procedure AssignNextCodigo;

    procedure BuildEdicaoFixa;        // cria NOME + combos
    procedure BuildCombosFixos;       // cria 16 combos e labels (IA..MD)
    procedure FillFiscaisCombo(C: TComboBox);
    procedure SyncCombosFromTable;    // Tb -> combos
    procedure SyncTableFromCombos;    // combos -> Tb

    procedure ComboEnterAsTab(Sender: TObject; var Key: Char);
  public
  end;

var
  frmParamBairro: TfrmParamBairro;

implementation

{$R *.dfm}

procedure TfrmParamBairro.ComboEnterAsTab(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmParamBairro.FillFiscaisCombo(C: TComboBox);
begin
  C.Items.BeginUpdate;
  try
    C.Items.Clear;
    C.Items.Add(''); // permite vazio

    C.Items.Add('ACADIA DE SOUZA VIEIRA SILVA');
    C.Items.Add('ADRIANA CRHISTINA DE REZENDE CARNEIRO');
    C.Items.Add('ADRIANE PEREIRA GUIMARÃES');
    C.Items.Add('ALINE CASTRO DAMASIO');
    C.Items.Add('ANA PAULA RODRIGUES CORRÊA GUIMARÃES');
    C.Items.Add('ANGELA RIBEIRO NEVES');
    C.Items.Add('ARIANNE FERREIRA VIEIRA');
    C.Items.Add('CÉSIO MALAQUIAS');
    C.Items.Add('CLÁUDIO NASCIMENTO SILVA');
    C.Items.Add('CLÓVIS RAFAEL BORGES FERREIRA');
    C.Items.Add('DANIEL SOARES BARBOSA');
    C.Items.Add('DANIELA DE ALMEIDA CASTRO');
    C.Items.Add('EDSON ARANTES FARIA FILHO');
    C.Items.Add('EDUARDO LUCAS MAGALHÃES CASTRO');
    C.Items.Add('FABÍOLA PEDROSA PEIXOTO MARQUES');
    C.Items.Add('GERALDO EDSON ROSA');
    C.Items.Add('GLEICIANE MARIA JOSÉ DA SILVA');
    C.Items.Add('GÚBIO DIAS PEREIRA');
    C.Items.Add('JOÃO BATISTA LUCAS DA SILVA REIS');
    C.Items.Add('JOSE LUIZ RIBEIRO');
    C.Items.Add('JULIANA FERREIRA VITURINO');
    C.Items.Add('JULIANA KÊNIA MARTINS DA SILVA');
    C.Items.Add('JULIO CÉSAR TELES SPINDOLA');
    C.Items.Add('KAMILLA CHRYSTINE ROLIM D. SANTOS GARCÊS');
    C.Items.Add('LIDIANE SIMÕES');
    C.Items.Add('LIVIA BRITO');
    C.Items.Add('LUCIANA CONSOLAÇÃO DOS SANTOS');
    C.Items.Add('LUCIANA SANTANA DA ROCHA');
    C.Items.Add('LUCIENE DE SOUZA BARBOSA GOMES SILVA');
    C.Items.Add('MARCIO HENRIQUE GOMES RODOVALHO');
    C.Items.Add('MARIA EDWIGES PINHEIRO DE SOUZA CHAVES');
    C.Items.Add('MARINA PERILLO NAVARRETE LAVERS');
    C.Items.Add('PATRÍCIA CORDEIRO DE MORAES E SOUZA');
    C.Items.Add('PEDRO HENRIQUE AIRES RIBEIRO');
    C.Items.Add('RODRIGO ALESSANDRO TÔGO SANTOS');
    C.Items.Add('RÚBIA MARA DE FREITAS');
    C.Items.Add('SILVIA MARQUES NAVES DA MOTA SOUZA');
    C.Items.Add('SIMONE DUARTE GROSSI');
    C.Items.Add('TATHIANE PESSOA DE SOUZA');
    C.Items.Add('THIAGO GOMES GOBO');
    C.Items.Add('VANESSA SANTANA');
    C.Items.Add('VIVIANE MANOEL DA SILVA BORGES');
    C.Items.Add('VIVIANE MIYADA');
    C.Items.Add('WANESSA DE BRITO JORGE');
  finally
    C.Items.EndUpdate;
  end;
end;

procedure TfrmParamBairro.BuildCombosFixos;
const
  Fields: array[0..15] of string =
    ('IA','AG','ED','OS','SS','OD','CS','AM','VT','BI','LP','AO','TR','FU','DR','MD');
var
  i: Integer;
  L: TLabel;
  ColW, X0, YLabel0, YCombo0, DX, DY: Integer;

  function ColOf(Index: Integer): Integer;
  begin
    // conforme a foto:
    // Linha 1: IA (col 2), AG (col 3)
    // Linhas seguintes: ED OS SS / OD CS AM / VT BI LP / AO TR FU / DR MD
    case Index of
      0: Result := 1; // IA
      1: Result := 2; // AG
    else
      Result := (Index - 2) mod 3; // 0..2
    end;
  end;

  function RowOf(Index: Integer): Integer;
  begin
    case Index of
      0,1: Result := 0;
    else
      Result := 1 + ((Index - 2) div 3);
    end;
  end;

begin
  ColW := 260;
  X0 := 12;         // início após o NOME
  YLabel0 := 12;
  YCombo0 := 26;
  DX := 280;
  DY := 54;

  for i := 0 to 15 do
    Cb[i] := nil;

  for i := 0 to 15 do
  begin
    // label (IA, AG, ED...)
    L := TLabel.Create(PanelEdicao);
    L.Parent := PanelEdicao;
    L.Caption := Fields[i];
    L.Left := X0 + ColOf(i) * DX;
    L.Top := YLabel0 + RowOf(i) * DY;

    // combo
    Cb[i] := TComboBox.Create(PanelEdicao);
    Cb[i].Parent := PanelEdicao;
    Cb[i].Style := csDropDownList;
    Cb[i].Left := L.Left;
    Cb[i].Top := YCombo0 + RowOf(i) * DY;
    Cb[i].Width := ColW;
    Cb[i].Height := 21;
    Cb[i].OnKeyPress := ComboEnterAsTab;

    FillFiscaisCombo(Cb[i]);
  end;
end;

procedure TfrmParamBairro.BuildEdicaoFixa;
var
  L: TLabel;
begin
  // limpa tudo do painel
  while PanelEdicao.ControlCount > 0 do
    PanelEdicao.Controls[0].Free;

  // LABEL NOME
  L := TLabel.Create(PanelEdicao);
  L.Parent := PanelEdicao;
  L.Caption := 'NOME';
  L.Left := 12;
  L.Top := 12;

  // DBEDIT NOME (AJUSTE o DataField se necessário)
  EdNomeBairro := TDBEdit.Create(PanelEdicao);
  EdNomeBairro.Parent := PanelEdicao;
  EdNomeBairro.Left := 12;
  EdNomeBairro.Top := 26;
  EdNomeBairro.Width := 260;
  EdNomeBairro.Height := 21;
  EdNomeBairro.DataSource := Ds;
  EdNomeBairro.DataField := 'NOME';
  EdNomeBairro.OnKeyPress := ComboEnterAsTab;

  BuildCombosFixos;
end;

procedure TfrmParamBairro.SyncCombosFromTable;
const
  Fields: array[0..15] of string =
    ('IA','AG','ED','OS','SS','OD','CS','AM','VT','BI','LP','AO','TR','FU','DR','MD');
var
  i: Integer;
  V: string;
  Idx: Integer;
begin
  if not Tb.Active then Exit;
  if Tb.IsEmpty then Exit;

  for i := 0 to 15 do
  begin
    if (Cb[i] = nil) then Continue;
    if Tb.FindField(Fields[i]) = nil then Continue;

    V := Trim(Tb.FieldByName(Fields[i]).AsString);

    // Se valor legado não estiver na lista, adiciona (para não ficar "branco")
    if (V <> '') and (Cb[i].Items.IndexOf(V) < 0) then
      Cb[i].Items.Insert(1, V);

    Idx := Cb[i].Items.IndexOf(V);
    if Idx < 0 then Idx := 0; // vazio

    Cb[i].ItemIndex := Idx;
  end;
end;

procedure TfrmParamBairro.SyncTableFromCombos;
const
  Fields: array[0..15] of string =
    ('IA','AG','ED','OS','SS','OD','CS','AM','VT','BI','LP','AO','TR','FU','DR','MD');
var
  i: Integer;
  V: string;
begin
  if not Tb.Active then Exit;

  for i := 0 to 15 do
  begin
    if (Cb[i] = nil) then Continue;
    if Tb.FindField(Fields[i]) = nil then Continue;

    if Cb[i].ItemIndex >= 0 then
      V := Trim(Cb[i].Items[Cb[i].ItemIndex])
    else
      V := '';

    Tb.FieldByName(Fields[i]).AsString := V;
  end;
end;

procedure TfrmParamBairro.ApplyFieldRules;
var
  i: Integer;
  HideName: string;
const
  HiddenFields: array[0..3] of string = ('CONTROLE', 'CODIGO', 'SETOR', 'SETORALIMENTO');
begin
  for i := Low(HiddenFields) to High(HiddenFields) do
  begin
    HideName := HiddenFields[i];
    if Tb.FindField(HideName) <> nil then
    begin
      Tb.FieldByName(HideName).Visible := False;
      Tb.FieldByName(HideName).ReadOnly := True;
    end;
  end;

  Ds.AutoEdit := False;
  Grid.ReadOnly := True;
end;

procedure TfrmParamBairro.EnterEditMode;
var
  i: Integer;
begin
  PanelEdicao.Enabled := True;
  Grid.Enabled := False;
  Grid.ReadOnly := True;

  if EdNomeBairro <> nil then
    EdNomeBairro.ReadOnly := False;

  for i := 0 to 15 do
    if Cb[i] <> nil then
      Cb[i].Enabled := True;

  if (EdNomeBairro <> nil) and EdNomeBairro.CanFocus then
    EdNomeBairro.SetFocus;
end;

procedure TfrmParamBairro.ExitEditMode;
var
  i: Integer;
begin
  PanelEdicao.Enabled := False;
  Grid.Enabled := True;
  Grid.ReadOnly := True;

  if EdNomeBairro <> nil then
    EdNomeBairro.ReadOnly := True;

  for i := 0 to 15 do
    if Cb[i] <> nil then
      Cb[i].Enabled := False;
end;

procedure TfrmParamBairro.FormActivate(Sender: TObject);
begin
  Session.AddPassword('paradiso');

  if not Tb.Active then
  begin
    Tb.IndexName := 'PorNome';
    Tb.Open;
  end;

  ApplyFieldRules;

  BuildEdicaoFixa;
  SyncCombosFromTable;

  ExitEditMode;
  AtualizaBotoes;
end;

procedure TfrmParamBairro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Tb.Active and (Tb.State in [dsEdit, dsInsert]) then
    Tb.Cancel;

  Action := caHide;
end;

procedure TfrmParamBairro.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmParamBairro.AssignNextCodigo;
var
  PrevIndexName, PrevIndexFields: string;
  NextCod: Integer;
begin
  NextCod := 1;
  if not Tb.Active then Exit;

  PrevIndexName := Tb.IndexName;
  PrevIndexFields := Tb.IndexFieldNames;

  try
    Tb.IndexName := '';
    Tb.IndexFieldNames := 'CODIGO';
  except
    // ignora se não existir
  end;

  Tb.DisableControls;
  try
    if Tb.RecordCount > 0 then
    begin
      Tb.Last;
      if Tb.FindField('CODIGO') <> nil then
        NextCod := Tb.FieldByName('CODIGO').AsInteger + 1;
    end;
  finally
    Tb.EnableControls;
    try
      Tb.IndexFieldNames := PrevIndexFields;
      Tb.IndexName := PrevIndexName;
    except
      // ignora
    end;
  end;

  if Tb.FindField('CODIGO') <> nil then
    Tb.FieldByName('CODIGO').AsInteger := NextCod;
end;

procedure TfrmParamBairro.BtnNovoClick(Sender: TObject);
begin
  Tb.Append;
  AssignNextCodigo;

  EnterEditMode;
  SyncCombosFromTable;
  AtualizaBotoes;
end;

procedure TfrmParamBairro.BtnAlterarClick(Sender: TObject);
begin
  if Tb.IsEmpty then Exit;

  Tb.Edit;

  EnterEditMode;
  SyncCombosFromTable;
  AtualizaBotoes;
end;

procedure TfrmParamBairro.BtnExcluirClick(Sender: TObject);
begin
  if Tb.IsEmpty then Exit;

  if MessageDlg('Confirma excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Tb.Delete;

  SyncCombosFromTable;
  AtualizaBotoes;
end;

procedure TfrmParamBairro.BtnSalvarClick(Sender: TObject);
begin
  if Tb.State in [dsInsert, dsEdit] then
  begin
    SyncTableFromCombos;
    Tb.Post;
  end;

  ExitEditMode;
  AtualizaBotoes;

  if Grid.CanFocus then Grid.SetFocus;
end;

procedure TfrmParamBairro.BtnCancelarClick(Sender: TObject);
begin
  if Tb.State in [dsInsert, dsEdit] then
    Tb.Cancel;

  SyncCombosFromTable;
  ExitEditMode;
  AtualizaBotoes;

  if Grid.CanFocus then Grid.SetFocus;
end;

procedure TfrmParamBairro.DsStateChange(Sender: TObject);
begin
  AtualizaBotoes;
end;

procedure TfrmParamBairro.AtualizaBotoes;
var
  EmEdicao: Boolean;
begin
  EmEdicao := (Tb.State in [dsInsert, dsEdit]);

  BtnNovo.Enabled     := not EmEdicao;
  BtnAlterar.Enabled  := (not EmEdicao) and (not Tb.IsEmpty);
  BtnExcluir.Enabled  := (not EmEdicao) and (not Tb.IsEmpty);

  BtnSalvar.Enabled   := EmEdicao;
  BtnCancelar.Enabled := EmEdicao;
end;

procedure TfrmParamBairro.GridCellClick(Column: TColumn);
begin
  SyncCombosFromTable;
end;

end.

