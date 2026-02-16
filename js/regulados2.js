/**
 * REGULADOS V2 - DESIGN INSPIRADO NO VISA.MANUS.SPACE
 * Focado em legibilidade, espaçamento e responsividade (Mobile-First)
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

  function normTxt(v) {
    return (v == null ? "" : String(v)).trim();
  }

  async function fetchJson(url) {
    const r = await fetch(url, { cache: "no-store" });
    if (!r.ok) return null;
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
    for (const it of list.slice(0, 50)) {
      const btn = document.createElement("button");
      btn.type = "button";
      btn.className = "result-item";
      btn.innerHTML = `
        <div class="result-item__title">${it.razao || "—"}</div>
        <div class="result-item__sub">
          <span>${it.documento || "—"}</span>
          <span class="result-item__tag-simple">#${it.codigo}</span>
        </div>
        ${it.fantasia ? `<div class="hint-text" style="margin-top:4px">${it.fantasia}</div>` : ""}
      `;
      btn.addEventListener("click", () => loadRegulado(it.codigo));
      frag.appendChild(btn);
    }
    els.results.appendChild(frag);
  }

  function renderDetail(reg) {
    safeText(els.dTitle, reg.razao || "—");
    safeText(els.dSub, reg.fantasia || "—");
    safeText(els.dCodigo, reg.codigo);
    safeText(els.dDoc, reg.cnpj || reg.cpf || "—");

    const e = reg.endereco || {};
    const endTxt = [
      [e.logradouro, e.complemento].filter(Boolean).join(" · "),
      [e.fone ? `Fone: ${e.fone}` : null, e.celular ? `Celular: ${e.celular}` : null].filter(Boolean).join(" · ")
    ].filter(Boolean).join(" · ");
    safeText(els.dEnd, endTxt || "—");
    safeText(els.dBairro, (reg.bairro || {}).nome || "—");

    const alv = reg.alvara_ultimo || {};
    safeText(els.dAlvEx, alv.exercicio || "—");
    safeText(els.dAlvVal, formatDateBR(alv.dt_validade));

    // Atividades
    if (els.atividadesList) {
      els.atividadesList.innerHTML = "";
      const atvs = Array.isArray(reg.atividades) ? reg.atividades : [];
      if (atvs.length === 0) {
        els.atividadesList.innerHTML = '<div class="hint-text">Nenhuma atividade encontrada.</div>';
      } else {
        atvs.forEach(a => {
          const div = document.createElement("div");
          div.className = "list-item";
          div.innerHTML = `
            <div class="list-item__header">
              <span class="list-item__title">${a.subclasse || "—"}</span>
              <span class="list-item__badge">${a.tipo || "—"}</span>
            </div>
            <div class="list-item__desc">
              ${[a.atividade, a.equipe ? `Equipe: ${a.equipe}` : null, a.complexidade ? `Complexidade: ${a.complexidade}` : null].filter(Boolean).join(" · ")}
            </div>
          `;
          els.atividadesList.appendChild(div);
        });
      }
    }

    // Inspeções
    if (els.inspecoesList) {
      els.inspecoesList.innerHTML = "";
      const insps = Array.isArray(reg.inspecoes) ? reg.inspecoes : [];
      if (insps.length === 0) {
        els.inspecoesList.innerHTML = '<div class="hint-text">Nenhuma inspeção encontrada.</div>';
      } else {
        insps.forEach(v => {
          const div = document.createElement("div");
          div.className = "list-item";
          
          const f1 = normTxt(v.Fiscal1);
          const f2 = normTxt(v.Fiscal2);
          const f3 = normTxt(v.Fiscal3);
          const fiscais = [f1, f2, f3].filter(Boolean);
          
          let fiscaisHtml = "";
          if (fiscais.length > 0) {
            fiscaisHtml = `
              <div class="list-item__fiscais">
                <strong>👮 Fiscais</strong>
                ${fiscais.map(f => `<div>• ${f}</div>`).join("")}
              </div>
            `;
          }

          const ndoc = Number(v.ndoc || 0);
          const btnHtml = ndoc > 0 
            ? `<button class="btn-action" style="width:100%; margin-top:12px" onclick="window.openDoc(${ndoc}, '${v.tipo}', '${v.numer}')">📄 Abrir documento</button>`
            : `<div class="hint-text" style="margin-top:8px">Histórico: —</div>`;

          div.innerHTML = `
            <div class="list-item__header">
              <span class="list-item__title">${v.tipo || "—"} ${v.numer || "—"} · ${formatDateBR(v.dt_visita)}</span>
              <span class="list-item__badge">${v.pz_retorno != null ? `Prazo: ${v.pz_retorno} d` : "Prazo: —"}</span>
            </div>
            ${fiscaisHtml}
            ${btnHtml}
          `;
          els.inspecoesList.appendChild(div);
        });
      }
    }
  }

  window.openDoc = async (ndoc, tipo, numer) => {
    const b = hisBucket(ndoc);
    const h = await fetchJson(`./data/his/${b}/${ndoc}.json`);
    const titulo = (tipo && numer) ? `${tipo} ${numer}` : `Documento ${ndoc}`;
    openModal(titulo, h ? (h.decr || h.descr || "Sem conteúdo.") : "Sem conteúdo.");
  };

  async function loadRegulado(codigo) {
    const c = Number(codigo);
    const path = `./data/reg/${regPrefix(c)}/${pad5(c)}.json`;
    showStatus(`Carregando #${c}...`);
    const reg = await fetchJson(path);
    if (reg) {
      renderDetail(reg);
      showDetail();
      showStatus(`Regulado ${c} carregado.`);
      els.detailPanel?.scrollIntoView({ behavior: "smooth" });
    } else {
      showStatus("Erro ao carregar dados.");
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
    const root = await fetchJson(`./data/index_regulados.json?v=${Date.now()}`);
    if (root) {
      indexItems = Array.isArray(root.dados) ? root.dados : (Array.isArray(root) ? root : []);
      showStatus(`Índice carregado.`);
      renderResults(indexItems.slice(0, 50));
    }
    els.q?.addEventListener("input", applyFilter);
    els.btnClear?.addEventListener("click", () => {
      if (els.q) els.q.value = "";
      hideDetail();
      applyFilter();
    });
    els.btnCloseDetail?.addEventListener("click", hideDetail);
    byId("btnCloseModal")?.addEventListener("click", closeModal);
    els.modalBackdrop?.addEventListener("click", closeModal);
  }

  window.addEventListener("DOMContentLoaded", init);
})();
