unit uExportarMenor;

interface

uses
  SysUtils;

function ExportarJsonCVS_Menor(const AliasOrPath, OutBaseDir: string; out Erro: string): Boolean;

implementation

uses
  uExportarJsonCVS_Shared;

function ExportarJsonCVS_Menor(const AliasOrPath, OutBaseDir: string; out Erro: string): Boolean;
begin
  // Gera apenas index_regulados.json + pasta reg\
  // NÃO gera histórico (his\), reaproveitando o já publicado no GitHub
  Result := ExportarJsonCVS_SemHistorico(AliasOrPath, OutBaseDir, Erro);
end;

end.



