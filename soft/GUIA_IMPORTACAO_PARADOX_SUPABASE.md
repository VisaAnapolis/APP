# Guia: Importar dados Paradox → Supabase

## 1. Exportar do Paradox para CSV

Você precisa gerar um arquivo CSV por tabela. Opções:

### Opção A – Programa em Delphi (recomendado)

Use o unit **`exportar_paradox_csv.pas`** (está na pasta `soft`). Ele exporta qualquer tabela do alias `wcvs` para CSV em UTF-8. Rode tabela por tabela ou adapte para exportar todas.

**Uso:** chame `ExportarTabelaParaCSV('CONTRIB.DB', 'C:\export\contrib.csv');` para cada tabela.

### Opção B – LibreOffice Base

1. Abra o LibreOffice Base.
2. Conecte ao diretório das tabelas Paradox (precisa do driver ODBC para Paradox ou “Conectar a um banco existente”).
3. Para cada tabela: abra a tabela → Arquivo → Salvar como → CSV (UTF-8, separador `;` ou `,`).
4. Salve com o nome da tabela (ex.: `bairro.csv`, `contrib.csv`).

### Opção C – Excel + driver Paradox/ODBC

Se tiver driver Paradox/ODBC no Windows:

1. Dados → Obter dados externos → De outro banco → Paradox.
2. Selecione a pasta onde estão os `.DB` e a tabela.
3. Depois: Arquivo → Salvar como → CSV UTF-8 (delimitador vírgula).

### Formato dos CSV

- **Encoding:** UTF-8.
- **Separador:** vírgula (`,`). Se usar `;`, altere no script Python.
- **Cabeçalho:** primeira linha = nomes das colunas (igual ao nome no Supabase).
- **Datas:** `YYYY-MM-DD` (ex.: 2024-01-15).
- **Horas:** `HH:MM` ou `HH:MM:SS`.
- **Booleanos:** `true` / `false` ou `1` / `0` (o script aceita os dois).
- **Vazio:** deixe em branco (será NULL).
- **Texto com vírgula:** use aspas duplas; ex.: `"Rua A, 100"`.

---

## 2. Ordem de importação (respeitar FKs)

Importe **nesta ordem** (tabelas que são referenciadas primeiro):

| # | Tabela      | Arquivo CSV   | Paradox (.DB)   |
|---|-------------|---------------|------------------|
| 1 | bairro      | bairro.csv    | bairro.DB        |
| 2 | ativi       | ativi.csv     | ATIVI.DB         |
| 3 | area        | area.csv      | area.db          |
| 4 | grupo       | grupo.csv     | grupo.DB         |
| 5 | cnae        | cnae.csv      | cnae.DB          |
| 6 | comple      | comple.csv    | COMPLE.DB        |
| 7 | sequencia   | sequencia.csv | sequencia.DB     |
| 8 | login       | login.csv     | login.db         |
| 9 | contrib     | contrib.csv   | CONTRIB.DB       |
|10 | registro    | registro.csv  | registro.DB      |
|11 | andamentos  | andamentos.csv| andamentos.db   |
|12 | denuncia    | denuncia.csv  | denuncia.db      |
|13 | atend       | atend.csv     | atend.DB         |
|14 | oficio      | oficio.csv    | oficio.DB        |
|15 | requerimento| requerimento.csv | requerimento.DB |
|16 | planta      | planta.csv    | planta.DB        |
|17 | tramitacao  | tramitacao.csv | tramitacao.DB   |
|18 | visitas     | visitas.csv   | VISITAS.DB       |
|19 | rt          | rt.csv        | rt.DB            |
|20 | alvara      | alvara.csv    | alvara.DB        |
|21 | alvlib      | alvlib.csv    | alvlib.DB        |
|22 | historico   | historico.csv | HISTORICO.DB     |
|23 | veiculo     | veiculo.csv   | veiculo.DB       |
|24 | rdpf        | rdpf.csv      | RDPF.DB          |
|25 | rdpfarq     | rdpfarq.csv   | RDPFARQ.DB       |
|26 | rmpf        | rmpf.csv      | rmpf.DB          |
|27 | tbcon       | tbcon.csv     | tbcon.db         |
|28 | auxrelativ  | auxrelativ.csv| auxrelativ.db    |
|29 | caracter    | caracter.csv | caracter.DB      |

Só pule tabelas que não existirem no seu Paradox.

---

## 3. Importar no Supabase

### Método 1 – Dashboard (poucos registros)

1. Supabase → **Table Editor** → selecione a tabela.
2. Botão **Import data from CSV** (ou “Insert” e colar).
3. Faça na **mesma ordem** da tabela acima.

### Método 2 – Script Python (recomendado para muitos registros)

1. Coloque todos os CSV numa pasta (ex.: `C:\export\csv`).
2. Crie um arquivo **`.env`** na mesma pasta do script:

   ```env
   SUPABASE_URL=https://seu-projeto.supabase.co
   SUPABASE_SERVICE_KEY=sua_service_role_key
   CSV_DIR=C:\export\csv
   ```

3. Instale e rode:

   ```bash
   pip install supabase python-dotenv
   python import_csv_supabase.py
   ```

4. Depois rode **`supabase_seed_sequences.sql`** no SQL Editor para ajustar os contadores (AutoInc).

---

## 4. Colunas por tabela (para montar o CSV)

Cada CSV deve ter **uma linha de cabeçalho** com exatamente estes nomes (minúsculo, como no schema). Colunas que não existirem no Paradox podem ser omitidas ou deixadas vazias.

- **bairro:** controle, codigo, nome, setor, setoralimento, ia, ag, ed, os, ss, od, cs, am, vt, bi, lp, ao, tr, fu, dr, md  
- **ativi:** controle, numero, nome  
- **area:** controle, codigo, nome  
- **grupo:** controle, cod, grupo, area, descricao, valor  
- **cnae:** controle, subclasse, classe, atividade, equipe, complexidade  
- **comple:** controle, dele, complexidade, codigo, procedimento  
- **sequencia:** numero, doc, den, pt, oficio, alvara, veiculo, protocolo, disponibilidade, versao, dt_versao  
- **login:** controle, usuario, senha, grupo, data, senha2, senha3, local, cpf, perfil  
- **contrib:** (todas as colunas do schema; inclua `user` entre aspas no CSV se o nome da coluna for "user")  
- E assim por diante para as demais tabelas do `supabase_schema.sql`.

O script Python lê o cabeçalho do CSV e envia só as colunas que existem na tabela no Supabase; colunas extras no CSV são ignoradas.
