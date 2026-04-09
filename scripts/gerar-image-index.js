#!/usr/bin/env node
/**
 * gerar-image-index.js
 *
 * Lê todos os arquivos de imagem do diretório data/img/ e gera
 * data/img/index.json — um índice mapeando o número da denúncia / NDOC
 * da inspeção para a lista de arquivos de imagem anexados.
 *
 * Padrões de nome suportados:
 *   den_XXXXXXXX_YYYYMMDDHHMMSS[...].jpg  → denúncia nº XXXXXXXX
 *   ins_NNNNNN_YYYYMMDDHHMMSS[...].jpg    → inspeção ndoc NNNNNN
 *
 * Uso: node scripts/gerar-image-index.js
 */

const fs   = require('fs');
const path = require('path');

const IMG_DIR    = path.join(__dirname, '..', 'data', 'img');
const INDEX_FILE = path.join(IMG_DIR, 'index.json');

const EXTENSIONS = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];

if (!fs.existsSync(IMG_DIR)) {
    console.error(`❌ Diretório não encontrado: ${IMG_DIR}`);
    process.exit(1);
}

const PREFIXOS_VALIDOS = ['den_', 'ins_'];

const arquivos = fs.readdirSync(IMG_DIR)
    .filter(f => {
        const ext = path.extname(f).toLowerCase();
        return EXTENSIONS.includes(ext) && PREFIXOS_VALIDOS.some(p => f.startsWith(p));
    });

const index = {};

for (const arquivo of arquivos) {
    // Remove a extensão para processar o nome
    const nome = path.parse(arquivo).name; // ex: den_20260195_20260409003353 | ins_122411_20260409184131
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
console.log(`✅ index.json gerado: ${totalArq} imagem(ns) em ${total} entradas (denúncias + inspeções)`);
console.log(`   → ${INDEX_FILE}`);
