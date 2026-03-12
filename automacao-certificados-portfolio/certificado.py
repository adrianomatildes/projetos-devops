#!/usr/bin/env python3
# Adiciona certificado no portfolio - Versão Simples

import os

# ----- CONFIGURAÇÃO -----
PASTA_PROJETO = "/home/kubeadriano/Documentos/Devops/github/portfolio.io"
ARQUIVO_HTML = f"{PASTA_PROJETO}/index.html"
BRANCH_GIT = "master"

# ----- PERGUNTA AO USUÁRIO -----
print("=" * 40)
print("ADICIONAR CERTIFICADO AO PORTFOLIO")
print("=" * 40)

curso = input("Nome do curso: ")
instituicao = input("Instituição: ")
ano = input("Ano (padrão 2026): ") or "2026"

print(f"\nVocê digitou: {curso} - {instituicao} ({ano})")
confirma = input("Confirma? (s/n): ")

if confirma.lower() != "s":
    print("Cancelado.")
    exit()

# ----- GIT PULL -----
print("\n[1/4] Baixando atualizações...")
os.system(f"cd {PASTA_PROJETO} && git pull origin {BRANCH_GIT}")

# ----- LÊ O ARQUIVO -----
print("[2/4] Lendo arquivo HTML...")
with open(ARQUIVO_HTML, "r", encoding="utf-8") as f:
    linhas = f.readlines()

# ----- ENCONTRA A TAG <div class="certifications-list"> -----
print("[3/4] Inserindo certificado...")

linha_insercao = 0

# Procura pela linha que tem <div class="certifications-list">
for i, linha in enumerate(linhas):
    if '<div class="certifications-list">' in linha:
        linha_insercao = i + 1  # +1 para inserir APÓS essa linha
        break

# Se não encontrou, usa um valor padrão
if linha_insercao == 0:
    linha_insercao = 531

# Cria o novo certificado com indentação de 5 tabs (20 espaços)
novo_certificado = f'''                    <div class="cert-item">
                        <i class="fas fa-certificate"></i>
                        <span>{curso} - {instituicao}</span>
                    </div>
'''

# Insere na posição encontrada
linhas.insert(linha_insercao, novo_certificado)

# ----- SALVA O ARQUIVO -----
with open(ARQUIVO_HTML, "w", encoding="utf-8") as f:
    f.writelines(linhas)

print("[4/4] Enviando para o GitHub...")
os.system(f"cd {PASTA_PROJETO} && git add index.html")
os.system(f'cd {PASTA_PROJETO} && git commit -m "Adiciona certificado: {curso}"')
os.system(f"cd {PASTA_PROJETO} && git push origin {BRANCH_GIT}")

print("\n" + "=" * 40)
print("CERTIFICADO ADICIONADO COM SUCESSO!")
print("=" * 40)