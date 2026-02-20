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
    // Aceita YYYY-MM-DD ou ISO
    try {
      const d = new Date(str);
      if (!isNaN(d.getTime())) {
        const dia = String(d.getDate()).padStart(2, "0");
        const mes = String(d.getMonth() + 1).padStart(2, "0");
        const ano = d.getFullYear();
        return `${dia}/${mes}/${ano}`;
      }
    } catch (e) {}

    // Tenta YYYY-MM-DD manual
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

  // Montar link do Google Maps (sem API / sem chave)
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

  // Armazena info da inspeção atual para usar no título do modal
  let currentInspecaoInfo = null;

  // ====== Modal helpers ======
  function openModal(title, html) {
    if (els.modalTitle) els.modalTitle.textContent = title || "Detalhes";
    if (els.modalMemo) els.modalMemo.innerHTML = html || "";
    if (els.modalBackdrop) els.modalBackdrop.classList.add("open");
    if (els.modal) els.modal.classList.add("open");
  }

  function closeModal() {
    if (els.modalBackdrop) els.modalBackdrop.classList.remove("open");
    if (els.modal) els.modal.classList.remove("open");
  }

  function openDetail() {
    if (els.detailPanel) els.detailPanel.classList.add("open");
  }

  function closeDetail() {
    if (els.detailPanel) els.detailPanel.classList.remove("open");
  }

  function setStatus(msg) {
    safeText(els.status, msg || "");
  }

  function clearResults() {
    if (els.results) els.results.innerHTML = "";
  }

  // ====== Render list ======
  function renderList(items) {
    clearResults();
    if (!els.results) return;

    if (!items || !items.length) {
      els.results.innerHTML = `<div class="empty">Nenhum resultado.</div>`;
      return;
    }

    const frag = document.createDocumentFragment();

    items.forEach((it) => {
      const card = document.createElement("div");
      card.className = "card";
      card.tabIndex = 0;

      const top = document.createElement("div");
      top.className = "card__top";
      top.innerHTML = `
        <div class="card__title">${it.razao || "—"}</div>
        <div class="card__sub">${it.fantasia || ""}</div>
      `;

      const meta = document.createElement("div");
      meta.className = "card__meta";
      meta.innerHTML = `
        <span class="pill">Código: ${it.codigo || "—"}</span>
        <span class="pill">${it.doc || "—"}</span>
      `;

      card.appendChild(top);
      card.appendChild(meta);

      card.addEventListener("click", () => loadDetail(it.codigo));
      card.addEventListener("keydown", (e) => {
        if (e.key === "Enter" || e.key === " ") {
          e.preventDefault();
          loadDetail(it.codigo);
        }
      });

      frag.appendChild(card);
    });

    els.results.appendChild(frag);
  }

  // ====== Data loading (index + detail) ======
  async function loadIndex() {
    setStatus("Carregando índice...");
    try {
      const idx = await safeJson("data/index_regulados.json");
      // idx deve ser array [{codigo, razao, fantasia, doc, ...}] ou similar
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
      setStatus(`Índice carregado: ${indexItems.length} regulados.`);
    } catch (err) {
      console.error(err);
      setStatus("Erro ao carregar índice.");
      indexItems = [];
    }
  }

  async function loadDetail(codigo) {
    if (!codigo) return;
    const c = pad5(codigo);
    const pre = regPrefix(c);

    setStatus(`Carregando regulado ${c}...`);
    openDetail();

    try {
      const reg = await safeJson(`data/reg/${pre}/${c}.json`);
      renderDetail(normalizeReg(reg));
      setStatus(`Regulado ${c} carregado.`);
    } catch (err) {
      console.error(err);
      setStatus(`Erro ao carregar regulado ${c}.`);
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
    const alvara_ultimo = r.alvara_ultimo || r.Alvara_ultimo || r.ALVARA_ULTIMO || r.alvara || r.Alvara || null;

    const atividades = r.atividades || r.Atividades || r.ATIVIDADES || [];
    const inspeções = r.inspecoes || r.Inspecoes || r.INSPECOES || [];

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
      inspecoes: inspeções,
    };
  }

  // ====== Detail render ======
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

    const endTxt = [endParts.length ? endParts.join(" · ") : "—", fones.length ? fones.join(" · ") : ""]
      .filter(Boolean)
      .join(" · ");

    safeText(els.dEnd, endTxt || "—");

    const b = reg.bairro || {};
    safeText(els.dBairro, b.nome || "—");

    // Google Maps (rota) — sem API / sem chave — logo após o bairro
    if (els.dMaps) {
      const e2 = reg.endereco || {};
      const endParts2 = [];
      if (e2.logradouro) endParts2.push(e2.logradouro);
      if (e2.complemento) endParts2.push(e2.complemento);

      // Endereço “limpo” (sem telefones)
      const enderecoMaps = endParts2.join(", ").trim();
      const bairroMaps = b && b.nome ? String(b.nome).trim() : "";
      const razaoMaps = reg.razao ? String(reg.razao).trim() : "";

      const linkMaps = montarLinkGoogleMapsRegulado({
        endereco: enderecoMaps,
        bairro: bairroMaps,
        razaoSocial: razaoMaps,
      });

      if (linkMaps) {
        els.dMaps.innerHTML = `
          <a href="${linkMaps}" target="_blank" rel="noopener"
             style="display:inline-block;padding:10px 14px;border-radius:10px;background:#34C759;color:#fff;font-weight:800;text-decoration:none;">
            🧭 Traçar rota
          </a>`;
      } else {
        els.dMaps.textContent = "—";
      }
    }

    const alv = reg.alvara_ultimo;
    if (alv && typeof alv === "object") {
      safeText(els.dAlvEx, alv.exercicio ?? "—");
      // Formata data de validade para dd/mm/aaaa
      safeText(els.dAlvVal, formatDateBR(alv.dt_validade) ?? "—");
    } else {
      safeText(els.dAlvEx, "—");
      safeText(els.dAlvVal, "—");
    }

    // Atividades
    const atvs = Array.isArray(reg.atividades) ? reg.atividades : [];
    renderAtividades(atvs);

    // Inspeções
    const insps = Array.isArray(reg.inspecoes) ? reg.inspecoes : [];
    renderInspecoes(insps);
  }

  // ====== Atividades / Inspeções ======
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
          <div class="row">
            <div class="row__main">
              <div class="row__title">${cnae || "—"}</div>
              <div class="row__sub">${desc || ""}</div>
            </div>
            <div class="row__meta">${tipo || ""}</div>
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
          <div class="row clickable" data-inspecao="${id}">
            <div class="row__main">
              <div class="row__title">${dt || "—"} ${tipo ? `· ${tipo}` : ""}</div>
              <div class="row__sub">${memo || ""}</div>
            </div>
            <div class="row__meta">${fiscal || ""}</div>
          </div>
        `;
      })
      .join("");

    els.inspecoesList.innerHTML = rows;

    // Clique abre modal com memo completo
    els.inspecoesList.querySelectorAll(".row.clickable").forEach((el) => {
      el.addEventListener("click", () => {
        const id = el.getAttribute("data-inspecao") || "";
        const i = insps.find((x) => String(x.id ?? x.ID ?? "") === id) || null;
        if (!i) return;

        currentInspecaoInfo = {
          data: formatDateBR(i.data ?? i.dt ?? i.DT) || "—",
          tipo: normTxt(i.tipo ?? i.TIPO) || "",
          fiscal: normTxt(i.fiscal ?? i.FISCAL ?? i.fiscal1 ?? i.FISCAL1) || "",
        };

        const memo = normTxt(i.memo ?? i.MEMO ?? i.obs ?? i.OBS) || "—";
        openModal(
          `Inspeção — ${currentInspecaoInfo.data}${currentInspecaoInfo.tipo ? " · " + currentInspecaoInfo.tipo : ""}`,
          `<div class="memo">${memo.replace(/\n/g, "<br>")}</div>`
        );
      });
    });
  }

  // ====== Search ======
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

      if (
        r.includes(t) ||
        f.includes(t) ||
        c.includes(t) ||
        (digits && d.includes(digits))
      ) {
        out.push(it);
        if (out.length >= 200) break; // limite de resultados
      }
    }
    return out;
  }

  function onSearch() {
    const q = normTxt(els.q?.value);
    if (!q) {
      clearResults();
      setStatus(`Digite para pesquisar. Índice: ${indexItems.length}.`);
      return;
    }
    const items = filterIndex(q);
    setStatus(`Resultados: ${items.length}`);
    renderList(items);
  }

  function bindEvents() {
    if (els.q) {
      els.q.addEventListener("input", () => onSearch());
      els.q.addEventListener("keydown", (e) => {
        if (e.key === "Enter") onSearch();
      });
    }

    if (els.btnClear) {
      els.btnClear.addEventListener("click", () => {
        if (els.q) els.q.value = "";
        clearResults();
        setStatus(`Índice: ${indexItems.length}.`);
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
    setStatus(`Índice: ${indexItems.length}. Digite para pesquisar.`);
  }

  document.addEventListener("DOMContentLoaded", init);
})();
