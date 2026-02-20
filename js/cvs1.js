(() => {
  "use strict";

  const byId = (id) => document.getElementById(id);

  // Base URL robusta (funciona mesmo se cvs.html estiver em subpasta)
  const u = (rel) => new URL(rel, document.baseURI).toString();

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
    } catch (_) {}

    if (typeof str === "string" && str.includes("-")) {
      const p = str.split("T")[0].split("-");
      if (p.length === 3) return `${p[2]}/${p[1]}/${p[0]}`;
    }
    return String(str);
  }

  function safeText(el, v) {
    if (!el) return;
    el.textContent = v === null || v === undefined || v === "" ? "—" : String(v);
  }

  function onlyDigits(s) {
    return String(s || "").replace(/\D+/g, "");
  }

  function normTxt(v) {
    return (v == null ? "" : String(v)).trim();
  }

  // ============================
  // Google Maps (sem API / sem chave)
  // ============================
  function montarLinkGoogleMapsRegulado({ endereco, bairro, razaoSocial }) {
    try {
      const partes = [];

      if (endereco) partes.push(String(endereco).trim());
      if (bairro) partes.push(String(bairro).trim());

      // Contexto do app
      partes.push("Anápolis - GO");

      let destino = partes
        .filter(Boolean)
        .join(", ")
        .replace(/\s+/g, " ")
        .trim();

      // Fallback: se endereço estiver fraco, usa Razão Social
      if ((!endereco || String(endereco).trim().length < 6) && razaoSocial) {
        destino = `${String(razaoSocial).trim()}, Anápolis - GO`;
      }

      if (!destino || destino === "Anápolis - GO") return null;

      const destEnc = encodeURIComponent(destino);
      return `https://www.google.com/maps/dir/?api=1&destination=${destEnc}&travelmode=driving`;
    } catch (_) {
      return null;
    }
  }

  // ============================
  // Elementos
  // ============================
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

  // ============================
  // Modal
  // ============================
  function openModal(title, html) {
    if (els.modalTitle) els.modalTitle.textContent = title || "Detalhes";
    if (els.modalMemo) els.modalMemo.innerHTML = html || "";
    if (els.modalBackdrop) els.modalBackdrop.hidden = false;
    if (els.modal) els.modal.hidden = false;
  }

  function closeModal() {
    if (els.modalBackdrop) els.modalBackdrop.hidden = true;
    if (els.modal) els.modal.hidden = true;
  }

  // ✅ IMPORTANTÍSSIMO: controlar hidden do detalhe
  function openDetail() {
    if (!els.detailPanel) return;
    els.detailPanel.hidden = false;
    els.detailPanel.classList.add("open");
  }

  function closeDetail() {
    if (!els.detailPanel) return;
    els.detailPanel.classList.remove("open");
    els.detailPanel.hidden = true;
  }

  function setStatus(msg, cls) {
    if (!els.status) return;
    els.status.textContent = msg || "";
    els.status.classList.remove("loading", "ready", "error");
    if (cls) els.status.classList.add(cls);
  }

  function clearResults() {
    if (els.results) els.results.innerHTML = "";
  }

  // ============================
  // Render lista
  // ============================
  function renderList(items) {
    clearResults();
    if (!els.results) return;

    if (!items || !items.length) {
      els.results.innerHTML = `<div class="empty">Nenhum resultado.</div>`;
      return;
    }

    const frag = document.createDocumentFragment();

    for (const it of items) {
      const card = document.createElement("button");
      card.type = "button";
      card.className = "result-item";
      card.innerHTML = `
        <div class="result-item__title">${it.razao || "—"}</div>
        <div class="result-item__subtitle">${it.fantasia || ""}</div>
        <div class="result-item__meta">
          <span class="result-item__badge">Código: ${it.codigo || "—"}</span>
          <span class="result-item__badge">${it.doc || "—"}</span>
        </div>
      `;
      card.addEventListener("click", () => loadDetail(it.codigo));
      frag.appendChild(card);
    }

    els.results.appendChild(frag);
  }

  // ============================
  // Carregamento de dados
  // ============================
  async function loadIndex() {
    setStatus("Carregando índice...", "loading");
    try {
      const idx = await safeJson(u("./data/index_regulados.json"));

      // Aceita array OU objeto com items/regulados
      const arr = Array.isArray(idx)
        ? idx
        : (Array.isArray(idx?.items) ? idx.items : (Array.isArray(idx?.regulados) ? idx.regulados : []));

      indexItems = arr.map((r) => ({
        codigo: pad5(r.codigo ?? r.Codigo ?? r.CODIGO),
        razao: normTxt(r.razao ?? r.Razao ?? r.RAZAO ?? r.razao_social ?? r.RAZAO_SOCIAL),
        fantasia: normTxt(r.fantasia ?? r.Fantasia ?? r.FANTASIA),
        doc: normTxt(r.doc ?? r.Doc ?? r.DOC ?? r.cnpj ?? r.CNPJ ?? r.cpf ?? r.CPF),
      }));

      setStatus(`Índice carregado: ${indexItems.length} regulados.`, "ready");
    } catch (err) {
      console.error(err);
      indexItems = [];
      setStatus("Erro ao carregar índice.", "error");
    }
  }

  async function loadDetail(codigo) {
    if (!codigo) return;

    const c = pad5(codigo);
    const pre = regPrefix(c);

    setStatus(`Carregando regulado ${c}...`, "loading");
    openDetail();

    try {
      const reg = await safeJson(u(`./data/reg/${pre}/${c}.json`));
      renderDetail(normalizeReg(reg));
      setStatus(`Regulado ${c} carregado.`, "ready");
    } catch (err) {
      console.error(err);
      setStatus(`Erro ao carregar regulado ${c}.`, "error");
    }
  }

  function normalizeReg(raw) {
    const r = raw || {};
    const codigo = pad5(r.codigo ?? r.Codigo ?? r.CODIGO);
    const razao = normTxt(r.razao ?? r.Razao ?? r.RAZAO ?? r.razao_social ?? r.RAZAO_SOCIAL);
    const fantasia = normTxt(r.fantasia ?? r.Fantasia ?? r.FANTASIA);

    const cnpj = normTxt(r.cnpj ?? r.CNPJ);
    const cpf = normTxt(r.cpf ?? r.CPF);

    const endereco = r.endereco || r.Endereco || r.ENDERECO || {};
    const bairro = r.bairro || r.Bairro || r.BAIRRO || {};
    const alvara_ultimo =
      r.alvara_ultimo || r.Alvara_ultimo || r.ALVARA_ULTIMO || r.alvara || r.Alvara || null;

    const atividades = r.atividades || r.Atividades || r.ATIVIDADES || [];
    const inspecoesArr = r.inspecoes || r.Inspecoes || r.INSPECOES || [];

    return {
      ...r,
      codigo,
      razao,
      fantasia,
      cnpj,
      cpf,
      endereco,
      bairro,
      alvara_ultimo,
      atividades,
      inspecoes: inspecoesArr,
    };
  }

  // ============================
  // Render detalhe
  // ============================
  function renderDetail(reg) {
    safeText(els.dTitle, reg.razao || "—");
    safeText(els.dSub, reg.fantasia || "—");
    safeText(els.dCodigo, reg.codigo);

    const doc = reg.cnpj || reg.cpf || "—";
    safeText(els.dDoc, doc);

    const e = reg.endereco || {};

    // Endereço/Contato para tela (mantém seu padrão)
    const endParts = [];
    if (e.logradouro) endParts.push(e.logradouro);
    if (e.complemento) endParts.push(e.complemento);

    const fones = [];
    if (e.fone) fones.push(`Fone: ${e.fone}`);
    if (e.celular) fones.push(`Celular: ${e.celular}`);

    const endTxt = [
      endParts.length ? endParts.join(" · ") : "—",
      fones.length ? fones.join(" · ") : "",
    ]
      .filter(Boolean)
      .join(" · ");

    safeText(els.dEnd, endTxt || "—");

    const b = reg.bairro || {};
    const bairroNome = b.nome ?? b.Nome ?? b.NOME ?? "";
    safeText(els.dBairro, bairroNome || "—");

    // ✅ Google Maps: sempre tenta gerar (endereço -> fallback razão social)
    if (els.dMaps) {
      const endParts2 = [];

      // tenta várias chaves comuns sem “inventar”
      const log =
        e.logradouro ?? e.Logradouro ?? e.LOGRADOURO ??
        e.endereco ?? e.Endereco ?? e.ENDERECO ?? "";

      const comp = e.complemento ?? e.Complemento ?? e.COMPLEMENTO ?? "";

      if (log) endParts2.push(String(log).trim());
      if (comp) endParts2.push(String(comp).trim());

      const enderecoMaps = endParts2.join(", ").replace(/\s+/g, " ").trim();

      const linkMaps = montarLinkGoogleMapsRegulado({
        endereco: enderecoMaps,
        bairro: bairroNome ? String(bairroNome).trim() : "",
        razaoSocial: reg.razao ? String(reg.razao).trim() : "",
      });

      if (linkMaps) {
        els.dMaps.innerHTML = `
          <a href="${linkMaps}" target="_blank" rel="noopener"
             class="btn btnPrimary"
             style="padding:10px 14px;border-radius:12px;display:inline-flex;gap:8px;align-items:center;justify-content:center;">
            🧭 Traçar rota
          </a>`;
      } else {
        els.dMaps.textContent = "—";
      }
    }

    const alv = reg.alvara_ultimo;
    if (alv && typeof alv === "object") {
      safeText(els.dAlvEx, alv.exercicio ?? "—");
      safeText(els.dAlvVal, formatDateBR(alv.dt_validade) ?? "—");
    } else {
      safeText(els.dAlvEx, "—");
      safeText(els.dAlvVal, "—");
    }

    // Listas
    const atvs = Array.isArray(reg.atividades) ? reg.atividades : [];
    renderAtividades(atvs);

    const insps = Array.isArray(reg.inspecoes) ? reg.inspecoes : [];
    renderInspecoes(insps);
  }

  // ============================
  // Atividades / Inspeções
  // ============================
  function renderAtividades(atvs) {
    if (!els.atividadesList) return;

    if (!atvs.length) {
      els.atividadesList.innerHTML = `<div class="empty">Sem atividades.</div>`;
      return;
    }

    els.atividadesList.innerHTML = atvs
      .map((a) => {
        const cnae = normTxt(a.cnae ?? a.CNAE);
        const desc = normTxt(a.descricao ?? a.DESCRICAO ?? a.desc);
        const tipo = normTxt(a.tipo ?? a.TIPO);
        return `
          <div class="item">
            <div class="item__top">
              <div class="item__title">${cnae || "—"}</div>
              <div class="tag">${tipo || ""}</div>
            </div>
            <div class="item__sub">${desc || ""}</div>
          </div>
        `;
      })
      .join("");
  }

  function renderInspecoes(insps) {
    if (!els.inspecoesList) return;

    if (!insps.length) {
      els.inspecoesList.innerHTML = `<div class="empty">Sem inspeções.</div>`;
      return;
    }

    els.inspecoesList.innerHTML = insps
      .map((i) => {
        const dt = formatDateBR(i.data ?? i.dt ?? i.DT);
        const tipo = normTxt(i.tipo ?? i.TIPO);
        const memo = normTxt(i.memo ?? i.MEMO ?? i.obs ?? i.OBS);
        const fiscal = normTxt(i.fiscal ?? i.FISCAL ?? i.fiscal1 ?? i.FISCAL1);
        const id = normTxt(i.id ?? i.ID ?? "");

        return `
          <div class="item" role="button" tabindex="0" data-inspecao="${id}">
            <div class="item__top">
              <div class="item__title">${dt || "—"}${tipo ? ` · ${tipo}` : ""}</div>
              <div class="tag">${fiscal || ""}</div>
            </div>
            <div class="item__sub">${memo || ""}</div>
          </div>
        `;
      })
      .join("");

    // abre modal
    els.inspecoesList.querySelectorAll("[data-inspecao]").forEach((el) => {
      const open = () => {
        const id = el.getAttribute("data-inspecao") || "";
        const i = insps.find((x) => String(x.id ?? x.ID ?? "") === id) || null;
        if (!i) return;

        const data = formatDateBR(i.data ?? i.dt ?? i.DT) || "—";
        const tipo = normTxt(i.tipo ?? i.TIPO) || "";
        const fiscal = normTxt(i.fiscal ?? i.FISCAL ?? i.fiscal1 ?? i.FISCAL1) || "";

        const memo = normTxt(i.memo ?? i.MEMO ?? i.obs ?? i.OBS) || "—";
        const titulo = `Inspeção — ${data}${tipo ? " · " + tipo : ""}${fiscal ? " · " + fiscal : ""}`;

        openModal(titulo, memo.replace(/\n/g, "<br>"));
      };

      el.addEventListener("click", open);
      el.addEventListener("keydown", (e) => {
        if (e.key === "Enter" || e.key === " ") {
          e.preventDefault();
          open();
        }
      });
    });
  }

  // ============================
  // Busca
  // ============================
  function filterIndex(q) {
    const t = normTxt(q).toUpperCase();
    if (!t) return [];
    const digits = onlyDigits(t);

    const out = [];
    for (const it of indexItems) {
      const r = (it.razao || "").toUpperCase();
      const f = (it.fantasia || "").toUpperCase();
      const d = onlyDigits(it.doc || "");
      const c = (it.codigo || "").toUpperCase();

      if (r.includes(t) || f.includes(t) || c.includes(t) || (digits && d.includes(digits))) {
        out.push(it);
        if (out.length >= 200) break;
      }
    }
    return out;
  }

  function onSearch() {
    const q = normTxt(els.q?.value);

    if (!q) {
      clearResults();
      setStatus(`Índice: ${indexItems.length}. Digite para pesquisar.`, "ready");
      return;
    }

    // seu texto da UI sugere 3+; mantém
    const digits = onlyDigits(q);
    if (q.length < 3 && digits.length < 3) {
      clearResults();
      setStatus(`Digite 3+ caracteres para refinar. Índice: ${indexItems.length}.`, "ready");
      return;
    }

    const items = filterIndex(q);
    setStatus(`Resultados: ${items.length}`, "ready");
    renderList(items);
  }

  function bindEvents() {
    if (els.q) {
      els.q.addEventListener("input", onSearch);
      els.q.addEventListener("keydown", (e) => {
        if (e.key === "Enter") onSearch();
      });
    }

    if (els.btnClear) {
      els.btnClear.addEventListener("click", () => {
        if (els.q) els.q.value = "";
        clearResults();
        setStatus(`Índice: ${indexItems.length}. Digite para pesquisar.`, "ready");
        closeDetail();
      });
    }

    if (els.btnCloseDetail) {
      els.btnCloseDetail.addEventListener("click", closeDetail);
    }

    if (els.btnCloseModal) {
      els.btnCloseModal.addEventListener("click", closeModal);
    }

    if (els.modalBackdrop) {
      els.modalBackdrop.addEventListener("click", (e) => {
        if (e.target === els.modalBackdrop) closeModal();
      });
    }

    // ESC fecha modal
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") closeModal();
    });
  }

  async function init() {
    bindEvents();
    await loadIndex();
    setStatus(`Índice: ${indexItems.length}. Digite para pesquisar.`, "ready");
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
