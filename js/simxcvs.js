/**
 * simxcvs.js — Comparação de CNAEs SIM × CVS
 * VISA Anápolis
 *
 * Fontes:
 *   CVS  → data/reg/XX/XXXXX.json  (campo atividades[].subclasse)
 *   SIM  → data/cnae_aux.csv       (campo CNAE)
 *   Chave principal → MUNICIPAL em regulados.csv ↔ INSCRICAO_ISS em cnae_aux.csv
 *   Fallback        → CNPJ (CGC) ou CPF
 *   Competência     → data/cnae.csv (Subclasse)
 */
(() => {
  "use strict";

  /* ══════════════════════════════════════════════════════════
     HELPERS
  ══════════════════════════════════════════════════════════ */

  const byId = (id) => document.getElementById(id);
  const pad5 = (n)  => String(n ?? "").padStart(5, "0");

  /** Remove qualquer caractere não-dígito */
  const onlyDigits = (s) => String(s || "").replace(/\D+/g, "");

  /** Normaliza a inscrição municipal:
   *  "29.601"  → "29601"
   *  "001.732" → "1732"
   *  Remove pontos, aspas, converte para inteiro sem zeros à esquerda.
   *  Retorna null quando o resultado é zero ou inválido.
   */
  function normInscricao(s) {
    const digits = String(s || "").replace(/\D/g, "");
    const n = parseInt(digits, 10);
    return isNaN(n) || n === 0 ? null : String(n);
  }

  /** Normaliza subclasse CNAE para comparação.
   *  "4721-1/04" → "4721-1/04" (trim + upper)
   *  Mantém o formato original; apenas garante maiúsculas e sem espaços. */
  function normCnae(s) {
    return String(s || "").trim().toUpperCase();
  }

  /** Normaliza texto para busca (lower + trim) */
  const normSearch = (s) => String(s || "").toLowerCase().trim();

  /* ══════════════════════════════════════════════════════════
     FETCH / CSV
  ══════════════════════════════════════════════════════════ */

  async function fetchJson(url) {
    const r = await fetch(url, { cache: "no-store" });
    if (!r.ok) throw new Error(`HTTP ${r.status} ao buscar ${url}`);
    return r.json();
  }

  async function fetchLastModified(url) {
    try {
      const r = await fetch(url, { method: "HEAD", cache: "no-store" });
      return r.headers.get("Last-Modified") || null;
    } catch { return null; }
  }

  function formatCsvDate(lm) {
    if (!lm) return "";
    try {
      return new Date(lm).toLocaleString("pt-BR", {
        day: "2-digit", month: "2-digit", year: "numeric",
        hour: "2-digit", minute: "2-digit",
      });
    } catch { return ""; }
  }

  /**
   * Carrega um CSV via PapaParse.
   * @param {string} url
   * @param {string[]|null} campos  - colunas a manter (null = todas)
   * @param {string|null}   encoding - encoding do arquivo (ex: 'windows-1252').
   *   Quando informado, busca os bytes brutos e decodifica antes de parsear,
   *   evitando mojibake em arquivos Latin-1/Windows-1252.
   * @returns {Promise<object[]>}
   */
  async function parseCSV(url, campos = null, encoding = null) {
    let text;
    if (encoding) {
      const r = await fetch(url, { cache: "no-store" });
      if (!r.ok) throw new Error(`HTTP ${r.status} ao buscar ${url}`);
      const buf = await r.arrayBuffer();
      text = new TextDecoder(encoding).decode(buf);
    }

    return new Promise((resolve, reject) => {
      const opts = {
        header:         true,
        delimiter:      ";",
        skipEmptyLines: true,
        complete: (results) => {
          let data = results.data;
          if (campos && data.length > 0) {
            const set = new Set(campos);
            data = data.map((row) => {
              const out = {};
              for (const c of set) if (c in row) out[c] = row[c];
              return out;
            });
          }
          resolve(data);
        },
        error: reject,
      };

      if (text !== undefined) {
        // Já decodificado: parsear string diretamente
        Papa.parse(text, opts);
      } else {
        // Deixa o PapaParse baixar (UTF-8 padrão)
        Papa.parse(url, { ...opts, download: true });
      }
    });
  }

  /* ══════════════════════════════════════════════════════════
     ESTADO
  ══════════════════════════════════════════════════════════ */

  let indexItems  = [];               // index_regulados.json → dados[]
  let visaSet     = new Set();        // subclasses em cnae.csv (competência VISA)
  // SIM: dois índices sobre cnae_aux.csv
  let simByInscricao = new Map();     // inscricao_norm → cnae_aux row[]
  let simByDoc       = new Map();     // digits-only doc → cnae_aux row[]
  // Regulados: mapa de CODIGO → info de inscrição e doc
  let reguladosMap   = new Map();     // codigo_str → { municipal, cgc, cpf }
  // Data/hora do arquivo cnae_aux.csv (Last-Modified)
  let simCsvDate     = null;

  /* ══════════════════════════════════════════════════════════
     ELEMENTOS DOM
  ══════════════════════════════════════════════════════════ */

  const els = {
    q:           byId("q"),
    btnClear:    byId("btnClear"),
    status:      byId("status"),
    results:     byId("results"),
    detailPanel: byId("detailPanel"),
    btnClose:    byId("btnClose"),
    dTitle:      byId("dTitle"),
    dSub:        byId("dSub"),
    matchInfo:   byId("matchInfo"),
    cvsCount:    byId("cvsCount"),
    simCount:    byId("simCount"),
    cvsTableWrap:byId("cvsTableWrap"),
    simTableWrap:byId("simTableWrap"),
  };

  /* ══════════════════════════════════════════════════════════
     UI HELPERS
  ══════════════════════════════════════════════════════════ */

  function showStatus(msg, cls = "") {
    if (!els.status) return;
    els.status.textContent = msg;
    els.status.className   = "status-text" + (cls ? " " + cls : "");
  }

  function showDetail()  { if (els.detailPanel) els.detailPanel.hidden = false; }
  function hideDetail()  { if (els.detailPanel) els.detailPanel.hidden = true;  }

  /* ══════════════════════════════════════════════════════════
     CARGA DE DADOS (paralela na inicialização)
  ══════════════════════════════════════════════════════════ */

  async function loadData() {
    showStatus("Carregando dados (isso pode levar alguns segundos)...", "loading");

    const ts = `v=${Date.now()}`;

    const [indexRoot, auxRows, regRows, cnaeRows, auxLastModified] = await Promise.all([
      fetchJson(`./data/index_regulados.json?${ts}`),
      parseCSV(`./data/cnae_aux.csv?${ts}`,   ["INSCRICAO_ISS", "CNAE", "ATIVIDADE", "DOCUMENTO"], "windows-1252"),
      parseCSV(`./data/regulados.csv?${ts}`,   ["CODIGO", "MUNICIPAL", "CGC", "CPF"]),
      parseCSV(`./data/cnae.csv?${ts}`,        ["Subclasse"]),
      fetchLastModified(`./data/cnae_aux.csv?${ts}`),
    ]);
    simCsvDate = auxLastModified;

    /* ── Índice de busca ─────────────────────────────────── */
    indexItems = Array.isArray(indexRoot?.dados)
      ? indexRoot.dados
      : Array.isArray(indexRoot) ? indexRoot : [];

    /* ── VISA competência ────────────────────────────────── */
    for (const row of cnaeRows) {
      const sub = row["Subclasse"] || row["subclasse"] || "";
      if (sub) visaSet.add(normCnae(sub));
    }

    /* ── Mapa inscrição → info (de regulados.csv) ─────────
       O campo MUNICIPAL vem entre aspas e com pontos: "29.601"
       Normalização: remover aspas + pontos, converter para inteiro. */
    for (const row of regRows) {
      const codigo = String(row["CODIGO"] || "").replace(/"/g, "").trim();
      if (!codigo) continue;
      reguladosMap.set(codigo, {
        municipal: normInscricao(row["MUNICIPAL"] || ""),
        cgc:       onlyDigits(row["CGC"] || ""),
        cpf:       onlyDigits(row["CPF"] || ""),
      });
    }

    /* ── Índices do SIM (cnae_aux.csv) ──────────────────── */
    for (const row of auxRows) {
      const insc = normInscricao(row["INSCRICAO_ISS"] || "");
      const doc  = onlyDigits(row["DOCUMENTO"] || "");

      if (insc) {
        if (!simByInscricao.has(insc)) simByInscricao.set(insc, []);
        simByInscricao.get(insc).push(row);
      }
      if (doc) {
        if (!simByDoc.has(doc)) simByDoc.set(doc, []);
        simByDoc.get(doc).push(row);
      }
    }

    showStatus(`Pronto. ${indexItems.length} regulados no índice.`, "ready");
    renderResults(indexItems.slice(0, 80));
  }

  /* ══════════════════════════════════════════════════════════
     BUSCA / FILTRO
  ══════════════════════════════════════════════════════════ */

  function applyFilter() {
    const q      = normSearch(els.q?.value || "");
    if (!q) {
      renderResults(indexItems.slice(0, 80));
      showStatus(`Pronto. (${indexItems.length} no índice)`, "ready");
      return;
    }
    const qDigits = onlyDigits(q);
    const out = [];
    for (const it of indexItems) {
      const hay = `${it.razao || ""} ${it.fantasia || ""} ${it.documento || ""} ${it.codigo || ""}`.toLowerCase();
      if (hay.includes(q)) out.push(it);
      else if (qDigits && onlyDigits(it.documento || "").includes(qDigits)) out.push(it);
      else if (qDigits && String(it.codigo || "").includes(qDigits)) out.push(it);
      if (out.length >= 80) break;
    }
    renderResults(out);
    showStatus(`${out.length} encontrado(s).`, "ready");
  }

  /* ══════════════════════════════════════════════════════════
     RENDER: LISTA DE RESULTADOS
  ══════════════════════════════════════════════════════════ */

  function renderResults(list) {
    if (!els.results) return;
    els.results.innerHTML = "";
    if (!list || list.length === 0) {
      els.results.innerHTML = `<div style="color:var(--muted);padding:12px 0;font-size:.95em;">Nenhum regulado encontrado.</div>`;
      return;
    }
    const frag = document.createDocumentFragment();
    for (const it of list.slice(0, 80)) {
      const btn = document.createElement("button");
      btn.type      = "button";
      btn.className = "result-item";
      btn.innerHTML = `
        <div class="result-item__title">${esc(it.razao || "—")}</div>
        <div class="result-item__sub">
          Fantasia: ${esc(it.fantasia || "—")} &nbsp;·&nbsp; Documento: ${esc(it.documento || "—")} &nbsp;·&nbsp; #${it.codigo}
        </div>`;
      btn.addEventListener("click", () => loadComparison(it.codigo));
      frag.appendChild(btn);
    }
    els.results.appendChild(frag);
  }

  /* ══════════════════════════════════════════════════════════
     CARREGAR REGULADO E COMPARAR
  ══════════════════════════════════════════════════════════ */

  async function loadComparison(codigo) {
    showStatus("Carregando comparação...", "loading");
    hideDetail();

    const c    = Number(codigo);
    const file = pad5(c);
    const pref = file.slice(0, 2);
    const reg  = await fetchJson(`./data/reg/${pref}/${file}.json`);

    /* ── Buscar CNAEs no SIM ─────────────────────────────── */
    const info = reguladosMap.get(String(c)) || {};
    let simRows     = null;
    let matchMethod = null;
    let matchCls    = "match-badge--err";

    if (info.municipal && simByInscricao.has(info.municipal)) {
      simRows     = simByInscricao.get(info.municipal);
      matchMethod = `via inscrição municipal ${info.municipal}`;
      matchCls    = "match-badge--ok";
    } else if (info.cgc && simByDoc.has(info.cgc)) {
      simRows     = simByDoc.get(info.cgc);
      matchMethod = `via CNPJ ${reg.cnpj || info.cgc}`;
      matchCls    = "match-badge--warn";
    } else if (info.cpf && simByDoc.has(info.cpf)) {
      simRows     = simByDoc.get(info.cpf);
      matchMethod = `via CPF ${reg.cpf || info.cpf}`;
      matchCls    = "match-badge--warn";
    }

    renderComparison(reg, simRows, matchMethod, matchCls);
    showDetail();
    showStatus("Comparação carregada.", "ready");
    els.detailPanel?.scrollIntoView?.({ behavior: "smooth", block: "start" });
  }

  /* ══════════════════════════════════════════════════════════
     RENDER: PAINEL DE COMPARAÇÃO
  ══════════════════════════════════════════════════════════ */

  function renderComparison(reg, simRows, matchMethod, matchCls) {
    /* ── Cabeçalho ─────────────────────────────────────────── */
    if (els.dTitle) els.dTitle.textContent = reg.razao  || "—";
    if (els.dSub)   els.dSub.textContent   = reg.fantasia || "—";

    /* Documento + inscrição no sub */
    const doc = reg.cnpj || reg.cpf || "—";
    if (els.dSub) {
      const info = reguladosMap.get(String(reg.codigo)) || {};
      const insc = info.municipal ? ` · Insc. ${info.municipal}` : "";
      els.dSub.textContent = `${doc}${insc}`;
    }

    /* Faixa de correspondência */
    if (els.matchInfo) {
      const csvDateHtml = simCsvDate
        ? `<span style="margin-left:auto;font-size:.8em;color:#64748b;white-space:nowrap;padding-left:12px;">📅 SIM: ${esc(formatCsvDate(simCsvDate))}</span>`
        : "";
      if (matchMethod) {
        els.matchInfo.innerHTML =
          `🔗 Encontrado no SIM <span class="match-badge ${matchCls}">${esc(matchMethod)}</span>${csvDateHtml}`;
      } else {
        els.matchInfo.innerHTML =
          `<span class="match-badge match-badge--err">⚠️ Contribuinte não encontrado no SIM (sem inscrição, CNPJ ou CPF correspondente)</span>${csvDateHtml}`;
      }
    }

    /* ── Conjuntos para comparação ─────────────────────────── */
    const cvsAtvs = Array.isArray(reg.atividades) ? reg.atividades : [];

    // Set normalizado de subclasses CVS → lookup rápido
    const cvsNormSet = new Set(cvsAtvs.map((a) => normCnae(a.subclasse)));

    // Set normalizado de subclasses SIM → lookup rápido
    // Remove duplicatas (cnae_aux pode ter o mesmo CNAE repetido por endereço)
    const simUniq    = [];
    const simNormSet = new Set();
    for (const r of (simRows || [])) {
      const nc = normCnae(r["CNAE"] || "");
      if (nc && !simNormSet.has(nc)) {
        simNormSet.add(nc);
        simUniq.push(r);
      }
    }

    /* ── Tabela CVS ────────────────────────────────────────── */
    if (els.cvsCount) els.cvsCount.textContent = cvsAtvs.length;
    if (els.cvsTableWrap) {
      els.cvsTableWrap.innerHTML = buildTable(
        cvsAtvs.map((a) => {
          const nc     = normCnae(a.subclasse);
          const inSim  = simNormSet.has(nc);
          const inVisa = visaSet.has(nc);
          return {
            subclasse: a.subclasse || "—",
            descricao: a.atividade || "—",
            status:    inSim ? "AMBOS" : "SÓ CVS",
            compete:   inVisa,
          };
        }),
        "Nenhuma atividade cadastrada no CVS."
      );
    }

    /* ── Tabela SIM ────────────────────────────────────────── */
    if (els.simCount) els.simCount.textContent = simUniq.length;
    if (els.simTableWrap) {
      if (!simRows) {
        els.simTableWrap.innerHTML =
          `<div class="empty-msg">Contribuinte não localizado no SIM.</div>`;
      } else {
        els.simTableWrap.innerHTML = buildTable(
          simUniq.map((r) => {
            const nc     = normCnae(r["CNAE"] || "");
            const inCvs  = cvsNormSet.has(nc);
            const inVisa = visaSet.has(nc);
            return {
              subclasse: r["CNAE"]     || "—",
              descricao: r["ATIVIDADE"]|| "—",
              status:    inCvs ? "AMBOS" : "SÓ SIM",
              compete:   inVisa,
            };
          }),
          "Nenhum CNAE ativo no SIM para este contribuinte."
        );
      }
    }
  }

  /* ══════════════════════════════════════════════════════════
     BUILD TABLE
  ══════════════════════════════════════════════════════════ */

  /**
   * Gera o HTML de uma tabela de comparação.
   * @param {{ subclasse, descricao, status, compete }[]} rows
   * @param {string} emptyMsg
   */
  function buildTable(rows, emptyMsg) {
    if (!rows || rows.length === 0) {
      return `<div class="empty-msg">${emptyMsg}</div>`;
    }

    const trRows = rows.map((r) => {
      const badge = r.compete ? badgeHtml(r.status) : `<span class="badge badge--nao-comp">Não Compete</span>`;
      return `
        <tr>
          <td>${badge}</td>
          <td style="white-space:nowrap"><span class="subclasse-code">${esc(r.subclasse)}</span></td>
          <td><span class="descricao-text">${esc(r.descricao)}</span></td>
        </tr>`;
    }).join("");

    return `
      <table class="cmp-table">
        <thead>
          <tr>
            <th>Status</th>
            <th>Subclasse</th>
            <th>Descrição</th>
          </tr>
        </thead>
        <tbody>${trRows}</tbody>
      </table>`;
  }

  /** Retorna o HTML do badge principal de status */
  function badgeHtml(status) {
    switch (status) {
      case "AMBOS":   return `<span class="badge badge--ambos">AMBOS</span>`;
      case "SÓ CVS":  return `<span class="badge badge--so-cvs">SÓ CVS</span>`;
      case "SÓ SIM":  return `<span class="badge badge--so-sim">SÓ SIM</span>`;
      default:        return `<span class="badge">${esc(status)}</span>`;
    }
  }

  /** Escape simples de HTML */
  function esc(s) {
    return String(s || "")
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
  }

  /* ══════════════════════════════════════════════════════════
     INIT
  ══════════════════════════════════════════════════════════ */

  window.addEventListener("DOMContentLoaded", async () => {
    try {
      await loadData();
    } catch (e) {
      showStatus(`Erro ao carregar dados: ${e.message}`, "error");
      console.error("[simxcvs] Erro na carga:", e);
    }

    els.q?.addEventListener("input", applyFilter);

    els.btnClear?.addEventListener("click", () => {
      if (els.q) els.q.value = "";
      hideDetail();
      applyFilter();
      els.q?.focus?.();
    });

    els.btnClose?.addEventListener("click", hideDetail);
  });
})();
