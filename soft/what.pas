unit what;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls;

type
  Tf_what = class(TForm)
    Panel1: TPanel;
    Copyright: TLabel;
    OKButton: TButton;
    RichEdit1: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterConstruction; override;
  end;

var
  f_what: Tf_what;

implementation

{$R *.dfm}

procedure Tf_what.AfterConstruction;
begin
  inherited;
  RichEdit1.Lines.Insert(0, '');
  RichEdit1.Lines.Insert(0, 'Após o encerramento, o próximo acesso exigirá login novamente.');
  RichEdit1.Lines.Insert(0, '                                                              ');
  RichEdit1.Lines.Insert(0, 'abertos são fechados automaticamente antes do aviso ser exibido.');
  RichEdit1.Lines.Insert(0, 'o sistema exibe um aviso com contagem regressiva de 15 segundos. Formulários');
  RichEdit1.Lines.Insert(0, 'Após 30 minutos de inatividade no menu principal,');
  RichEdit1.Lines.Insert(0, '                                                              ');
  RichEdit1.Lines.Insert(0, 'proteger o banco de dados, além de acessos indevidos.');
  RichEdit1.Lines.Insert(0, 'O sistema agora encerra automaticamente a sessão por inatividade, para');
  RichEdit1.Lines.Insert(0, '                                                              ');
  RichEdit1.Lines.Insert(0, '- ENCERRAMENTO AUTOMÁTICO POR INATIVIDADE - PROTEÇÃO DE SESSÃO(9.25)');
  RichEdit1.Lines.Insert(0, '                                                              ');
  RichEdit1.Lines.Insert(0, '- PARAMETRIZAÇÖES: INICIAL, USUÁRIOS, BAIRROS E CNAES(9.26)');
  RichEdit1.Lines.Insert(0, '                                                              ');
  RichEdit1.Lines.Insert(0, '- APRIMORAMENTO NA INTERFACE COM SIM(9.27)');
  RichEdit1.Lines.Insert(0, '                                                              ');
  RichEdit1.Lines.Insert(0, '- PAINEL INFORMATIVO DE OS - PRAZO PRÓXIMO/VENCIDAS (9.28)');
  RichEdit1.Lines.Insert(0, '                                                              ');
  RichEdit1.Lines.Insert(0, '- POSSSIBILIDADE DE ANEXAR IMAGENS E PDFS NO REGISTRO DE DENÚNCIA');



end;

end.

