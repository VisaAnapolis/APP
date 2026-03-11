/**
 * BUSCA-GLOBAL.JS — Pesquisa Global Unificada
 * VISA Anápolis — v1.2.2
 *
 * Módulo ES6 que implementa busca unificada no Dashboard.
 * Consulta: regulados (JSON), protocolos, denúncias, requerimentos,
 * ofícios, alvarás via CSVs e inspeções via JSONs individuais
 * (data/reg/XX/CODIGO.json) com cache em memória e lazy loading.
 *
 * Exporta: initBuscaGlobal(), limparCacheBusca()
 */

/* ── Constantes ─────────────────────────────────────────────────────────── */
const MAX_POR_CATEGORIA    = 5;
const MAX_INSPECOES_VISITA = 5;
const MAX_FETCH_REG_JSON   = 20;
const DEBOUNCE_MS          = 400;
const MIN_CHARS            = 3;

/* ── Cache em memória (singleton por sessão/aba) ────────────────────────── */
let _cacheBusca          = null;
let _promiseCarregamento = null;

/* ── Cache de JSONs individuais de regulados (por código) ───────────────── */
const _cacheRegJSON = new Map();

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 1 — CARREGAMENTO E CACHE DE DADOS
   ══════════════════════════════════════════════════════════════════════════ */

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

async function _carregarTudo() {
  mostrarSpinnerNoCampo(true);

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
               ['Oficio', 'Regulado', 'Cnpj', 'Logradouro', 'Motivo',
                'Prazo', 'Fiscalencaminha', 'Cancela', 'Archive']),
      parseCSV(`data/alvara.csv?d=${hoje}`,
               ['Controle', 'Codigo', 'Numero', 'Exercicio',
                'Dt_emite', 'Dt_validade', 'Autoridade', 'Cancela'])
    ]);

  const regulados = reguladosJson.dados || reguladosJson;

  const denuncias = denunciasRaw;

  const requerimentosAtivos = requerimentosRaw.filter(r =>
    !_processarBool(r.Atendimento) && !_processarBool(r.Cancelado)
  );

  const mapaUltimoRequerimento = new Map();
  for (const r of requerimentosAtivos) {
    const cod = String(r.Codigo || '').trim();
    if (!cod) continue;
    const existente = mapaUltimoRequerimento.get(cod);
    const osA = parseInt(r.OS, 10) || 0;
    const osE = existente ? (parseInt(existente.OS, 10) || 0) : -1;
    if (!existente || osA > osE) mapaUltimoRequerimento.set(cod, r);
  }
  const requerimentos = Array.from(mapaUltimoRequerimento.values());

  const oficios = oficiosRaw.filter(o =>
    !_processarBool(o.Cancela) && !_processarBool(o.Archive)
  );

  const alvarasAtivos = alvarasRaw.filter(a => !String(a.Cancela || '').trim());

  const mapaUltimoAlvara = new Map();
  for (const a of alvarasAtivos) {
    const cod = String(a.Codigo || '').trim();
    if (!cod) continue;
    const existente = mapaUltimoAlvara.get(cod);
    const exercA = parseInt(a.Exercicio, 10) || 0;
    const exercE = existente ? (parseInt(existente.Exercicio, 10) || 0) : -1;
    if (!existente || exercA > exercE) mapaUltimoAlvara.set(cod, a);
  }
  const alvarasUltimos = Array.from(mapaUltimoAlvara.values());

  const mapaRegulados = new Map();
  for (const r of regulados) mapaRegulados.set(String(r.codigo).trim(), r);

  const mapaReguladosPorDoc = new Map();
  for (const r of regulados) {
    const docNorm = norm(r.documento);
    if (docNorm) mapaReguladosPorDoc.set(docNorm, r);
  }

  for (const a of alvarasUltimos) {
    const reg = mapaRegulados.get(String(a.Codigo || '').trim());
    if (reg) {
      a._fantasia = reg.fantasia; a._razao = reg.razao; a._documento = reg.documento;
      a._fantasia_n = norm(reg.fantasia); a._razao_n = norm(reg.razao); a._documento_n = norm(reg.documento);
    }
    a._numero_n = norm(a.Numero); a._autoridade_n = norm(a.Autoridade);
  }

  for (const r of requerimentos) {
    const reg = mapaRegulados.get(String(r.Codigo || '').trim());
    if (reg) {
      r._fantasia = reg.fantasia; r._razao = reg.razao; r._documento = reg.documento;
      r._fantasia_n = norm(reg.fantasia); r._razao_n = norm(reg.razao); r._documento_n = norm(reg.documento);
    } else {
      r._fantasia = ''; r._razao = ''; r._documento = '';
      r._fantasia_n = norm(r.Requerente); r._razao_n = ''; r._documento_n = '';
    }
    r._requerente_n = norm(r.Requerente);
  }

  for (const o of oficios) {
    const reg = mapaReguladosPorDoc.get(norm(o.Cnpj));
    if (reg) {
      o._fantasia = reg.fantasia; o._razao = reg.razao; o._documento = reg.documento;
      o._fantasia_n = norm(reg.fantasia); o._razao_n = norm(reg.razao); o._documento_n = norm(reg.documento);
    } else {
      o._fantasia = ''; o._razao = ''; o._documento = '';
      o._fantasia_n = norm(o.Regulado); o._razao_n = ''; o._documento_n = norm(o.Cnpj);
    }
    o._motivo_n = norm(o.Motivo);
  }

  for (const d of denuncias) {
    const reg = mapaReguladosPorDoc.get(norm(d.Cnpj));
    if (reg) {
      d._fantasia = reg.fantasia; d._razao = reg.razao; d._documento = reg.documento;
      d._fantasia_n = norm(reg.fantasia); d._razao_n = norm(reg.razao); d._documento_n = norm(reg.documento);
    } else {
      d._fantasia = ''; d._razao = ''; d._documento = '';
      d._fantasia_n = norm(d.Reclamado); d._razao_n = ''; d._documento_n = norm(d.Cnpj);
    }
  }

  for (const p of protocolos) {
    const reg = mapaRegulados.get(String(p.Codigo || '').trim());
    if (reg) {
      p._fantasia = reg.fantasia; p._razao = reg.razao; p._documento = reg.documento;
      p._fantasia_n = norm(reg.fantasia); p._razao_n = norm(reg.razao); p._documento_n = norm(reg.documento);
    } else {
      p._fantasia = ''; p._razao = ''; p._documento = '';
      p._fantasia_n = ''; p._razao_n = ''; p._documento_n = '';
    }
  }

  const mapaTramitacao = new Map();
  for (const t of tramitacoes) {
    const proto = (t.PROTOCOLO || '').trim();
    if (!proto) continue;
    const existente = mapaTramitacao.get(proto);
    if (!existente || (t.DATA || '') > (existente.DATA || '')) mapaTramitacao.set(proto, t);
  }

  mostrarSpinnerNoCampo(false);

  return { regulados, protocolos, tramitacoes, denuncias,
           requerimentos, oficios, alvaras: alvarasUltimos,
           mapaRegulados, mapaReguladosPorDoc, mapaTramitacao };
}

/* ── Busca JSON individual de um regulado com cache por sessão ──────────── */
function _prefixoReg(codigo) {
  return String(codigo).substring(0, 2);
}

async function _fetchRegJSON(codigo) {
  const chave = String(codigo);
  if (_cacheRegJSON.has(chave)) return _cacheRegJSON.get(chave);
  const prefixo = _prefixoReg(chave);
  const hoje = new Date().toISOString().slice(0, 10);
  try {
    const r = await fetch(`data/reg/${prefixo}/${chave}.json?d=${hoje}`);
    if (!r.ok) return null;
    const json = await r.json();
    _cacheRegJSON.set(chave, json);
    return json;
  } catch {
    return null;
  }
}

function parseCSV(url, campos = null) {
  return new Promise((resolve, reject) => {
    Papa.parse(url, {
      download: true, header: true, delimiter: ';', skipEmptyLines: true,
      complete: (results) => {
        if (campos && results.data.length > 0) {
          const camposSet = new Set(campos);
          resolve(results.data.map(row => {
            const filtrado = {};
            for (const c of camposSet) { if (c in row) filtrado[c] = row[c]; }
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

function _processarBool(valor) {
  const v = String(valor || '').toUpperCase().trim();
  return v === 'TRUE' || v === 'SIM' || v === 'T' || v === 'S';
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 2 — NORMALIZAÇÃO E MATCHING
   ══════════════════════════════════════════════════════════════════════════ */

function norm(s) {
  return String(s || '')
    .toUpperCase().trim()
    .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
    .replace(/[.\-\/]+/g, '').replace(/\s+/g, ' ');
}

function match(campo, termoNorm) { return norm(campo).includes(termoNorm); }

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 3 — BUSCA EM TODAS AS FONTES
   ══════════════════════════════════════════════════════════════════════════ */

function _buscarSincrono(dados, termoNorm) {
  const resultados = {};
  const contagens  = {};

  function buscar(fonte, chave, matchFn, transformFn) {
    const lista = []; let total = 0;
    for (const item of fonte) {
      if (matchFn(item)) {
        total++;
        if (lista.length < MAX_POR_CATEGORIA) lista.push(transformFn ? transformFn(item) : item);
      }
    }
    resultados[chave] = lista; contagens[chave] = total;
  }

  buscar(dados.regulados, 'regulados',
    r => match(r.fantasia, termoNorm) || match(r.razao, termoNorm) || match(r.documento, termoNorm)
  );

  buscar(dados.protocolos, 'protocolos',
    p => (p._fantasia_n && p._fantasia_n.includes(termoNorm)) ||
         (p._razao_n && p._razao_n.includes(termoNorm)) ||
         (p._documento_n && p._documento_n.includes(termoNorm)) ||
         match(p.Protocolo, termoNorm) || match(p.Protocolante, termoNorm) || match(p.Assunto, termoNorm),
    p => {
      const tram = dados.mapaTramitacao.get((p.Protocolo || '').trim());
      const reg  = dados.mapaRegulados.get(String(p.Codigo || '').trim());
      return { ...p, _tramitacao: tram || null,
               _razao: reg ? reg.razao : (p._razao || ''),
               _fantasia: reg ? reg.fantasia : (p._fantasia || ''),
               _documento: reg ? reg.documento : (p._documento || '') };
    }
  );

  buscar(dados.denuncias, 'denuncias',
    d => (d._fantasia_n && d._fantasia_n.includes(termoNorm)) ||
         (d._razao_n && d._razao_n.includes(termoNorm)) ||
         (d._documento_n && d._documento_n.includes(termoNorm)) ||
         match(d.Denuncia, termoNorm) || match(d.Logradouro, termoNorm)
  );

  buscar(dados.oficios, 'oficios',
    o => (o._fantasia_n && o._fantasia_n.includes(termoNorm)) ||
         (o._razao_n && o._razao_n.includes(termoNorm)) ||
         (o._documento_n && o._documento_n.includes(termoNorm)) ||
         match(o.Oficio, termoNorm) ||
         (o._motivo_n && o._motivo_n.includes(termoNorm))
  );

  buscar(dados.requerimentos, 'requerimentos',
    r => (r._fantasia_n  && r._fantasia_n.includes(termoNorm)) ||
         (r._razao_n     && r._razao_n.includes(termoNorm)) ||
         (r._documento_n && r._documento_n.includes(termoNorm)) ||
         (r._requerente_n && r._requerente_n.includes(termoNorm)) ||
         match(r.OS, termoNorm)
  );

  buscar(dados.alvaras, 'alvaras',
    a => (a._fantasia_n  && a._fantasia_n.includes(termoNorm)) ||
         (a._razao_n     && a._razao_n.includes(termoNorm)) ||
         (a._documento_n && a._documento_n.includes(termoNorm)) ||
         a._numero_n.includes(termoNorm) || a._autoridade_n.includes(termoNorm)
  );

  return { resultados, contagens };
}

/* ── Busca inspeções sob demanda nos JSONs dos regulados encontrados ────── */
async function _buscarInspecoes(dados, termoNorm) {
  const reguladosMatch = [];
  for (const r of dados.regulados) {
    if (match(r.fantasia, termoNorm) || match(r.razao, termoNorm) || match(r.documento, termoNorm)) {
      reguladosMatch.push(r);
      if (reguladosMatch.length >= MAX_FETCH_REG_JSON) break;
    }
  }

  if (reguladosMatch.length === 0) return { lista: [], total: 0 };

  const jsons = await Promise.all(
    reguladosMatch.map(r => _fetchRegJSON(String(r.codigo)))
  );

  const lista = [];
  let total = 0;

  for (let idx = 0; idx < reguladosMatch.length; idx++) {
    const json = jsons[idx];
    if (!json || !Array.isArray(json.inspecoes) || json.inspecoes.length === 0) continue;

    const termoEhFiscal = !match(json.fantasia, termoNorm) &&
                          !match(json.razao, termoNorm) &&
                          !match(json.cnpj, termoNorm);
    if (termoEhFiscal) {
      const temFiscal = json.inspecoes.some(v =>
        match(v.Fiscal1, termoNorm) || match(v.Fiscal2, termoNorm) || match(v.Fiscal3, termoNorm)
      );
      if (!temFiscal) continue;
    }

    total++;
    if (lista.length < MAX_POR_CATEGORIA) {
      lista.push({
        _codigo:   json.codigo,
        _fantasia: json.fantasia,
        _razao:    json.razao,
        _cnpj:     json.cnpj,
        inspecoes: json.inspecoes.slice(0, MAX_INSPECOES_VISITA)
      });
    }
  }

  return { lista, total };
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 4 — RENDERIZAÇÃO DO DROPDOWN
   ══════════════════════════════════════════════════════════════════════════ */

function _esc(s) {
  const d = document.createElement('div');
  d.textContent = String(s || '');
  return d.innerHTML;
}

/**
 * Monta o bloco padrão de nome para TODAS as categorias:
 *   linha principal → <strong>RAZÃO SOCIAL</strong> (fantasia)
 *   se só um existe → exibe o que houver, sem negrito desnecessário
 * @param {string} razao
 * @param {string} fantasia
 * @param {string} [fallback] - usado quando nenhum dos dois existe (ex: Requerente)
 * @returns {string} HTML seguro
 */
function _nomeRegulado(razao, fantasia, fallback = '') {
  const r = (razao   || '').trim();
  const f = (fantasia || '').trim();
  if (r && f && r !== f) {
    return `<strong>${_esc(r)}</strong> <span class="busca-item-fantasia">(${_esc(f)})</span>`;
  }
  if (r) return `<strong>${_esc(r)}</strong>`;
  if (f) return `<strong>${_esc(f)}</strong>`;
  return _esc(fallback);
}

function _badgeAlvara(dtValidade) {
  if (!dtValidade || !dtValidade.trim()) return '';
  const partes = dtValidade.trim().split('.');
  if (partes.length !== 3) return '';
  const dataVal = new Date(+partes[2], +partes[1] - 1, +partes[0]);
  if (isNaN(dataVal.getTime())) return '';
  const hoje = new Date(); hoje.setHours(0, 0, 0, 0);
  const diff = Math.floor((dataVal - hoje) / 86400000);
  if (diff < 0)   return '<span class="busca-item-badge badge-vencida">Vencido</span>';
  if (diff <= 30) return '<span class="busca-item-badge badge-avencer">A vencer</span>';
  return '<span class="busca-item-badge badge-ok">Vigente</span>';
}

function _isoParaExibicao(iso) {
  if (!iso) return '';
  const p = iso.split('-');
  if (p.length !== 3) return iso;
  return `${p[2]}/${p[1]}/${p[0]}`;
}

function renderizarResultados(resultados, contagens, inspecoes, totalInspecoes, termoOriginal) {
  const painel = document.getElementById('buscaResultado');
  if (!painel) return;

  const totalExibido = Object.values(resultados).reduce((s, arr) => s + arr.length, 0)
                     + inspecoes.length;
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
      const id  = itemId();
      const qReg = encodeURIComponent(r.documento || r.fantasia || r.razao || '');
      html += `<a id="${id}" class="busca-item" href="cvs.html?q=${qReg}" role="option">
        <span class="busca-item-icon" aria-hidden="true">🏪</span>
        <div>
          <span class="busca-item-nome">${_nomeRegulado(r.razao, r.fantasia)}</span>
          <span class="busca-item-sub">${_esc(r.documento)}</span>
        </div>
      </a>`;
    }
    if (contagens.regulados > MAX_POR_CATEGORIA)
      html += `<a class="busca-ver-todos" href="cvs.html?q=${q}">Ver todos os ${contagens.regulados} resultados →</a>`;
  }

  // ── Protocolos ──
  if (resultados.protocolos.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Protocolos</div>';
    for (const p of resultados.protocolos) {
      const id = itemId();
      const tram = p._tramitacao;
      const arquivado = tram && (tram.DESTINO || '').trim().toUpperCase() === 'ARQUIVO';
      const tramInfo  = tram && !arquivado ? ` → ${_esc(tram.DESTINO)} · ${_esc(tram.DATA)}` : '';
      const badge = arquivado
        ? '<span class="busca-item-badge badge-ok">Arquivado</span>'
        : '<span class="busca-item-badge badge-aberto">Protocolo</span>';
      const qProto = encodeURIComponent(p.Protocolo || p._documento || p._razao || p._fantasia || p.Protocolante || '');
      html += `<a id="${id}" class="busca-item" href="protocolo.html?q=${qProto}" role="option">
        <span class="busca-item-icon" aria-hidden="true">📋</span>
        <div>
          <span class="busca-item-nome">${_esc(p.Protocolo)} · ${_nomeRegulado(p._razao, p._fantasia, p.Protocolante)}</span>
          <span class="busca-item-sub">${_esc(p.Assunto)}${p._documento ? ' · ' + _esc(p._documento) : ''}${tramInfo}</span>
        </div>
        ${badge}
      </a>`;
    }
    if (contagens.protocolos > MAX_POR_CATEGORIA)
      html += `<a class="busca-ver-todos" href="protocolo.html?q=${q}">Ver todos os ${contagens.protocolos} resultados →</a>`;
  }

  // ── Denúncias ──
  if (resultados.denuncias.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Denúncias</div>';
    for (const d of resultados.denuncias) {
      const id = itemId();
      const atendida = _processarBool(d.Archive);
      const badge = atendida
        ? '<span class="busca-item-badge badge-ok">Atendida</span>'
        : '<span class="busca-item-badge badge-aberto">Aberta</span>';
      html += `<a id="${id}" class="busca-item" href="os.html?tipo=Den%C3%BAncia&numero=${encodeURIComponent(d.Denuncia||'')}" role="option">
        <span class="busca-item-icon" aria-hidden="true">⚠️</span>
        <div>
          <span class="busca-item-nome">${_esc(d.Denuncia)} · ${_nomeRegulado(d._razao, d._fantasia, d.Reclamado)}</span>
          <span class="busca-item-sub">${_esc(d.Logradouro)}${d.Cnpj ? ' · ' + _esc(d.Cnpj) : ''}</span>
        </div>
        ${badge}
      </a>`;
    }
    if (contagens.denuncias > MAX_POR_CATEGORIA)
      html += `<a class="busca-ver-todos" href="os.html?tipo=Den%C3%BAncia&q=${q}">Ver todas as ${contagens.denuncias} denúncias →</a>`;
  }

  // ── Ofícios ──
  if (resultados.oficios.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Ofícios</div>';
    for (const o of resultados.oficios) {
      const id = itemId();
      const subParts = [
        o.Motivo     ? _esc(o.Motivo)     : '',
        o.Cnpj       ? _esc(o.Cnpj)       : '',
        o.Logradouro ? _esc(o.Logradouro) : ''
      ].filter(Boolean);
      html += `<a id="${id}" class="busca-item" href="os.html?tipo=Of%C3%ADcio&numero=${encodeURIComponent(o.Oficio||'')}" role="option">
        <span class="busca-item-icon" aria-hidden="true">📨</span>
        <div>
          <span class="busca-item-nome">${_esc(o.Oficio)} · ${_nomeRegulado(o._razao, o._fantasia, o.Regulado)}</span>
          <span class="busca-item-sub">${subParts.join(' · ')}</span>
        </div>
        <span class="busca-item-badge badge-aberto">Aberto</span>
      </a>`;
    }
    if (contagens.oficios > MAX_POR_CATEGORIA)
      html += `<a class="busca-ver-todos" href="os.html?tipo=Of%C3%ADcio&q=${q}">Ver todos os ${contagens.oficios} ofícios →</a>`;
  }

  // ── Requerimentos ──
  if (resultados.requerimentos.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Requerimentos</div>';
    for (const r of resultados.requerimentos) {
      const id = itemId();
      html += `<a id="${id}" class="busca-item" href="os.html?tipo=Requerimento&numero=${encodeURIComponent(r.OS||'')}" role="option">
        <span class="busca-item-icon" aria-hidden="true">📝</span>
        <div>
          <span class="busca-item-nome">OS ${_esc(r.OS)} · ${_nomeRegulado(r._razao, r._fantasia, r.Requerente)}</span>
          <span class="busca-item-sub">${r._documento ? _esc(r._documento) + ' · ' : ''}${r.Prazo ? 'Prazo: ' + _esc(r.Prazo) : ''}</span>
        </div>
        <span class="busca-item-badge badge-aberto">Aberto</span>
      </a>`;
    }
    if (contagens.requerimentos > MAX_POR_CATEGORIA)
      html += `<a class="busca-ver-todos" href="os.html?tipo=Requerimento&q=${q}">Ver todos os ${contagens.requerimentos} requerimentos →</a>`;
  }

  // ── Alvarás ──
  if (resultados.alvaras.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Alvarás</div>';
    for (const a of resultados.alvaras) {
      const id    = itemId();
      const badge = _badgeAlvara(a.Dt_validade);
      const emissao  = a.Dt_emite    ? 'Emissão: '  + _esc(a.Dt_emite)    : '';
      const validade = a.Dt_validade ? 'Validade: ' + _esc(a.Dt_validade) : '';
      const datas    = [emissao, validade].filter(Boolean).join(' · ');
      const sub      = datas || (a.Autoridade ? _esc(a.Autoridade) : '');
      const exerc    = a.Exercicio ? ` (${_esc(a.Exercicio)})` : '';
      html += `<a id="${id}" class="busca-item" href="alvara.html?numero=${encodeURIComponent(a.Numero||'')}" role="option">
        <span class="busca-item-icon" aria-hidden="true">🏦</span>
        <div>
          <span class="busca-item-nome">Alv. ${_esc(a.Numero)}${exerc} · ${_nomeRegulado(a._razao, a._fantasia)}</span>
          <span class="busca-item-sub">${sub}${a._documento ? ' · ' + _esc(a._documento) : ''}</span>
        </div>
        ${badge}
      </a>`;
    }
    if (contagens.alvaras > MAX_POR_CATEGORIA)
      html += `<a class="busca-ver-todos" href="alvara.html?q=${q}">Ver todos os ${contagens.alvaras} alvarás →</a>`;
  }

  // ── Inspeções ──
  if (inspecoes.length > 0) {
    html += '<div class="busca-grupo-titulo" aria-hidden="true">Inspeções</div>';
    for (const est of inspecoes) {
      const id   = itemId();
      const href = `cvs.html?codigo=${encodeURIComponent(String(est._codigo || ''))}`;

      let visitasHtml = '<ul class="busca-insp-lista">';
      for (const v of est.inspecoes) {
        const dt     = _isoParaExibicao(v.dt_visita);
        const numer  = v.numer && v.numer !== '000000' ? _esc(v.numer) : '—';
        const fiscais = [v.Fiscal1, v.Fiscal2, v.Fiscal3]
          .filter(Boolean)
          .map(f => _esc(f.split(' ')[0]))
          .join(', ');
        visitasHtml += `<li class="busca-insp-row">
          <span class="busca-insp-col-dt">${_esc(dt)}<br><span class="busca-insp-numer">${numer}</span></span>
          <span class="busca-insp-col-tipo">${_esc(v.tipo || '')}</span>
          <span class="busca-insp-col-fiscal">${fiscais}</span>
        </li>`;
      }
      visitasHtml += '</ul>';

      html += `<a id="${id}" class="busca-item busca-item--inspecoes" href="${href}" role="option">
        <span class="busca-item-icon" aria-hidden="true">👁️</span>
        <div class="busca-item-corpo">
          <span class="busca-item-nome">${_nomeRegulado(est._razao, est._fantasia)}</span>
          <span class="busca-item-sub">${_esc(est._cnpj || '')}</span>
          ${visitasHtml}
        </div>
        <span class="busca-item-badge badge-aberto">Inspeção</span>
      </a>`;
    }
    if (totalInspecoes > MAX_POR_CATEGORIA)
      html += `<a class="busca-ver-todos" href="inspecoes.html?q=${q}">Ver todos os ${totalInspecoes} resultados →</a>`;
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
  icon.innerHTML = show ? '<span class="busca-spinner"></span>' : '';
  if (!show) icon.textContent = '🔍';
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
  if (painel) { painel.hidden = true; painel.innerHTML = ''; }
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
    e.preventDefault(); itens[_indiceSelecionado].click();
  } else if (e.key === 'Escape') {
    e.preventDefault(); fecharPainel(); if (campo) campo.focus();
  }
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 7 — INICIALIZAÇÃO (ENTRY POINT)
   ══════════════════════════════════════════════════════════════════════════ */

let _timerDebounce = null;
let _inicializado  = false;

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
    if (termo.length < MIN_CHARS) { mostrarVazio('Digite pelo menos 3 caracteres para buscar'); return; }
    _executarBuscaUI(termo);
  };

  const btnBuscar = document.getElementById('buscaBtnBuscar');
  if (btnBuscar) btnBuscar.addEventListener('click', executarBusca);

  campo.addEventListener('keypress', (e) => { if (e.key === 'Enter') { e.preventDefault(); executarBusca(); } });
  campo.addEventListener('keydown', _onKeyDown);

  document.addEventListener('keydown', (e) => {
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') { e.preventDefault(); campo.focus(); campo.select(); }
  });

  document.addEventListener('mousedown', (e) => {
    const container = document.querySelector('.busca-global-container');
    if (container && !container.contains(e.target)) fecharPainel();
  });

  console.log('[BuscaGlobal] Inicializado v1.2.2');
}

async function _executarBuscaUI(termo) {
  const termoNorm = norm(termo);
  if (!termoNorm || termoNorm.length < MIN_CHARS) { fecharPainel(); return; }

  if (!_cacheBusca) mostrarLoading();

  const dados = await garantirDadosCarregados();
  if (!dados) {
    const painel = document.getElementById('buscaResultado');
    if (painel) { painel.innerHTML = '<div class="busca-vazio">Erro ao carregar dados. Tente novamente.</div>'; painel.hidden = false; }
    return;
  }

  const campoAtual = document.getElementById('buscaGlobal');
  if (campoAtual && campoAtual.value.trim() !== termo) return;

  const { resultados, contagens } = _buscarSincrono(dados, termoNorm);

  _indiceSelecionado = -1;
  renderizarResultados(resultados, contagens, [], 0, termo);

  const { lista: inspecoes, total: totalInsp } = await _buscarInspecoes(dados, termoNorm);

  if (campoAtual && campoAtual.value.trim() !== termo) return;

  renderizarResultados(resultados, contagens, inspecoes, totalInsp, termo);
}

/* ══════════════════════════════════════════════════════════════════════════
   SEÇÃO 8 — LIMPEZA DE CACHE
   ══════════════════════════════════════════════════════════════════════════ */

export function limparCacheBusca() {
  _cacheBusca = null;
  _promiseCarregamento = null;
  _cacheRegJSON.clear();
  _inicializado = false;
}
