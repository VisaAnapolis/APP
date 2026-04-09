#!/usr/bin/env node
/**
 * gerar-pdf-index.js
 *
 * Lê todos os arquivos PDF do diretório data/pdf/ e gera
 * data/pdf/index.json — um índice mapeando o número da denúncia / NDOC
 * da inspeção para a lista de arquivos PDF anexados.
 *
 * Padrões de nome suportados:
 *   den_XXXXXXXX_YYYYMMDDHHMMSS[...].pdf  → denúncia nº XXXXXXXX
 *   ins_NNNNNN_YYYYMMDDHHMMSS[...].pdf    → inspeção ndoc NNNNNN
 *
 * Uso: node scripts/gerar-pdf-index.js
 */

const fs   = require('fs');
const path = require('path');

const PDF_DIR    = path.join(__dirname, '..', 'data', 'pdf');
const INDEX_FILE = path.join(PDF_DIR, 'index.json');

const PREFIXOS_VALIDOS = ['den_', 'ins_'];

if (!fs.existsSync(PDF_DIR)) {
    console.error(`❌ Diretório não encontrado: ${PDF_DIR}`);
    process.exit(1);
}

const arquivos = fs.readdirSync(PDF_DIR)
    .filter(f => {
        return path.extname(f).toLowerCase() === '.pdf' &&
               PREFIXOS_VALIDOS.some(p => f.startsWith(p));
    });

const index = {};

for (const arquivo of arquivos) {
    const nome = path.parse(arquivo).name; // ex: den_20260154_20260409102806 | ins_122411_20260409184142
    const partes = nome.split('_');
    // partes[0] = 'den'|'ins', partes[1] = número da denúncia / ndoc
    if (partes.length < 2) continue;
    const chave = partes[1];
    if (!chave) continue;

    if (!index[chave]) {
        index[chave] = [];
    }
    index[chave].push(arquivo);
}

// Ordena os arquivos de cada entrada para exibição consistente
for (const chave of Object.keys(index)) {
    index[chave].sort();
}

fs.writeFileSync(INDEX_FILE, JSON.stringify(index, null, 2), 'utf8');

const total = Object.keys(index).length;
const totalArq = arquivos.length;
console.log(`✅ index.json gerado: ${totalArq} PDF(s) em ${total} entradas (denúncias + inspeções)`);
console.log(`   → ${INDEX_FILE}`);
