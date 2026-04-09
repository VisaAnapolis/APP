unit andamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, DBGrids, Mask;

type
  Tfrmanda = class(TForm)
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBEdatamov: TDBEdit;
    DBEhora: TDBEdit;
    DBGanda: TDBGrid;
    DBClocal: TDBComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmanda: Tfrmanda;

implementation

{$R *.dfm}

end.
