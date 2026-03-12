.PHONY: certificado install remove

install:
	@echo "🔧 Instalando..."
	@echo "alias certificado='python3 $(PWD)/certificado.py'" >> ~/.bashrc
	@echo "✅ Pronto!"
	@echo ""
	@echo "🔄 Execute: source ~/.bashrc"
	@echo "💡 Depois use: certificado"

remove:
	@sed -i '/alias certificado=/d' ~/.bashrc
	@echo "❌ Alias removido"

certificado:
	@python3 certificado.py