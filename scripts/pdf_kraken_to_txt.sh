#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
    echo "Uso: MODEL=/caminho/modelo.mlmodel $0 arquivo.pdf [dpi] [jobs]"
    echo "Exemplo: MODEL=/home/usuario/models/german_print.mlmodel $0 livro.pdf 300 4"
    exit 1
fi

if [ -z "${MODEL:-}" ]; then
    echo "Erro: defina a variável de ambiente MODEL."
    echo "Exemplo: export MODEL=/home/usuario/models/german_print.mlmodel"
    exit 1
fi

PDF="$1"
DPI="${2:-300}"
JOBS="${3:-4}"

BASENAME="$(basename "$PDF" .pdf)"
OUTDIR="${BASENAME}_kraken"
IMGDIR="$OUTDIR/images"
TXTDIR="$OUTDIR/text"
LOGDIR="$OUTDIR/logs"
OUTFILE="$OUTDIR/${BASENAME}_ocr.txt"
FAILED="$OUTDIR/failed_pages.txt"
LOGFILE="$OUTDIR/ocr.log"

mkdir -p "$IMGDIR" "$TXTDIR" "$LOGDIR"
: > "$FAILED"
: > "$LOGFILE"

PAGES=$(pdfinfo "$PDF" | awk '/^Pages:/ {print $2}')

echo "==> PDF: $PDF" | tee -a "$LOGFILE"
echo "==> Modelo: $MODEL" | tee -a "$LOGFILE"
echo "==> Páginas: $PAGES" | tee -a "$LOGFILE"
echo "==> DPI: $DPI" | tee -a "$LOGFILE"
echo "==> Processos paralelos: $JOBS" | tee -a "$LOGFILE"
echo "==> Saída: $OUTDIR" | tee -a "$LOGFILE"
echo

export PDF MODEL DPI IMGDIR TXTDIR LOGDIR FAILED LOGFILE

process_page() {
    PAGE="$1"
    PADDED=$(printf "%04d" "$PAGE")
    PREFIX="$IMGDIR/page_${PADDED}"
    TXT="$TXTDIR/page_${PADDED}.txt"
    PAGELOG="$LOGDIR/page_${PADDED}.log"

    {
        echo "==> Página $PAGE"

        pdftocairo \
            -tiff \
            -r "$DPI" \
            -f "$PAGE" \
            -l "$PAGE" \
            "$PDF" \
            "$PREFIX"

        REAL_IMG="$(find "$IMGDIR" -maxdepth 1 -name "page_${PADDED}*.tif" | sort | head -n 1)"

        if [ -z "$REAL_IMG" ] || [ ! -f "$REAL_IMG" ]; then
            echo "ERRO: imagem não gerada para página $PAGE"
            echo "$PAGE" >> "$FAILED"
            exit 1
        fi

        kraken \
            -i "$REAL_IMG" \
            "$TXT" \
            binarize \
            segment \
            ocr \
            -m "$MODEL"

        if [ ! -s "$TXT" ]; then
            echo "ERRO: texto não gerado ou vazio para página $PAGE"
            echo "$PAGE" >> "$FAILED"
            exit 1
        fi

        echo "OK: página $PAGE"
    } > "$PAGELOG" 2>&1
}

export -f process_page

seq 1 "$PAGES" | parallel --bar -j "$JOBS" process_page {}

echo
echo "==> Unindo textos..."

: > "$OUTFILE"

for n in $(seq 1 "$PAGES"); do
    PADDED=$(printf "%04d" "$n")
    FILE="$TXTDIR/page_${PADDED}.txt"

    if [ -f "$FILE" ]; then
        {
            echo
            echo "===== Página $n ====="
            echo
            cat "$FILE"
        } >> "$OUTFILE"
    else
        echo "$n" >> "$FAILED"
    fi
done

sort -n -u "$FAILED" -o "$FAILED"

TOTAL_OK=$(find "$TXTDIR" -name "page_*.txt" | wc -l)
TOTAL_FAIL=$(wc -l < "$FAILED")

echo
echo "Concluído."
echo "Páginas OK: $TOTAL_OK"
echo "Páginas com falha: $TOTAL_FAIL"
echo "Texto final: $OUTFILE"
echo "Falhas: $FAILED"
echo "Logs: $LOGDIR"
