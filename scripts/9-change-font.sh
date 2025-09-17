#!/bin/bash

# Script 9: Trocar toda a fonte do site para Montserrat
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "🔤 INICIANDO ALTERAÇÃO DA FONTE PARA MONTSERRAT..."
echo "=============================================="

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    echo "   Certifique-se de estar em promessas-jesus/"
    exit 1
fi

# Backup dos arquivos CSS e HTML
echo "📁 Criando backup dos arquivos..."
mkdir -p backups/fonts-change-$(date +%Y%m%d_%H%M%S)/
cp -r css/ backups/fonts-change-$(date +%Y%m%d_%H%M%S)/css/ 2>/dev/null
cp index.html backups/fonts-change-$(date +%Y%m%d_%H%M%S)/ 2>/dev/null
echo "✅ Backup criado em backups/fonts-change-$(date +%Y%m%d_%H%M%S)/"

# Atualizar Google Fonts no index.html
echo "🌐 Atualizando Google Fonts no HTML..."
if grep -q "fonts.googleapis.com" index.html; then
    # Substituir links existentes do Google Fonts
    sed -i.bak 's|<link[^>]*fonts\.googleapis\.com[^>]*>|<link rel="preconnect" href="https://fonts.googleapis.com">|g' index.html
    sed -i 's|<link rel="preconnect" href="https://fonts.googleapis.com">|<link rel="preconnect" href="https://fonts.googleapis.com">\n    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\n    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">|' index.html
else
    # Adicionar Google Fonts se não existir
    sed -i 's|</head>|    <link rel="preconnect" href="https://fonts.googleapis.com">\n    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>\n    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">\n</head>|' index.html
fi

# Atualizar CSS - substituir todas as fontes por Montserrat
echo "🎨 Atualizando CSS para usar Montserrat..."

# Criar backup específico do style.css
cp css/style.css css/style.css.backup

# Lista de fontes antigas para substituir
OLD_FONTS=(
    "Cinzel"
    "Inter"
    "Georgia"
    "serif"
    "sans-serif"
    "'Times New Roman'"
    "Times"
    "Arial"
    "Helvetica"
    "Verdana"
    "Roboto"
    "Open Sans"
    "Lato"
    "Source Sans Pro"
)

# Função para substituir fontes no CSS
replace_fonts_in_css() {
    local file=$1
    echo "   📄 Processando: $file"
    
    # Substituir font-family declarations
    for old_font in "${OLD_FONTS[@]}"; do
        # Padrões de substituição
        sed -i "s/font-family:[^;]*$old_font[^;]*/font-family: 'Montserrat', sans-serif/g" "$file"
        sed -i "s/font-family:[^;}]*$old_font[^;}]*/font-family: 'Montserrat', sans-serif/g" "$file"
    done
    
    # Limpeza específica para padrões complexos
    sed -i 's/font-family: [^;}]*serif[^;}]*/font-family: '\''Montserrat'\'', sans-serif/g' "$file"
    sed -i 's/font-family: [^;}]*sans-serif[^;}]*/font-family: '\''Montserrat'\'', sans-serif/g' "$file"
    sed -i 's/font-family: [^;}]*monospace[^;}]*/font-family: '\''Montserrat'\'', monospace/g' "$file"
    
    # Substituir declarações específicas conhecidas
    sed -i 's/font-family: "Cinzel"[^;}]*/font-family: '\''Montserrat'\'', serif/g' "$file"
    sed -i 's/font-family: "Inter"[^;}]*/font-family: '\''Montserrat'\'', sans-serif/g' "$file"
}

# Processar todos os arquivos CSS
if [ -d "css" ]; then
    find css/ -name "*.css" -type f | while read css_file; do
        replace_fonts_in_css "$css_file"
    done
fi

# Otimizar pesos da fonte Montserrat baseado no uso
echo "⚖️  Otimizando pesos da fonte Montserrat..."

# Criar variáveis CSS para diferentes pesos
cat >> css/style.css << 'EOF'

/* ============================================
   MONTSERRAT FONT WEIGHTS OPTIMIZATION
   ============================================ */

/* Variáveis para pesos de fonte */
:root {
    --font-light: 300;
    --font-regular: 400;
    --font-medium: 500;
    --font-semibold: 600;
    --font-bold: 700;
    --font-extrabold: 800;
}

/* Classes utilitárias para pesos */
.font-light { font-weight: var(--font-light) !important; }
.font-regular { font-weight: var(--font-regular) !important; }
.font-medium { font-weight: var(--font-medium) !important; }
.font-semibold { font-weight: var(--font-semibold) !important; }
.font-bold { font-weight: var(--font-bold) !important; }
.font-extrabold { font-weight: var(--font-extrabold) !important; }

/* Hierarquia tipográfica com Montserrat */
h1, .h1 { 
    font-family: 'Montserrat', serif; 
    font-weight: var(--font-extrabold);
    font-size: clamp(2rem, 5vw, 3.5rem);
}

h2, .h2 { 
    font-family: 'Montserrat', serif; 
    font-weight: var(--font-bold);
    font-size: clamp(1.5rem, 4vw, 2.5rem);
}

h3, .h3 { 
    font-family: 'Montserrat', serif; 
    font-weight: var(--font-semibold);
    font-size: clamp(1.25rem, 3vw, 2rem);
}

h4, h5, h6 { 
    font-family: 'Montserrat', sans-serif; 
    font-weight: var(--font-medium);
}

p, body, .text-regular { 
    font-family: 'Montserrat', sans-serif; 
    font-weight: var(--font-regular);
    line-height: 1.6;
}

/* Texto em destaque */
.text-highlight, .promise-text, .verse-text {
    font-family: 'Montserrat', serif;
    font-weight: var(--font-medium);
    font-style: italic;
    line-height: 1.7;
}

/* Botões e CTAs */
.btn, button, .cta {
    font-family: 'Montserrat', sans-serif;
    font-weight: var(--font-semibold);
    text-transform: uppercase;
    letter-spacing: 1px;
}

/* Navegação */
nav, .nav-item, .menu-item {
    font-family: 'Montserrat', sans-serif;
    font-weight: var(--font-medium);
}

/* Cards e componentes */
.card-title {
    font-family: 'Montserrat', serif;
    font-weight: var(--font-semibold);
}

.card-text, .card-content {
    font-family: 'Montserrat', sans-serif;
    font-weight: var(--font-regular);
}

EOF

# Atualizar JavaScript se necessário (para elementos dinâmicos)
echo "🔧 Verificando JavaScript para fontes dinâmicas..."
if [ -f "js/main.js" ]; then
    # Adicionar classe de fonte a elementos criados dinamicamente
    sed -i '/createElement/a\        element.style.fontFamily = "Montserrat, sans-serif";' js/main.js 2>/dev/null
fi

# Otimizar performance das fontes
echo "🚀 Otimizando performance das fontes..."

# Adicionar font-display: swap no CSS se não existir
if ! grep -q "font-display" css/style.css; then
    cat >> css/style.css << 'EOF'

/* Font loading optimization */
@font-face {
    font-family: 'Montserrat';
    font-display: swap;
}

EOF
fi

# Preload das fontes críticas no HTML
echo "⚡ Configurando preload das fontes críticas..."
if ! grep -q "rel=\"preload\".*Montserrat" index.html; then
    sed -i 's|<link href="https://fonts.googleapis.com/css2|    <link rel="preload" href="https://fonts.gstatic.com/s/montserrat/v26/JTUSjIg1_i6t8kCHKm459Wlhyw.woff2" as="font" type="font/woff2" crossorigin>\n    <link href="https://fonts.googleapis.com/css2|' index.html
fi

# Verificar se as alterações foram aplicadas
echo "🔍 Verificando alterações..."
if grep -q "Montserrat" css/style.css && grep -q "Montserrat" index.html; then
    echo "✅ FONTE MONTSERRAT APLICADA COM SUCESSO!"
    echo ""
    echo "📋 RESUMO DAS ALTERAÇÕES:"
    echo "   ✓ Google Fonts atualizado para Montserrat (todos os pesos)"
    echo "   ✓ CSS atualizado com font-family: 'Montserrat'"
    echo "   ✓ Variáveis CSS criadas para diferentes pesos"
    echo "   ✓ Classes utilitárias adicionadas"
    echo "   ✓ Hierarquia tipográfica otimizada"
    echo "   ✓ Performance otimizada com font-display: swap"
    echo "   ✓ Preload configurado para fontes críticas"
    echo ""
    echo "🎨 PESOS DISPONÍVEIS:"
    echo "   • 100-900: Todos os pesos da Montserrat"
    echo "   • Italic: Todas as variações itálicas"
    echo ""
    echo "📱 CLASSES UTILITÁRIAS CRIADAS:"
    echo "   • .font-light (300)"
    echo "   • .font-regular (400)"
    echo "   • .font-medium (500)"
    echo "   • .font-semibold (600)"
    echo "   • .font-bold (700)"
    echo "   • .font-extrabold (800)"
else
    echo "❌ ERRO: Falha ao aplicar as alterações!"
    echo "   Verifique os arquivos manualmente"
    exit 1
fi

# Instruções finais
echo ""
echo "🌟 PRÓXIMOS PASSOS:"
echo "1. Teste localmente: python3 -m http.server 8000"
echo "2. Verifique se todas as fontes estão carregando"
echo "3. Teste a performance no PageSpeed Insights"
echo "4. Faça commit das alterações:"
echo "   git add ."
echo "   git commit -m \"feat: Alterar fonte do site para Montserrat\""
echo "   git push origin main"
echo ""
echo "📚 BACKUP CRIADO EM: backups/fonts-change-$(date +%Y%m%d_%H%M%S)/"
echo "💡 Para reverter: cp backups/fonts-change-*/css/style.css css/"
echo ""
echo "🔤 MONTSERRAT APLICADA COM SUCESSO! ✨"