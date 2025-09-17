#!/bin/bash

# Script 11a: Corrigir Layout Timeline - PARTE 1
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "🔧 CORRIGINDO LAYOUT TIMELINE - PARTE 1..."
echo "========================================="

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    exit 1
fi

# Backup
echo "💾 Criando backup..."
cp index.html index.html.backup-layout-fix-$(date +%Y%m%d_%H%M%S)
echo "✅ Backup criado"

# Criar CSS de correção para layout horizontal
echo "🎨 Criando CSS para layout horizontal correto..."
cat > css/timeline-fix.css << 'EOF'
/* ============================================
   CORREÇÃO LAYOUT TIMELINE - HORIZONTAL
   ============================================ */

/* FORÇAR layout horizontal lado a lado */
.timeline__divisions {
    display: flex !important;
    flex-direction: row !important;
    align-items: stretch !important;
    gap: 1rem !important;
    width: 100% !important;
    max-width: 1200px !important;
    margin: 0 auto !important;
    min-height: 500px !important;
    position: relative !important;
}

/* Seções lado a lado */
.testament-section {
    flex: 1 !important;
    max-width: 45% !important;
    margin: 0 !important;
    position: relative !important;
}

.testament-section.old-testament {
    margin-right: 0 !important;
}

.testament-section.new-testament {
    margin-left: 0 !important;
}

/* Divisor central vertical */
.timeline__divider {
    position: absolute !important;
    left: 50% !important;
    top: 0 !important;
    bottom: 0 !important;
    width: 4px !important;
    height: 100% !important;
    transform: translateX(-50%) !important;
    z-index: 10 !important;
    background: linear-gradient(to bottom, #d4af37 0%, #f4d03f 50%, #b7950b 100%) !important;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.6) !important;
}

.timeline__divider::before {
    content: '✝️' !important;
    position: absolute !important;
    top: 50% !important;
    left: 50% !important;
    transform: translate(-50%, -50%) !important;
    background: #1a1611 !important;
    color: #d4af37 !important;
    width: 40px !important;
    height: 40px !important;
    border-radius: 50% !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    font-size: 1.2rem !important;
    border: 3px solid #d4af37 !important;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.5) !important;
}

/* Grid de livros mais compacto */
.testament-books {
    display: grid !important;
    grid-template-columns: 1fr 1fr !important;
    gap: 0.5rem !important;
    margin: 1rem 0 !important;
    max-height: 200px !important;
    overflow-y: auto !important;
}

.book-item {
    padding: 0.4rem 0.6rem !important;
    font-size: 0.85rem !important;
    cursor: pointer !important;
    transition: all 0.2s ease !important;
    background: rgba(212, 175, 55, 0.1) !important;
    border: 1px solid rgba(212, 175, 55, 0.3) !important;
    border-radius: 8px !important;
    text-align: center !important;
    color: #f5f1e8 !important;
}

.book-item:hover {
    background: rgba(212, 175, 55, 0.3) !important;
    border-color: #f4d03f !important;
    transform: scale(1.05) !important;
}

/* Stats layout horizontal */
.testament-stats {
    display: flex !important;
    justify-content: space-around !important;
    margin: 1rem 0 !important;
    padding: 1rem !important;
    background: rgba(0, 0, 0, 0.3) !important;
    border-radius: 15px !important;
    border: 1px solid rgba(212, 175, 55, 0.2) !important;
}

.stat-item {
    text-align: center !important;
    flex: 1 !important;
}

.stat-number {
    display: block !important;
    font-size: 1.5rem !important;
    font-weight: 700 !important;
    color: #f4d03f !important;
    text-shadow: 0 0 10px rgba(244, 208, 63, 0.5) !important;
}

.stat-label {
    font-size: 0.8rem !important;
    opacity: 0.8 !important;
    text-transform: uppercase !important;
    letter-spacing: 1px !important;
}

/* Botões de ação */
.testament-cta {
    width: 100% !important;
    padding: 1rem !important;
    background: linear-gradient(135deg, #d4af37 0%, #f4d03f 100%) !important;
    color: #1a1611 !important;
    border: none !important;
    border-radius: 12px !important;
    font-family: 'Montserrat', sans-serif !important;
    font-weight: 600 !important;
    font-size: 0.9rem !important;
    cursor: pointer !important;
    transition: all 0.3s ease !important;
    text-transform: uppercase !important;
    letter-spacing: 1px !important;
}

.testament-cta:hover {
    transform: translateY(-2px) !important;
    box-shadow: 0 8px 25px rgba(212, 175, 55, 0.4) !important;
    background: linear-gradient(135deg, #f4d03f 0%, #d4af37 100%) !important;
}

/* Cronologia histórica DEPOIS das divisões */
.timeline__history {
    order: 2 !important;
    margin-top: 4rem !important;
    width: 100% !important;
}

.timeline__visual {
    order: 1 !important;
}

/* Linha histórica */
.history-line {
    width: 100% !important;
    height: 6px !important;
    background: linear-gradient(90deg, #8B4513 0%, #d4af37 50%, #4169E1 100%) !important;
    border-radius: 3px !important;
    position: relative !important;
    margin: 2rem 0 !important;
    box-shadow: 0 0 15px rgba(212, 175, 55, 0.3) !important;
}

.history-markers {
    display: flex !important;
    justify-content: space-between !important;
    position: absolute !important;
    width: 100% !important;
    top: -10px !important;
}

.history-marker {
    width: 20px !important;
    height: 20px !important;
    background: #d4af37 !important;
    border: 3px solid #1a1611 !important;
    border-radius: 50% !important;
    cursor: pointer !important;
    transition: all 0.3s ease !important;
    position: relative !important;
}

.history-marker:hover {
    transform: scale(1.2) !important;
    box-shadow: 0 0 15px rgba(212, 175, 55, 0.8) !important;
}

.marker-label {
    position: absolute !important;
    top: 30px !important;
    left: 50% !important;
    transform: translateX(-50%) !important;
    background: rgba(26, 22, 17, 0.9) !important;
    color: #d4af37 !important;
    padding: 0.5rem !important;
    border-radius: 8px !important;
    font-size: 0.8rem !important;
    white-space: nowrap !important;
    opacity: 0 !important;
    transition: all 0.3s ease !important;
    border: 1px solid rgba(212, 175, 55, 0.3) !important;
}

.history-marker:hover .marker-label {
    opacity: 1 !important;
    transform: translateX(-50%) translateY(-5px) !important;
}

/* Responsivo */
@media (max-width: 768px) {
    .timeline__divisions {
        flex-direction: column !important;
        gap: 3rem !important;
        align-items: center !important;
    }
    
    .timeline__divider {
        position: relative !important;
        left: 0 !important;
        width: 100% !important;
        height: 4px !important;
        transform: none !important;
        margin: 1rem 0 !important;
    }
    
    .testament-section {
        width: 100% !important;
        max-width: 500px !important;
    }
    
    .testament-stats {
        flex-direction: column !important;
        gap: 1rem !important;
    }
}

/* Animações */
@keyframes slideInLeft {
    from {
        opacity: 0;
        transform: translateX(-50px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes slideInRight {
    from {
        opacity: 0;
        transform: translateX(50px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.testament-section.old-testament {
    animation: slideInLeft 1s ease-out !important;
}

.testament-section.new-testament {
    animation: slideInRight 1s ease-out !important;
}
EOF

# Inserir CSS de correção no index.html
echo "📝 Inserindo CSS de correção no index.html..."
if ! grep -q "timeline-fix.css" index.html; then
    sed -i '/<link rel="stylesheet" href="css\/style.css">/a\    <link rel="stylesheet" href="css/timeline-fix.css">' index.html
    echo "✅ CSS de correção inserido"
else
    echo "✅ CSS de correção já existe"
fi

# Atualizar JavaScript para navegação funcional
echo "🔧 Atualizando JavaScript para navegação..."
if ! grep -q "openTestamentDetails" js/main.js; then
    cat >> js/main.js << 'EOF'

// ============================================
// TIMELINE NAVIGATION - PARTE 1
// ============================================

/**
 * Navegar para páginas de testamento
 */
function openTestamentDetails(testament) {
    const urls = {
        'old': 'pages/timeline/antigo-testamento/',
        'new': 'pages/timeline/novo-testamento/'
    };
    
    const testamentNames = {
        'old': 'Antigo Testamento',
        'new': 'Novo Testamento'
    };
    
    // Verificar se a página existe
    const url = urls[testament];
    if (url) {
        console.log(`Navegando para ${testamentNames[testament]}`);
        window.location.href = url;
    } else {
        // Mostrar modal temporário
        showTestamentModal(testament, testamentNames[testament]);
    }
}

/**
 * Modal temporário enquanto páginas não existem
 */
function showTestamentModal(testament, name) {
    const modal = document.createElement('div');
    modal.style.cssText = `
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.8); display: flex; justify-content: center;
        align-items: center; z-index: 1000;
    `;
    
    modal.innerHTML = `
        <div style="background: #1a1611; border: 2px solid #d4af37; border-radius: 15px;
                    max-width: 500px; width: 90%; color: #f5f1e8; padding: 2rem;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                <h2 style="margin: 0; color: #d4af37;">${testament === 'old' ? '📜' : '✝️'} ${name}</h2>
                <button onclick="this.parentElement.parentElement.parentElement.remove()" 
                        style="background: none; border: none; color: #d4af37; font-size: 2rem; cursor: pointer;">&times;</button>
            </div>
            <div>
                <p>Página detalhada do ${name} será criada na próxima parte.</p>
                <p><strong>Incluirá:</strong></p>
                <ul>
                    <li>🏺 Evidências arqueológicas detalhadas</li>
                    <li>📍 Localizações geográficas precisas</li>
                    <li>📚 Fatos marcantes de cada livro</li>
                    <li>🗓️ Cronologia histórica completa</li>
                </ul>
            </div>
        </div>
    `;
    
    modal.addEventListener('click', (e) => {
        if (e.target === modal) modal.remove();
    });
    
    document.body.appendChild(modal);
}

// Inicializar quando DOM carregar
document.addEventListener('DOMContentLoaded', () => {
    console.log('✅ Timeline navigation inicializada - Parte 1');
});
EOF
    echo "✅ JavaScript atualizado"
else
    echo "✅ JavaScript já existe"
fi

echo "✅ SCRIPT 11a-timeline-details.sh PARTE 1 EXECUTADO COM SUCESSO!"
echo ""
echo "🔧 CORREÇÕES IMPLEMENTADAS (PARTE 1):"
echo "   ✅ CSS corrigido para layout HORIZONTAL"
echo "   ✅ Seções lado a lado (não mais uma em cima da outra)"
echo "   ✅ Cronologia histórica movida para DEPOIS das divisões"
echo "   ✅ JavaScript básico para navegação"
echo "   ✅ Modal temporário para cliques nos botões"
echo "   ✅ Animações de entrada diferenciadas"
echo ""
echo "🎨 LAYOUT CORRIGIDO:"
echo "   • Antigo Testamento | Novo Testamento (lado a lado)"
echo "   • Divisor central vertical com cruz"
echo "   • Cronologia histórica abaixo das divisões"
echo "   • Stats e livros organizados em cada seção"
echo ""
echo "🌐 TESTE:"
echo "   Acesse: http://localhost:8005/#timeline"
echo "   Layout agora deve estar HORIZONTAL"
echo ""
echo "⏭️ PRÓXIMA PARTE 1a:"
echo "   Digite 'continuar' para criar as páginas detalhadas"
echo "   com header/footer padrão do projeto"