# Modelos gregos

Esta pasta armazena modelos Kraken para:

- grego antigo;
- grego politônico;
- edições críticas;
- comentários clássicos;
- documentos mistos grego/latim/inglês/alemão.

Modelos prioritários:

- Ajax Multi Commentary;
- modelos especializados em fonte Porson;
- modelos treinados em comentários clássicos históricos.

Registrar cada modelo em `MODELS.md`.

---

## Modelos disponíveis

### Ajax Multi Commentary — Greek-English Porson / Sophocles

- **Arquivo original:**  
  `greek-english_porson_sophoclesplaysa05campgoog/greek-english_porson_sophoclesplaysa05campgoog.mlmodel`

- **Nome local sugerido:**  
  `models/greek/ajax_polytonic_porson_sophocles.mlmodel`

- **Fonte:**  
  Ajax Multi Commentary — OCR Kraken Models  
  `https://github.com/AjaxMultiCommentary/OCR-kraken-models`

- **Tipo:**  
  Modelo Kraken de reconhecimento OCR (`.mlmodel`)

- **Idioma principal:**  
  Grego antigo

- **Escrita:**  
  Grego politônico

- **Fonte tipográfica aproximada:**  
  Porson / grego clássico impresso

- **Uso recomendado:**  
  - textos gregos antigos;
  - edições críticas;
  - comentários clássicos;
  - páginas com grego politônico e texto auxiliar em inglês;
  - testes com Platão, tragédias, OCT, Teubner e edições próximas.

- **Licença:**  
  CC BY 4.0, conforme documentação original do repositório Ajax Multi Commentary.

- **SHA256:**

```text
bb14ebeac21e35f60c2d107d160ed32f0c271e19b1ed026d049f631232af2437
```

- **Comando usado para verificação:**

```bash
sha256sum greek-english_porson_sophoclesplaysa05campgoog/greek-english_porson_sophoclesplaysa05campgoog.mlmodel
```

- **Resultado:**

```text
bb14ebeac21e35f60c2d107d160ed32f0c271e19b1ed026d049f631232af2437  greek-english_porson_sophoclesplaysa05campgoog/greek-english_porson_sophoclesplaysa05campgoog.mlmodel
```

- **Status:**  
  Baixado; aguardando teste empírico em páginas de grego politônico.

---

## Uso

Exemplo:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic_porson_sophocles.mlmodel"

./scripts/pdf_kraken_to_txt.sh "texto_grego.pdf" 300 4
```

---

## Observação sobre normalização

Para grego antigo politônico, não se recomenda remover automaticamente diacríticos. Acentos, espíritos, iota subscrito e sinais editoriais podem ser relevantes para leitura filológica.

Caso seja necessária uma versão simplificada para busca aproximada, preserve também a versão diplomática do OCR.
