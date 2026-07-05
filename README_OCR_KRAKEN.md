# OCR de PDF com Kraken em processamento paralelo

Este repositório contém um script Bash para executar OCR em arquivos PDF usando o [**Kraken OCR**](https://github.com/mittagessen/kraken) , com conversão prévia das páginas para imagens por meio do `pdftocairo` e processamento paralelo controlado pelo usuário.

O fluxo foi pensado especialmente para PDFs digitalizados, livros antigos e impressos históricos, quando se deseja controlar explicitamente o modelo OCR utilizado.

## Fluxo geral

O script executa as seguintes etapas:

1. Recebe um arquivo PDF de entrada.
2. Converte cada página do PDF em uma imagem local usando `pdftocairo`.
3. Executa OCR em cada imagem com o Kraken.
4. Processa várias páginas em paralelo.
5. Gera um arquivo `.txt` para cada página.
6. Junta todos os textos parciais em um arquivo final consolidado.

Em termos simples:

```text
PDF → imagens por página → OCR Kraken em paralelo → TXT por página → TXT final
```

## Requisitos

Antes de executar o script, instale os seguintes componentes:

### 1. Poppler

O script usa `pdftocairo`, que faz parte do pacote `poppler-utils`.

No Ubuntu/Debian:

```bash
sudo apt update
sudo apt install poppler-utils
```

### 2. Kraken OCR

Instale o Kraken conforme o ambiente Python utilizado no projeto.

Exemplo com `pipx`:

```bash
pipx install kraken
```

Ou, em ambiente virtual:

```bash
python -m venv .venv
source .venv/bin/activate
pip install kraken
```

Verifique se o comando está disponível:

```bash
kraken --help
```

### 3. Modelo OCR do Kraken

O Kraken precisa de um modelo de reconhecimento para executar o OCR. O modelo é um arquivo `.mlmodel` treinado para determinado tipo de escrita, língua, período histórico ou família tipográfica.

Antes de instalar um modelo, consulte os modelos disponíveis no repositório público do Kraken:

```bash
kraken list
```

Esse comando exibe uma tabela com os modelos disponíveis, incluindo o DOI, uma breve descrição, o tipo do modelo e palavras-chave.

Também é possível filtrar a busca por modelos de reconhecimento:

```bash
kraken show --recognition
```

Ou procurar por língua:

```bash
kraken show --recognition --language deu   # alemão
kraken show --recognition --language lat   # latim
kraken show --recognition --language eng   # inglês
kraken show --recognition --language fra   # francês
```

Também se pode procurar por sistema de escrita:

```bash
kraken show --recognition --script Latn   # alfabeto latino
kraken show --recognition --script Grek   # grego
kraken show --recognition --script Cyrl   # cirílico
kraken show --recognition --script Arab   # árabe
```

Depois de identificar o modelo desejado, instale-o com `kraken get`, usando o DOI informado na listagem.

Exemplo genérico:

```bash
kraken get 10.5281/zenodo.XXXXXXX
```

Exemplo com o modelo alemão/latino usado nos testes:

```bash
kraken get 10.5281/zenodo.10519596
```

Ao baixar o modelo, o Kraken informa no terminal o diretório onde o arquivo `.mlmodel` foi salvo. Copie esse caminho e use-o na variável `MODEL`.

Exemplo:

```bash
export MODEL="/caminho/gerado/pelo/kraken/modelo.mlmodel"
```

Também é possível localizar modelos já baixados procurando por arquivos `.mlmodel`:

```bash
find "$HOME" -name "*.mlmodel" 2>/dev/null
```

O script lê o caminho do modelo pela variável de ambiente `MODEL`.

Exemplo:

```bash
export MODEL="/caminho/para/o/modelo.mlmodel"
```

Para o modelo alemão/latino que usamos nos testes, o caminho deve apontar para o arquivo `.mlmodel` baixado localmente.

## Uso básico

A forma geral de uso é:

```bash
MODEL="/caminho/para/modelo.mlmodel" ./ocr_pdf_kraken.sh entrada.pdf saida 3
```

Onde:

- `MODEL="/caminho/para/modelo.mlmodel"` define o modelo OCR a ser usado pelo Kraken.
- `./ocr_pdf_kraken.sh` é o script principal.
- `entrada.pdf` é o PDF que será processado.
- `saida` é a pasta onde serão salvos os resultados.
- `3` é o número de processos paralelos.

## Exemplo completo

```bash
MODEL="$HOME/modelos/kraken/german_prints.mlmodel" \
./ocr_pdf_kraken.sh livro.pdf ocr_livro 3
```

Esse comando irá:

1. Ler o arquivo `livro.pdf`.
2. Criar a pasta `ocr_livro`, se ela ainda não existir.
3. Gerar imagens das páginas dentro da pasta de saída.
4. Processar 3 páginas ao mesmo tempo.
5. Criar arquivos `.txt` individuais por página.
6. Criar um arquivo final com o texto unido.

## Estrutura esperada da saída

Após a execução, a pasta de saída deverá conter uma estrutura semelhante a esta:

```text
ocr_livro/
├── imagens/
│   ├── page-001.png
│   ├── page-002.png
│   ├── page-003.png
│   └── ...
├── txt/
│   ├── page-001.txt
│   ├── page-002.txt
│   ├── page-003.txt
│   └── ...
└── texto_final.txt
```

A estrutura exata pode variar conforme o nome adotado no script, mas a lógica é esta:

- `imagens/`: imagens geradas a partir do PDF.
- `txt/`: OCR individual de cada página.
- `texto_final.txt`: texto consolidado, com as páginas reunidas em ordem.

## Escolha do número de processos

O último argumento indica quantos processos OCR serão executados em paralelo.

Exemplo com 3 processos:

```bash
MODEL="$HOME/modelos/kraken/german_prints.mlmodel" \
./ocr_pdf_kraken.sh livro.pdf ocr_livro 3
```

Em uma máquina com 16 threads, é possível usar mais processos, por exemplo:

```bash
MODEL="$HOME/modelos/kraken/german_prints.mlmodel" \
./ocr_pdf_kraken.sh livro.pdf ocr_livro 6
```

Contudo, o OCR pode consumir bastante CPU e memória. Recomenda-se começar com valores moderados, como `3`, `4` ou `6`, e aumentar apenas se o sistema continuar responsivo.

## Variável `MODEL`

A variável `MODEL` é obrigatória. Ela informa ao script qual modelo do Kraken será utilizado.

Exemplo:

```bash
export MODEL="$HOME/modelos/kraken/modelo.mlmodel"
./ocr_pdf_kraken.sh livro.pdf ocr_livro 3
```

Também é possível definir a variável apenas para uma execução:

```bash
MODEL="$HOME/modelos/kraken/modelo.mlmodel" ./ocr_pdf_kraken.sh livro.pdf ocr_livro 3
```

Se `MODEL` não estiver definida, o script deve encerrar com erro, pois o Kraken não saberá qual modelo usar.

## Verificando e instalando modelos disponíveis no Kraken

Para listar os modelos disponíveis no repositório do Kraken:

```bash
kraken list
```

Para consultar os metadados de um modelo específico:

```bash
kraken show 10.5281/zenodo.10519596
```

Para baixar e instalar um modelo:

```bash
kraken get 10.5281/zenodo.10519596
```

Depois de instalado, informe o caminho do arquivo `.mlmodel` ao script por meio da variável `MODEL`:

```bash
MODEL="/caminho/para/o/modelo.mlmodel" ./ocr_pdf_kraken.sh livro.pdf ocr_livro 3
```

Para filtrar modelos de reconhecimento:

```bash
kraken show --recognition
```

Para procurar modelos por língua:

```bash
kraken show --recognition --language deu
kraken show --recognition --language lat
kraken show --recognition --language eng
```

Para procurar modelos por sistema de escrita:

```bash
kraken show --recognition --script Latn
kraken show --recognition --script Grek
kraken show --recognition --script Cyrl
```

## Observações sobre qualidade do OCR

A qualidade final depende principalmente de quatro fatores:

1. Qualidade visual do PDF original.
2. Resolução das imagens geradas pelo `pdftocairo`.
3. Adequação do modelo Kraken ao tipo de fonte e período histórico.
4. Estado material do texto: manchas, inclinação, cortes, sombra, páginas tortas etc.

Para impressos antigos em alemão, latim ou fontes históricas, um modelo específico costuma produzir resultado melhor que um modelo genérico moderno.

## Problemas comuns

### `pdftocairo: command not found`

Instale o pacote `poppler-utils`:

```bash
sudo apt install poppler-utils
```

### `kraken: command not found`

Verifique se o Kraken foi instalado e se o ambiente virtual está ativado:

```bash
source .venv/bin/activate
kraken --help
```

Ou, se instalado com `pipx`, verifique o caminho:

```bash
pipx list
```

### O script não encontra o modelo

Confirme se a variável `MODEL` aponta para um arquivo existente:

```bash
echo "$MODEL"
ls -lh "$MODEL"
```

### O texto final ficou vazio ou incompleto

Verifique primeiro se os arquivos por página foram gerados:

```bash
ls -lh saida/txt/
```

Se os arquivos individuais existem, mas o texto consolidado não foi criado corretamente, o problema provavelmente está na etapa final de concatenação.

### A ordem das páginas ficou errada

Os nomes dos arquivos devem conter numeração com zeros à esquerda, por exemplo:

```text
page-001.txt
page-002.txt
page-003.txt
```

Isso evita que a ordenação alfabética coloque `page-10.txt` antes de `page-2.txt`.

## Comando recomendado

Para uma primeira execução segura:

```bash
MODEL="$HOME/modelos/kraken/german_prints.mlmodel" \
./ocr_pdf_kraken.sh livro.pdf ocr_livro 3
```

Depois, se o computador suportar bem a carga, aumente gradualmente o número de processos.

## Licença

Defina aqui a licença do projeto antes de publicá-lo no GitHub.

Exemplo:

```text
MIT License
```
