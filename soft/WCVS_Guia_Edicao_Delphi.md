# Guia de Edição — Projeto WCVS (Delphi / Paradox BDE)

> **Portável entre máquinas.** Este guia documenta as decisões técnicas e métodos
> estabelecidos durante o desenvolvimento do WCVS para uso do desenvolvedor e do
> agente Cursor em qualquer instalação.

---

## 1. Estrutura do Projeto

```
D:\WCVS\
  soft\          ← fontes Delphi (.PAS, .DFM, .DPR, .RES)
  data\          ← tabelas Paradox (.DB, .PX, .MB, .X01, .Y01 ...)
  .cursor\
    rules\       ← regras do agente Cursor (delphi-wcvs.md)
```

Compilador: **Delphi 7** ou compatível. BDE (Borland Database Engine) para acesso
às tabelas Paradox.

---

## 2. Acentuação em strings literais de `.PAS`

### Problema

O Delphi 7 usa codificação ANSI Windows-1252. O agente Cursor (e outros editores de
texto) opera internamente em UTF-8. Quando o agente inseria caracteres acentuados em
strings Delphi, a codificação podia se perder ao salvar, gerando strings erradas em
runtime.

Também foi tentada a notação `#193` (código ASCII do caractere), que compilava mas
exibia literalmente `#193` no editor — gerando confusão.

### Solução confirmada em produção

**Colar o caractere acentuado diretamente no código.** O Cursor Agent salva o arquivo
como ANSI (Windows-1252) quando copia do chat, e o Delphi aceita normalmente.

Exemplos de strings corretas no código:

```pascal
{ Filtros de tabela }
tbplanta.Filter := 'assunto=' + quotedstr('PROJETO ARQUITETÔNICO SANITÁRIO');

{ Validações de campo }
if tbcnaetipo.Value = 'Secundária' then ...
if tbvisitasmodalidade.Value = 'DENÚNCIA' then ...
if tbvisitastipo.Value = 'CERTIDÃO' then ...
if tbvisitastipo.Value = 'TERMO DE INTIMAÇÃO' then ...
if tbvisitastipo.Value = 'TERMO DE NOTIFICAÇÃO' then ...
if tbvisitastipo.Value = 'AUTO DE INFRAÇÃO' then ...
if tbvisitastipo.Value = 'AUTO DE IMPOSIÇÃO DE PENALIDADE' then ...
if tbinspcarga.Value = 'GERÊNCIA' then ...

{ Verificações de cargo/responsável }
if trim(tbresponsavel.Value) = 'CLÁUDIO NASCIMENTO SILVA' then ...
if tbcargo.Value = 'GERENTE DE VIGILÂNCIA SANITÁRIA' then ...
if tbinspcarga.Value = 'DE OFÍCIO' then ...
```

### Verificação antes de editar

Antes de qualquer edição no `ESTABE.pas`, verificar se as correções ainda estão
presentes (podem ser revertidas por atualização de repositório):

```
rg "Secundária" d:\WCVS\soft\ESTABE.pas
rg "DE OFÍCIO" d:\WCVS\soft\ESTABE.pas
rg "CERTIDÃO" d:\WCVS\soft\ESTABE.pas
rg "DENÚNCIA" d:\WCVS\soft\ESTABE.pas
```

Lista completa de verificação: `d:\WCVS\soft\ESTABE_correcoes_acentos.txt`

---

## 3. Edição de arquivos `.DFM`

### Por que não editar diretamente

Os arquivos `.DFM` armazenam captions, labels e propriedades de componentes visuais.
Os acentos são gravados pelo Delphi no formato ANSI com escapes próprios, por exemplo:

```
Caption = 'Matr'#237'cula'
```

Se um editor externo (incluindo o agente Cursor) salvar o arquivo em UTF-8 ou alterar
essa codificação, o Delphi não conseguirá abrir o form ou exibirá texto corrompido.

### Método correto para alterar o .DFM

1. Abrir o form desejado no **Delphi Designer** (duplo clique no `.dfm` no Project Manager)
2. Botão direito na área vazia do form → **"View as Text"** (ou **Alt+F12**)
3. O Delphi exibe o conteúdo DFM em modo texto — editar aqui é seguro
4. Localizar o ponto indicado e colar o trecho fornecido pelo agente
5. **Alt+F12** novamente (ou botão direito → **"View as Form"**) para voltar ao modo visual
6. **Ctrl+S** para salvar

### Exemplo: adicionando um TTimer ao form ESTABE

No modo texto do DFM, localizar a linha `end` que fecha o objeto raiz do form e inserir
antes dela:

```
  object TimerInatividade: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = TimerInatividadeTimer
    Left = 608
    Top = 56
  end
```

### Exemplo: adicionando OnMouseMove ao form raiz

Localizar as propriedades do objeto raiz (primeiras linhas do DFM) e adicionar:

```
  OnMouseMove = FormMouseMove
```

---

## 4. Timeout de inatividade

### Constante de configuração (ESTABE.pas)

```pascal
const
  // Para teste: 30 segundos. Para produção: 1800 (30 minutos)
  INATIVIDADE_SEGUNDOS = 1800;
```

Trocar `1800` por `30` para testar o comportamento sem esperar 30 minutos.

### Regra: NUNCA usar ShowMessage em timer de inatividade

```pascal
// ERRADO — bloqueia o form e ele nunca fecha
procedure TfrmEstabe.TimerInatividadeTimer(Sender: TObject);
begin
  if SecondsBetween(Now, FLastActivity) < INATIVIDADE_SEGUNDOS then Exit;
  ShowMessage('Fechando por inatividade...'); // ← PROBLEMA: aguarda clique
  Close;
end;

// CORRETO — fechar diretamente
procedure TfrmEstabe.TimerInatividadeTimer(Sender: TObject);
begin
  if SecondsBetween(Now, FLastActivity) < INATIVIDADE_SEGUNDOS then Exit;
  Close;
end;
```

### Fechamento em cascata (ESTABE → LOCPRO) sem timer adicional

Usar variável booleana em `frmlocpro`:

```pascal
// LOCPRO.PAS — seção public da classe
FechouPorInatividade: Boolean;

// LOCPRO.PAS — após showmodal do ESTABE
procedure Tfrmlocpro.btokClick(Sender: TObject);
begin
  frmestabe.ShowModal;
  if FechouPorInatividade then
  begin
    FechouPorInatividade := False;
    Close;
    Exit;
  end;
  // continua lógica normal...
end;

// ESTABE.PAS — timer de inatividade seta a flag antes de fechar
procedure TfrmEstabe.TimerInatividadeTimer(Sender: TObject);
begin
  if SecondsBetween(Now, FLastActivity) < INATIVIDADE_SEGUNDOS then Exit;
  frmlocpro.FechouPorInatividade := True;
  Close;
end;

// ESTABE.PAS — FormActivate limpa a flag
procedure TfrmEstabe.FormActivate(Sender: TObject);
begin
  FLastActivity := Now;
  frmlocpro.FechouPorInatividade := False;
  // ...
end;
```

---

## 5. Tabelas Paradox — Regeneração de índices (SIMAUX e similares)

### Problema

Ao tentar limpar uma tabela Paradox usando loop `while not T.IsEmpty do T.Delete`,
os arquivos de índice secundário (`.X01`, `.Y01`) ficam inconsistentes. Na abertura
seguinte o BDE reporta **"index out of date"**.

### Solução

Recriar a tabela do zero com `DeleteTable` + `CreateTable`:

```pascal
procedure TfrmEstabe.GerarSIMTabela;
var
  T: TTable;
begin
  T := TTable.Create(nil);
  try
    T.DatabaseName := 'WCVSDATA';
    T.TableName := 'SIMAUX.DB';

    // Recriar sempre do zero — garante índices limpos
    if T.Exists then
      T.DeleteTable;

    T.FieldDefs.Clear;
    T.FieldDefs.Add('Campo1', ftString, 20, False);
    // ... demais campos ...

    T.IndexDefs.Clear;
    T.IndexDefs.Add('', 'Campo1', [ixPrimary, ixUnique]);
    T.CreateTable;

    // Agora abrir e popular
    T.Open;
    // ... inserir registros ...
    T.Close;
  finally
    T.Free;
  end;
end;
```

### Por que não usar DbiRegenIndexes apenas

`DbiRegenIndexes` regenera o índice a partir dos dados existentes, mas se os dados
e os arquivos de índice estiverem inconsistentes (situação causada pelo loop de delete),
a função pode falhar ou gerar índices incorretos na primeira execução.
`DeleteTable` + `CreateTable` garante um estado limpo.

---

## 6. Validação de CNAE antes de emitir alvará

### Regra de negócio

Ao clicar em **"Emitir Alvará"** ou **"Reemitir Alvará"**:
- Todos os CNAEs liberados para o alvará (`alvlib.db`) devem existir no cadastro
  do regulado (`rt.db`).
- CNAEs em `rt.db` que não estão em `alvlib.db` são permitidos (regulado pode ter
  mais atividades do que as liberadas no alvará).
- Se algum CNAE de `alvlib.db` não estiver em `rt.db`: bloquear a emissão para
  todos os perfis e exibir a lista de CNAEs faltantes.

### Função de verificação

```pascal
function TfrmEstabe.CNAEsAlvlibForaRT: string;
var
  Faltando: string;
begin
  Faltando := '';
  tbalvlib.First;
  while not tbalvlib.Eof do
  begin
    if not tbrt.Locate('Subclasse', tbalvlib['Subclasse'], []) then
      Faltando := Faltando + tbalvlib['Subclasse'] + ' ';
    tbalvlib.Next;
  end;
  Result := Trim(Faltando);
end;
```

### Uso nos botões

```pascal
procedure TfrmEstabe.BtemitenovoClick(Sender: TObject);
var
  FaltaRt: string;
begin
  FaltaRt := CNAEsAlvlibForaRT;
  if FaltaRt <> '' then
  begin
    ShowMessage('Os seguintes CNAEs não constam no cadastro do contribuinte: '
      + FaltaRt + '. Favor ajustar.');
    Exit;
  end;
  // ... continua lógica de emissão ...
end;
```

---

## 7. Fluxo recomendado de trabalho por sessão com o agente

1. **Verificar regressões** — rodar grep das strings-chave antes de editar.
2. **Editar .PAS** — o agente aplica alterações diretamente com acentos corretos.
3. **Editar .DFM** — o agente fornece o trecho; o desenvolvedor cola no Delphi Designer.
4. **Compilar no Delphi** — verificar se não há erros de compilação.
5. **Testar em runtime** — confirmar que validações e filtros funcionam.
6. **Atualizar checklist** — registrar novas strings corrigidas em `ESTABE_correcoes_acentos.txt`.

---

*Última atualização: Março 2026 — gerado pelo agente Cursor com base na sessão de desenvolvimento.*
