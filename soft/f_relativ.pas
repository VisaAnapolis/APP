unit f_relativ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DB, DBTables, dbcgrids, Mask,
  Grids, DBGrids;

type
  Tfrmrelativ = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    dscnae: TDataSource;
    tbcnae: TTable;
    tbcnaeControle: TAutoIncField;
    tbcnaeAtividade: TStringField;
    tbcnaeClasse: TStringField;
    tbaux: TTable;
    tbauxControle: TAutoIncField;
    tbauxCodigo: TIntegerField;
    tbauxRazao: TStringField;
    tbauxFantasia: TStringField;
    tbauxLogradouro: TStringField;
    tbauxComplemento: TStringField;
    tbauxBairro: TStringField;
    tbauxNumero_alvara: TIntegerField;
    tbauxExercicio: TIntegerField;
    tbauxData_validade: TDateField;
    tbauxSubclasse: TStringField;
    tbcontrib: TTable;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    tbalvara: TTable;
    tbalvlib: TTable;
    tbalvlibControle: TAutoIncField;
    tbalvlibAlvara: TIntegerField;
    tbalvlibData: TDateField;
    tbalvlibAtividade: TStringField;
    tbalvlibAutoridade: TStringField;
    tbalvlibAutenticador: TStringField;
    tbalvaraControle: TAutoIncField;
    tbalvaraCodigo: TIntegerField;
    tbalvaraExercicio: TIntegerField;
    tbalvaraEvento: TBooleanField;
    tbalvaraTipo: TBooleanField;
    tbalvaraUnidade: TStringField;
    tbalvaraNumero: TIntegerField;
    tbalvaraLibera: TBooleanField;
    tbalvaraDt_libera: TDateField;
    tbalvaraAutoridade: TStringField;
    tbalvaraDt_emite: TDateField;
    tbalvaraDt_validade: TDateField;
    tbalvaraEmitente: TStringField;
    tbalvaraDt_reemite: TDateField;
    tbalvaraReemitente: TStringField;
    tbalvaraAutenticador: TStringField;
    tbalvaraCancela: TBooleanField;
    tbalvaraCancelador: TStringField;
    tbalvaraDt_cancela: TDateField;
    tbalvaraObs: TMemoField;
    tbalvaraDuam: TIntegerField;
    tbalvaraDt_duam: TDateField;
    tbalvaraRequerente: TStringField;
    tbalvaraOb_duam: TMemoField;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribPESSOA: TStringField;
    tbcontribCPF: TStringField;
    tbcontribCGC: TStringField;
    tbcontribAGREGADO: TBooleanField;
    tbcontribRAZAO: TStringField;
    tbcontribFANTASIA: TStringField;
    tbcontribHORARIO: TStringField;
    tbcontribMUNICIPAL: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribCDBAI: TIntegerField;
    tbcontribCELULAR: TStringField;
    tbcontribEMAIL: TStringField;
    tbcontribTAXA: TBooleanField;
    tbcontribINATIVIDADE: TBooleanField;
    tbcontribOBS: TMemoField;
    tbcontribPendoc: TBooleanField;
    tbcontribDt_cadastro: TDateField;
    tbcontribUser: TStringField;
    tbcontribDt_alter: TDateField;
    tbcontribH_alter: TTimeField;
    tbauxData_libera: TDateField;
    dscontrib: TDataSource;
    tbcnaeSubclasse: TStringField;
    dsalvara: TDataSource;
    Label3: TLabel;
    Label4: TLabel;
    tbauxProvisorio: TStringField;
    tbauxNovo: TBooleanField;
    tbauxCNPJ: TStringField;
    tbauxCPF: TStringField;
    tbauxInatividade: TBooleanField;
    LbContagem: TLabel;
    CBAlvara: TCheckBox;
    tbauxValidade: TBooleanField;
    tbbairroaux: TTable;
    tbbairroauxCONTROLE: TAutoIncField;
    tbbairroauxCODIGO: TIntegerField;
    tbbairroauxNOME: TStringField;
    tbbairroauxSETOR: TIntegerField;
    dsbairroaux: TDataSource;
    DBGBairro: TDBGrid;
    RadioGroup1: TRadioGroup;
    RGBairro: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

var
  frmrelativ: Tfrmrelativ;

implementation

uses relativ;

{$R *.dfm}

procedure Tfrmrelativ.Button1Click(Sender: TObject);

var
contagem : integer;
total    : integer;
percento : integer; 
begin
    tbaux.EmptyTable;
    contagem := tbcontrib.RecordCount;
    total := contagem;
//    lbcontagem.Caption := inttostr(contagem);
    lbcontagem.Visible :=true;
    lbcontagem.Refresh;
    tbcontrib.first;
    while not tbcontrib.Eof do
    begin
           if tbcontribinatividade.Value = false then
           begin
               while not tbalvara.Eof do
               begin
                    while not tbalvlib.eof do
                    begin
                        if tbalvlibatividade.Value = tbcnaesubclasse.Value then
                        begin
                            tbaux.Insert;
                            tbauxCodigo.Value        := tbcontribcodigo.Value;
                            tbauxcnpj.Value          := tbcontribcgc.Value;
                            tbauxcpf.Value           := tbcontribcpf.Value;
                            tbauxinatividade.Value   := tbcontribinatividade.Value;
                            tbauxRazao.Value         := tbcontribrazao.Value;
                            tbauxFantasia.Value      := tbcontribfantasia.Value;
                            tbauxLogradouro.Value    := tbcontriblogradouro.Value;
                            tbauxComplemento.Value   := tbcontribcomplement.Value;
                            tbauxBairro.Value        := tbbairronome.Value;
                            tbauxexercicio.Value     := tbalvaraexercicio.Value;
                            tbauxNumero_alvara.Value := tbalvaranumero.Value;
                            if tbalvaraTipo.value = true then
                            tbauxprovisorio.value    :=  'Provisório';
                            tbauxdata_libera.value   := tbalvlibdata.value;
                            tbauxData_validade.Value := tbalvaradt_validade.Value;
                            if tbauxData_validade.Value > date then
                            tbauxvalidade.value := true;
                            tbauxSubclasse.Value     := tbalvlibatividade.Value;
                            tbaux.Post;
                        end;
                        tbalvlib.Next;
                    end;
                   tbalvara.Next;
               end;
           end;
           tbcontrib.next;
           contagem := contagem - 1;
           percento := round((((contagem/total)-1)*(-1)*100));
           lbcontagem.Caption := inttostr(percento)+'%  ';
           lbcontagem.Refresh;
           if not tbaux.Eof then
           begin
               tbaux.Edit;
               tbauxnovo.Value := true;
               tbaux.Post;
            end;
    end;
    rel_atividade.tbaux.open;
    if cbalvara.Checked = true then rel_atividade.tbaux.Filter := 'novo = true and validade = true' else rel_atividade.tbaux.Filter := 'novo = true';
    if rgbairro.ItemIndex = 0  then rel_atividade.tbaux.Filter := 'novo = true and bairro='+quotedstr(tbbairroauxnome.value) ;
    rel_atividade.QRativ.preview;
    rel_atividade.tbaux.close;
end;

procedure Tfrmrelativ.Button2Click(Sender: TObject);
begin
   frmrelativ.close;
   tbaux.close;
   tbalvlib.close;
   tbalvara.close;
   tbbairro.close;
   tbcontrib.close;
   tbcnae.close;
   tbbairroaux.close;
 end;

procedure Tfrmrelativ.FormActivate(Sender: TObject);
begin
tbbairroaux.open;
tbcnae.open;
tbcontrib.Open;
tbbairro.open;
tbalvara.Open;
tbalvlib.Open;
tbaux.Open;
end;

procedure Tfrmrelativ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tbaux.close;
end;

end.
