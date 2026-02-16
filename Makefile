.PHONY: help serve open dev clean

# Variables
PORT ?= 8000
BROWSER := open

help: ## Muestra esta ayuda
	@echo "Comandos disponibles para el CV:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""

serve: ## Inicia servidor local en puerto 8000 (o PORT=XXXX)
	@echo "🚀 Iniciando servidor en http://localhost:$(PORT)"
	@echo "📝 Edita cv.md y recarga el navegador para ver cambios"
	@echo "⏹️  Presiona Ctrl+C para detener"
	@python3 -m http.server $(PORT)

open: ## Abre el CV en el navegador
	@echo "🌐 Abriendo CV en el navegador..."
	@$(BROWSER) http://localhost:$(PORT)

dev: ## Inicia servidor y abre el navegador automáticamente
	@echo "🚀 Iniciando entorno de desarrollo..."
	@echo "📝 Edita cv.md y recarga el navegador para ver cambios"
	@$(BROWSER) http://localhost:$(PORT) &
	@python3 -m http.server $(PORT)

clean: ## Limpia archivos temporales (si existen)
	@echo "🧹 Limpiando archivos temporales..."
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@find . -name "*.pyc" -delete 2>/dev/null || true
	@echo "✨ Limpieza completada"
