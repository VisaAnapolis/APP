#!/usr/bin/env node
/**
 * gerar-complexidade-index.js
 *
 * Lê todos os JSONs individuais de regulados (data/reg/XX/NNNNN.json)
 * e o cnae.csv para gerar data/complexidade_regulados.json — um índice
 * pré-computado com a maior complexidade de cada regulado e flags para
 * o mapa SIA/SUS (hospital, ILPI, alimentação).
 *
 * Lógica de resolução de complexidade (mesma de indicadores.html):
 *   1) Busca exata da subclasse no cnae.csv
 *   2) Prefixo de classe CNAE (ex.: "5611-2/")
 *   3) Fallback: campo complexidade embutido no JSON
 *
 * Para regulados com mais de um CNAE, considera a MAIOR complexidade
 * (ALTA > MÉDIA > BAIXA).
 *
 * Uso: node scripts/gerar-complexidade-index.js
 */

const fs = require('fs');
const path = require('path');

const COMP_PRIORITY = ['ALTA', 'MÉDIA', 'BAIXA'];

const SIGLA_AREA = {
  'MD': 'Medicamentos',
  'DR': 'Comércio varejista de Medicamentos',
  'OS': 'Produtos para Saúde',
  'PS': 'Produtos para Saúde',
  'CS': 'Cosméticos e Saneantes',
  'SS': 'Serviços de Saúde',
  'LP': 'Serviços de Saúde',
  'IA': 'Indústrias Alimentícias',
  'AG': 'Alimentos em Geral'
};

const REG_PRIORITY = [
  'Medicamentos',
  'Comércio varejista de Medicamentos',
  'Produtos para Saúde',
  'Cosméticos e Saneantes',
  'Serviços de Saúde',
  'Indústrias Alimentícias',
  'Alimentos em Geral'
];

/* ── Carregar cnae.csv ── */
function loadCnaeCsv(filePath) {
  const map = new Map();
  const raw = fs.readFileSync(filePath, 'utf8');
  const lines = raw.split('\n');
  // Pular cabeçalho
  for (let i = 1; i < lines.length; i++) {
    const line = lines[i].trim();
    if (!line) continue;
    // Formato: "Controle";"Subclasse";"Classe";"Atividade";"Equipe";"Complexidade"
    const parts = line.split(';').map(s => s.replace(/^"|"$/g, '').trim());
    const subclasse = parts[1] || '';
    const equipe = parts[4] || '';
    const complexidade = parts[5] || '';
    if (subclasse) {
      map.set(subclasse, { complexidade, equipe });
    }
  }
  return map;
}

/* ── Resolução de complexidade (mesma lógica de indicadores.html) ── */
function resolveComplexidade(a, mapaCNAE) {
  const sub = (a.subclasse || '').trim();

  // 1) Busca exata na subclasse do cnae.csv
  if (sub) {
    const entry = mapaCNAE.get(sub);
    if (entry) {
      const c = entry.complexidade;
      if (c && COMP_PRIORITY.includes(c)) return c;
    }
  }

  // 2) Prefixo de classe CNAE (ex.: "5611-2/" para "5611-2/02")
  if (sub) {
    const slashIdx = sub.lastIndexOf('/');
    if (slashIdx > 0) {
      const pfx = sub.slice(0, slashIdx + 1);
      let best = null;
      for (const [key, val] of mapaCNAE) {
        if (key.startsWith(pfx) && COMP_PRIORITY.includes(val.complexidade)) {
          if (!best || COMP_PRIORITY.indexOf(val.complexidade) < COMP_PRIORITY.indexOf(best)) {
            best = val.complexidade;
            if (best === COMP_PRIORITY[0]) break; // ALTA = melhor
          }
        }
      }
      if (best) return best;
    }
  }

  // 3) Fallback: campo complexidade embutido no JSON
  const c = (a.complexidade || '').trim();
  if (c && COMP_PRIORITY.includes(c)) return c;

  return null;
}

/* ── Principal ── */
function main() {
  const dataDir = path.join(__dirname, '..', 'data');
  const regDir = path.join(dataDir, 'reg');
  const cnaeFile = path.join(dataDir, 'cnae.csv');
  const outputFile = path.join(dataDir, 'complexidade_regulados.json');

  console.log('Carregando cnae.csv…');
  const mapaCNAE = loadCnaeCsv(cnaeFile);
  console.log(`  ${mapaCNAE.size} subclasses carregadas.`);

  console.log('Processando JSONs de regulados…');
  const result = {};
  let total = 0;
  let withAtv = 0;
  let classified = 0;

  // Iterar sobre diretórios de prefixo (00-99)
  const prefixDirs = fs.readdirSync(regDir)
    .filter(d => /^\d{2}$/.test(d))
    .sort();

  for (const prefix of prefixDirs) {
    const prefixPath = path.join(regDir, prefix);
    const files = fs.readdirSync(prefixPath).filter(f => f.endsWith('.json'));

    for (const file of files) {
      total++;
      const filePath = path.join(prefixPath, file);
      let data;
      try {
        data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
      } catch (e) {
        console.warn('  ⚠ Erro ao ler ' + filePath + ': ' + e.message);
        continue;
      }

      const codigo = data.codigo;
      if (codigo == null) continue;

      const atvs = data.atividades || [];
      const entry = { comp: null, hospital: false, ilpi: false, alimentacao: false };

      if (atvs.length === 0) {
        result[codigo] = entry;
        continue;
      }

      withAtv++;

      // Maior complexidade entre todas as atividades
      let highestComp = null;
      for (const a of atvs) {
        const c = resolveComplexidade(a, mapaCNAE);
        if (!c) continue;
        if (!highestComp || COMP_PRIORITY.indexOf(c) < COMP_PRIORITY.indexOf(highestComp)) {
          highestComp = c;
        }
      }
      entry.comp = highestComp;
      if (highestComp) classified++;

      // Área de maior prioridade (para Mapa SIA/SUS)
      const areaNomes = atvs.map(a => {
        let sig = (a.equipe || '').trim().toUpperCase();
        if (sig === 'PS') sig = 'OS';
        return SIGLA_AREA[sig] || null;
      }).filter(Boolean);

      let topArea = null;
      for (const area of REG_PRIORITY) {
        if (areaNomes.includes(area)) {
          topArea = area;
          break;
        }
      }

      if (topArea === 'Serviços de Saúde') {
        const ssAtvs = atvs.filter(a => {
          let sig = (a.equipe || '').trim().toUpperCase();
          if (sig === 'PS') sig = 'OS';
          return SIGLA_AREA[sig] === 'Serviços de Saúde';
        });
        const temHosp = ssAtvs.some(a => (a.subclasse || '').startsWith('8610-1'));
        const temILPI = ssAtvs.some(a => {
          const s = a.subclasse || '';
          return s.startsWith('8711-5') || s.startsWith('8731-1');
        });
        if (temHosp) entry.hospital = true;
        else if (temILPI) entry.ilpi = true;
      } else if (topArea === 'Indústrias Alimentícias' || topArea === 'Alimentos em Geral') {
        entry.alimentacao = true;
      }

      result[codigo] = entry;
    }
  }

  console.log(`  Total: ${total} | Com atividades: ${withAtv} | Classificados: ${classified}`);
  console.log(`  Sem atividades: ${total - withAtv} | Sem classificação (com atv): ${withAtv - classified}`);

  // Salvar
  const output = {
    meta: {
      gerado_em: new Date().toISOString(),
      total_regulados: total,
      classificados: classified,
      sem_atividades: total - withAtv
    },
    dados: result
  };

  fs.writeFileSync(outputFile, JSON.stringify(output), 'utf8');
  const sizeMB = (fs.statSync(outputFile).size / 1024 / 1024).toFixed(2);
  console.log(`\nArquivo gerado: ${outputFile} (${sizeMB} MB)`);
}

main();
