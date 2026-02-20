(() => {
  "use strict";

  const byId = (id) => document.getElementById(id);

  const pad5 = (n) => String(n ?? "").padStart(5, "0");
  const regPrefix = (codigo) => pad5(codigo).slice(0, 2);

  const safeJson = async (url) => {
    const r = await fetch(url, { cache: "no-store" });
    if (!r.ok) throw new Error(`Falha ao carregar ${url} (${r.status})`);
    return r.json();
  };

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

    if (typeof str === "string" && str.includes("-")) {
      const p = str.split("T")[0].split("-");
      if (p.length === 3) return `${p[2]}/${p[1]}/${p[0]}`;
    }
    return str;
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

  // Google Maps (sem API / sem chave)
  function montarLinkGoogleMapsRegulado({ endereco, bairro, razaoSocial }) {
    try {
      const partes = [];
      if (endereco) partes.push(String(endereco).trim());
      if (bairro) partes.push(String(bairro).trim());
      partes.push("Anápolis - GO");

      let destino = partes
        .filter(Boolean)
        .join(", ")
        .replace(/\s+/g, " ")
        .trim();

      // Fallback se endereço estiver fraco
      if ((!endereco || String(endereco).trim().length < 6) && razaoSocial) {
        destino = `${String(razaoSocial).trim()}, Anápolis - GO`;
      }

      if (!destino || destino === "Anápolis - GO") return null;

      const destEnc = encodeURIComponent(destino);
      return `https://www.google.com/maps/dir/?api=1&destination=${destEnc}&travelmode=driving`;
    } catch (e) {
      return null;
    }
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

  // ===== Modal helpers =====
  function openModal(title, html) {
    if (els.modalTitle) els.modalTitle.textContent = title || "Detalhes";
    // modalMemo no seu HTML é <pre>, mas pode receber HTML (line breaks) via innerHTML
    if (els.modalMemo) els.modalMemo.innerHTML = html || "";
    if (els.modalBackdrop) els.modalBackdrop.hidden = false;
    if (els.modal) els.modal.hidden = false;
  }

  function closeModal() {
    if (els.modalBackdrop) els.modalBackdrop.hidden = true;
    if (els.modal) els.modal.hidden = true;
  }

  // ✅ CORREÇÃO: remover/aplicar atributo hidden corretamente
  function openDetail() {
    if (!els.detailPanel) return;
    els.detailPanel.hidden = false;
    // (classe open é opcional; mantida por compatibilidade)
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
    // opcional: classes loading/ready/error, se existirem no CSS
    els.status.classList.remove("loading", "ready", "error");
    if (cls) els.status.classList.add(cls);
  }

  function clearResults() {
    if (els.results) els.results.innerHTML = "";
  }

  // ===== Render list =====
  function renderList(items) {
    clearResults();
    if (!els.results) return;

    if (!items || !items.length) {
      els.results.innerHTML = `<div class="empty">Nenhum resultado.</div>`;
      return;
    }

    const frag = document.createDocumentFragment();

    items.forEach((it) => {
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
    });

    els.results.appendChild(frag);
  }

  // ===== Data loading (index + detail) =====
  async function loadIndex() {
    setStatus("Carregando índice...", "loading");
    try {
      const idx = await safeJson("data/index_regulados.json");

      if (Array.isArray(idx)) {
        indexItems = idx.map((r) => ({
          codigo: pad5(r.codigo ?? r.Codigo ?? r.CODIGO),
          razao: normTxt(r.razao ?? r.Razao ?? r.RAZAO ?? r.razao_social ?? r.RAZAO_SOCIAL),
          fantasia: normTxt(r.fantasia ?? r.Fantasia ?? r.FANTASIA),
          doc: normTxt(r.doc ?? r.Doc ?? r.DOC ?? r.cnpj ?? r.CNPJ ?? r.cpf ?? r.CPF),
        }));
      } else {
        indexItems = [];
      }

      setStatus(`Índice carregado: ${indexItems.length} regulados.`, "ready");
    } catch (err) {
      console.error(err);
      setStatus("Erro ao carregar índice.", "error");
      indexItems = [];
    }
  }

  async function loadDetail(codigo) {
    if (!codigo) return;

    const c = pad5(codigo);
    const pre = regPrefix(c);

    setStatus(`Carregando regulado ${c}...`, "loading");
    openDetail();

    try {
      const reg = await safeJson(`data/reg/${pre}/${c}.json`);
      renderDetail(normalizeReg(reg));
      setStatus(`Regulado ${c} carregado.`, "ready");
    } catch (err) {
      console.error(err);
      setStatus(`Erro ao carregar regulado ${c}.`, "error");
    }
  }

  // Normaliza possíveis variações do JSON do regulado
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

    // Evita identificador com acento
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

  // ===== Detail render =====
  function renderDetail(reg) {
    safeText(els.dTitle, reg.razao || "—");
    safeText(els.dSub, reg.fantasia || "—");
    safeText(els.dCodigo, reg.codigo);

    const doc = reg.cnpj || reg.cpf || "—";
    safeText(els.dDoc, doc);

    const e = reg.endereco || {};

    // Texto do endereço / contato (para tela)
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
    safeText(els.dBairro, b.nome || "—");

    // Google Maps (rota) — logo após o bairro
    if (els.dMaps) {
      // Endereço “limpo” (sem telefones)
      const endParts2 = [];
      if (e.logradouro) endParts2.push(e.logradouro);
      if (e.complemento) endParts2.push(e.complemento);

      const enderecoMaps = endParts2.join(", ").trim();
      const bairroMaps = b && b.nome ? String(b.nome).trim() : "";
      const razaoMaps = reg.razao ? String(reg.razao).trim() : "";

      const linkMaps = montarLinkGoogleMapsRegulado({
        endereco: enderecoMaps,
        bairro: bairroMaps,
        razaoSocial: razaoMaps,
      });

      if (linkMaps) {
        // Usa a classe .btn do seu CSS (mantém o padrão visual)
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

  // ===== Atividades / Inspeções =====
  function renderAtividades(atvs) {
    if (!els.atividadesList) return;
    if (!atvs.length) {
      els.atividadesList.innerHTML = `<div class="empty">Sem atividades.</div>`;
      return;
    }

    const rows = atvs
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

    els.atividadesList.innerHTML = rows;
  }

  function renderInspecoes(insps) {
    if (!els.inspecoesList) return;
    if (!insps.length) {
      els.inspecoesList.innerHTML = `<div class="empty">Sem inspeções.</div>`;
      return;
    }

    const rows = insps
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

    els.inspecoesList.innerHTML = rows;

    // Clique abre modal com memo completo
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

  // ===== Search =====
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

    // dica do seu UI: "3+ letras para refinar"
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
      els.btnCloseDetail.addEventListener("click", () => closeDetail());
    }

    if (els.btnCloseModal) {
      els.btnCloseModal.addEventListener("click", () => closeModal());
    }

    if (els.modalBackdrop) {
      els.modalBackdrop.addEventListener("click", (e) => {
        if (e.target === els.modalBackdrop) closeModal();
      });
    }
  }

  async function init() {
    bindEvents();
    await loadIndex();
    setStatus(`Índice: ${indexItems.length}. Digite para pesquisar.`, "ready");
  }

  document.addEventListener("DOMContentLoaded", init);
})();
