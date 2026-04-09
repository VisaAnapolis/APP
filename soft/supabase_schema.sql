-- =============================================================================
-- Schema Supabase - CVS Vigilância Sanitária (migrado de Paradox/Delphi)
-- Executar no SQL Editor do Supabase (PostgreSQL)
-- Ordem: tabelas independentes primeiro, depois dependentes (FKs ao final)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. TABELAS SEM DEPENDÊNCIA DE FK
-- -----------------------------------------------------------------------------

-- Bairros (cadastro municipal)
CREATE TABLE bairro (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER NOT NULL UNIQUE,
  nome VARCHAR(50),
  setor INTEGER,
  setoralimento INTEGER,
  ia VARCHAR(40),
  ag VARCHAR(40),
  ed VARCHAR(40),
  os VARCHAR(40),
  ss VARCHAR(40),
  od VARCHAR(40),
  cs VARCHAR(40),
  am VARCHAR(40),
  vt VARCHAR(40),
  bi VARCHAR(40),
  lp VARCHAR(40),
  ao VARCHAR(40),
  tr VARCHAR(40),
  fu VARCHAR(40),
  dr VARCHAR(40),
  md VARCHAR(40)
);
CREATE INDEX idx_bairro_codigo ON bairro(codigo);
CREATE INDEX idx_bairro_nome ON bairro(nome);

-- Atividades (ATIVI)
CREATE TABLE ativi (
  controle SERIAL PRIMARY KEY,
  numero INTEGER NOT NULL UNIQUE,
  nome VARCHAR(80)
);
CREATE INDEX idx_ativi_numero ON ativi(numero);
CREATE INDEX idx_ativi_nome ON ativi(nome);

-- Áreas
CREATE TABLE area (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER,
  nome VARCHAR(50)
);
CREATE INDEX idx_area_nome ON area(nome);

-- Grupos (para alvará)
CREATE TABLE grupo (
  controle SERIAL PRIMARY KEY,
  cod INTEGER NOT NULL,
  grupo VARCHAR(40),
  area INTEGER,
  descricao VARCHAR(80),
  valor NUMERIC(15,2)
);

-- CNAE (atividade econômica)
CREATE TABLE cnae (
  controle SERIAL PRIMARY KEY,
  subclasse VARCHAR(9) NOT NULL,
  classe VARCHAR(7),
  atividade VARCHAR(254),
  equipe VARCHAR(2),
  complexidade VARCHAR(5)
);
CREATE INDEX idx_cnae_subclasse ON cnae(subclasse);

-- Procedimentos SINAVISA (COMPLE) – codigo é referenciado por denuncia.sinavisa
CREATE TABLE comple (
  controle SERIAL PRIMARY KEY,
  dele BOOLEAN DEFAULT FALSE,
  complexidade VARCHAR(5),
  codigo INTEGER NOT NULL UNIQUE,
  procedimento VARCHAR(254)
);
CREATE INDEX idx_comple_codigo ON comple(codigo);

-- Sequência de numeração (Doc, Den, Pt, Oficio, Alvara, etc.)
CREATE TABLE sequencia (
  numero INTEGER,
  doc INTEGER,
  den INTEGER,
  pt INTEGER,
  oficio INTEGER,
  alvara INTEGER,
  veiculo INTEGER,
  protocolo INTEGER,
  disponibilidade BOOLEAN DEFAULT TRUE,
  versao VARCHAR(5),
  dt_versao VARCHAR(25)
);

-- Login (usuários do sistema) – depois migrar para Supabase Auth se desejar
CREATE TABLE login (
  controle SERIAL PRIMARY KEY,
  usuario VARCHAR(60) NOT NULL,
  senha TEXT,
  grupo VARCHAR(3),
  data DATE,
  senha2 TEXT,
  senha3 TEXT,
  local VARCHAR(40),
  cpf VARCHAR(14),
  perfil VARCHAR(3)
);
CREATE UNIQUE INDEX idx_login_usuario ON login(usuario);

-- -----------------------------------------------------------------------------
-- 2. CONTRIBUINTES (depende de bairro, ativi, area, grupo)
-- -----------------------------------------------------------------------------

CREATE TABLE contrib (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER NOT NULL UNIQUE,
  pessoa VARCHAR(4),
  cpf VARCHAR(14),
  cgc VARCHAR(18),
  agregado BOOLEAN DEFAULT FALSE,
  razao VARCHAR(50),
  fantasia VARCHAR(40),
  representante VARCHAR(40),
  cpfrepres VARCHAR(14),
  atividade INTEGER,
  area INTEGER,
  grupo INTEGER,
  municipal VARCHAR(6),
  logradouro VARCHAR(40),
  complement VARCHAR(30),
  bairro VARCHAR(50),
  cdbai INTEGER,
  zona SMALLINT,
  cep VARCHAR(10),
  fone VARCHAR(15),
  email VARCHAR(50),
  taxa BOOLEAN DEFAULT FALSE,
  inatividade BOOLEAN DEFAULT FALSE,
  obs TEXT,
  pendoc BOOLEAN DEFAULT FALSE,
  dt_cadastro DATE,
  "user" VARCHAR(30),
  dt_alter DATE,
  h_alter TIME,
  horario VARCHAR(15),
  novativ INTEGER,
  CONSTRAINT fk_contrib_bairro FOREIGN KEY (cdbai) REFERENCES bairro(codigo) ON DELETE SET NULL,
  CONSTRAINT fk_contrib_ativi FOREIGN KEY (atividade) REFERENCES ativi(numero) ON DELETE SET NULL,
  CONSTRAINT fk_contrib_area FOREIGN KEY (area) REFERENCES area(controle) ON DELETE SET NULL,
  CONSTRAINT fk_contrib_grupo FOREIGN KEY (grupo) REFERENCES grupo(controle) ON DELETE SET NULL
);
CREATE INDEX idx_contrib_codigo ON contrib(codigo);
CREATE INDEX idx_contrib_cgc ON contrib(cgc);
CREATE INDEX idx_contrib_razao ON contrib(razao);
CREATE INDEX idx_contrib_fantasia ON contrib(fantasia);
CREATE INDEX idx_contrib_cpf ON contrib(cpf);
CREATE INDEX idx_contrib_cdbai ON contrib(cdbai);

-- -----------------------------------------------------------------------------
-- 3. REGISTRO (protocolo de documentos)
-- -----------------------------------------------------------------------------

CREATE TABLE registro (
  controle SERIAL PRIMARY KEY,
  proto INTEGER NOT NULL,
  interessado VARCHAR(60),
  logradouro VARCHAR(60),
  complemento VARCHAR(30),
  cdbai SMALLINT,
  assunto VARCHAR(30),
  fone VARCHAR(13),
  pma VARCHAR(20),
  CONSTRAINT fk_registro_bairro FOREIGN KEY (cdbai) REFERENCES bairro(codigo) ON DELETE SET NULL
);
CREATE UNIQUE INDEX idx_registro_proto ON registro(proto);

-- Andamentos do protocolo
CREATE TABLE andamentos (
  controle SERIAL PRIMARY KEY,
  proto INTEGER NOT NULL,
  data DATE,
  hora TIME,
  destino VARCHAR(40),
  user_env VARCHAR(40),
  user_rec VARCHAR(40),
  CONSTRAINT fk_andamentos_registro FOREIGN KEY (proto) REFERENCES registro(proto) ON DELETE CASCADE
);
CREATE INDEX idx_andamentos_proto ON andamentos(proto);

-- -----------------------------------------------------------------------------
-- 4. DENÚNCIA E ATENDIMENTO
-- -----------------------------------------------------------------------------

CREATE TABLE denuncia (
  controle SERIAL PRIMARY KEY,
  denuncia INTEGER NOT NULL,
  data DATE,
  reclamado VARCHAR(60),
  logradouro VARCHAR(60),
  referencia VARCHAR(40),
  area VARCHAR(35),
  objeto1 VARCHAR(60),
  cdbai SMALLINT,
  cpf VARCHAR(14),
  cnpj VARCHAR(18),
  descricao VARCHAR(255),
  archive BOOLEAN DEFAULT FALSE,
  "user" VARCHAR(60),
  sinavisa INTEGER,
  meio VARCHAR(30),
  satatus VARCHAR(25),
  emissao VARCHAR(60),
  dtemite DATE,
  dtencaminha DATE,
  fiscalencaminha VARCHAR(60),
  prazo DATE,
  ponto VARCHAR(20),
  fiscalatend VARCHAR(60),
  CONSTRAINT fk_denuncia_bairro FOREIGN KEY (cdbai) REFERENCES bairro(codigo) ON DELETE SET NULL,
  CONSTRAINT fk_denuncia_comple FOREIGN KEY (sinavisa) REFERENCES comple(codigo) ON DELETE SET NULL
);
CREATE UNIQUE INDEX idx_denuncia_num ON denuncia(denuncia);
CREATE INDEX idx_denuncia_cdbai ON denuncia(cdbai);
CREATE INDEX idx_denuncia_sinavisa ON denuncia(sinavisa);

CREATE TABLE atend (
  controle SERIAL PRIMARY KEY,
  denuncia INTEGER NOT NULL,
  data_atendimento DATE,
  prazo DATE,
  data_retorno DATE,
  fiscal1 VARCHAR(40),
  fiscal2 VARCHAR(40),
  fiscal3 VARCHAR(40),
  obs TEXT,
  tipodoc VARCHAR(20),
  numdoc VARCHAR(20),
  h_inicio TIME,
  h_fim TIME,
  CONSTRAINT fk_atend_denuncia FOREIGN KEY (denuncia) REFERENCES denuncia(denuncia) ON DELETE CASCADE
);
-- Nota: denuncia.denuncia é o número público (único); controle é o PK interno.
CREATE INDEX idx_atend_denuncia ON atend(denuncia);

-- -----------------------------------------------------------------------------
-- 5. OFÍCIO
-- -----------------------------------------------------------------------------

CREATE TABLE oficio (
  controle SERIAL PRIMARY KEY,
  oficio INTEGER NOT NULL,
  data DATE,
  emitente VARCHAR(60),
  motivo VARCHAR(25),
  regulado VARCHAR(60),
  logradouro VARCHAR(60),
  cdbai SMALLINT,
  ordem VARCHAR(120),
  cpf VARCHAR(14),
  cnpj VARCHAR(18),
  fiscalencaminha VARCHAR(60),
  dtencaminha DATE,
  prazo DATE,
  dtatendimento DATE,
  cancela BOOLEAN DEFAULT FALSE,
  archive BOOLEAN DEFAULT FALSE,
  "user" VARCHAR(60),
  CONSTRAINT fk_oficio_bairro FOREIGN KEY (cdbai) REFERENCES bairro(codigo) ON DELETE SET NULL
);
CREATE INDEX idx_oficio_num ON oficio(oficio);
CREATE INDEX idx_oficio_cdbai ON oficio(cdbai);
CREATE INDEX idx_oficio_dtencaminha ON oficio(dtencaminha);
CREATE INDEX idx_oficio_fiscal ON oficio(fiscalencaminha);

-- -----------------------------------------------------------------------------
-- 6. REQUERIMENTO (OS)
-- -----------------------------------------------------------------------------

CREATE TABLE requerimento (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER NOT NULL,
  os INTEGER NOT NULL,
  area VARCHAR(25),
  motivo VARCHAR(25),
  veiculos SMALLINT,
  requerente VARCHAR(40),
  obs_req VARCHAR(60),
  dt_req DATE,
  fiscal_encaminha VARCHAR(40),
  recebedor VARCHAR(40),
  encaminhador VARCHAR(40),
  fiscal_atend VARCHAR(40),
  dt_atend DATE,
  tipo_documento VARCHAR(20),
  obs_atend VARCHAR(60),
  dt_encaminha DATE,
  encaminhamento BOOLEAN DEFAULT FALSE,
  atendimento BOOLEAN DEFAULT FALSE,
  num_documento VARCHAR(6),
  cancelado BOOLEAN DEFAULT FALSE,
  prioridade BOOLEAN DEFAULT FALSE,
  prazo DATE,
  fiscal_sugere VARCHAR(60),
  complexidade VARCHAR(5),
  justificativa TEXT,
  CONSTRAINT fk_requerimento_contrib FOREIGN KEY (codigo) REFERENCES contrib(codigo) ON DELETE CASCADE
);
CREATE INDEX idx_requerimento_codigo ON requerimento(codigo);
CREATE INDEX idx_requerimento_os ON requerimento(os);
CREATE UNIQUE INDEX idx_requerimento_codigo_os ON requerimento(codigo, os);
CREATE INDEX idx_requerimento_dt_req ON requerimento(dt_req);
CREATE INDEX idx_requerimento_fiscal ON requerimento(fiscal_encaminha);

-- -----------------------------------------------------------------------------
-- 7. PLANTA (protocolo de processo) e TRAMITAÇÃO
-- -----------------------------------------------------------------------------

CREATE TABLE planta (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER NOT NULL,
  protocolo INTEGER NOT NULL,
  data DATE,
  assunto VARCHAR(40),
  CONSTRAINT fk_planta_contrib FOREIGN KEY (codigo) REFERENCES contrib(codigo) ON DELETE CASCADE
);
CREATE UNIQUE INDEX idx_planta_protocolo ON planta(protocolo);
CREATE INDEX idx_planta_codigo ON planta(codigo);

CREATE TABLE tramitacao (
  controle SERIAL PRIMARY KEY,
  protocolo INTEGER NOT NULL,
  data DATE,
  destino VARCHAR(40),
  usuario VARCHAR(40),
  hora TIME,
  descricao VARCHAR(40),
  CONSTRAINT fk_tramitacao_planta FOREIGN KEY (protocolo) REFERENCES planta(protocolo) ON DELETE CASCADE
);
CREATE INDEX idx_tramitacao_protocolo ON tramitacao(protocolo);

-- -----------------------------------------------------------------------------
-- 8. VISITAS
-- -----------------------------------------------------------------------------

CREATE TABLE visitas (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER NOT NULL,
  dt_visita DATE,
  pz_retorno SMALLINT,
  prioridade BOOLEAN DEFAULT FALSE,
  acao VARCHAR(35),
  tipo VARCHAR(35),
  modalidade VARCHAR(30),
  denuncia INTEGER,
  os INTEGER,
  oficio INTEGER,
  protocolo INTEGER,
  numero VARCHAR(6),
  ndoc INTEGER,
  atividade VARCHAR(9),
  area VARCHAR(7),
  libera VARCHAR(12),
  fiscal1 VARCHAR(40),
  fiscal2 VARCHAR(40),
  fiscal3 VARCHAR(40),
  meio VARCHAR(7),
  us_inclu VARCHAR(40),
  dt_inclu DATE,
  gr_inclu VARCHAR(3),
  us_altera VARCHAR(40),
  dt_altera DATE,
  entrega BOOLEAN DEFAULT FALSE,
  CONSTRAINT fk_visitas_contrib FOREIGN KEY (codigo) REFERENCES contrib(codigo) ON DELETE CASCADE
  -- Opcional: FK para denuncia, requerimento(os), oficio, planta(protocolo)
);
CREATE INDEX idx_visitas_codigo ON visitas(codigo);
CREATE INDEX idx_visitas_denuncia ON visitas(denuncia);
CREATE INDEX idx_visitas_os ON visitas(os);
CREATE INDEX idx_visitas_oficio ON visitas(oficio);
CREATE INDEX idx_visitas_protocolo ON visitas(protocolo);

-- -----------------------------------------------------------------------------
-- 9. RT (Razão Tributária)
-- -----------------------------------------------------------------------------

CREATE TABLE rt (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER NOT NULL,
  nomeresp1 VARCHAR(40),
  consresp1 VARCHAR(20),
  ufresp1 VARCHAR(2),
  regresp1 VARCHAR(20),
  nomeresp2 VARCHAR(40),
  consresp2 VARCHAR(20),
  ufresp2 VARCHAR(2),
  regresp2 VARCHAR(20),
  atividade VARCHAR(80),
  subclasse VARCHAR(9),
  tipo VARCHAR(10),
  equipe VARCHAR(2),
  CONSTRAINT fk_rt_contrib FOREIGN KEY (codigo) REFERENCES contrib(codigo) ON DELETE CASCADE
);
CREATE INDEX idx_rt_codigo ON rt(codigo);

-- -----------------------------------------------------------------------------
-- 10. ALVARÁ E ALVARÁ LIVRE
-- -----------------------------------------------------------------------------

CREATE TABLE alvara (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER NOT NULL,
  exercicio INTEGER,
  evento BOOLEAN DEFAULT FALSE,
  tipo BOOLEAN DEFAULT FALSE,
  unidade VARCHAR(10),
  numero INTEGER NOT NULL UNIQUE,
  dt_validade DATE,
  obs TEXT,
  duam INTEGER,
  dt_duam DATE,
  cancela BOOLEAN DEFAULT FALSE,
  dt_cancela DATE,
  CONSTRAINT fk_alvara_contrib FOREIGN KEY (codigo) REFERENCES contrib(codigo) ON DELETE CASCADE
);
CREATE INDEX idx_alvara_codigo ON alvara(codigo);
CREATE INDEX idx_alvara_codigo_validade ON alvara(codigo, dt_validade);

CREATE TABLE alvlib (
  controle SERIAL PRIMARY KEY,
  numero INTEGER NOT NULL,
  -- referência ao alvará.numero
  CONSTRAINT fk_alvlib_alvara FOREIGN KEY (numero) REFERENCES alvara(numero) ON DELETE CASCADE
);
CREATE INDEX idx_alvlib_numero ON alvlib(numero);

-- -----------------------------------------------------------------------------
-- 11. HISTÓRICO
-- -----------------------------------------------------------------------------

CREATE TABLE historico (
  controle SERIAL PRIMARY KEY,
  ndoc INTEGER,
  descr TEXT,
  dispositivo TEXT
);
CREATE INDEX idx_historico_ndoc ON historico(ndoc);

-- -----------------------------------------------------------------------------
-- 12. VEÍCULO (alveicular)
-- -----------------------------------------------------------------------------

CREATE TABLE veiculo (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER,
  placa VARCHAR(15),
  -- adicione demais campos conforme alveicular.dfm se necessário
  CONSTRAINT fk_veiculo_contrib FOREIGN KEY (codigo) REFERENCES contrib(codigo) ON DELETE SET NULL
);
CREATE INDEX idx_veiculo_codigo ON veiculo(codigo);

-- -----------------------------------------------------------------------------
-- 13. TABELAS AUXILIARES / RELATÓRIOS
-- -----------------------------------------------------------------------------

CREATE TABLE rdpf (
  controle SERIAL PRIMARY KEY
  -- incluir campos conforme rdpf.dfm se necessário
);

CREATE TABLE rdpfarq (
  controle SERIAL PRIMARY KEY,
  data DATE
  -- campos conforme r_old/rdpfvelho
);
CREATE INDEX idx_rdpfarq_data ON rdpfarq(data);

CREATE TABLE rmpf (
  controle SERIAL PRIMARY KEY
  -- campos conforme r_rmpf.dfm
);

CREATE TABLE tbcon (
  controle SERIAL PRIMARY KEY
  -- campos conforme r_rcon.dfm
);

CREATE TABLE auxrelativ (
  controle SERIAL PRIMARY KEY,
  razao VARCHAR(50),
  novo BOOLEAN DEFAULT FALSE
  -- demais campos conforme relatividade
);
CREATE INDEX idx_auxrelativ_razao ON auxrelativ(razao);

CREATE TABLE caracter (
  controle SERIAL PRIMARY KEY,
  codigo INTEGER
  -- campos conforme caracter.DB
);
CREATE INDEX idx_caracter_codigo ON caracter(codigo);

-- -----------------------------------------------------------------------------
-- COMENTÁRIOS (opcional)
-- -----------------------------------------------------------------------------
COMMENT ON TABLE contrib IS 'Contribuintes/estabelecimentos - CONTRIB.DB';
COMMENT ON TABLE denuncia IS 'Denúncias - denuncia.db';
COMMENT ON TABLE requerimento IS 'Requerimentos/OS - requerimento.DB';
COMMENT ON TABLE planta IS 'Protocolo de processo - planta.DB';
COMMENT ON TABLE tramitacao IS 'Tramitação - tramitacao.DB';
COMMENT ON TABLE visitas IS 'Visitas de fiscalização - VISITAS.DB';
COMMENT ON TABLE registro IS 'Protocolo de documentos - registro.DB';
COMMENT ON TABLE andamentos IS 'Andamentos do protocolo - andamentos.db';
