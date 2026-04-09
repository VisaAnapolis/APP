# Documentação do Sistema CVS (Vigilância Sanitária) e Plano de Migração para Supabase

## 1. Como o sistema atual funciona

### 1.1 Tecnologia
- **Delphi 6** com **BDE (Borland Database Engine)** e tabelas **Paradox** (arquivos `.DB`).
- Todas as tabelas ficam em um único diretório, acessado via **alias BDE** chamado **`wcvs`** (DatabaseName = `'wcvs'` nos formulários).
- O arquivo `DBDWORK.INI` (vazio no seu projeto) normalmente conteria a definição do alias; o caminho real do banco é configurado no BDE Administrator (Windows).

### 1.2 Conexão com o banco
- **Componente:** `TTable` (DBTables) ligado a `DatabaseName = 'wcvs'`.
- **Proteção:** senha Paradox definida no código: `Session.AddPassword('paradiso');` (em `login.pas`, nos eventos `FormActivate`, `tbloginBeforeOpen`, `Database1BeforeConnect`, `Database1Login`).
- Não há componente `TDatabase` visível no `login.dfm`; a conexão é feita pela Session padrão do BDE ao abrir a primeira tabela (`tblogin`).
- **Tabela de login:** `login.db` — campos: Controle (AutoInc), Usuario, Senha, Grupo, Data, Senha2, Senha3, Local, Cpf, Perfil. Índice: PorUser (provavelmente em Usuario).

### 1.3 Relacionamentos (inferidos dos .dfm)
Os relacionamentos não são chaves estrangeiras no Paradox; são feitos em tempo de execução via **MasterSource** e **MasterFields**:

| Tabela filha   | Campo(s)   | Tabela pai  | Observação                    |
|----------------|------------|-------------|-------------------------------|
| andamentos     | Proto      | registro    | Andamentos do protocolo       |
| tbbai (bairro) | Cdbai      | registro    | Bairro do protocolo           |
| tbbairro       | CDBAI      | contrib     | Bairro do contribuinte        |
| tbativi        | ATIVIDADE  | contrib     | Atividade (ATIVI)             |
| visitas        | CODIGO     | contrib     | Visitas do estabelecimento    |
| rt             | CODIGO     | contrib     | Razão tributária               |
| tbalvara       | CODIGO     | contrib     | Alvarás do contribuinte       |
| tbreq          | Codigo     | contrib     | Requerimentos (em relatórios) |
| atend          | Denuncia   | denuncia    | Atendimentos da denúncia      |
| tbsinavisa     | SINAVISA   | denuncia    | COMPLE (procedimento SINAVISA) |
| tbbairro       | Cdbai      | denuncia    | Bairro da denúncia            |
| tramitacao     | Protocolo  | planta      | Tramitação do protocolo       |
| tbcontrib      | Codigo     | planta      | Contribuinte do protocolo     |
| oficio         | Cdbai      | (bairro)    | Bairro do ofício              |
| relofpen       | CDBAI      | oficio      | Bairro a partir do ofício    |

### 1.4 Tabelas identificadas (Paradox → nome lógico)
- **login** (login.db) — usuários do sistema  
- **contrib** (CONTRIB.DB) — contribuintes/estabelecimentos  
- **bairro** (bairro.DB) — bairros  
- **registro** (registro.DB) — protocolo de documentos  
- **andamentos** (andamentos.db) — andamentos do protocolo  
- **sequencia** (sequencia.DB) — numeração (Doc, Den, Pt, Oficio, Alvara, etc.)  
- **ativi** (ATIVI.DB) — atividades  
- **area** (area.db) — áreas  
- **denuncia** (denuncia.db) — denúncias  
- **comple** (COMPLE.DB) — procedimentos SINAVISA (complemento da denúncia)  
- **atend** (atend.DB) — atendimentos de denúncia  
- **oficio** (oficio.DB) — ofícios  
- **requerimento** (requerimento.DB) — requerimentos / OS  
- **planta** (planta.DB) — protocolo de processo (Codigo, Protocolo, Data, Assunto)  
- **tramitacao** (tramitacao.DB) — tramitação (Protocolo, Data, Destino, Usuario, Hora, Descricao)  
- **visitas** (VISITAS.DB) — visitas de fiscalização  
- **rt** (rt.DB) — razão tributária (por contribuinte)  
- **cnae** (cnae.DB) — CNAE (atividade econômica)  
- **alvara** (alvara.DB) — alvarás  
- **alvlib** (alvlib.DB) — alvará livre (por alvará)  
- **grupo** (grupo.DB) — grupos (alvará)  
- **historico** (HISTORICO.DB) — histórico (NDOC, DESCR, DISPOSITIVO)  
- **veiculo** (veiculo.DB) — veículos (alveicular)  
- **caracter** (caracter.DB) — característica (concatena)  
- **rdpf** (RDPF.DB) — RDPF  
- **rdpfarq** (RDPFARQ.DB) — arquivo RDPF  
- **rmpf** (rmpf.DB) — RMPF  
- **tbcon** (tbcon.db) — controle (relatórios)  
- **auxrelativ** (auxrelativ.db) — auxiliar relatório de atividades  
- **matricula** (concatena) — matrícula (se existir tabela separada)

---

## 2. Regras de validação (extraídas do código .pas)

### 2.1 Login
- Senha não pode ser vazia: "Favor informar a senha!"  
- Nova senha: não pode ser igual às 3 últimas; mínimo 8 caracteres; confirmação deve coincidir.  
- Usuário sem senha: "Usuário sem senha, Cadastrar nova senha!"  
- Política de troca de senha: avisos aos 30, 60, 90, 120, 150 e 180 dias.

### 2.2 Denúncia
- Data da denúncia obrigatória.  
- Logradouro do reclamado obrigatório.  
- Complemento do endereço obrigatório.  
- Nome do reclamado obrigatório.  
- Classificação da denúncia obrigatória.  
- Descrição obrigatória.  
- Deve indicar correspondência na tabela de procedimentos SINAVISA.  
- Meio de recebimento obrigatório.  
- Arquivada: não pode alterar.  
- Exclusão: apenas grupo ADM; caso contrário "Encaminhar Para o Setor de Cadastro".

### 2.3 Protocolo (registro)
- Exclusão: só se encaminhar ao setor de cadastro; andamentos excluídos antes do protocolo.

### 2.4 Outros
- Contribuinte não cadastrado (em buscas por CGC, Fantasia, Razão, Codigo, CPF).  
- OS não cadastrado (locreq, locof).  
- Denúncia não cadastrada / Data não encontrada (locden).  
- "Não há requerimento pra este Regulado" (LOCPRO4).

Essas regras devem ser reimplementadas na aplicação React (e, quando fizer sentido, como CHECK/UNIQUE ou triggers no Supabase).

---

## 3. Plano de migração Paradox → Supabase (PostgreSQL)

### Fase 1: Schema no Supabase
1. Criar todas as tabelas em **ordem de dependência** (tabelas sem FK primeiro: bairro, ativi, area, grupo, cnae, comple, sequencia, login; depois contrib, registro, andamentos, denuncia, atend, oficio, requerimento, planta, tramitacao, visitas, rt, alvara, alvlib, etc.).  
2. Adicionar **chaves estrangeiras** após as tabelas referenciadas existirem.  
3. Criar **índices** equivalentes aos usados no Delphi (PorCodigo, PorRazao, PorCGC, PorProtocolo, PorDenuncia, etc.).  
4. Opcional: **RLS (Row Level Security)** e políticas para multi‑tenant ou por perfil (ex.: grupo ADM).

### Fase 2: Dados
1. Exportar Paradox para CSV (ou usar ferramenta de migração BDE/ODBC).  
2. Ajustar encoding (UTF-8), datas e decimais.  
3. Importar no Supabase via `COPY` ou script INSERT, respeitando a ordem das tabelas (e desabilitando temporariamente FKs se necessário).  
4. Reativar sequences para AutoInc (ex.: `SELECT setval('contrib_controle_seq', (SELECT MAX(controle) FROM contrib));`).

### Fase 3: Aplicação
1. Substituir TTable/TQuery por chamadas à **API REST do Supabase** (ou cliente JS).  
2. Reimplementar validações no front (React) e, onde couber, em **constraints** e **triggers** no banco.  
3. Autenticação: migrar usuários/senhas para **Supabase Auth** (recomendado) ou tabela com hash de senha.

---

## 4. Scripts gerados
- **`supabase_schema.sql`** — CREATE TABLE + FOREIGN KEY + índices básicos.  
- **`supabase_seed_sequences.sql`** — opcional: ajuste de sequences após carga.

Execute `supabase_schema.sql` no SQL Editor do Supabase (ou via migração) antes de importar dados.
