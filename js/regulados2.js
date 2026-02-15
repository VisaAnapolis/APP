/**
 * REGULADOS V2 - Baseado em regulados1.js
 * Mantém 100% da lógica original com melhorias visuais nos cards
 */
(() => {
  "use strict";
  const byId = (id) => document.getElementById(id);
  const pad5 = (n) => String(n ?? "").padStart(5, "0");
  const regPrefix = (codigo) => pad5(codigo).slice(0, 2);
  const hisBucket = (ndoc) => String((Number(ndoc) || 0) % 100).padStart(2, "0");

  function formatDateBR(dateStr) {
    if (!dateStr || dateStr === "—" || dateStr === "-") return "—";
    const str = String(dateStr).trim();
    if (/^\d{2}\/\d{2}\/\d{4}$/.test(str)) return str;
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
    return String(s || "").toLowerCase().trim();
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
    dCodigo: byId("dCodigo"),
    dDoc: byId("dDoc"),
    dEnd: byId("dEnd"),
    dBairro: byId("dBairro"),
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

  function showStatus(msg) {
    safeText(els.status, msg || "");
  }

  function hideDetail() {
    if (els.detailPanel) els.detailPanel.hidden = true;
  }

  function showDetail() {
    if (els.detailPanel) els.detailPanel.hidden = false;
  }

  function closeModal() {
    if (els.modalBackdrop) els.modalBackdrop.style.display = "none";
    if (els.modal) els.modal.style.display = "none";
    document.body.style.overflow = "";
  }

  function openModal(title, memo) {
    safeText(els.modalTitle, title || "Histórico");
    safeText(els.modalMemo, memo || "");
    if (els.modalBackdrop) els.modalBackdrop.style.display = "block";
    if (els.modal) els.modal.style.display = "flex";
    document.body.style.overflow = "hidden";
  }

  function renderResults(list) {
    if (!els.results) return;
    els.results.innerHTML = "";

    if (!list || list.length === 0) {
      els.results.innerHTML = '<div class="hint-text">Nenhum regulado encontrado.</div>';
      return;
    }

    const frag = document.createDocumentFragment();
    for (const it of list.slice(0, 80)) {
      const btn = document.createElement("button");
      btn.type = "button";
      btn.className = "result-item"; // Usando a classe da V2

      const title = document.createElement("div");
      title.className = "result-item__title";
      title.textContent = it.razao || "—";

      const sub = document.createElement("div");
      sub.className = "result-item__sub";
      
      const docSpan = document.createElement("span");
      docSpan.textContent = it.documento || "—";
      
      const tagSpan = document.createElement("span");
      tagSpan.className = "result-item__tag-simple"; // Nova classe discreta
      tagSpan.textContent = `#${it.codigo}`;

      sub.appendChild(docSpan);
      sub.appendChild(tagSpan);

      btn.appendChild(title);
      btn.appendChild(sub);
      
      if (it.fantasia) {
        const fant = document.createElement("div");
        fant.className = "hint-text";
        fant.style.marginTop = "2px";
        fant.textContent = it.fantasia;
        btn.appendChild(fant);
      }

      btn.addEventListener("click", () => loadRegulado(it.codigo));
      frag.appendChild(btn);
    }
    els.results.appendChild(frag);
  }

  function renderDetail(reg) {
    safeText(els.dTitle, reg.razao || "—");
    safeText(els.dSub, reg.fantasia || "—");
    safeText(els.dCodigo, reg.codigo);

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

    const alv = reg.alvara_ultimo;
    if (alv && typeof alv === "object") {
      safeText(els.dAlvEx, alv.exercicio ?? "—");
      safeText(els.dAlvVal, formatDateBR(alv.dt_validade) ?? "—");
    } else {
      safeText(els.dAlvEx, "—");
      safeText(els.dAlvVal, "—");
    }

    // Atividades
    const atvs = Array.isArray(reg.atividades) ? reg.atividades : [];
    if (els.atividadesList) {
      els.atividadesList.innerHTML = "";
      if (atvs.length === 0) {
        els.atividadesList.innerHTML = '<div class="hint-text">Nenhuma atividade encontrada.</div>';
      } else {
        for (const a of atvs) {
          const item = document.createElement("div");
          item.className = "list-item";
          item.innerHTML = `
            <div class="list-item__header">
              <span class="list-item__title">${a.subclasse || "—"}</span>
              <span class="list-item__badge">${a.tipo || "—"}</span>
            </div>
            <div class="list-item__desc">
              ${[a.atividade, a.equipe ? `Equipe: ${a.equipe}` : null, a.complexidade ? `Complexidade: ${a.complexidade}` : null].filter(Boolean).join(" · ")}
            </div>
          `;
          els.atividadesList.appendChild(item);
        }
      }
    }

    // Inspeções
    const insps = Array.isArray(reg.inspecoes) ? reg.inspecoes : [];
    if (els.inspecoesList) {
      els.inspecoesList.innerHTML = "";
      if (insps.length === 0) {
        els.inspecoesList.innerHTML = '<div class="hint-text">Nenhuma inspeção encontrada.</div>';
      } else {
        for (const v of insps) {
          const item = document.createElement("div");
          item.className = "list-item";
          
          const dt = formatDateBR(v.dt_visita) || "—";
          const tipo = v.tipo || "—";
          const num = v.numer || "—";

          const top = document.createElement("div");
          top.className = "list-item__header";
          top.innerHTML = `
            <span class="list-item__title">${tipo} ${num} · ${dt}</span>
            <span class="list-item__badge">${(v.pz_retorno !== undefined && v.pz_retorno !== null) ? `Prazo: ${v.pz_retorno} d` : "Prazo: —"}</span>
          `;
          item.appendChild(top);

          // Fiscais (Lógica do regulados1.js)
          if (Array.isArray(v.fiscais) && v.fiscais.length > 0) {
            const fiscaisBox = document.createElement("div");
            fiscaisBox.className = "list-item__desc";
            fiscaisBox.style.marginTop = "4px";
            fiscaisBox.style.padding = "6px 8px";
            fiscaisBox.style.background = "var(--surface-variant)";
            fiscaisBox.style.borderRadius = "6px";
            fiscaisBox.innerHTML = "<strong>Fiscais:</strong>";
            v.fiscais.forEach(f => {
              const fDiv = document.createElement("div");
              fDiv.textContent = "• " + (f.nome || "—");
              fiscaisBox.appendChild(fDiv);
            });
            item.appendChild(fiscaisBox);
          }

          const ndoc = Number(v.ndoc || 0);
          if (ndoc > 0) {
            const btn = document.createElement("button");
            btn.className = "btn-action";
            btn.style.marginTop = "8px";
            btn.style.width = "100%";
            btn.innerHTML = "📄 Abrir documento";
            btn.onclick = () => openHistorico(ndoc, tipo, num);
            item.appendChild(btn);
          }
          els.inspecoesList.appendChild(item);
        }
      }
    }
  }

  async function loadRegulado(codigo) {
    const c = Number(codigo);
    const file = pad5(c);
    const path = `./data/reg/${regPrefix(c)}/${file}.json`;
    showStatus(`Carregando #${c}...`);
    hideDetail();
    try {
      const reg = await fetchJson(path);
      renderDetail(reg);
      showDetail();
      showStatus(`Regulado ${c} carregado.`);
      els.detailPanel?.scrollIntoView({ behavior: "smooth", block: "start" });
    } catch (e) {
      showStatus("Erro ao carregar dados.");
    }
  }

  async function openHistorico(ndoc, tipo, numer) {
    const b = hisBucket(ndoc);
    const path = `./data/his/${b}/${ndoc}.json`;
    let titulo = (tipo && numer) ? `${tipo} ${numer}` : `Documento ${ndoc}`;
    try {
      const h = await fetchJson(path);
      const conteudo = (h.decr || h.descr) || "Documento sem conteúdo digitado.";
      openModal(titulo, conteudo);
    } catch (e) {
      openModal(titulo, "Documento sem conteúdo digitado.");
    }
  }

  function applyFilter() {
    const q = normalize(els.q?.value || "");
    if (!q) {
      renderResults(indexItems.slice(0, 80));
      showStatus(`Pronto (${indexItems.length} registros)`);
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
    showStatus(`${out.length} encontrado(s).`);
  }

  async function init() {
    showStatus("Carregando índice...");
    try {
      const root = await fetchJson(`./data/index_regulados.json?v=${Date.now()}`);
      indexItems = Array.isArray(root.dados) ? root.dados : (Array.isArray(root) ? root : []);
      showStatus(`Índice carregado.`);
      renderResults(indexItems.slice(0, 80));
    } catch (e) {
      showStatus("Erro ao carregar índice.");
    }

    els.q?.addEventListener("input", applyFilter);
    els.btnClear?.addEventListener("click", () => {
      if (els.q) els.q.value = "";
      closeModal();
      hideDetail();
      applyFilter();
      els.q?.focus();
    });
    els.btnCloseDetail?.addEventListener("click", hideDetail);
    byId("btnCloseModal")?.addEventListener("click", closeModal);
    els.modalBackdrop?.addEventListener("click", closeModal);
    els.btnAtividades?.addEventListener("click", () => els.atividadesList?.scrollIntoView({ behavior: "smooth" }));
    els.btnInspecoes?.addEventListener("click", () => els.inspecoesList?.scrollIntoView({ behavior: "smooth" }));
  }

  window.addEventListener("DOMContentLoaded", init);
})();
