(() => {
  "use strict";

  const byId = (id) => document.getElementById(id);
  const pad5 = (n) => String(n ?? "").padStart(5, "0");
  const regPrefix = (codigo) => pad5(codigo).slice(0, 2);
  const hisBucket = (ndoc) => String((Number(ndoc) || 0) % 100).padStart(2, "0");
  function formatDateBR(dateStr) {
    if (!dateStr || dateStr === "—" || dateStr === "-") return "—";
    const str = String(dateStr).trim();
    if (/^\d{2}\/\d{2}\/\d{4}$/.test(str)) {
      return str;
    }
    if (/^\d{4}[-\/]\d{2}[-\/]\d{2}/.test(str)) {
      const parts = str.split(/[-\/T ]/);
      if (parts.length >= 3) {
        const [ano, mes, dia] = parts;
        return `${dia.padStart(2, '0')}/${mes.padStart(2, '0')}/${ano}`;
      }
    }
    if (/^\d{2}[-]\d{2}[-]\d{4}$/.test(str)) {
      const [dia, mes, ano] = str.split('-');
      return `${dia}/${mes}/${ano}`;
    }
    const d = new Date(str);
    if (!isNaN(d.getTime())) {
      const dia = String(d.getDate()).padStart(2, '0');
      const mes = String(d.getMonth() + 1).padStart(2, '0');
      const ano = d.getFullYear();
      return `${dia}/${mes}/${ano}`;
    }
    return str;
  }

  function safeText(el, v) {
    if (!el) return;
    el.textContent = (v === null || v === undefined || v === "") ? "—" : String(v);
  }

  function onlyDigits(s) {
    return String(s || "").replace(/\D+/g, "");
  }

  function normalize(s) {
    return String(s || "").toLowerCase().trim()
      .normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  }

  function normMunicipal(s) {
    const digits = String(s || "").replace(/\D+/g, "");
    const n = parseInt(digits, 10);
    return isNaN(n) || n === 0 ? "" : String(n);
  }

  function normTxt(v) {
    return (v == null ? "" : String(v)).trim();
  }

  async function fetchJson(url) {
    const r = await fetch(url, { cache: "no-store" });
    if (!r.ok) {
      const txt = await r.text().catch(() => "");
      throw new Error(`HTTP ${r.status} em ${url}${txt ? `\n${txt.slice(0, 200)}` : ""}`);
    }
    return r.json();
  }

  const els = {
    q: byId("q"),
    btnClear: byId("btnClear"),
    status: byId("status"),
    results: byId("results"),
    detailPanel: byId("detailPanel"),
    btnCloseDetail: byId("btnCloseDetail"),
    dTitle: byId("dTitle"),
    dSub: byId("dSub"),
    dCodigoLabel: byId("dCodigoLabel"),
    dCodigo: byId("dCodigo"),
    dDoc: byId("dDoc"),
    dEnd: byId("dEnd"),
    dBairro: byId("dBairro"),
    dMaps: byId("dMaps"),
    dAlvEx: byId("dAlvEx"),
    dAlvVal: byId("dAlvVal"),
    btnAtividades: byId("btnAtividades"),
    btnInspecoes: byId("btnInspecoes"),
    atividadesList: byId("atividadesList"),
    inspecoesList: byId("inspecoesList"),
    modalBackdrop: byId("modalBackdrop"),
    modal: byId("modal"),
    modalTitle: byId("modalTitle"),
    modalMemo: byId("modalMemo"),
    btnCloseModal: byId("btnCloseModal"),
  };

  let indexItems = [];
  let currentInspecaoInfo = null;
  let municipalMap     = new Map(); // CODIGO (string) → MUNICIPAL raw (for display)
  let municipalNormMap = new Map(); // CODIGO (string) → MUNICIPAL digits-only (for search)
  let taxaMap          = new Map(); // Inscrição Municipal (string) → dados da taxa
  let taxaTimestamp    = "";        // Data de atualização do arquivo taxa.csv

  function showStatus(msg) { safeText(els.status, msg || ""); }
  function hideDetail() {
    if (els.detailPanel) els.detailPanel.hidden = true;
    const taxaCard = byId("taxaCard");
    if (taxaCard) taxaCard.style.display = "none";
  }
  function showDetail() { if (els.detailPanel) els.detailPanel.hidden = false; }

  function closeModal() {
    if (els.modalBackdrop) els.modalBackdrop.hidden = true;
    if (els.modal) els.modal.hidden = true;
    safeText(els.modalTitle, "");
    safeText(els.modalMemo, "");
    currentInspecaoInfo = null;
  }

  function openModal(title, memo) {
    safeText(els.modalTitle, title || "Histórico");
    safeText(els.modalMemo, memo || "");
    if (els.modalBackdrop) els.modalBackdrop.hidden = false;
    if (els.modal) els.modal.hidden = false;
  }

  async function loadMunicipalData() {
    try {
      const url = `./data/regulados.csv?v=${Date.now()}`;
      const r = await fetch(url, { cache: "no-store" });
      if (!r.ok) return;
      const text = await r.text();
      if (typeof Papa === "undefined") {
        // Fallback: manual semicolon-delimited CSV parsing
        const lines = text.split(/\r?\n/);
        if (lines.length < 2) return;
        const headers = lines[0].split(";").map(h => h.trim().replace(/^"|"$/g, ""));
        const codigoIdx = headers.indexOf("CODIGO");
        const municipalIdx = headers.indexOf("MUNICIPAL");
        if (codigoIdx < 0 || municipalIdx < 0) return;
        for (let i = 1; i < lines.length; i++) {
          const parts = lines[i].split(";").map(p => p.trim().replace(/^"|"$/g, ""));
          const codigo = parts[codigoIdx] || "";
          const municipal = parts[municipalIdx] || "";
          if (codigo && municipal) {
            municipalMap.set(codigo, municipal);
            municipalNormMap.set(codigo, normMunicipal(municipal));
          }
        }
      } else {
        const result = Papa.parse(text, {
          header: true,
          delimiter: ";",
          skipEmptyLines: true,
        });
        for (const row of result.data) {
          const codigo = String(row["CODIGO"] || "").trim();
          const municipal = String(row["MUNICIPAL"] || "").trim();
          if (codigo && municipal) {
            municipalMap.set(codigo, municipal);
            municipalNormMap.set(codigo, normMunicipal(municipal));
          }
        }
      }
    } catch (e) {
      console.warn("Falha ao carregar inscrições municipais:", e);
    }
  }

  async function loadTaxaData() {
    try {
      const url = `./data/taxa.csv?v=${Date.now()}`;
      const r = await fetch(url, { cache: "no-store" });
      if (!r.ok) return;
      const lastMod = r.headers.get("Last-Modified");
      if (lastMod) {
        const d = new Date(lastMod);
        const hh = String(d.getHours()).padStart(2, "0");
        const mm = String(d.getMinutes()).padStart(2, "0");
        const dd = String(d.getDate()).padStart(2, "0");
        const mo = String(d.getMonth() + 1).padStart(2, "0");
        const aa = d.getFullYear();
        taxaTimestamp = `${hh}:${mm} ${dd}/${mo}/${aa}`;
      }
      const buf = await r.arrayBuffer();
      const rawText = new TextDecoder("iso-8859-1").decode(buf);
      // Join "* Área:" continuation lines to their parent row so Papa.parse
      // treats them as part of the same Observação field.
      const text = rawText.replace(/\r?\n(\* Área:)/g, "$1");
      const result = Papa.parse(text, {
        header: true,
        delimiter: ";",
        skipEmptyLines: true,
      });
      for (const row of result.data) {
        const im = normMunicipal(String(row["Inscrição Municipal"] || "").trim());
        if (!im) continue;
        const obs = String(row["Observação"] || row["Observacao"] || "");
        const matchAtividade = obs.match(/Atividade:\s*(.+?)\.?\s*(?:\*|$)/);
        const matchArea = obs.match(/Área:\s*([^*\r\n]+)/);
        taxaMap.set(im, {
          valor: String(row["Valor"] || "").trim(),
          situacao: String(row["Sit. da conta"] || "").trim(),
          atividade: matchAtividade ? matchAtividade[1].trim() : "",
          area: matchArea ? matchArea[1].trim().replace(/\.?\s*$/, "") : "",
          vencimento: String(row["Dt. Vencimento"] || "").trim(),
          exercicio: String(row["Exercício"] || row["Exercicio"] || "").trim(),
          lancamento: String(row["Ano Lançamento"] || row["Ano Lancamento"] || "").trim(),
        });
      }
    } catch (e) {
      console.warn("Falha ao carregar taxa.csv:", e);
    }
  }

  function renderResults(list) {
    if (!els.results) return;
    els.results.innerHTML = "";
    if (!list || list.length === 0) {
      const div = document.createElement("div");
      div.className = "small";
      div.textContent = "Nenhum regulado encontrado.";
      els.results.appendChild(div);
      return;
    }
    const frag = document.createDocumentFragment();
    for (const it of list.slice(0, 80)) {
      const btn = document.createElement("button");
      btn.type = "button";
      btn.className = "result";
      btn.dataset.codigo = String(it.codigo);
      const top = document.createElement("div");
      top.className = "result__top";
      const left = document.createElement("div");
      const title = document.createElement("div");
      title.className = "result__title";
      title.textContent = it.razao || "—";
      const sub = document.createElement("div");
      sub.className = "result__sub";
      const fant = it.fantasia ? `Fantasia: ${it.fantasia}` : "Fantasia: —";
      const doc = it.documento ? `Documento: ${it.documento}` : "Documento: —";
      sub.textContent = `${fant} · ${doc}`;
      left.appendChild(title);
      left.appendChild(sub);
      const tag = document.createElement("div");
      tag.className = "tag";
      tag.textContent = `#${it.codigo}`;
      top.appendChild(left);
      top.appendChild(tag);
      btn.appendChild(top);
      btn.addEventListener("click", () => loadRegulado(it.codigo));
      frag.appendChild(btn);
    }
    els.results.appendChild(frag);
  }

  function renderDetail(reg) {
    safeText(els.dTitle, reg.razao || "—");
    safeText(els.dSub, reg.fantasia || "—");
    const codigoStr = String(reg.codigo || "");
    const municipal = municipalMap.get(codigoStr) || "";
    if (municipal) {
      safeText(els.dCodigo, municipal);
      if (els.dCodigoLabel) els.dCodigoLabel.textContent = "🏛️ Insc. Municipal";
    } else {
      safeText(els.dCodigo, codigoStr || "—");
      if (els.dCodigoLabel) els.dCodigoLabel.textContent = "📋 Código";
    }
    const doc = reg.cnpj || reg.cpf || "—";
    safeText(els.dDoc, doc);

    const e = reg.endereco || {};
    const endParts = [];
    if (e.logradouro) endParts.push(e.logradouro);
    if (e.complemento) endParts.push(e.complemento);
    const fones = [];
    if (e.fone) fones.push(`Fone: ${e.fone}`);
    if (e.celular) fones.push(`Celular: ${e.celular}`);
    const endTxt = [
      endParts.length ? endParts.join(" · ") : "—",
      fones.length ? fones.join(" · ") : ""
    ].filter(Boolean).join(" · ");
    safeText(els.dEnd, endTxt || "—");

    const b = reg.bairro || {};
    safeText(els.dBairro, b.nome || "—");

    if (els.dMaps) {
      const q = encodeURIComponent([endParts.join(", "), b.nome, "Anápolis GO"].filter(Boolean).join(" - "));
      els.dMaps.innerHTML = q
        ? `<a href="https://www.google.com/maps/search/?api=1&query=${q}" target="_blank" rel="noopener noreferrer">📍 Abrir no Google Maps</a>`
        : "";
    }

    const alv = reg.alvara_ultimo;
    if (alv && typeof alv === "object") {
      safeText(els.dAlvEx, alv.exercicio ?? "—");
      safeText(els.dAlvVal, formatDateBR(alv.dt_validade) ?? "—");
    } else {
      safeText(els.dAlvEx, "—");
      safeText(els.dAlvVal, "—");
    }

    // Taxa de Vigilância Sanitária
    const taxaCard = byId("taxaCard");
    const taxaKv = byId("taxaKv");
    if (taxaCard && taxaKv) {
      const im = normMunicipal(municipal || "");
      const taxa = taxaMap.get(im);
      if (taxa) {
        taxaCard.style.display = "";
        taxaKv.innerHTML = "";

        const kValor = document.createElement("div");
        kValor.className = "kv__k";
        kValor.textContent = "💲 Valor";
        const vValor = document.createElement("div");
        vValor.className = "kv__v";
        vValor.textContent = taxa.valor ? `R$ ${taxa.valor}` : "—";

        const kAtiv = document.createElement("div");
        kAtiv.className = "kv__k";
        kAtiv.textContent = "🏷️ Atividade";
        const vAtiv = document.createElement("div");
        vAtiv.className = "kv__v";
        vAtiv.textContent = taxa.atividade || "—";

        const kArea = document.createElement("div");
        kArea.className = "kv__k";
        kArea.textContent = "📐 Área";
        const vArea = document.createElement("div");
        vArea.className = "kv__v";
        vArea.textContent = taxa.area || "—";

        const kSit = document.createElement("div");
        kSit.className = "kv__k";
        kSit.textContent = "📌 Situação";
        const vSit = document.createElement("div");
        vSit.className = "kv__v";
        const sitLower = (taxa.situacao || "").toLowerCase();
        let sitColor = "inherit";
        if (sitLower.includes("pago")) {
          sitColor = "#10b981";
        } else if (sitLower.includes("dívida") || sitLower.includes("divida")) {
          sitColor = "#ef4444";
        }
        const sitSpan = document.createElement("span");
        sitSpan.style.color = sitColor;
        sitSpan.style.fontWeight = "700";
        sitSpan.textContent = `● ${taxa.situacao || "—"}`;
        vSit.appendChild(sitSpan);

        const kVenc = document.createElement("div");
        kVenc.className = "kv__k";
        kVenc.textContent = "📅 Vencimento";
        const vVenc = document.createElement("div");
        vVenc.className = "kv__v";
        vVenc.textContent = formatDateBR(taxa.vencimento) || "—";

        const kExerc = document.createElement("div");
        kExerc.className = "kv__k";
        kExerc.textContent = "📆 Exercício";
        const vExerc = document.createElement("div");
        vExerc.className = "kv__v";
        vExerc.textContent = taxa.exercicio || "—";

        if (taxaTimestamp) {
          const kSync = document.createElement("div");
          kSync.className = "kv__k";
          kSync.style.cssText = "grid-column:1/-1; color:var(--muted,#64748b); font-size:0.78rem; font-style:italic; padding-top:6px;";
          kSync.textContent = `🔄 Sincronização com o SIM: ${taxaTimestamp}`;
          taxaKv.append(kValor, vValor, kAtiv, vAtiv, kArea, vArea, kVenc, vVenc, kExerc, vExerc, kSit, vSit, kSync);
        } else {
          taxaKv.append(kValor, vValor, kAtiv, vAtiv, kArea, vArea, kVenc, vVenc, kExerc, vExerc, kSit, vSit);
        }
      } else {
        taxaCard.style.display = "";
        taxaKv.innerHTML = "";
        const msg = document.createElement("p");
        msg.className = "taxa-not-found";
        msg.textContent = "Taxa não encontrada para esta inscrição municipal.";
        taxaKv.appendChild(msg);
      }
    }

    // Atividades
    const atvs = Array.isArray(reg.atividades) ? reg.atividades : [];
    if (els.atividadesList) {
      els.atividadesList.innerHTML = "";
      if (atvs.length === 0) {
        const div = document.createElement("div");
        div.className = "small";
        div.textContent = "Nenhuma atividade encontrada.";
        els.atividadesList.appendChild(div);
      } else {
        for (const a of atvs) {
          const item = document.createElement("div");
          item.className = "item";
          const top = document.createElement("div");
          top.className = "item__top";
          const t = document.createElement("div");
          t.className = "item__title";
          t.textContent = a.subclasse ? `${a.subclasse}` : "—";
          const badge = document.createElement("div");
          badge.className = "tag";
          badge.textContent = a.tipo || "—";
          top.appendChild(t);
          top.appendChild(badge);
          const sub = document.createElement("div");
          sub.className = "item__sub";
          const linha = [
            a.atividade ? a.atividade : null,
            a.equipe ? `Equipe: ${a.equipe}` : null,
            a.complexidade ? `Complexidade: ${a.complexidade}` : null
          ].filter(Boolean).join(" · ");
          sub.textContent = linha || "—";
          item.appendChild(top);
          item.appendChild(sub);
          els.atividadesList.appendChild(item);
        }
      }
    }

    // Inspeções
    const insps = Array.isArray(reg.inspecoes) ? reg.inspecoes : [];
    if (els.inspecoesList) {
      els.inspecoesList.innerHTML = "";
      if (insps.length === 0) {
        const div = document.createElement("div");
        div.className = "small";
        div.textContent = "Nenhuma inspeção encontrada.";
        els.inspecoesList.appendChild(div);
      } else {
        for (const v of insps) {
          const item = document.createElement("div");
          item.className = "item";
          const top = document.createElement("div");
          top.className = "item__top";
          const title = document.createElement("div");
          title.className = "item__title";
          const dt = formatDateBR(v.dt_visita) || "—";
          const tipo = v.tipo || "—";
          const num = v.numer || "—";
          title.textContent = `${tipo} ${num} · ${dt}`;
          const badge = document.createElement("div");
          badge.className = "tag";
          badge.textContent = (v.pz_retorno !== undefined && v.pz_retorno !== null)
            ? `Prazo: ${v.pz_retorno} dia(s)`
            : "Prazo: —";
          top.appendChild(title);
          top.appendChild(badge);
          const sub = document.createElement("div");
          sub.className = "item__sub";

          let fiscaisBox = null;
          const f1 = normTxt(v.Fiscal1);
          const f2 = normTxt(v.Fiscal2);
          const f3 = normTxt(v.Fiscal3);
          const fiscaisValidos = [f1, f2, f3].filter(Boolean);
          if (fiscaisValidos.length > 0) {
            fiscaisBox = document.createElement("div");
            fiscaisBox.className = "insp-fiscais";
            const label = document.createElement("div");
            label.className = "insp-fiscais__label";
            label.textContent = "👮 Fiscais";
            fiscaisBox.appendChild(label);
            const vals = document.createElement("div");
            vals.className = "insp-fiscais__vals";
            for (const nome of fiscaisValidos) {
              const linha = document.createElement("div");
              linha.className = "insp-fiscal";
              linha.textContent = "• " + nome;
              vals.appendChild(linha);
            }
            fiscaisBox.appendChild(vals);
          }

          const ndoc = Number(v.ndoc || 0);
          if (ndoc > 0) {
            const btn = document.createElement("button");
            btn.type = "button";
            btn.className = "btn";
            btn.style.padding = "8px 10px";
            btn.textContent = "📄 Abrir documento";
            const inspecaoTipo = tipo;
            const inspecaoNum = num;
            btn.addEventListener("click", async (ev) => {
              ev.preventDefault();
              ev.stopPropagation();
              try {
                await openHistorico(ndoc, inspecaoTipo, inspecaoNum);
              } catch (e) {
                openModal("Erro ao abrir histórico", String(e.message || e));
              }
            });
            sub.textContent = "Histórico: ";
            sub.appendChild(btn);
          } else {
            sub.textContent = "Histórico: —";
          }

          item.appendChild(top);
          if (fiscaisBox) item.appendChild(fiscaisBox);
          item.appendChild(sub);
          els.inspecoesList.appendChild(item);
        }
      }
    }
  }

  async function loadRegulado(codigo) {
    const c = Number(codigo);
    const file = pad5(c);
    const path = `./data/reg/${regPrefix(c)}/${file}.json`;
    showStatus(`Carregando regulado #${c}...`);
    hideDetail();
    const reg = await fetchJson(path);
    renderDetail(reg);
    showDetail();
    showStatus(`Regulado ${c} carregado.`);
    els.detailPanel?.scrollIntoView?.({ behavior: "smooth", block: "start" });
  }

  async function openHistorico(ndoc, tipo, numer) {
    const b = hisBucket(ndoc);
    const path = `./data/his/${b}/${ndoc}.json`;
    let titulo;
    if (tipo && tipo !== "—" && numer && numer !== "—") {
      titulo = `${tipo} ${numer}`;
    } else if (tipo && tipo !== "—") {
      titulo = `${tipo} (Doc. ${ndoc})`;
    } else {
      titulo = `Documento ${ndoc}`;
    }
    try {
      const h = await fetchJson(path);
      const conteudo = (h && (h.decr || h.descr)) ? (h.decr || h.descr) : "Documento sem conteúdo digitado.";
      openModal(titulo, conteudo);
    } catch (e) {
      openModal(titulo, "Documento sem conteúdo digitado.");
    }
  }

  function applyFilter() {
    const q = normalize(els.q?.value || "");
    if (!q) {
      renderResults(indexItems.slice(0, 80));
      showStatus(`Pronto. (${indexItems.length} no índice)`);
      return;
    }
    const qDigits = onlyDigits(q);
    const qMunicipal = normMunicipal(q);
    // Only search by municipal inscription when input is short (≤6 digits, not a CPF/CNPJ)
    const tryMunicipal = qMunicipal.length >= 2 && qMunicipal.length <= 6 && municipalNormMap.size > 0;
    const out = [];
    for (const it of indexItems) {
      const codigoStr = String(it.codigo || "");
      const hay = `${it.razao || ""} ${it.fantasia || ""} ${it.documento || ""} ${codigoStr}`.toLowerCase()
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "");
      if (tryMunicipal) {
        const mNorm = municipalNormMap.get(codigoStr) || "";
        if (mNorm && (mNorm === qMunicipal || (mNorm.startsWith(qMunicipal) && qMunicipal.length >= 3))) {
          out.push(it); if (out.length >= 80) break; continue;
        }
      }
      if (hay.includes(q)) out.push(it);
      else if (qDigits && onlyDigits(it.documento || "").includes(qDigits)) out.push(it);
      else if (qDigits && codigoStr.includes(qDigits)) out.push(it);
      if (out.length >= 80) break;
    }
    renderResults(out);
    showStatus(`${out.length} encontrado(s).`);
  }

  async function init() {
    closeModal();
    hideDetail();
    showStatus("Carregando índice...");
    const url = `./data/index_regulados.json?v=${Date.now()}`;
    const root = await fetchJson(url);
    indexItems = Array.isArray(root?.dados) ? root.dados : (Array.isArray(root) ? root : []);
    showStatus(`Índice carregado (${indexItems.length}).`);
    renderResults(indexItems.slice(0, 80));

    // Carrega inscrições municipais em segundo plano (não bloqueia UI)
    loadMunicipalData().catch(() => {});
    loadTaxaData().catch(() => {});

    const urlParams = new URLSearchParams(window.location.search);

    // ── ?codigo= : abertura direta do regulado (vindo de inspeções da busca global) ──
    const codigoParam = urlParams.get('codigo');
    if (codigoParam && /^\d+$/.test(codigoParam.trim())) {
      try {
        await loadRegulado(Number(codigoParam.trim()));
      } catch (e) {
        showStatus(`Regulado #${codigoParam} não encontrado.`);
      }
    } else {
      // ── ?q= : filtro de texto (comportamento original) ──
      const qParam = urlParams.get('q');
      if (qParam && els.q) {
        els.q.value = qParam;
        applyFilter();
      }
    }

    els.q?.addEventListener("input", applyFilter);
    els.btnClear?.addEventListener("click", () => {
      if (els.q) els.q.value = "";
      closeModal();
      hideDetail();
      applyFilter();
      els.q?.focus?.();
    });
    els.btnCloseDetail?.addEventListener("click", hideDetail);
    els.btnCloseModal?.addEventListener("click", closeModal);
    els.modalBackdrop?.addEventListener("click", closeModal);
    els.btnAtividades?.addEventListener("click", () => {
      (els.atividadesList?.closest(".card") ?? els.atividadesList)
        ?.scrollIntoView?.({ behavior: "smooth", block: "start" });
    });
    els.btnInspecoes?.addEventListener("click", () => {
      (els.inspecoesList?.closest(".card") ?? els.inspecoesList)
        ?.scrollIntoView?.({ behavior: "smooth", block: "start" });
    });
  }

  window.addEventListener("DOMContentLoaded", init);
})();
