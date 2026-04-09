unit relativ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, QuickRpt, QRCtrls, StdCtrls;

type
  Trel_atividade = class(TForm)
    QRativ: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData4: TQRSysData;
    QRLabel2: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand3: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
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
    tbauxData_libera: TDateField;
    tbauxSubclasse: TStringField;
    QRDBText5: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText11: TQRDBText;
    tbauxProvisorio: TStringField;
    QRDBText12: TQRDBText;
    tbauxNovo: TBooleanField;
    dsaux: TDataSource;
    QRLabel8: TQRLabel;
    tbauxCNPJ: TStringField;
    tbauxCPF: TStringField;
    tbauxInatividade: TBooleanField;
    QRLabel7: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    tbauxValidade: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rel_atividade: Trel_atividade;

implementation

uses f_relativ;

{$R *.dfm}

end.
