(() => {
  "use strict";

  const byId = (id) => document.getElementById(id);

  const pad5 = (n) => String(n ?? "").padStart(5, "0");
  const regPrefix = (codigo) => pad5(codigo).slice(0, 2);

  async function safeJson(url) {
    const r = await fetch(url, { cache: "no-store" });
    if (!r.ok) throw new Error(`Falha ao carregar ${url} (${r.status})`);
    return r.json();
  }

  function formatDateBR(str) {
    if (!str) return null;
    try {
      const d = new Date(str);
      if (!isNaN(d.getTime())) {
        const dia = String(d.getDate()).padStart(2, "0");
        const mes = String(d.getMonth() + 1).padStart(2, "0");
        const ano = d.getFullYear();
        return `${dia}/${mes}/${ano}`;
      }
    } catch (e) {}
    return str;
  }

  function safeText(el, v) {
    if (!el) return;
    el.textContent = v === null || v === undefined || v === "" ? "—" : String(v);
  }

  function normTxt(v) {
    return (v == null ? "" : String(v)).trim();
  }

  // =============================
  // GOOGLE MAPS (SEM API)
  // =============================
  function montarLinkGoogleMaps(endereco, bairro, razao) {
    const partes = [];

    if (endereco) partes.push(endereco);
    if (bairro) partes.push(bairro);

    partes.push("Anápolis - GO");

    let destino = partes.join(", ").replace(/\s+/g, " ").trim();

    if (!endereco && razao) {
      destino = `${razao}, Anápolis - GO`;
    }

    const encoded = encodeURIComponent(destino);
    return `https://www.google.com/maps/dir/?api=1&destination=${encoded}&travelmode=driving`;
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
    dMaps: byId("dMaps"),
    dAlvEx: byId("dAlvEx"),
    dAlvVal: byId("dAlvVal")
  };

  let indexItems = [];

  function openDetail() {
    if (!els.detailPanel) return;
    els.detailPanel.hidden = false;
  }

  function closeDetail() {
    if (!els.detailPanel) return;
    els.detailPanel.hidden = true;
  }

  function setStatus(msg) {
    if (!els.status) return;
    els.status.textContent = msg || "";
  }

  function clearResults() {
    if (els.results) els.results.innerHTML = "";
  }

  function renderList(items) {
    clearResults();
    if (!els.results) return;

    if (!items.length) {
      els.results.innerHTML = `<div class="empty">Nenhum resultado.</div>`;
      return;
    }

    items.forEach((it) => {
      const card = document.createElement("button");
      card.type = "button";
      card.className = "result-item";
      card.innerHTML = `
        <div class="result-item__title">${it.razao}</div>
        <div class="result-item__subtitle">${it.fantasia}</div>
        <div class="result-item__meta">
          <span class="result-item__badge">Código: ${it.codigo}</span>
        </div>
      `;
      card.addEventListener("click", () => loadDetail(it.codigo));
      els.results.appendChild(card);
    });
  }

  async function loadIndex() {
    setStatus("Carregando índice...");
    try {
      const idx = await safeJson("data/index_regulados.json");

      indexItems = idx.map((r) => ({
        codigo: pad5(r.codigo),
        razao: normTxt(r.razao),
        fantasia: normTxt(r.fantasia),
        doc: normTxt(r.cnpj || r.cpf)
      }));

      setStatus(`Índice carregado: ${indexItems.length}`);
    } catch (err) {
      console.error(err);
      setStatus("Erro ao carregar índice.");
    }
  }

  async function loadDetail(codigo) {
    const c = pad5(codigo);
    const pre = regPrefix(c);

    openDetail();
    setStatus(`Carregando regulado ${c}...`);

    try {
      const reg = await safeJson(`data/reg/${pre}/${c}.json`);
      renderDetail(reg);
      setStatus(`Regulado ${c} carregado.`);
    } catch (err) {
      console.error(err);
      setStatus("Erro ao carregar regulado.");
    }
  }

  function renderDetail(reg) {
    safeText(els.dTitle, reg.razao);
    safeText(els.dSub, reg.fantasia);
    safeText(els.dCodigo, reg.codigo);
    safeText(els.dDoc, reg.cnpj || reg.cpf);

    const endereco = `${reg.endereco?.logradouro || ""} ${reg.endereco?.complemento || ""}`.trim();
    safeText(els.dEnd, endereco);

    const bairro = reg.bairro?.nome || "";
    safeText(els.dBairro, bairro);

    // =============================
    // BOTÃO GOOGLE MAPS
    // =============================
    if (els.dMaps) {
      const link = montarLinkGoogleMaps(endereco, bairro, reg.razao);

      els.dMaps.innerHTML = `
        <a href="${link}" target="_blank" rel="noopener"
           class="btn btnPrimary"
           style="padding:10px 14px;border-radius:12px;display:inline-flex;gap:8px;align-items:center;justify-content:center;">
          🧭 Traçar rota
        </a>`;
    }
  }

  function filterIndex(q) {
    const t = normTxt(q).toUpperCase();
    return indexItems.filter(it =>
      it.razao.toUpperCase().includes(t) ||
      it.fantasia.toUpperCase().includes(t) ||
      it.codigo.includes(t)
    );
  }

  function onSearch() {
    const q = normTxt(els.q.value);
    if (!q) {
      clearResults();
      return;
    }
    renderList(filterIndex(q));
  }

  function bindEvents() {
    if (els.q) els.q.addEventListener("input", onSearch);
    if (els.btnClear) els.btnClear.addEventListener("click", () => {
      els.q.value = "";
      clearResults();
      closeDetail();
    });
    if (els.btnCloseDetail) els.btnCloseDetail.addEventListener("click", closeDetail);
  }

  async function init() {
    bindEvents();
    await loadIndex();
  }

  document.addEventListener("DOMContentLoaded", init);
})();
