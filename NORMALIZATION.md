# Normalização pós-OCR

Este documento registra normalizações úteis após OCR de livros históricos, especialmente Fraktur alemã e textos clássicos.

A recomendação é preservar sempre duas versões:

1. **diplomática**: mantém os caracteres reconhecidos pelo OCR;
2. **normalizada**: substitui caracteres históricos por equivalentes modernos para busca, tradução e indexação.

---

## 1. Fraktur alemã

### Caracteres comuns

| Caractere | Nome | Normalização usual |
|---|---|---|
| `ſ` | s longo | `s` |
| `⸗` | double oblique hyphen | `-` |
| `ﬀ` | ligadura ff | `ff` |
| `ﬁ` | ligadura fi | `fi` |
| `ﬂ` | ligadura fl | `fl` |
| `ﬃ` | ligadura ffi | `ffi` |
| `ﬄ` | ligadura ffl | `ffl` |

---

## 2. Comando `sed` simples

Criar cópia normalizada:

```bash
sed \
  -e 's/ſ/s/g' \
  -e 's/⸗/-/g' \
  -e 's/ﬀ/ff/g' \
  -e 's/ﬁ/fi/g' \
  -e 's/ﬂ/fl/g' \
  -e 's/ﬃ/ffi/g' \
  -e 's/ﬄ/ffl/g' \
  livro_ocr.txt > livro_ocr_normalizado.txt
```

---

## 3. Script Python para normalização

```python
from pathlib import Path

src = Path("livro_ocr.txt")
dst = Path("livro_ocr_normalizado.txt")

text = src.read_text(encoding="utf-8")

replacements = {
    "ſ": "s",
    "⸗": "-",
    "ﬀ": "ff",
    "ﬁ": "fi",
    "ﬂ": "fl",
    "ﬃ": "ffi",
    "ﬄ": "ffl",
}

for old, new in replacements.items():
    text = text.replace(old, new)

dst.write_text(text, encoding="utf-8")
```

---

## 4. Grego antigo

Para grego antigo politônico, **não normalize diacríticos automaticamente** sem uma razão clara.

Evite remover:

- acentos;
- espíritos;
- iota subscrito;
- diérese;
- sinais editoriais.

Em filologia clássica, esses sinais são semanticamente relevantes.

Normalizações gregas só devem ser feitas para fins específicos, por exemplo:

- busca aproximada;
- comparação lexical;
- indexação;
- geração de corpus paralelo.

Nesse caso, mantenha sempre o texto diplomático original.

---

## 5. Nomes sugeridos de saída

```text
livro_ocr_diplomatico.txt
livro_ocr_normalizado.txt
```

Ou:

```text
KAPP_1845_ocr.txt
KAPP_1845_ocr_normalizado.txt
```
