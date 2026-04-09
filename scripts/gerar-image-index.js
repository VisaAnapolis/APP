#!/usr/bin/env node
/**
 * gerar-image-index.js
 *
 * Lê todos os arquivos de imagem do diretório data/img/ e gera
 * data/img/index.json — um índice mapeando o número da denúncia
 * para a lista de arquivos de imagem anexados.
 *
 * Padrão de nome: den_XXXXXXXX_YYYYMMDDHHMMSS[...].jpg
 *   - den    : tipo denúncia
 *   - XXXXXXXX : número da denúncia
 *   - restante : data/hora + caracteres diferenciadores
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

const arquivos = fs.readdirSync(IMG_DIR)
    .filter(f => {
        const ext = path.extname(f).toLowerCase();
        return EXTENSIONS.includes(ext) && f.startsWith('den_');
    });

const index = {};

for (const arquivo of arquivos) {
    // Remove a extensão para processar o nome
    const nome = path.parse(arquivo).name; // ex: den_20260195_20260409003353
    const partes = nome.split('_');
    // partes[0] = 'den', partes[1] = número da denúncia
    if (partes.length < 2) continue;
    const numeroDenuncia = partes[1];
    if (!numeroDenuncia) continue;

    if (!index[numeroDenuncia]) {
        index[numeroDenuncia] = [];
    }
    index[numeroDenuncia].push(arquivo);
}

// Ordena os arquivos de cada denúncia para exibição consistente
for (const num of Object.keys(index)) {
    index[num].sort();
}

fs.writeFileSync(INDEX_FILE, JSON.stringify(index, null, 2), 'utf8');

const total = Object.keys(index).length;
const totalArq = arquivos.length;
console.log(`✅ index.json gerado: ${totalArq} imagem(ns) em ${total} denúncia(s)`);
console.log(`   → ${INDEX_FILE}`);
