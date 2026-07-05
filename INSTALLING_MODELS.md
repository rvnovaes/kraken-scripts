# Instalação de modelos OCR para Kraken

Este documento explica como instalar modelos OCR do Kraken vindos de três fontes:

1. catálogo padrão do Kraken;
2. Zenodo ou DOI;
3. repositórios externos, como GitHub, eScriptorium, OCR-D ou Ajax Multi Commentary.

---

## 1. Princípio geral

O Kraken usa modelos de reconhecimento em formato:

```text
.mlmodel
```

O arquivo `.mlmodel` pode estar em qualquer pasta. Não é necessário que ele apareça em `kraken list`.

Exemplo:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic.mlmodel"
kraken -i pagina.tif pagina.txt binarize segment ocr -m "$MODEL"
```

No nosso script:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic.mlmodel"
./scripts/pdf_kraken_to_txt.sh "livro.pdf" 300 4
```

---

## 2. Modelos do catálogo Kraken

Listar modelos disponíveis:

```bash
kraken list
```

Pesquisar por termo:

```bash
kraken list | grep -Ei "greek|grc|polytonic|hellenic|ancient"
```

Pesquisar por Fraktur:

```bash
kraken list | grep -Ei "fraktur|german|blackletter|antiqua"
```

Baixar modelo por DOI:

```bash
kraken get 10.5281/zenodo.10519596
```

Depois localize o arquivo, se necessário:

```bash
find ~/.local -name "*.mlmodel" 2>/dev/null
find ~/.cache -name "*.mlmodel" 2>/dev/null
```

---

## 3. Modelos externos ao catálogo

O Kraken também aceita modelos não listados em `kraken list`.

Procedimento recomendado:

```bash
mkdir -p models/greek
cp NOME_DO_MODELO.mlmodel models/greek/
```

Depois:

```bash
export MODEL="$PWD/models/greek/NOME_DO_MODELO.mlmodel"
```

---

## 4. Exemplo: modelos Ajax Multi Commentary

Repositório:

```text
https://github.com/AjaxMultiCommentary/OCR-kraken-models
```

Clonar:

```bash
git clone https://github.com/AjaxMultiCommentary/OCR-kraken-models.git external/OCR-kraken-models
```

Listar modelos:

```bash
find external/OCR-kraken-models -name "*.mlmodel"
```

Copiar para o diretório do projeto:

```bash
mkdir -p models/greek
cp external/OCR-kraken-models/CAMINHO/DO/MODELO.mlmodel models/greek/
```

Renomeie de modo estável, se necessário:

```bash
mv models/greek/NOME_ORIGINAL.mlmodel models/greek/ajax_polytonic_porson.mlmodel
```

Use:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic_porson.mlmodel"
./scripts/pdf_kraken_to_txt.sh "texto_grego.pdf" 300 4
```

---

## 5. Baixar arquivo individual do GitHub

Quando o link bruto do `.mlmodel` estiver disponível:

```bash
mkdir -p models/greek
wget -O models/greek/ajax_polytonic_porson.mlmodel \
  "https://raw.githubusercontent.com/USUARIO/REPOSITORIO/BRANCH/CAMINHO/MODELO.mlmodel"
```

Atenção: o link da página HTML do GitHub não é o mesmo que o link bruto. Use sempre `raw.githubusercontent.com` ou o botão **Raw** do GitHub.

---

## 6. Modelos compactados

Se o modelo vier como `.gz`:

```bash
gunzip modelo.mlmodel.gz
```

Se vier como `.zip`:

```bash
unzip modelos.zip -d modelos_extraidos
find modelos_extraidos -name "*.mlmodel"
```

---

## 7. Registro obrigatório em MODELS.md

Ao adicionar um modelo ao repositório, registre:

```markdown
## Nome do modelo

- Arquivo: `models/greek/ajax_polytonic_porson.mlmodel`
- Fonte: Ajax Multi Commentary
- URL: https://github.com/AjaxMultiCommentary/OCR-kraken-models
- Licença: CC BY 4.0, conforme repositório original
- Uso recomendado: grego antigo politônico em edições impressas
- Data de download: AAAA-MM-DD
- Observações: bom para Porson; testar com Burnet/OCT/Teubner.
```

---

## 8. Verificação de integridade

Para registrar o hash do modelo:

```bash
sha256sum models/greek/ajax_polytonic_porson.mlmodel
```

Inclua o resultado em `MODELS.md`:

```text
SHA256: ...
```

Isso ajuda a garantir reprodutibilidade.

---

## 9. Convenção de nomes

Use nomes descritivos e estáveis:

```text
models/greek/ajax_polytonic_porson.mlmodel
models/greek/ajax_polytonic_german_serifs.mlmodel
models/german/german_print_zenodo_10519596.mlmodel
models/latin/latin_early_prints.mlmodel
```

Evite nomes genéricos como:

```text
best.mlmodel
model.mlmodel
final.mlmodel
```

---

## 10. Importante sobre licenças

Guardar uma cópia local do modelo aumenta a reprodutibilidade da pesquisa, mas não altera a licença original.

Ao redistribuir modelos:

1. mantenha referência ao projeto de origem;
2. preserve arquivos de licença quando disponíveis;
3. registre a licença em `MODELS.md`;
4. não misture modelos de licenças incompatíveis sem anotação clara.
