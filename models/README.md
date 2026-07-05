# Pasta `models/`

Esta pasta armazena modelos OCR utilizados pelo projeto.

Os modelos permanecem sujeitos às licenças dos autores e repositórios originais. Este repositório preserva cópias locais para fins de reprodutibilidade acadêmica.

Antes de adicionar um modelo:

1. registre a fonte original;
2. preserve a licença;
3. calcule o SHA256;
4. documente o uso em `MODELS.md`.

---

## Para que calcular o SHA256?

Calcular o SHA256 **não é necessário para o Kraken funcionar**. O Kraken executa o modelo normalmente desde que receba um arquivo `.mlmodel` válido.

O SHA256 serve para **controle de integridade, identificação exata do arquivo e reprodutibilidade acadêmica**. Ele funciona como uma “impressão digital” do modelo: se qualquer byte do arquivo mudar, o hash também muda.

Isso é útil em quatro situações principais:

1. **Reprodutibilidade acadêmica**  
   Permite registrar exatamente qual versão do modelo foi usada para gerar determinado OCR. Isso é especialmente importante quando o resultado do OCR será citado, revisado ou usado como base de pesquisa.

2. **Verificação de integridade**  
   Se o modelo for copiado entre máquinas, enviado para Dropbox, armazenado em HD externo ou baixado novamente, o SHA256 permite confirmar que o arquivo não foi corrompido.

3. **Detecção de mudanças silenciosas**  
   Um repositório externo pode substituir um arquivo mantendo o mesmo nome. Se o conteúdo mudar, o SHA256 mudará, mesmo que o nome continue igual.

4. **Controle de versões locais**  
   Quando houver vários modelos parecidos — por exemplo, diferentes modelos para grego politônico ou Fraktur — o SHA256 ajuda a identificar exatamente qual arquivo foi usado em cada teste.

Para calcular:

```bash
sha256sum models/greek/ajax_polytonic_porson.mlmodel
```

Exemplo de saída:

```text
3f9a...c82d  models/greek/ajax_polytonic_porson.mlmodel
```

Registre o valor correspondente em `MODELS.md`, na ficha do modelo.

O campo `SHA256` é, portanto, uma boa prática de documentação e preservação, mas não é requisito para começar a usar os modelos no Kraken.

---

## Estrutura

```text
models/
├── greek/
├── german/
├── latin/
├── french/
└── multilingual/
```
