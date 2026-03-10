/**
 * BUSCA-GLOBAL.JS — Pesquisa Global Unificada
 * VISA Anápolis — v1.1.3
 *
 * Módulo ES6 que implementa busca unificada no Dashboard.
 * Consulta: regulados (JSON), protocolos, denúncias, requerimentos,
 * ofícios e alvarás (CSVs) com cache em memória e lazy loading.
 *
 * Exporta: initBuscaGlobal(), limparCacheBusca()
 */

/* ── Constantes ────────────────────────────────────────────────────────── */
const MAX_POR_CATEGORIA = 5;
const DEBOUNCE_MS       = 400;
const MIN_CHARS         = 3;

/* ── Cache em memória (singleton por sessão/aba) ───────────────────────── */
let _cacheBusca          = null;
let _promiseCarregamento = null;

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 1 — CARREGAMENTO E CACHE DE DADOS
   ══════════════════════════════════════════════════════════════════════════ */

/**
 * Garante que os dados estejam carregados (lazy load na primeira busca).
 * Usa Promise compartilhada para evitar race condition.
 */
async function garantirDadosCarregados() {
  if (_cacheBusca) return _cacheBusca;

  if (_promiseCarregamento) return _promiseCarregamento;

  _promiseCarregamento = _carregarTudo();
  try {
    _cacheBusca = await _promiseCarregamento;
    return _cacheBusca;
  } catch (e) {
    console.error('[BuscaGlobal] Falha ao carregar dados:', e);
    return null;
  } finally {
    _promiseCarregamento = null;
  }
}

/**
 * Carrega todas as fontes de dados em paralelo, aplica filtros e JOINs.
 */
async function _carregarTudo() {
  mostrarSpinnerNoCampo(true);

  // Cache-buster com granularidade diária
  const hoje = new Date().toISOString().slice(0, 10);

  const [reguladosJson, protocolos, tramitacoes, denunciasRaw,
         requerimentosRaw, oficiosRaw, alvarasRaw] =
    await Promise.all([
      fetch(`data/index_regulados.json?d=${hoje}`).then(r => r.json()),
      parseCSV(`data/protocolo.csv?d=${hoje}`),
      parseCSV(`data/tramitacao.csv?d=${hoje}`),
      parseCSV(`data/denuncia.csv?d=${hoje}`),
      parseCSV(`data/requerimento.csv?d=${hoje}`,
               ['OS', 'Codigo', 'Requerente', 'Prazo', 'Fiscal_Encaminha',
                'Atendimento', 'Cancelado']),
      parseCSV(`data/oficio.csv?d=${hoje}`,
               ['Oficio', 'Regulado', 'Cnpj', 'Logradouro',
                'Prazo', 'Fiscalencaminha', 'Cancela', 'Archive']),
      parseCSV(`data/alvara.csv?d=${hoje}`,
               ['Controle', 'Codigo', 'Numero', 'Exercicio',
                'Dt_emite', 'Dt_validade', 'Autoridade', 'Cancela'])
    ]);

  // Extrair array de dados do JSON (estrutura: { meta, dados })
  const regulados = reguladosJson.dados || reguladosJson;

  // ── FILTROS DE REGISTROS ATIVOS ──

  // Denúncias: todas (ativas e atendidas) — busca histórica completa
  const denuncias = denunciasRaw;

  // Requerimentos: somente ativos (sem Atendimento e sem Cancelado)
  const requerimentosAtivos = requerimentosRaw.filter(r =>
    !_processarBool(r.Atendimento) && !_processarBool(r.Cancelado)
  );

  // ── SOMENTE O ÚLTIMO REQUERIMENTO ATIVO POR REGULADO (maior número OS) ──
  // Chave: Codigo (FK para regulados) — mesmo padrão usado nos alvarás.
  // Critério de recente: maior OS (numérico sequencial).
  const mapaUltimoRequerimento = new Map();
  for (const r of requerimentosAtivos) {
    const cod = String(r.Codigo || '').trim();
    if (!cod) continue;
    const existente = mapaUltimoRequerimento.get(cod);
    const osA = parseInt(r.OS, 10) || 0;
    const osE = existente ? (parseInt(existente.OS, 10) || 0) : -1;
    if (!existente || osA > osE) {
      mapaUltimoRequerimento.set(cod, r);
    }
  }
  const requerimentos = Array.from(mapaUltimoRequerimento.values());

  // Ofícios: somente ativos (sem Cancela e sem Archive)
  const oficios = oficiosRaw.filter(o =>
    !_processarBool(o.Cancela) && !_processarBool(o.Archive)
  );

  // Alvarás: excluir cancelados (Cancela preenchido = cancelado)
  const alvarasAtivos = alvarasRaw.filter(a =>
    !String(a.Cancela || '').trim()
  );

  // ── SOMENTE O ÚLTIMO ALVARÁ POR REGULADO (maior Exercicio) ──
  const mapaUltimoAlvara = new Map();
  for (const a of alvarasAtivos) {
    const cod = String(a.Codigo || '').trim();
    if (!cod) continue;
    const existente = mapaUltimoAlvara.get(cod);
    const exercA = parseInt(a.Exercicio, 10) || 0;
    const exercE = existente ? (parseInt(existente.Exercicio, 10) || 0) : -1;
    if (!existente || exercA > exercE) {
      mapaUltimoAlvara.set(cod, a);
    }
  }
  const alvarasUltimos = Array.from(mapaUltimoAlvara.values());

  // ── MAPA DE REGULADOS (para JOIN por código) ──
  const mapaRegulados = new Map();
  for (const r of regulados) {
    mapaRegulados.set(String(r.codigo).trim(), r);
  }

  // ── MAPA DE REGULADOS POR DOCUMENTO/CNPJ (para JOIN com OS) ──
  const mapaReguladosPorDoc = new Map();
  for (const r of regulados) {
    const docNorm = norm(r.documento);
    if (docNorm) mapaReguladosPorDoc.set(docNorm, r);
  }

  // ── ENRIQUECER ALVARÁS com dados de regulados via Codigo (FK) ──
  for (const a of alvarasUltimos) {
    const reg = mapaRegulados.get(String(a.Codigo || '').trim());
    if (reg) {
      a._fantasia  = reg.fantasia;
      a._razao     = reg.razao;
      a._documento = reg.documento;
      a._fantasia_n  = norm(reg.fantasia);
      a._razao_n     = norm(reg.razao);
      a._documento_n = norm(reg.documento);
    }
    a._numero_n     = norm(a.Numero);
    a._autoridade_n = norm(a.Autoridade);
  }

  // ── ENRIQUECER REQUERIMENTOS com dados de regulados via Codigo (FK) ──
  for (const r of requerimentos) {
    const reg = mapaRegulados.get(String(r.Codigo || '').trim());
    if (reg) {
      r._fantasia    = reg.fantasia;
      r._razao       = reg.razao;
      r._documento   = reg.documento;
      r._fantasia_n  = norm(reg.fantasia);
      r._razao_n     = norm(reg.razao);
      r._documento_n = norm(reg.documento);
    } else {
      // Fallback: usa o nome do próprio campo Requerente
      r._fantasia_n  = norm(r.Requerente);
      r._razao_n     = '';
      r._documento_n = '';
    }
    r._requerente_n = norm(r.Requerente);
  }

  // ── ENRIQUECER OFÍCIOS com dados de regulados via CNPJ ──
  for (const o of oficios) {
    const reg = mapaReguladosPorDoc.get(norm(o.Cnpj));
    if (reg) {
      o._fantasia_n  = norm(reg.fantasia);
      o._razao_n     = norm(reg.razao);
      o._documento_n = norm(reg.documento);
    } else {
      o._fantasia_n  = norm(o.Regulado);
      o._razao_n     = '';
      o._documento_n = norm(o.Cnpj);
    }
  }

  // ── ENRIQUECER DENÚNCIAS com dados de regulados via CNPJ ──
  for (const d of denuncias) {
    const reg = mapaReguladosPorDoc.get(norm(d.Cnpj));
    if (reg) {
      d._fantasia_n  = norm(reg.fantasia);
      d._razao_n     = norm(reg.razao);
      d._documento_n = norm(reg.documento);
    } else {
      d._fantasia_n  = norm(d.Reclamado);
      d._razao_n     = '';
      d._documento_n = norm(d.Cnpj);
    }
  }

  // ── ENRIQUECER PROTOCOLOS com dados de regulados via Codigo (FK) ──
  for (const p of protocolos) {
    const reg = mapaRegulados.get(String(p.Codigo || '').trim());
    if (reg) {
      p._fantasia_n  = norm(reg.fantasia);
      p._razao_n     = norm(reg.razao);
      p._documento_n = norm(reg.documento);
    } else {
      p._fantasia_n  = '';
      p._razao_n     = '';
      p._documento_n = '';
    }
  }

  // ── MAPA DE ÚLTIMA TRAMITAÇÃO POR PROTOCOLO ──
  const mapaTramitacao = new Map();
  for (const t of tramitacoes) {
    const proto = (t.PROTOCOLO || '').trim();
    if (!proto) continue;
    const existente = mapaTramitacao.get(proto);
    if (!existente || (t.DATA || '') > (existente.DATA || '')) {
      mapaTramitacao.set(proto, t);
    }
  }

  mostrarSpinnerNoCampo(false);

  return { regulados, protocolos, tramitacoes, denuncias,
           requerimentos, oficios, alvaras: alvarasUltimos,
           mapaRegulados, mapaReguladosPorDoc, mapaTramitacao };
}

/**
 * Wrapper do PapaParse com delimiter ';' (padrão dos CSVs do VISA).
 * @param {string} url - URL do CSV
 * @param {string[]|null} campos - Se informado, só retorna esses campos
 */
function parseCSV(url, campos = null) {
  return new Promise((resolve, reject) => {
    Papa.parse(url, {
      download: true,
      header: true,
      delimiter: ';',
      skipEmptyLines: true,
      complete: (results) => {
        if (campos && results.data.length > 0) {
          const camposSet = new Set(campos);
          resolve(results.data.map(row => {
            const filtrado = {};
            for (const c of camposSet) {
              if (c in row) filtrado[c] = row[c];
            }
            return filtrado;
          }));
        } else {
          resolve(results.data);
        }
      },
      error: reject
    });
  });
}

/**
 * Compatível com processarBool() do os.html.
 * Aceita: TRUE, true, True, T, SIM, Sim, S → true
 */
function _processarBool(valor) {
  const v = String(valor || '').toUpperCase().trim();
  return v === 'TRUE' || v === 'SIM' || v === 'T' || v === 'S';
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 2 — NORMALIZAÇÃO E MATCHING
   ══════════════════════════════════════════════════════════════════════════ */

function norm(s) {
  return String(s || '')
    .toUpperCase()
    .trim()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')   // remove acentos
    .replace(/[.\-\/]+/g, '')          // remove pontuação CNPJ/CPF
    .replace(/\s+/g, ' ');             // normaliza espaços
}

function match(campo, termoNorm) {
  return norm(campo).includes(termoNorm);
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 3 — BUSCA EM TODAS AS FONTES
   ══════════════════════════════════════════════════════════════════════════ */

/**
 * Passe único: coleta os primeiros MAX_POR_CATEGORIA resultados
 * E conta o total de matches para o link "Ver todos".
 */
function executarBuscaComContagem(dados, termoNorm) {
  const resultados = {};
  const contagens  = {};

  function buscar(fonte, chave, matchFn, transformFn) {
    const lista = [];
    let total = 0;
    for (const item of fonte) {
      if (matchFn(item)) {
        total++;
        if (lista.length < MAX_POR_CATEGORIA) {
          lista.push(transformFn ? transformFn(item) : item);
        }
      }
    }
    resultados[chave] = lista;
    contagens[chave]  = total;
  }

  // ── Regulados ──
  buscar(dados.regulados, 'regulados',
    r => match(r.fantasia, termoNorm) || match(r.razao, termoNorm) || match(r.documento, termoNorm)
  );

  // ── Protocolos ──
  buscar(dados.protocolos, 'protocolos',
    p => (p._fantasia_n && p._fantasia_n.includes(termoNorm)) ||
         (p._razao_n && p._razao_n.includes(termoNorm)) ||
         (p._documento_n && p._documento_n.includes(termoNorm)) ||
         match(p.Protocolo, termoNorm) ||
         match(p.Protocolante, termoNorm) ||
         match(p.Assunto, termoNorm),
    p => {
      const tram = dados.mapaTramitacao.get((p.Protocolo || '').trim());
      const reg = dados.mapaRegulados.get(String(p.Codigo || '').trim());
      return {
        ...p,
        _tramitacao: tram || null,
        _razao: reg ? reg.razao : '',
        _fantasia: reg ? reg.fantasia : '',
        _documento: reg ? reg.documento : ''
      };
    }
  );

  // ── Denúncias ──
  buscar(dados.denuncias, 'denuncias',
    d => (d._fantasia_n && d._fantasia_n.includes(termoNorm)) ||
         (d._razao_n && d._razao_n.includes(termoNorm)) ||
         (d._documento_n && d._documento_n.includes(termoNorm)) ||
         match(d.Denuncia, termoNorm) ||
         match(d.Logradouro, termoNorm)
  );

  // ── Ofícios ──
  buscar(dados.oficios, 'oficios',
    o => (o._fantasia_n && o._fantasia_n.includes(termoNorm)) ||
         (o._razao_n && o._razao_n.includes(termoNorm)) ||
         (o._documento_n && o._documento_n.includes(termoNorm)) ||
         match(o.Oficio, termoNorm)
  );

  // ── Requerimentos (apenas o último ativo por regulado via Codigo FK) ──
  buscar(dados.requerimentos, 'requerimentos',
    r => (r._fantasia_n  && r._fantasia_n.includes(termoNorm)) ||
         (r._razao_n     && r._razao_n.includes(termoNorm)) ||
         (r._documento_n && r._documento_n.includes(termoNorm)) ||
         (r._requerente_n && r._requerente_n.includes(termoNorm)) ||
         match(r.OS, termoNorm)
  );

  // ── Alvarás (apenas o último por regulado) ──
  buscar(dados.alvaras, 'alvaras',
    a => (a._fantasia_n  && a._fantasia_n.includes(termoNorm)) ||
         (a._razao_n     && a._razao_n.includes(termoNorm)) ||
         (a._documento_n && a._documento_n.includes(termoNorm)) ||
         a._numero_n.includes(termoNorm) ||
         a._autoridade_n.includes(termoNorm)
  );

  return { resultados, contagens };
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 4 — RENDERIZAÇÃO DO DROPDOWN
   ══════════════════════════════════════════════════════════════════════════ */

function _esc(s) {
  const d = document.createElement('div');
  d.textContent = String(s || '');
  return d.innerHTML;
}

function _badgeAlvara(dtValidade) {
  if (!dtValidade || !dtValidade.trim()) return '';
  const partes = dtValidade.trim().split('.');
  if (partes.length !== 3) return '';
  const dataVal = new Date(+partes[2], +partes[1] - 1, +partes[0]);
  if (isNaN(dataVal.getTime())) return '';
  const hoje = new Date();
  hoje.setHours(0, 0, 0, 0);
  const diff = Math.floor((dataVal - hoje) / 86400000);
  if (diff < 0)   return '<span class="busca-item-badge badge-vencida">Vencido</span>';
  if (diff <= 30) return '<span class="busca-item-badge badge-avencer">A vencer</span>';
  return '<span class="busca-item-badge badge-ok">Vigente</span>';
}

function renderizarResultados(resultados, contagens, termoOriginal) {
  const painel = document.getElementById('buscaResultado');
  if (!painel) return;

  const totalExibido = Object.values(resultados).reduce((s, arr) => s + arr.length, 0);
  if (totalExibido === 0) {
    painel.innerHTML = '<div class="busca-vazio">Nenhum resultado encontrado</div>';
    painel.hidden = false;
    return;
  }

  let html = '';
  const q = encodeURIComponent(termoOriginal);
  let idxGlobal = 0;
  function itemId() { return `busca-opt-${idxGlobal++}`; }

  // ── Regulados ──
  if (resultados.regulados.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Regulados</div>';
    for (const r of resultados.regulados) {
      const id = itemId();
      html += `<a id="${id}" class="busca-item" href="cvs.html?q=${q}" role="option">
        <span class="busca-item-icon" aria-hidden="true">🏪</span>
        <div>
          <span class="busca-item-nome">${_esc(r.fantasia || r.razao)}</span>
          <span class="busca-item-sub">${_esc(r.documento)}${r.razao && r.fantasia ? ' · ' + _esc(r.razao) : ''}</span>
        </div>
      </a>`;
    }
    if (contagens.regulados > MAX_POR_CATEGORIA) {
      html += `<a class="busca-ver-todos" href="cvs.html?q=${q}">Ver todos os ${contagens.regulados} resultados →</a>`;
    }
  }

  // ── Protocolos ──
  if (resultados.protocolos.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Protocolos</div>';
    for (const p of resultados.protocolos) {
      const id = itemId();
      const tram = p._tramitacao;
      const arquivado = tram && (tram.DESTINO || '').trim().toUpperCase() === 'ARQUIVO';
      const tramInfo = tram && !arquivado ? `→ ${_esc(tram.DESTINO)} · ${_esc(tram.DATA)}` : '';
      const razaoSocial = p._razao || p._fantasia || p.Protocolante;
      const badge = arquivado
        ? '<span class="busca-item-badge badge-ok" aria-label="Protocolo arquivado">Arquivado</span>'
        : '<span class="busca-item-badge badge-aberto" aria-label="Protocolo">Protocolo</span>';
      html += `<a id="${id}" class="busca-item" href="protocolo.html?q=${q}" role="option">
        <span class="busca-item-icon" aria-hidden="true">📋</span>
        <div>
          <span class="busca-item-nome">${_esc(p.Protocolo)} · ${_esc(razaoSocial)}</span>
          <span class="busca-item-sub">${_esc(p.Assunto)}${p._documento ? ' · ' + _esc(p._documento) : ''}${tramInfo ? ' ' + tramInfo : ''}</span>
        </div>
        ${badge}
      </a>`;
    }
    if (contagens.protocolos > MAX_POR_CATEGORIA) {
      html += `<a class="busca-ver-todos" href="protocolo.html?q=${q}">Ver todos os ${contagens.protocolos} resultados →</a>`;
    }
  }

  // ── Denúncias ──
  if (resultados.denuncias.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Denúncias</div>';
    for (const d of resultados.denuncias) {
      const id = itemId();
      const atendida = _processarBool(d.Archive);
      const badge = atendida
        ? '<span class="busca-item-badge badge-ok" aria-label="Denúncia atendida">Atendida</span>'
        : '<span class="busca-item-badge badge-aberto" aria-label="Denúncia ativa">Aberta</span>';
      html += `<a id="${id}" class="busca-item" href="os.html?tipo=Den%C3%BAncia" role="option">
        <span class="busca-item-icon" aria-hidden="true">⚠️</span>
        <div>
          <span class="busca-item-nome">${_esc(d.Denuncia)} · ${_esc(d.Reclamado)}</span>
          <span class="busca-item-sub">${_esc(d.Logradouro)}${d.Cnpj ? ' · ' + _esc(d.Cnpj) : ''}</span>
        </div>
        ${badge}
      </a>`;
    }
    if (contagens.denuncias > MAX_POR_CATEGORIA) {
      html += `<a class="busca-ver-todos" href="os.html?tipo=Den%C3%BAncia">Ver todas as ${contagens.denuncias} denúncias →</a>`;
    }
  }

  // ── Ofícios ──
  if (resultados.oficios.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Ofícios</div>';
    for (const o of resultados.oficios) {
      const id = itemId();
      html += `<a id="${id}" class="busca-item" href="os.html?tipo=Of%C3%ADcio" role="option">
        <span class="busca-item-icon" aria-hidden="true">📨</span>
        <div>
          <span class="busca-item-nome">${_esc(o.Oficio)} · ${_esc(o.Regulado)}</span>
          <span class="busca-item-sub">${o.Cnpj ? _esc(o.Cnpj) : ''}${o.Logradouro ? ' · ' + _esc(o.Logradouro) : ''}</span>
        </div>
        <span class="busca-item-badge badge-aberto" aria-label="Ofício aberto">Aberto</span>
      </a>`;
    }
    if (contagens.oficios > MAX_POR_CATEGORIA) {
      html += `<a class="busca-ver-todos" href="os.html?tipo=Of%C3%ADcio">Ver todos os ${contagens.oficios} ofícios →</a>`;
    }
  }

  // ── Requerimentos (último ativo por regulado, enriquecido via Codigo FK) ──
  if (resultados.requerimentos.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Requerimentos</div>';
    for (const r of resultados.requerimentos) {
      const id = itemId();
      const nome = r._fantasia || r._razao || _esc(r.Requerente);
      html += `<a id="${id}" class="busca-item" href="os.html?tipo=Requerimento" role="option">
        <span class="busca-item-icon" aria-hidden="true">📝</span>
        <div>
          <span class="busca-item-nome">OS ${_esc(r.OS)} · ${_esc(nome)}</span>
          <span class="busca-item-sub">${r._documento ? _esc(r._documento) + ' · ' : ''}${r.Prazo ? 'Prazo: ' + _esc(r.Prazo) : ''}</span>
        </div>
        <span class="busca-item-badge badge-aberto" aria-label="Requerimento aberto">Aberto</span>
      </a>`;
    }
    if (contagens.requerimentos > MAX_POR_CATEGORIA) {
      html += `<a class="busca-ver-todos" href="os.html?tipo=Requerimento">Ver todos os ${contagens.requerimentos} requerimentos →</a>`;
    }
  }

  // ── Alvarás (último por regulado) ──
  if (resultados.alvaras.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Alvarás</div>';
    for (const a of resultados.alvaras) {
      const id = itemId();
      const nome = a._fantasia || a._razao || '(sem vínculo cadastral)';
      const badge = _badgeAlvara(a.Dt_validade);
      const emissao = a.Dt_emite ? 'Emissão: ' + _esc(a.Dt_emite) : '';
      const validade = a.Dt_validade ? 'Validade: ' + _esc(a.Dt_validade) : '';
      const datas = [emissao, validade].filter(Boolean).join(' · ');
      const sub = datas || (a.Autoridade ? _esc(a.Autoridade) : '');
      const exerc = a.Exercicio ? ` (${_esc(a.Exercicio)})` : '';
      html += `<a id="${id}" class="busca-item" href="alvara.html?q=${q}" role="option">
        <span class="busca-item-icon" aria-hidden="true">🏦</span>
        <div>
          <span class="busca-item-nome">Alv. ${_esc(a.Numero)}${exerc} · ${_esc(nome)}</span>
          <span class="busca-item-sub">${sub}${a._documento ? ' · ' + _esc(a._documento) : ''}</span>
        </div>
        ${badge}
      </a>`;
    }
    if (contagens.alvaras > MAX_POR_CATEGORIA) {
      html += `<a class="busca-ver-todos" href="alvara.html?q=${q}">Ver todos os ${contagens.alvaras} alvarás →</a>`;
    }
  }

  painel.innerHTML = html;
  painel.hidden = false;
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 5 — UI: SPINNER, PAINEL, INTERAÇÕES
   ══════════════════════════════════════════════════════════════════════════ */

function mostrarSpinnerNoCampo(show) {
  const icon = document.getElementById('buscaIcon');
  if (!icon) return;
  if (show) {
    icon.innerHTML = '<span class="busca-spinner"></span>';
  } else {
    icon.textContent = '🔍';
  }
}

function mostrarLoading() {
  const painel = document.getElementById('buscaResultado');
  if (!painel) return;
  painel.innerHTML = '<div class="busca-loading"><span class="busca-spinner"></span> Carregando dados…</div>';
  painel.hidden = false;
}

function mostrarVazio(mensagem) {
  const painel = document.getElementById('buscaResultado');
  if (!painel) return;
  painel.innerHTML = `<div class="busca-vazio">${mensagem}</div>`;
  painel.hidden = false;
}

function fecharPainel() {
  const painel = document.getElementById('buscaResultado');
  if (painel) {
    painel.hidden = true;
    painel.innerHTML = '';
  }
  _indiceSelecionado = -1;
  const campo = document.getElementById('buscaGlobal');
  if (campo) campo.removeAttribute('aria-activedescendant');
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 6 — NAVEGAÇÃO POR TECLADO
   ══════════════════════════════════════════════════════════════════════════ */

let _indiceSelecionado = -1;

function _getItensNavegaveis() {
  const painel = document.getElementById('buscaResultado');
  if (!painel || painel.hidden) return [];
  return Array.from(painel.querySelectorAll('.busca-item'));
}

function _atualizarSelecao(itens) {
  const campo = document.getElementById('buscaGlobal');
  itens.forEach((el, i) => {
    if (i === _indiceSelecionado) {
      el.classList.add('busca-item--ativo');
      el.scrollIntoView({ block: 'nearest' });
      if (campo) campo.setAttribute('aria-activedescendant', el.id);
    } else {
      el.classList.remove('busca-item--ativo');
    }
  });
}

function _onKeyDown(e) {
  const painel = document.getElementById('buscaResultado');
  const campo  = document.getElementById('buscaGlobal');
  if (!painel || painel.hidden) return;
  const itens = _getItensNavegaveis();
  if (itens.length === 0) return;
  if (e.key === 'ArrowDown') {
    e.preventDefault();
    _indiceSelecionado = (_indiceSelecionado + 1) % itens.length;
    _atualizarSelecao(itens);
  } else if (e.key === 'ArrowUp') {
    e.preventDefault();
    _indiceSelecionado = _indiceSelecionado <= 0 ? itens.length - 1 : _indiceSelecionado - 1;
    _atualizarSelecao(itens);
  } else if (e.key === 'Enter' && _indiceSelecionado >= 0 && itens[_indiceSelecionado]) {
    e.preventDefault();
    itens[_indiceSelecionado].click();
  } else if (e.key === 'Escape') {
    e.preventDefault();
    fecharPainel();
    if (campo) campo.focus();
  }
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 7 — INICIALIZAÇÃO (ENTRY POINT)
   ══════════════════════════════════════════════════════════════════════════ */

let _timerDebounce  = null;
let _inicializado   = false;

export function initBuscaGlobal() {
  if (_inicializado) return;
  _inicializado = true;

  const campo = document.getElementById('buscaGlobal');
  if (!campo) {
    console.warn('[BuscaGlobal] Campo #buscaGlobal não encontrado');
    _inicializado = false;
    return;
  }

  const executarBusca = () => {
    const termo = campo.value.trim();
    if (termo.length < MIN_CHARS) {
      mostrarVazio('Digite pelo menos 3 caracteres para buscar');
      return;
    }
    _executarBuscaUI(termo);
  };

  const btnBuscar = document.getElementById('buscaBtnBuscar');
  if (btnBuscar) btnBuscar.addEventListener('click', executarBusca);

  campo.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') { e.preventDefault(); executarBusca(); }
  });

  campo.addEventListener('keydown', _onKeyDown);

  document.addEventListener('keydown', (e) => {
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
      e.preventDefault();
      campo.focus();
      campo.select();
    }
  });

  document.addEventListener('mousedown', (e) => {
    const container = document.querySelector('.busca-global-container');
    if (container && !container.contains(e.target)) fecharPainel();
  });

  console.log('[BuscaGlobal] Inicializado');
}

async function _executarBuscaUI(termo) {
  const termoNorm = norm(termo);
  if (!termoNorm || termoNorm.length < MIN_CHARS) { fecharPainel(); return; }

  if (!_cacheBusca) mostrarLoading();

  const dados = await garantirDadosCarregados();
  if (!dados) {
    const painel = document.getElementById('buscaResultado');
    if (painel) {
      painel.innerHTML = '<div class="busca-vazio">Erro ao carregar dados. Tente novamente.</div>';
      painel.hidden = false;
    }
    return;
  }

  const campoAtual = document.getElementById('buscaGlobal');
  if (campoAtual && campoAtual.value.trim() !== termo) return;

  _indiceSelecionado = -1;
  const { resultados, contagens } = executarBuscaComContagem(dados, termoNorm);
  renderizarResultados(resultados, contagens, termo);
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 8 — LIMPEZA DE CACHE
   ══════════════════════════════════════════════════════════════════════════ */

export function limparCacheBusca() {
  _cacheBusca = null;
  _promiseCarregamento = null;
  _inicializado = false;
}
