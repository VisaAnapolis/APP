unit alvnovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, jpeg, DB, DBTables, StdCtrls, Mask,
  DBCtrls;

type
  Tfrmalvnovo = class(TForm)
    realvara: TQuickRep;
    Btail: TQRBand;
    tbcontrib: TTable;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribPESSOA: TStringField;
    tbcontribCPF: TStringField;
    tbcontribCGC: TStringField;
    tbcontribAGREGADO: TBooleanField;
    tbcontribRAZAO: TStringField;
    tbcontribFANTASIA: TStringField;
    tbcontribATIVIDADE: TIntegerField;
    tbcontribAREA: TIntegerField;
    tbcontribGRUPO: TIntegerField;
    tbcontribMUNICIPAL: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribBAIRRO: TStringField;
    tbcontribCDBAI: TIntegerField;
    tbcontribZONA: TSmallintField;
    tbcontribCEP: TStringField;
    tbcontribFONE: TStringField;
    tbcontribEMAIL: TStringField;
    tbcontribTAXA: TBooleanField;
    tbcontribINATIVIDADE: TBooleanField;
    tbcontribOBS: TMemoField;
    tbcontribPendoc: TBooleanField;
    tbcontribDt_cadastro: TDateField;
    tbcontribUser: TStringField;
    tbcontribDt_alter: TDateField;
    tbcontribH_alter: TTimeField;
    dscontrib: TDataSource;
    tbbairro: TTable;
    tbbairroCONTROLE: TAutoIncField;
    tbbairroCODIGO: TIntegerField;
    tbbairroNOME: TStringField;
    tbbairroSETOR: TIntegerField;
    tbalvara: TTable;
    tbalvaraControle: TAutoIncField;
    tbalvaraCodigo: TIntegerField;
    tbalvaraExercicio: TIntegerField;
    tbalvaraUnidade: TStringField;
    tbalvaraNumero: TIntegerField;
    tbalvaraLibera: TBooleanField;
    tbalvaraDt_libera: TDateField;
    tbalvaraAutoridade: TStringField;
    tbalvaraDt_emite: TDateField;
    tbalvaraEmitente: TStringField;
    tbalvaraObs: TMemoField;
    tbalvaraDuam: TIntegerField;
    tbalvaraDt_duam: TDateField;
    QRMemorando: TQRMemo;
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
    tbativ: TTable;
    tbativCONTROLE: TAutoIncField;
    tbativNUMERO: TIntegerField;
    tbativNOME: TStringField;
    tbalvaraAutenticador: TStringField;
    tbgrupo: TTable;
    tbgrupoCONTROLE: TAutoIncField;
    tbgrupoCOD: TIntegerField;
    tbgrupoGRUPO: TStringField;
    tbgrupoAREA: TIntegerField;
    tbgrupoDESCRICAO: TStringField;
    tbgrupoVALOR: TCurrencyField;
    tbcontribREPRESENTANTE: TStringField;
    tbcontribCPFREPRES: TStringField;
    BAtividade: TQRBand;
    tbalvlib: TTable;
    tbalvlibControle: TAutoIncField;
    tbalvlibAlvara: TIntegerField;
    tbalvlibData: TDateField;
    tbalvlibAtividade: TStringField;
    tbalvlibAutoridade: TStringField;
    tbalvlibAutenticador: TStringField;
    dsalvlib: TDataSource;
    dsalvara: TDataSource;
    QRDBativ: TQRDBText;
    QRDBautentic: TQRDBText;
    tbcnae: TTable;
    tbcnaeControle: TAutoIncField;
    tbcnaeSubclasse: TStringField;
    tbcnaeAtividade: TStringField;
    dscnae: TDataSource;
    QRLDescrativi: TQRLabel;
    QRobs: TQRLabel;
    QRDBText1: TQRDBText;
    BHead: TQRBand;
    QRLpma: TQRLabel;
    QRsec: TQRLabel;
    QRLdir: TQRLabel;
    QRLger: TQRLabel;
    QRlalvara: TQRLabel;
    QRLnum: TQRLabel;
    QRDBnum: TQRDBText;
    QRlnomecontr: TQRLabel;
    QRDBraz: TQRDBText;
    QRLfanta: TQRLabel;
    QRDBfasnta: TQRDBText;
    QRLrepre: TQRLabel;
    QRLend: TQRLabel;
    QRDBlogr: TQRDBText;
    QRDBcompl: TQRDBText;
    QRLcpf: TQRLabel;
    QRDBCpf: TQRDBText;
    QRLcgc: TQRLabel;
    QRLccm: TQRLabel;
    QRDBmunic: TQRDBText;
    QRDBcgc: TQRDBText;
    QRDBrepre: TQRDBText;
    QRDBcpfrepre: TQRDBText;
    QRDBbai: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRImage1: TQRImage;
    QRLdatadia: TQRLabel;
    QRLdatames: TQRLabel;
    qrldataano: TQRLabel;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    QRShape3: TQRShape;
    tbalvaraDt_validade: TDateField;
    QRLvalidadedia: TQRLabel;
    QRLvalidademes: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLvalidadeano: TQRLabel;
    tbalvaraTipo: TBooleanField;
    QRLabel9: TQRLabel;
    QRImage2: TQRImage;
    QRLabel11: TQRLabel;
    QRAlv: TQRLabel;
    QRShape2: TQRShape;
    QRLabel12: TQRLabel;
    QRDBText2: TQRDBText;
    QRImageCancel: TQRImage;
    tbalvaraCancela: TBooleanField;
    tbalvaraEvento: TBooleanField;
    QRLabel13: TQRLabel;
    QRDBText3: TQRDBText;
    QRMemo1: TQRMemo;
    QRLabel10: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel14: TQRLabel;
    tbrtSubclasse: TStringField;
    procedure realvaraBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure BAtividadeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BtailAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmalvnovo: Tfrmalvnovo;

implementation

uses ESTABE, login;

{$R *.dfm}

procedure Tfrmalvnovo.realvaraBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
mes:integer;
mesval:integer;
begin
//QRLdatadia.Caption     :=formatdatetime('dd',tbalvaradt_reemite.value);
QRLdatadia.Caption     :=formatdatetime('dd',date);
QRLvalidadedia.Caption :=formatdatetime('dd',tbalvaradt_validade.Value);
//mes := strtoint(formatdatetime('mm',tbalvaradt_reemite.value));
mes := strtoint(formatdatetime('mm',date));
case mes of
        1:  QRLdatames.Caption:='janeiro';
        2:  QRLdatames.Caption:='fevereiro';
        3:  QRLdatames.Caption:='março';
        4:  QRLdatames.Caption:='abril';
        5:  QRLdatames.Caption:='maio';
        6:  QRLdatames.Caption:='junho';
        7:  QRLdatames.Caption:='julho';
        8:  QRLdatames.Caption:='agosto';
        9:  QRLdatames.Caption:='setembro';
        10: QRLdatames.Caption:='outubro';
        11: QRLdatames.Caption:='novembro';
        12: QRLdatames.Caption:='dezembro';
end;
//
mesval := strtoint(formatdatetime('mm',tbalvaradt_validade.value));
case mesval of
        1:  QRLvalidademes.Caption:='janeiro';
        2:  QRLvalidademes.Caption:='fevereiro';
        3:  QRLvalidademes.Caption:='março';
        4:  QRLvalidademes.Caption:='abril';
        5:  QRLvalidademes.Caption:='maio';
        6:  QRLvalidademes.Caption:='junho';
        7:  QRLvalidademes.Caption:='julho';
        8:  QRLvalidademes.Caption:='agosto';
        9:  QRLvalidademes.Caption:='setembro';
        10: QRLvalidademes.Caption:='outubro';
        11: QRLvalidademes.Caption:='novembro';
        12: QRLvalidademes.Caption:='dezembro';
end;

//QRLdataano.Caption     :=formatdatetime('yyyy',tbalvaradt_reemite.value);
QRLdataano.Caption     :=formatdatetime('yyyy',date);
QRLvalidadeano.Caption :=formatdatetime('yyyy',tbalvaradt_validade.value);

{ if tbalvaratipo.Value   = true then QRalv.Caption      := 'Provisório' else QRalv.Caption      := '';
  if tbalvaraevento.Value = true then QRLeventos.Caption := 'de Eventos' else QRLeventos.Caption := '';
}
 if tbalvaratipo.Value   = true then QRalv.Caption := 'Provisório' else
 if tbalvaraevento.Value = true then QRalv.Caption := 'Evento' else
                                     QRalv.Caption := '';


if tbalvaracancela.Value = true then QRImageCancel.enabled := true else QRImageCancel.enabled := false;


if tbcontribpessoa.Value = 'CPF' then
begin
QRDBcgc.enabled := false;
QRDBcpf.enabled := true;
end
else
begin
QRDBcgc.enabled := true;
QRDBcpf.enabled := false;
end;




end;

procedure Tfrmalvnovo.BAtividadeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
if tbcnae.FindKey([tbalvlibatividade.value]) then QRLDescrativi.caption:=tbcnaeatividade.value else QRLDescrativi.caption:='';;
end;


//=========================

procedure ImprimeBitMap(Cnv: TCanvas; BitMap: TBitMap; R: TRect);

var

Info : PBitMapInfo;

InfoSize : DWORD;

Image : Pointer;

ImageSize : DWORD;

begin

with BitMap do

begin

GetDIBSizes(Handle, InfoSize, ImageSize);

GetMem(Info, InfoSize);

try

Getmem(Image, ImageSize);

try

GetDIB(Handle, Palette, Info^,Image^);

with Info^.bmiHeader do

StretchDIBits(Cnv.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,0, 0, biWidth, biHeight, Image,Info^, DIB_RGB_COLORS, SRCAND);

finally

FreeMem(Image, ImageSize);

end;

finally

FreeMem(Info, InfoSize);

end;

end;

end;

procedure Tfrmalvnovo.BtailAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
const

Imagem = '\\192.168.1.2\wcvs\brasbig.bmp';
// Imagem = 'C:\brasbig.bmp';
//altere aqui o nome/caminho da sua imagem

var

BitMap : TBitMap;

R      : TRect;

X, Y   : integer;

begin

BitMap := TBitMap.Create;

try

if not FileExists(Imagem) then

begin

messagebox(handle,

'O arquivo de imagem não existe ou foi removido !',

'Atenção', MB_OK or MB_ICONWARNING);

SetActiveWindow(Application.Handle);

end

else

begin

BitMap.LoadFromFile(Imagem);

with realvara.QRPrinter do

begin

//Y := YPos(PaperLengthValue) div 6;
Y := YPos(PaperLengthValue) div 7;

X := XPos(PaperWidthValue) div 4;


//R := Rect(X, 2 * Y, 3 * X, 4 * Y);
R := Rect(X, Y, 3 * X, 4 * Y);

ImprimeBitMap(Canvas, BitMap, R);

end;

end;

finally

BitMap.Free;

end;
end;

{procedure Tfrmalvnovo.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
if QRSubDetail1.DataSet.RecNo = 1 then
    QRLabelTitulo.Enabled := True
  else
    QRLabelTitulo.Enabled := False;
  if tbcnae.FindKey([tbrtsubclasse.value]) then QRLDescrnao.caption:=tbcnaeatividade.value else QRLDescrnao.caption:='';;
end;}

end.
