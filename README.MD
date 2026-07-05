# OCR com Kraken: guia de instalação, modelos e uso

Este documento organiza o fluxo de OCR com **Kraken** para PDFs acadêmicos, livros históricos e textos com tipografias especializadas, como **Fraktur alemã** e **grego antigo politônico**.

O objetivo é manter um ambiente reprodutível: os modelos usados no projeto devem ser documentados, preservados localmente e referenciados com fonte, licença e finalidade de uso.

---

## 1. Visão geral

Fluxo recomendado:

```text
PDF
  ↓
pdftocairo
  ↓
TIFF por página
  ↓
Kraken
  ↓
TXT por página
  ↓
TXT final
```

O Kraken trabalha muito bem com imagens. Por isso, o script do projeto converte cada página do PDF em TIFF, executa OCR com um modelo `.mlmodel` e depois junta os textos resultantes.

---

## 2. Dependências do sistema

No Ubuntu:

```bash
sudo apt update
sudo apt install -y \
  poppler-utils \
  parallel \
  python3 \
  python3-venv \
  python3-pip \
  python3-dev \
  build-essential \
  libopenjp2-7 \
  libopenjp2-7-dev \
  libtiff-dev \
  libjpeg-dev \
  zlib1g-dev
```

Componentes principais:

- `pdftocairo`: converte páginas do PDF para TIFF;
- `pdfinfo`: identifica o número de páginas do PDF;
- `parallel`: processa páginas em paralelo;
- `kraken`: executa OCR;
- arquivos `.mlmodel`: modelos de reconhecimento usados pelo Kraken.

---

## 3. Instalação do Kraken

### Opção recomendada: pipx

```bash
sudo apt install -y pipx
pipx install kraken
```

Caso seja necessário usar uma versão específica do Python:

```bash
pipx install --python python3.12 kraken
```

### Alternativa: ambiente virtual

```bash
python3 -m venv ~/kraken-env
source ~/kraken-env/bin/activate
pip install --upgrade pip setuptools wheel
pip install "kraken[pdf]"
```

Verificação:

```bash
kraken --version
```

---

## 4. Estrutura sugerida do projeto

```text
.
├── scripts/
│   └── pdf_kraken_to_txt.sh
└── models/
    ├── README.md
    ├── greek/
    │   └── README.md
    ├── german/
    │   └── README.md
    ├── latin/
    │   └── README.md
    ├── french/
    │   └── README.md
    └── multilingual/
        └── README.md
```

Os arquivos `.mlmodel` não precisam estar no catálogo padrão do Kraken. O script aceita qualquer modelo compatível, desde que o caminho seja passado pela variável de ambiente `MODEL`.

---

## 5. Uso básico do script

Exemplo:

```bash
export MODEL="/caminho/para/models/german/german_print.mlmodel"
./scripts/pdf_kraken_to_txt.sh "livro.pdf" 300 4
```

Parâmetros:

```text
./scripts/pdf_kraken_to_txt.sh ARQUIVO.pdf [DPI] [PROCESSOS]
```

Exemplo com grego politônico:

```bash
export MODEL="$PWD/models/greek/ajax_polytonic.mlmodel"
./scripts/pdf_kraken_to_txt.sh "burnet_crito.pdf" 300 4
```

Exemplo com Fraktur alemã:

```bash
export MODEL="$PWD/models/german/german_print.mlmodel"
./scripts/pdf_kraken_to_txt.sh "kapp_1845.pdf" 300 4
```

---

## 6. DPI recomendado

| Tipo de documento | DPI sugerido |
|---|---:|
| PDF moderno limpo | 300 |
| Livro escaneado bom | 300 |
| Fraktur alemã | 300–400 |
| Grego politônico com muitos diacríticos | 350–400 |
| Impressão ruim, apagada ou torta | 400 |

Regra prática: comece com `300`. Aumente para `400` apenas se houver perda sensível em diacríticos, pontuação fina ou letras pequenas.

---

## 7. Número de processos paralelos

O terceiro parâmetro do script controla o número de processos Kraken paralelos:

```bash
./scripts/pdf_kraken_to_txt.sh "livro.pdf" 300 4
```

Neste exemplo, `4` significa quatro páginas processadas simultaneamente.

Sugestão inicial:

| Hardware | Processos |
|---|---:|
| CPU apenas, 8 threads | 6–8 |
| CPU apenas, 16 threads | 12–15 |
| GPU NVIDIA RTX 4060 | testar 3, 4, 5 e 6 |
| GPU com pouca VRAM | começar em 2 |

Com CUDA, muitos processos podem disputar a mesma GPU. O melhor valor deve ser medido empiricamente com:

```bash
time ./scripts/pdf_kraken_to_txt.sh "livro.pdf" 300 4
```

---

## 8. Como escolher modelos

Consulte:

- `INSTALLING_MODELS.md`: como instalar modelos;
- `MODELS.md`: catálogo dos modelos usados no projeto;
- `MODELS_DIRECTORY.md`: organização das pastas de modelos;
- `NORMALIZATION.md`: normalização pós-OCR, especialmente para Fraktur.

Critério geral:

| Material | Modelo preferencial |
|---|---|
| Grego antigo politônico | modelo Kraken treinado em grego politônico |
| Edições críticas com grego + latim/inglês | modelo grego, ou reconhecimento multi-script se houver segmentação adequada |
| Fraktur alemã | modelo de German historical print / Fraktur |
| Antiqua alemã moderna | modelo German print ou Tesseract `deu` |
| Latim impresso antigo | modelo Latin incunabula / early prints |

---

## 9. Observação sobre modelos externos

O Kraken pode carregar diretamente arquivos `.mlmodel`. Portanto, modelos externos ao catálogo padrão, como os do **AjaxMultiCommentary/OCR-kraken-models**, podem ser baixados, preservados em `models/` e usados normalmente com:

```bash
export MODEL="$PWD/models/greek/NOME_DO_MODELO.mlmodel"
```

Sempre registre em `MODELS.md`:

- nome do arquivo;
- fonte;
- URL original;
- licença;
- uso recomendado;
- data de download;
- observações empíricas.
