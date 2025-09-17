#!/bin/bash

echo "🔍 INVESTIGANDO ESTRUTURA ATUAL DA TIMELINE..."
echo "=============================================="

# Verificar arquivos que deveriam existir
echo "📁 VERIFICANDO ARQUIVOS ESPERADOS:"
echo ""

files_to_check=(
    "json/timeline/timeline-config.json"
    "json/timeline/old-testament.json" 
    "json/timeline/new-testament.json"
    "assets/css/timeline.css"
    "assets/js/timeline.js"
    "pages/timeline/index.html"
)

for file in "${files_to_check[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file - EXISTE"
    else
        echo "❌ $file - NÃO EXISTE"
    fi
done

echo ""
echo "📂 ESTRUTURA DE PASTAS ATUAL:"
echo ""

# Mostrar estrutura das pastas relevantes
echo "📁 json/"
ls -la json/ 2>/dev/null || echo "   Pasta json/ não existe"

echo ""
echo "📁 json/timeline/"
ls -la json/timeline/ 2>/dev/null || echo "   Pasta json/timeline/ não existe"

echo ""
echo "📁 assets/"
ls -la assets/ 2>/dev/null || echo "   Pasta assets/ não existe"

echo ""  
echo "📁 assets/css/"
ls -la assets/css/ 2>/dev/null || echo "   Pasta assets/css/ não existe"

echo ""
echo "📁 assets/js/"
ls -la assets/js/ 2>/dev/null || echo "   Pasta assets/js/ não existe"

echo ""
echo "📁 pages/"
ls -la pages/ 2>/dev/null || echo "   Pasta pages/ não existe"

echo ""
echo "📁 pages/timeline/"
ls -la pages/timeline/ 2>/dev/null || echo "   Pasta pages/timeline/ não existe"

echo ""
echo "🔧 DIAGNÓSTICO:"
echo "Se algum arquivo NÃO EXISTE, execute os scripts na ordem:"
echo "1. ./10-timeline-biblical.sh"
echo "2. ./10a-timeline-biblical.sh" 
echo "3. ./10b-timeline-biblical.sh"