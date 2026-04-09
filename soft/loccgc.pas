unit loccgc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, ExtCtrls;

type
  Tfrmloccgc = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    c_processo: TEdit;
    tbcontrib: TTable;
    tbcontribCONTROLE: TAutoIncField;
    tbcontribCODIGO: TIntegerField;
    tbcontribCGC: TStringField;
    tbcontribRAZAO: TStringField;
    tbcontribFANTASIA: TStringField;
    tbcontribATIVIDADE: TSmallintField;
    tbcontribALVARA: TStringField;
    tbcontribMUNICIPAL: TStringField;
    tbcontribESTADUAL: TStringField;
    tbcontribLOGRADOURO: TStringField;
    tbcontribCOMPLEMENT: TStringField;
    tbcontribBAIRRO: TStringField;
    tbcontribZONA: TSmallintField;
    dscontrib: TDataSource;
    btok: TButton;
    btcancel: TButton;
    procedure btokClick(Sender: TObject);
    procedure c_processoChange(Sender: TObject);
  private
    { Private declarations }
  public
 loc_cgc:integer   { Public declarations }
  end;

var
  frmloccgc: Tfrmloccgc;

implementation

{$R *.dfm}

procedure Tfrmloccgc.btokClick(Sender: TObject);
begin
   if tbconttrib.findkey([c_processo])} = true then
   begin
           loc_cgc:=1;
           close;
   end
   else
   begin
        showmessage('Contribuinte não cadastrado!');
   end;

end;

procedure Tfrmloccgc.c_processoChange(Sender: TObject);
begin

end;

end.
