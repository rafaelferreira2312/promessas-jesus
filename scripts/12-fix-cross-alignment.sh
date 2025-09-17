#!/bin/bash

# Script 12: Corrigir Alinhamento da Cruz na Timeline
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "✝️ CORRIGINDO ALINHAMENTO DA CRUZ NA TIMELINE..."
echo "=============================================="

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    exit 1
fi

# Backup
echo "💾 Criando backup do CSS..."
cp css/timeline-fix.css css/timeline-fix.css.backup-$(date +%Y%m%d_%H%M%S)

# Corrigir CSS do divisor e cruz
echo "🔧 Corrigindo alinhamento da cruz..."
cat > css/timeline-cross-fix.css << 'EOF'
/* ============================================
   CORREÇÃO ESPECÍFICA - ALINHAMENTO DA CRUZ
   ============================================ */

/* Ajustar container das divisões para posicionamento relativo correto */
.timeline__divisions {
    position: relative !important;
    display: flex !important;
    align-items: stretch !important;
    justify-content: space-between !important;
    gap: 2rem !important;
    min-height: 500px !important;
}

/* Divisor vertical centralizado */
.timeline__divider {
    position: absolute !important;
    left: calc(50% - 2px) !important; /* Ajuste fino para centralizar */
    top: 0 !important;
    width: 4px !important;
    height: 100% !important;
    background: linear-gradient(to bottom, #d4af37 0%, #f4d03f 50%, #b7950b 100%) !important;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.6) !important;
    z-index: 5 !important;
    transform: none !important; /* Remover transform que causa desalinhamento */
}

/* Cruz centralizada na linha vertical */
.timeline__divider::before {
    content: '✝️' !important;
    position: absolute !important;
    top: 50% !important;
    left: 50% !important;
    transform: translate(-50%, -50%) !important;
    background: #1a1611 !important;
    color: #d4af37 !important;
    width: 45px !important;
    height: 45px !important;
    border-radius: 50% !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    font-size: 1.4rem !important;
    border: 4px solid #d4af37 !important;
    box-shadow: 0 0 25px rgba(212, 175, 55, 0.8) !important;
    z-index: 10 !important;
}

/* Garantir que seções não sobreponham o divisor */
.testament-section {
    flex: 1 !important;
    max-width: calc(50% - 2rem) !important;
    z-index: 1 !important;
    position: relative !important;
}

.testament-section.old-testament {
    margin-right: 1rem !important;
}

.testament-section.new-testament {
    margin-left: 1rem !important;
}

/* Ajuste para mobile - cruz horizontal */
@media (max-width: 768px) {
    .timeline__divisions {
        flex-direction: column !important;
        gap: 3rem !important;
    }
    
    .timeline__divider {
        position: relative !important;
        left: 0 !important;
        top: 0 !important;
        width: 100% !important;
        height: 6px !important;
        margin: 2rem 0 !important;
    }
    
    .timeline__divider::before {
        top: 50% !important;
        left: 50% !important;
        transform: translate(-50%, -50%) !important;
    }
    
    .testament-section {
        max-width: 100% !important;
        margin: 0 !important;
    }
}

/* Hover effect na cruz */
.timeline__divider::before:hover {
    transform: translate(-50%, -50%) scale(1.1) !important;
    box-shadow: 0 0 35px rgba(212, 175, 55, 1) !important;
    transition: all 0.3s ease !important;
}
EOF

# Inserir CSS de correção da cruz no index.html
echo "📝 Inserindo CSS de correção da cruz..."
if ! grep -q "timeline-cross-fix.css" index.html; then
    sed -i '/<link rel="stylesheet" href="css\/timeline-fix.css">/a\    <link rel="stylesheet" href="css/timeline-cross-fix.css">' index.html
    echo "✅ CSS da cruz inserido"
else
    echo "✅ CSS da cruz já existe"
fi

# Corrigir JavaScript para navegação dos botões amarelos
echo "🔧 Corrigindo navegação dos botões para páginas reais..."
sed -i '/function openTestamentDetails(testament) {/,/}/ {
    s|// Verificar se a página existe|// Navegar diretamente para páginas reais|
    s|const url = urls\[testament\];|window.location.href = urls[testament]; return;|
    s|if (url) {|// Removido - navega direto|
    s|console.log.*navigando.*|// Navegação direta implementada|
    s|window.location.href = url;|// Já implementado acima|
    s|} else {|/*|
    s|showTestamentModal.*|*/|
    s|}$|// Fim da função openTestamentDetails|
}' js/main.js

# Verificar se a correção funcionou
if grep -q "window.location.href = urls\[testament\]" js/main.js; then
    echo "✅ JavaScript dos botões corrigido"
else
    echo "⚠️ Adicionando JavaScript corrigido..."
    cat >> js/main.js << 'EOF'

// CORREÇÃO ESPECÍFICA - Navegação direta dos botões
function openTestamentDetails(testament) {
    const urls = {
        'old': 'pages/timeline/antigo-testamento/',
        'new': 'pages/timeline/novo-testamento/'
    };
    
    // Navegar diretamente para a página
    if (urls[testament]) {
        window.location.href = urls[testament];
    }
}
EOF
fi

echo "✅ SCRIPT 12-fix-cross-alignment.sh EXECUTADO COM SUCESSO!"
echo ""
echo "🔧 CORREÇÕES APLICADAS:"
echo "   ✅ Cruz centralizada na linha divisória vertical"
echo "   ✅ Divisor posicionado exatamente no centro"
echo "   ✅ Cruz não fica mais em cima dos retângulos"
echo "   ✅ Botões amarelos agora levam para páginas reais"
echo "   ✅ Hover effect na cruz implementado"
echo ""
echo "📱 RESPONSIVO:"
echo "   ✅ Mobile: Cruz centralizada na linha horizontal"
echo "   ✅ Desktop: Cruz centralizada na linha vertical"
echo ""
echo "🌐 TESTE:"
echo "   1. Acesse: http://localhost:8005/#timeline"
echo "   2. Cruz deve estar alinhada no centro da linha"
echo "   3. Botões amarelos devem funcionar"
echo ""
echo "🔗 NAVEGAÇÃO DOS BOTÕES:"
echo "   • 'Explorar Antigo Testamento' → /pages/timeline/antigo-testamento/"
echo "   • 'Explorar Novo Testamento' → /pages/timeline/novo-testamento/"
echo ""
echo "⏭️ PRÓXIMO PASSO:"
echo "   Header/footer das páginas será corrigido no próximo script"
echo ""
echo "🚀 PARA EXECUTAR:"
echo "   chmod +x 12-fix-cross-alignment.sh && ./12-fix-cross-alignment.sh"