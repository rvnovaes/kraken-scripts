# Catálogo de modelos OCR

Este arquivo registra os modelos OCR usados no projeto.

Cada modelo deve ter:

- localização local;
- fonte original;
- licença;
- finalidade;
- data de download;
- hash de integridade;
- avaliação empírica.

---

## Resumo

| Modelo local | Idioma | Escrita/tipo | Fonte | Licença | Uso recomendado | Estado |
|---|---|---|---|---|---|---|
| `models/greek/ajax_polytonic_porson_sophocles.mlmodel` | Grego antigo | Politônico / Porson | Ajax Multi Commentary | CC BY 4.0, conforme repositório | Platão, tragédia, comentários clássicos | Baixado; aguardando teste |
| `models/greek/ajax_polytonic_german_serifs_schneidewin.mlmodel` | Grego antigo + alemão/latim | Politônico + serifas alemãs | Ajax Multi Commentary | CC BY 4.0, conforme repositório | Edições críticas e comentários com grego + alemão | A baixar/testar |
| `models/greek/ajax_polytonic_german_serifs_lobeck.mlmodel` | Grego antigo + latim/alemão | Politônico + serifas | Ajax Multi Commentary | CC BY 4.0, conforme repositório | Comentários históricos com grego e latim | A baixar/testar |
| `models/german/german_print_zenodo_10519596.mlmodel` | Alemão/latim | Fraktur + Antiqua | Zenodo / Kraken model repository | Ver Zenodo | Livros alemães dos sécs. XVIII–XX | Testado em Kapp |
| `models/multilingual/party_base_multilingual.mlmodel` | Multilíngue | Multiscript | Zenodo | Ver Zenodo | Testes exploratórios | Opcional |

---

## 1. Ajax Multi Commentary — modelos gregos

### Fonte

- Repositório: `https://github.com/AjaxMultiCommentary/OCR-kraken-models`
- Projeto: Ajax Multi Commentary
- Finalidade declarada: modelos Kraken pré-treinados para OCR de comentários clássicos históricos.
- Dados de treino mencionados no README original:
  - Polytonic Greek Training Data from Historic Texts (Pogretra) v1.0;
  - OCR GT for Historical Commentaries.
- Licença indicada no README: CC BY 4.0.
- Observação: consultar também o `metadata.json` de cada diretório de modelo.

### 1.1 `ajax_polytonic_porson_sophocles.mlmodel`

- Arquivo local: `models/greek/ajax_polytonic_porson_sophocles.mlmodel`
- Nome original no repositório: `greek-english_porson_sophoclesplaysa05campgoog`
- Arquivo original no repositório: `greek-english_porson_sophoclesplaysa05campgoog/greek-english_porson_sophoclesplaysa05campgoog.mlmodel`
- Idioma principal: grego antigo
- Escrita: grego politônico
- Fonte tipográfica aproximada: Porson / grego clássico impresso
- Tipo: reconhecimento OCR Kraken
- Uso recomendado:
  - grego antigo em fonte Porson;
  - edições críticas clássicas;
  - tragédia grega;
  - textos gregos com aparato ou comentário em inglês.
- Uso provável no projeto:
  - Platão em edições com grego politônico limpo;
  - comparação com Tesseract `grc`;
  - teste em Burnet/OCT/Teubner.
- Licença: CC BY 4.0, conforme repositório original.
- Data de download: `PREENCHER`
- SHA256:

```text
bb14ebeac21e35f60c2d107d160ed32f0c271e19b1ed026d049f631232af2437
```

- Comando usado para verificação:

```bash
sha256sum greek-english_porson_sophoclesplaysa05campgoog/greek-english_porson_sophoclesplaysa05campgoog.mlmodel
```

- Resultado da verificação:

```text
bb14ebeac21e35f60c2d107d160ed32f0c271e19b1ed026d049f631232af2437  greek-english_porson_sophoclesplaysa05campgoog/greek-english_porson_sophoclesplaysa05campgoog.mlmodel
```

- Avaliação empírica:
  - baixado; aguardando teste em páginas representativas de grego politônico;
  - testar com pelo menos uma página de texto corrido, uma com notas, uma com aparato crítico e uma página mista grego/inglês.

Comando:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic_porson_sophocles.mlmodel"
./scripts/pdf_kraken_to_txt.sh "texto_grego.pdf" 300 4
```

---

### 1.2 `ajax_polytonic_german_serifs_schneidewin.mlmodel`

- Arquivo local: `models/greek/ajax_polytonic_german_serifs_schneidewin.mlmodel`
- Nome original no repositório: `greek-german_serifs_sophokle1v3soph`
- Idioma principal: grego antigo
- Idiomas secundários prováveis: alemão/latim em comentários
- Escrita: grego politônico + serifas alemãs/latinas
- Tipo: reconhecimento OCR Kraken
- Uso recomendado:
  - comentários clássicos alemães;
  - edições históricas com grego politônico e notas em alemão;
  - material semelhante a filologia alemã do século XIX.
- Licença: CC BY 4.0, conforme repositório original.
- Data de download: `PREENCHER`
- SHA256: `PREENCHER`
- Avaliação empírica:
  - `PREENCHER`

Comando:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic_german_serifs_schneidewin.mlmodel"
./scripts/pdf_kraken_to_txt.sh "comentario_grego_alemao.pdf" 300 4
```

---

### 1.3 `ajax_polytonic_german_serifs_lobeck.mlmodel`

- Arquivo local: `models/greek/ajax_polytonic_german_serifs_lobeck.mlmodel`
- Nome original no repositório: `greek-german_serifs_bsb10234118`
- Idioma principal: grego antigo
- Idiomas secundários prováveis: latim/alemão
- Escrita: grego politônico + serifas históricas
- Tipo: reconhecimento OCR Kraken
- Uso recomendado:
  - comentários históricos com grego e latim;
  - edições clássicas de aparato denso;
  - comparação com o modelo Porson.
- Licença: CC BY 4.0, conforme repositório original.
- Data de download: `PREENCHER`
- SHA256: `PREENCHER`
- Avaliação empírica:
  - `PREENCHER`

Comando:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic_german_serifs_lobeck.mlmodel"
./scripts/pdf_kraken_to_txt.sh "comentario_grego_latim.pdf" 300 4
```

---

## 2. German Historical Print

### `german_print_zenodo_10519596.mlmodel`

- Arquivo local: `models/german/german_print_zenodo_10519596.mlmodel`
- Fonte: Zenodo / Kraken model repository
- DOI: `10.5281/zenodo.10519596`
- Descrição curta: OCR model for German prints trained from several datasets.
- Palavras-chave registradas na listagem Kraken:
  - `kraken_pytorch`
  - `antiqua`
  - `Fraktur`
  - `Latin`
  - `OCR`
- Idiomas:
  - alemão;
  - latim em material misto.
- Escritas:
  - Fraktur;
  - Antiqua.
- Uso recomendado:
  - livros alemães dos séculos XVIII–XX;
  - filosofia alemã;
  - teoria do Estado;
  - edições históricas em Fraktur.
- Licença: verificar página Zenodo do registro.
- Data de download: `PREENCHER`
- SHA256: `PREENCHER`
- Avaliação empírica:
  - testado em Kapp, `Vergleichende allgemeine Erdkunde`, 1845;
  - bom reconhecimento de Fraktur;
  - preserva `ſ` como s longo;
  - pode gerar `⸗` para hífen tipográfico/hífen de quebra.

Comando:

```bash
export MODEL="$PWD/models/german/german_print_zenodo_10519596.mlmodel"
./scripts/pdf_kraken_to_txt.sh "kapp_1845.pdf" 300 4
```

---

## 3. Modelo multilíngue opcional

### `party_base_multilingual.mlmodel`

- Arquivo local: `models/multilingual/party_base_multilingual.mlmodel`
- Fonte: Zenodo / Kraken model repository
- DOI observado em listagem: `10.5281/zenodo.20642057`
- Descrição curta: Pretrained multilingual Party base model.
- Tipo: reconhecimento OCR
- Uso recomendado:
  - testes exploratórios;
  - documentos mistos;
  - avaliação quando não houver modelo especializado.
- Licença: verificar página Zenodo.
- Data de download: `PREENCHER`
- SHA256: `PREENCHER`
- Avaliação empírica:
  - `PREENCHER`

---

## 4. Como preencher SHA256

```bash
sha256sum models/greek/ajax_polytonic_porson_sophocles.mlmodel
sha256sum models/german/german_print_zenodo_10519596.mlmodel
```

Copiar o resultado para a ficha do modelo.

O SHA256 não é necessário para o Kraken funcionar. Ele serve para controle de integridade, identificação exata do arquivo e reprodutibilidade acadêmica.

---

## 5. Critérios de avaliação empírica

Para cada modelo, testar pelo menos:

1. uma página de texto corrido;
2. uma página com notas de rodapé;
3. uma página com aparato crítico;
4. uma página com grego + latim/alemão/inglês;
5. uma página com impressão ruim.

Registrar:

```markdown
- Documento testado:
- Página:
- DPI:
- Processos:
- Erros frequentes:
- Tempo médio por página:
- Comentário:
```
