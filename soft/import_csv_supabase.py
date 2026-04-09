"""
Importa CSVs (exportados do Paradox) para as tabelas do Supabase (CVS Vigilância Sanitária).
Requer: pip install supabase python-dotenv

Uso:
  1. Crie um .env na mesma pasta com SUPABASE_URL, SUPABASE_SERVICE_KEY e opcionalmente CSV_DIR.
  2. Coloque os CSV na pasta (ex.: bairro.csv, contrib.csv) com cabeçalho igual aos nomes das colunas no banco.
  3. Execute: python import_csv_supabase.py
  4. Depois rode supabase_seed_sequences.sql no SQL Editor.
"""

import csv
import os
import re
from pathlib import Path

from dotenv import load_dotenv
from supabase import create_client, Client

load_dotenv()

# Ordem de importação (respeita FKs)
TABELAS_ORDEM = [
    "bairro", "ativi", "area", "grupo", "cnae", "comple", "sequencia", "login",
    "contrib", "registro", "andamentos", "denuncia", "atend", "oficio",
    "requerimento", "planta", "tramitacao", "visitas", "rt", "alvara", "alvlib",
    "historico", "veiculo", "rdpf", "rdpfarq", "rmpf", "tbcon", "auxrelativ", "caracter",
]

BATCH_SIZE = 200
CSV_DIR = os.getenv("CSV_DIR", ".")


def parse_val(val: str, col: str):
    """Converte string do CSV para tipo Python (None, bool, date, time, int, float, str)."""
    if val is None or (isinstance(val, str) and val.strip() == ""):
        return None
    s = (val.strip() if isinstance(val, str) else str(val)).strip()
    if not s:
        return None
    # Boolean
    if s.upper() in ("TRUE", "1", "S", "SIM", "Y", "YES", "-1"):
        return True
    if s.upper() in ("FALSE", "0", "N", "NAO", "NÃO"):
        return False
    # Inteiro
    if re.match(r"^-?\d+$", s):
        return int(s)
    # Decimal
    if re.match(r"^-?\d+[,.]?\d*$", s.replace(",", ".")):
        try:
            return float(s.replace(",", "."))
        except ValueError:
            pass
    # Data: YYYY-MM-DD ou DD/MM/YYYY
    if re.match(r"^\d{4}-\d{2}-\d{2}$", s):
        return s
    if re.match(r"^\d{1,2}/\d{1,2}/\d{4}$", s):
        d, m, a = s.split("/")
        return f"{a}-{m.zfill(2)}-{d.zfill(2)}"
    # Hora: HH:MM ou HH:MM:SS
    if re.match(r"^\d{1,2}:\d{2}(:\d{2})?$", s):
        return s
    return s


def ler_csv(caminho: Path) -> list[dict]:
    """Lê CSV UTF-8 e retorna lista de dict (cabeçalho = chaves)."""
    with open(caminho, "r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f, delimiter=",", quotechar='"')
        rows = []
        for row in reader:
            # Normalizar nomes das colunas (minúsculo, sem BOM)
            clean = {}
            for k, v in row.items():
                key = k.strip().lower().replace("\ufeff", "")
                clean[key] = v
            rows.append(clean)
        return rows


def preparar_linha(row: dict, colunas_tabela: set) -> dict:
    """Mantém só colunas que existem na tabela e converte tipos."""
    out = {}
    for k, v in row.items():
        key = k.lower().strip()
        if key not in colunas_tabela:
            continue
        out[key] = parse_val(v, key)
    return out


def importar_tabela(supabase: Client, nome: str, pasta: Path) -> int:
    """Importa um CSV para a tabela. Retorna quantidade de linhas inseridas."""
    arquivo = pasta / f"{nome}.csv"
    if not arquivo.exists():
        print(f"  [PULAR] {nome}.csv não encontrado.")
        return 0

    rows = ler_csv(arquivo)
    if not rows:
        print(f"  [VAZIO] {nome}.csv")
        return 0

    # Colunas presentes no CSV (usar primeira linha como referência)
    colunas_csv = set(k.lower().strip() for k in rows[0].keys())
    # No Supabase, colunas da tabela são inferidas pela primeira inserção
    # Assumimos que o CSV tem os nomes corretos; removemos colunas vazias no insert
    total = 0
    for i in range(0, len(rows), BATCH_SIZE):
        batch = rows[i : i + BATCH_SIZE]
        to_insert = []
        for row in batch:
            clean = {}
            for k, v in row.items():
                key = k.strip().lower().replace("\ufeff", "")
                clean[key] = parse_val(v, key)
            to_insert.append(clean)
        try:
            supabase.table(nome).insert(to_insert).execute()
            total += len(to_insert)
        except Exception as e:
            print(f"  [ERRO] {nome} lote {i//BATCH_SIZE + 1}: {e}")
            raise
    print(f"  [OK] {nome}: {total} linhas.")
    return total


def main():
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_SERVICE_KEY")
    if not url or not key:
        print("Defina SUPABASE_URL e SUPABASE_SERVICE_KEY no .env")
        return

    pasta = Path(os.getenv("CSV_DIR", "."))
    if not pasta.is_dir():
        print(f"Pasta de CSV não encontrada: {pasta}")
        return

    supabase: Client = create_client(url, key)
    print(f"Importando CSVs de: {pasta.absolute()}\n")

    for nome in TABELAS_ORDEM:
        importar_tabela(supabase, nome, pasta)

    print("\nConcluído. Execute supabase_seed_sequences.sql no Supabase para ajustar as sequences.")


if __name__ == "__main__":
    main()
