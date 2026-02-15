/**
 * REGULADOS V2 - Lógica de Negócio
 * Adaptado para o layout modernizado cvs2.html
 */
(function() {
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
    if (!r.ok) throw new Error(`HTTP ${r.status}`);
    return r.json();
  }

  let indexItems = [];

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
    btnCloseModal: byId("btnCloseModal")
  };

  function showStatus(msg) {
    if (els.status) els.status.textContent = msg;
  }

  function showDetail() {
    if (els.detailPanel) els.detailPanel.hidden = false;
  }

  function hideDetail() {
    if (els.detailPanel) els.detailPanel.hidden = true;
  }

  function openModal(title, content) {
    if (els.modalTitle) els.modalTitle.textContent = title;
    if (els.modalMemo) els.modalMemo.textContent = content;
    if (els.modalBackdrop) els.modalBackdrop.style.display = "block";
    if (els.modal) els.modal.style.display = "flex";
    document.body.style.overflow = "hidden";
  }

  function closeModal() {
    if (els.modalBackdrop) els.modalBackdrop.style.display = "none";
    if (els.modal) els.modal.style.display = "none";
    document.body.style.overflow = "";
  }

  function renderResults(items) {
    if (!els.results) return;
    els.results.innerHTML = "";
    if (items.length === 0) {
      els.results.innerHTML = '<div class="hint-text">Nenhum resultado encontrado.</div>';
      return;
    }

    items.forEach(it => {
      const div = document.createElement("button");
      div.className = "result-item";
      div.innerHTML = `
        <div class="result-item__title">${it.razao || "SEM RAZÃO SOCIAL"}</div>
        <div class="result-item__sub">
          <span>${it.documento || "—"}</span>
          <span class="result-item__tag">#${it.codigo}</span>
        </div>
        ${it.fantasia ? `<div class="hint-text">${it.fantasia}</div>` : ""}
      `;
      div.onclick = () => loadRegulado(it.codigo);
      els.results.appendChild(div);
    });
  }

  function renderDetail(reg) {
    const d = reg.dados || {};
    safeText(els.dTitle, d.razao);
    safeText(els.dSub, d.fantasia || d.documento);
    safeText(els.dCodigo, d.codigo);
    safeText(els.dDoc, d.documento);
    safeText(els.dEnd, d.endereco);
    safeText(els.dBairro, d.bairro);
    safeText(els.dAlvEx, d.alvara_num);
    safeText(els.dAlvVal, formatDateBR(d.alvara_venc));

    // Atividades
    if (els.atividadesList) {
      els.atividadesList.innerHTML = "";
      const ativs = Array.isArray(reg.atividades) ? reg.atividades : [];
      if (ativs.length === 0) {
        els.atividadesList.innerHTML = '<div class="hint-text">Nenhuma atividade registrada.</div>';
      } else {
        ativs.forEach(a => {
          const item = document.createElement("div");
          item.className = "list-item";
          item.innerHTML = `
            <div class="list-item__header">
              <span class="list-item__title">${a.cnae || "—"}</span>
              <span class="list-item__badge">${a.principal === "S" ? "Principal" : "Secundária"}</span>
            </div>
            <div class="list-item__desc">${a.descricao || "—"}</div>
          `;
          els.atividadesList.appendChild(item);
        });
      }
    }

    // Inspeções
    if (els.inspecoesList) {
      els.inspecoesList.innerHTML = "";
      const insps = Array.isArray(reg.inspecoes) ? reg.inspecoes : [];
      if (insps.length === 0) {
        els.inspecoesList.innerHTML = '<div class="hint-text">Nenhuma inspeção registrada.</div>';
      } else {
        insps.forEach(v => {
          const item = document.createElement("div");
          item.className = "list-item";
          const tipo = v.tipo || "Inspeção";
          const num = v.numero || "—";
          const data = formatDateBR(v.data);
          
          item.innerHTML = `
            <div class="list-item__header">
              <span class="list-item__title">${tipo} ${num}</span>
              <span class="list-item__badge">${data}</span>
            </div>
            <div class="list-item__desc">Prazo: ${v.pz_retorno ?? "—"} dia(s)</div>
          `;

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
        });
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
    const titulo = (tipo && numer) ? `${tipo} ${numer}` : `Documento ${ndoc}`;
    
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
      renderResults(indexItems.slice(0, 50));
      showStatus(`Pronto (${indexItems.length} registros)`);
      return;
    }
    const qDigits = onlyDigits(q);
    const out = indexItems.filter(it => {
      const hay = `${it.razao} ${it.fantasia} ${it.documento} ${it.codigo}`.toLowerCase();
      return hay.includes(q) || (qDigits && (onlyDigits(it.documento).includes(qDigits) || String(it.codigo).includes(qDigits)));
    }).slice(0, 50);
    
    renderResults(out);
    showStatus(`${out.length} encontrado(s).`);
  }

  async function init() {
    showStatus("Carregando índice...");
    try {
      const root = await fetchJson(`./data/index_regulados.json?v=${Date.now()}`);
      indexItems = Array.isArray(root.dados) ? root.dados : (Array.isArray(root) ? root : []);
      showStatus(`Índice carregado.`);
      renderResults(indexItems.slice(0, 50));
    } catch (e) {
      showStatus("Erro ao carregar índice.");
    }

    els.q?.addEventListener("input", applyFilter);
    els.btnClear?.addEventListener("click", () => {
      if (els.q) els.q.value = "";
      hideDetail();
      applyFilter();
      els.q?.focus();
    });
    els.btnCloseDetail?.addEventListener("click", hideDetail);
    byId("btnCloseModal")?.addEventListener("click", closeModal);
    els.modalBackdrop?.addEventListener("click", closeModal);
    
    els.btnAtividades?.addEventListener("click", () => {
      els.atividadesList?.scrollIntoView({ behavior: "smooth" });
    });
    els.btnInspecoes?.addEventListener("click", () => {
      els.inspecoesList?.scrollIntoView({ behavior: "smooth" });
    });
  }

  window.addEventListener("DOMContentLoaded", init);
})();
