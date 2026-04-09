unit r_doc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, QRCtrls, jpeg, QuickRpt, ExtCtrls, StdCtrls,
  OleCtrls, SHDocVw, AcroPDFLib_TLB;

type
  Trel_doc = class(TForm)
    AcroPDF1: TAcroPDF;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    mes_rel:integer;
    ano_rel:integer;
  end;

var
  rel_doc: Trel_doc;

implementation

{$R *.dfm}


procedure Trel_doc.FormResize(Sender: TObject);
begin
  if Assigned(AcroPDF1) then
  begin
    AcroPDF1.Width  := ClientWidth;
    AcroPDF1.Height := ClientHeight;
  end;
end;


end.
