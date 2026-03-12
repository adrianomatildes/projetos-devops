# 🎓 Automação de Certificados

Script Python para adicionar certificados automaticamente ao portfolio DevOps.

🌐 **Veja o portfolio:** [adrianomatildes.github.io/portfolio.io](https://adrianomatildes.github.io/portfolio.io)

## 🚀 Funcionalidades

- ✅ Interface interativa (pergunta curso e instituição)
- ✅ Validação de inputs
- ✅ Git pull/commit/push automático
- ✅ Indentação correta do HTML
- ✅ Inserção no local correto da lista de certificações

## 📦 Instalação

```bash
make install
source ~/.bashrc

````
## 💡 Uso

```bash
certificado

````
## 📝 Exemplo de Execução

```bash
========================================
ADICIONAR CERTIFICADO AO PORTFOLIO
========================================

Nome do curso: AWS Solutions Architect
Instituição: Amazon Web Services
Ano (padrão 2026): 

Você digitou: AWS Solutions Architect - Amazon Web Services (2026)
Confirma? (s/n): s

[1/4] Baixando atualizações...
[2/4] Lendo arquivo HTML...
[3/4] Inserindo certificado...
[4/4] Enviando para o GitHub...

========================================
CERTIFICADO ADICIONADO COM SUCESSO!
========================================
````
##  🛠️ Tecnologias

- Python 3
- Git/GitHub
- Makefile
- HTML

## 📁 Estrutura

```bash
automazacao-certificados/
├── certificado.py    # Script principal
├── Makefile          # Comandos de instalação
└── README.md         # Este arquivo
````
## ⚙️ Configuração

Edite as variáveis no início do certificado.py:

```bash
PASTA_PROJETO = "Caminho absoluto do projeto"
ARQUIVO_HTML = f"{PASTA_PROJETO}/index.html"
BRANCH_GIT = "master"  # ou "main"
````
## 🧹 Desinstalar

```bash
make remove
source ~/.bashrc
````

`### Autor:` Adriano Matildes | DevOps Engineer

🌐 **Veja o portfolio:** [adrianomatildes.github.io/portfolio.io](https://adrianomatildes.github.io/portfolio.io)
