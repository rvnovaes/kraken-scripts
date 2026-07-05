# Diretório de modelos OCR

Este documento descreve como organizar os modelos OCR no repositório.

---

## 1. Estrutura recomendada

```text
models/
├── README.md
├── greek/
│   ├── README.md
│   ├── ajax_polytonic_porson.mlmodel
│   ├── ajax_polytonic_german_serifs_schneidewin.mlmodel
│   └── ajax_polytonic_german_serifs_lobeck.mlmodel
├── german/
│   ├── README.md
│   └── german_print_zenodo_10519596.mlmodel
├── latin/
│   └── README.md
├── french/
│   └── README.md
└── multilingual/
    ├── README.md
    └── party_base_multilingual.mlmodel
```

---

## 2. Convenções

### 2.1 Nomes descritivos

Use:

```text
ajax_polytonic_porson.mlmodel
german_print_zenodo_10519596.mlmodel
latin_early_prints.mlmodel
```

Evite:

```text
model.mlmodel
best.mlmodel
final.mlmodel
download.mlmodel
```

---

## 3. Preservação de fontes

Sempre que possível, preservar junto ao modelo:

```text
metadata.json
LICENSE
README.md
CITATION.cff
```

Se o repositório externo organizar cada modelo em uma pasta própria, preserve também a pasta original em `external/` ou copie os metadados relevantes para `MODELS.md`.

---

## 4. Exemplo de importação

```bash
mkdir -p external
git clone https://github.com/AjaxMultiCommentary/OCR-kraken-models.git external/OCR-kraken-models

find external/OCR-kraken-models -name "*.mlmodel"
```

Copiar:

```bash
mkdir -p models/greek
cp external/OCR-kraken-models/CAMINHO/DO/MODELO.mlmodel \
   models/greek/ajax_polytonic_porson.mlmodel
```

Registrar hash:

```bash
sha256sum models/greek/ajax_polytonic_porson.mlmodel
```

Atualizar `MODELS.md`.

---

## 5. Não confiar apenas no nome do modelo

Antes de usar em produção, verificar:

```bash
kraken -i pagina_teste.tif saida.txt binarize segment ocr -m models/greek/ajax_polytonic_porson.mlmodel
```

Depois comparar o resultado com:

- trecho revisado manualmente;
- OCRmyPDF/Tesseract `grc`, se aplicável;
- outro modelo Kraken.
