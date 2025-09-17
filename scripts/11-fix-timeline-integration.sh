#!/bin/bash

# Script 11: Corrigir Timeline - Integração no Index.html
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "🔧 CORRIGINDO TIMELINE - INTEGRAÇÃO NO INDEX.HTML..."
echo "=================================================="

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    exit 1
fi

# Backup do index.html atual
echo "💾 Criando backup do index.html..."
cp index.html index.html.backup-timeline-fix-$(date +%Y%m%d_%H%M%S)
echo "✅ Backup criado"

# Remover página separada incorreta (se existir)
echo "🗑️ Removendo página separada incorreta..."
if [ -d "pages/timeline" ]; then
    mv pages/timeline pages/timeline-old-backup-$(date +%Y%m%d_%H%M%S) 2>/dev/null
    echo "✅ Página separada movida para backup"
fi

# Criar CSS específico para timeline integrada
echo "🎨 Criando CSS para timeline integrada..."
cat >> css/style.css << 'EOF'

/* ============================================
   TIMELINE BÍBLICA INTEGRADA NO INDEX
   ============================================ */

.timeline {
    background: linear-gradient(135deg, #2d1810 0%, #1a1611 100%);
    position: relative;
    overflow: hidden;
}

.timeline::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: radial-gradient(circle at center, rgba(212, 175, 55, 0.1) 0%, transparent 70%);
    pointer-events: none;
}

.timeline__visual {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 400px;
    margin: 3rem 0;
    position: relative;
}

.timeline__divisions {
    display: flex;
    width: 100%;
    max-width: 1000px;
    height: 300px;
    position: relative;
}

/* Linha central divisória */
.timeline__divider {
    position: absolute;
    left: 50%;
    top: 0;
    bottom: 0;
    width: 4px;
    background: linear-gradient(to bottom, #d4af37 0%, #f4d03f 50%, #b7950b 100%);
    transform: translateX(-50%);
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.6);
    z-index: 2;
}

.timeline__divider::before {
    content: '✝️';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #1a1611;
    color: #d4af37;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    border: 3px solid #d4af37;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.5);
}

/* Seções Antigo e Novo Testamento */
.testament-section {
    flex: 1;
    padding: 2rem;
    cursor: pointer;
    transition: all 0.4s ease;
    position: relative;
    border: 2px solid transparent;
    border-radius: 20px;
    background: rgba(212, 175, 55, 0.05);
    backdrop-filter: blur(10px);
}

.testament-section:hover {
    transform: translateY(-10px);
    border-color: #d4af37;
    background: rgba(212, 175, 55, 0.1);
    box-shadow: 0 15px 40px rgba(212, 175, 55, 0.2);
}

.testament-section.old-testament {
    margin-right: 1rem;
    background: linear-gradient(135deg, rgba(139, 69, 19, 0.1) 0%, rgba(212, 175, 55, 0.05) 100%);
}

.testament-section.new-testament {
    margin-left: 1rem;
    background: linear-gradient(135deg, rgba(212, 175, 55, 0.05) 0%, rgba(65, 105, 225, 0.1) 100%);
}

.testament-header {
    text-align: center;
    margin-bottom: 1.5rem;
}

.testament-title {
    font-size: 2rem;
    color: #d4af37;
    font-weight: 700;
    margin-bottom: 0.5rem;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.testament-period {
    color: #f4d03f;
    font-size: 1.1rem;
    font-weight: 500;
    opacity: 0.9;
}

.testament-books {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.5rem;
    margin-bottom: 1.5rem;
}

.book-item {
    background: rgba(212, 175, 55, 0.1);
    border: 1px solid rgba(212, 175, 55, 0.3);
    border-radius: 8px;
    padding: 0.5rem;
    font-size: 0.9rem;
    text-align: center;
    color: #f5f1e8;
    transition: all 0.3s ease;
}

.book-item:hover {
    background: rgba(212, 175, 55, 0.2);
    border-color: #d4af37;
    transform: scale(1.05);
}

.testament-stats {
    display: flex;
    justify-content: space-around;
    margin-bottom: 1rem;
    padding: 1rem;
    background: rgba(0, 0, 0, 0.3);
    border-radius: 15px;
    border: 1px solid rgba(212, 175, 55, 0.2);
}

.stat-item {
    text-align: center;
}

.stat-number {
    display: block;
    font-size: 1.8rem;
    font-weight: 700;
    color: #f4d03f;
    text-shadow: 0 0 10px rgba(244, 208, 63, 0.5);
}

.stat-label {
    font-size: 0.8rem;
    opacity: 0.8;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.testament-cta {
    width: 100%;
    padding: 1rem;
    background: linear-gradient(135deg, #d4af37 0%, #f4d03f 100%);
    color: #1a1611;
    border: none;
    border-radius: 12px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 600;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.testament-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(212, 175, 55, 0.4);
    background: linear-gradient(135deg, #f4d03f 0%, #d4af37 100%);
}

/* Timeline histórica visual */
.timeline__history {
    margin-top: 3rem;
    position: relative;
}

.history-line {
    width: 100%;
    height: 6px;
    background: linear-gradient(90deg, #8B4513 0%, #d4af37 50%, #4169E1 100%);
    border-radius: 3px;
    position: relative;
    margin: 2rem 0;
    box-shadow: 0 0 15px rgba(212, 175, 55, 0.3);
}

.history-markers {
    display: flex;
    justify-content: space-between;
    position: absolute;
    width: 100%;
    top: -10px;
}

.history-marker {
    width: 20px;
    height: 20px;
    background: #d4af37;
    border: 3px solid #1a1611;
    border-radius: 50%;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
}

.history-marker:hover {
    transform: scale(1.2);
    box-shadow: 0 0 15px rgba(212, 175, 55, 0.8);
}

.marker-label {
    position: absolute;
    top: 30px;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(26, 22, 17, 0.9);
    color: #d4af37;
    padding: 0.5rem;
    border-radius: 8px;
    font-size: 0.8rem;
    white-space: nowrap;
    opacity: 0;
    transition: all 0.3s ease;
    border: 1px solid rgba(212, 175, 55, 0.3);
}

.history-marker:hover .marker-label {
    opacity: 1;
    transform: translateX(-50%) translateY(-5px);
}

/* Responsivo */
@media (max-width: 768px) {
    .timeline__divisions {
        flex-direction: column;
        height: auto;
        gap: 2rem;
    }
    
    .timeline__divider {
        left: 0;
        right: 0;
        top: 50%;
        bottom: auto;
        width: 100%;
        height: 4px;
        transform: translateY(-50%);
    }
    
    .timeline__divider::before {
        top: 50%;
        left: 50%;
    }
    
    .testament-section {
        margin: 0;
    }
    
    .testament-section.old-testament,
    .testament-section.new-testament {
        margin: 0;
    }
    
    .testament-books {
        grid-template-columns: 1fr;
    }
    
    .testament-stats {
        flex-direction: column;
        gap: 1rem;
    }
}

/* Animações */
@keyframes timelineSlideIn {
    from {
        opacity: 0;
        transform: translateY(50px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.timeline__visual {
    animation: timelineSlideIn 1s ease-out;
}

/* Efeito de partículas */
.timeline::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image: 
        radial-gradient(2px 2px at 20px 30px, rgba(212, 175, 55, 0.3), transparent),
        radial-gradient(2px 2px at 40px 70px, rgba(244, 208, 63, 0.2), transparent),
        radial-gradient(1px 1px at 90px 40px, rgba(212, 175, 55, 0.4), transparent);
    background-repeat: repeat;
    background-size: 120px 120px;
    animation: particles 20s linear infinite;
    pointer-events: none;
}

@keyframes particles {
    0% { transform: translateY(0px); }
    100% { transform: translateY(-120px); }
}
EOF

# Modificar a seção timeline no index.html
echo "🔄 Atualizando seção timeline no index.html..."

# Primeiro, vamos encontrar e substituir a seção timeline
sed -i '/<!-- Timeline Section - Jornada Bíblica -->/,/<!-- Chat Section - Chat Espiritual -->/{
    /<!-- Chat Section - Chat Espiritual -->/!d
}' index.html

# Inserir nova seção timeline antes do Chat
sed -i '/<!-- Chat Section - Chat Espiritual -->/i\
        <!-- Timeline Section - Linha do Tempo Integrada -->\
        <section class="section timeline" id="timeline" aria-labelledby="timeline-title">\
            <div class="container">\
                <header class="section__header">\
                    <div class="section__subtitle">Jornada Sagrada</div>\
                    <h2 class="section__title" id="timeline-title">\
                        Linha do Tempo <span class="text-gold">Bíblica</span>\
                    </h2>\
                    <p class="section__description">\
                        De Gênesis ao Apocalipse: uma jornada através da revelação divina com evidências arqueológicas\
                    </p>\
                </header>\
\
                <div class="timeline__visual">\
                    <div class="timeline__divisions">\
                        <!-- Antigo Testamento -->\
                        <div class="testament-section old-testament" data-testament="old">\
                            <div class="testament-header">\
                                <h3 class="testament-title">📜 Antigo Testamento</h3>\
                                <div class="testament-period">~2000 AC - 400 AC</div>\
                            </div>\
                            \
                            <div class="testament-stats">\
                                <div class="stat-item">\
                                    <span class="stat-number">39</span>\
                                    <span class="stat-label">Livros</span>\
                                </div>\
                                <div class="stat-item">\
                                    <span class="stat-number">1600</span>\
                                    <span class="stat-label">Anos</span>\
                                </div>\
                                <div class="stat-item">\
                                    <span class="stat-number">50+</span>\
                                    <span class="stat-label">Evidências</span>\
                                </div>\
                            </div>\
                            \
                            <div class="testament-books">\
                                <div class="book-item">Gênesis</div>\
                                <div class="book-item">Êxodo</div>\
                                <div class="book-item">Levítico</div>\
                                <div class="book-item">Números</div>\
                                <div class="book-item">Deuteronômio</div>\
                                <div class="book-item">Josué</div>\
                                <div class="book-item">Juízes</div>\
                                <div class="book-item">Reis</div>\
                                <div class="book-item">Salmos</div>\
                                <div class="book-item">+ 30 livros</div>\
                            </div>\
                            \
                            <button class="testament-cta" onclick="openTestamentDetails('"'"'old'"'"')">\
                                🏺 Explorar Antigo Testamento\
                            </button>\
                        </div>\
                        \
                        <!-- Divisor Central -->\
                        <div class="timeline__divider"></div>\
                        \
                        <!-- Novo Testamento -->\
                        <div class="testament-section new-testament" data-testament="new">\
                            <div class="testament-header">\
                                <h3 class="testament-title">✝️ Novo Testamento</h3>\
                                <div class="testament-period">6 AC - 100 DC</div>\
                            </div>\
                            \
                            <div class="testament-stats">\
                                <div class="stat-item">\
                                    <span class="stat-number">27</span>\
                                    <span class="stat-label">Livros</span>\
                                </div>\
                                <div class="stat-item">\
                                    <span class="stat-number">106</span>\
                                    <span class="stat-label">Anos</span>\
                                </div>\
                                <div class="stat-item">\
                                    <span class="stat-number">50+</span>\
                                    <span class="stat-label">Evidências</span>\
                                </div>\
                            </div>\
                            \
                            <div class="testament-books">\
                                <div class="book-item">Mateus</div>\
                                <div class="book-item">Marcos</div>\
                                <div class="book-item">Lucas</div>\
                                <div class="book-item">João</div>\
                                <div class="book-item">Atos</div>\
                                <div class="book-item">Romanos</div>\
                                <div class="book-item">Coríntios</div>\
                                <div class="book-item">Efésios</div>\
                                <div class="book-item">Apocalipse</div>\
                                <div class="book-item">+ 18 livros</div>\
                            </div>\
                            \
                            <button class="testament-cta" onclick="openTestamentDetails('"'"'new'"'"')">\
                                ⛪ Explorar Novo Testamento\
                            </button>\
                        </div>\
                    </div>\
                </div>\
                \
                <!-- Linha histórica visual -->\
                <div class="timeline__history">\
                    <h3 style="text-align: center; color: #d4af37; margin-bottom: 2rem;">Cronologia Histórica</h3>\
                    <div class="history-line">\
                        <div class="history-markers">\
                            <div class="history-marker">\
                                <div class="marker-label">Criação<br>~2000+ AC</div>\
                            </div>\
                            <div class="history-marker">\
                                <div class="marker-label">Abraão<br>~2000 AC</div>\
                            </div>\
                            <div class="history-marker">\
                                <div class="marker-label">Êxodo<br>~1280 AC</div>\
                            </div>\
                            <div class="history-marker">\
                                <div class="marker-label">Reino Unido<br>~1000 AC</div>\
                            </div>\
                            <div class="history-marker">\
                                <div class="marker-label">Cativeiro<br>~586 AC</div>\
                            </div>\
                            <div class="history-marker">\
                                <div class="marker-label">Jesus<br>6 AC - 30 DC</div>\
                            </div>\
                            <div class="history-marker">\
                                <div class="marker-label">Igreja<br>30-100 DC</div>\
                            </div>\
                        </div>\
                    </div>\
                </div>\
            </div>\
        </section>\
\
' index.html

# Adicionar JavaScript para interação
echo "🔧 Adicionando JavaScript para timeline..."
cat >> js/main.js << 'EOF'

// ============================================
// TIMELINE BÍBLICA INTEGRADA
// ============================================

/**
 * Abrir detalhes do testamento
 */
function openTestamentDetails(testament) {
    const testamentNames = {
        'old': 'Antigo Testamento',
        'new': 'Novo Testamento'
    };
    
    // Por enquanto, mostrar modal (depois será página dedicada)
    const modal = document.createElement('div');
    modal.className = 'testament-modal';
    modal.innerHTML = `
        <div class="modal-content">
            <div class="modal-header">
                <h2>${testament === 'old' ? '📜' : '✝️'} ${testamentNames[testament]}</h2>
                <button class="modal-close" onclick="this.parentElement.parentElement.parentElement.remove()">&times;</button>
            </div>
            <div class="modal-body">
                <p>Timeline detalhada do ${testamentNames[testament]} será implementada em breve.</p>
                <p>Incluirá:</p>
                <ul>
                    <li>🏺 Evidências arqueológicas</li>
                    <li>📍 Localizações geográficas</li>
                    <li>📚 Fatos marcantes</li>
                    <li>🗓️ Cronologia detalhada</li>
                </ul>
            </div>
        </div>
    `;
    
    // Estilo do modal
    const style = document.createElement('style');
    style.textContent = `
        .testament-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: #1a1611;
            border: 2px solid #d4af37;
            border-radius: 15px;
            max-width: 500px;
            width: 90%;
            color: #f5f1e8;
        }
        .modal-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(212, 175, 55, 0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-header h2 {
            margin: 0;
            color: #d4af37;
        }
        .modal-close {
            background: none;
            border: none;
            color: #d4af37;
            font-size: 2rem;
            cursor: pointer;
            padding: 0;
            width: 30px;
            height: 30px;
        }
        .modal-body {
            padding: 1.5rem;
        }
        .modal-body ul {
            margin: 1rem 0;
            padding-left: 1.5rem;
        }
        .modal-body li {
            margin: 0.5rem 0;
        }
    `;
    
    document.head.appendChild(style);
    document.body.appendChild(modal);
    
    // Fechar ao clicar fora
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.remove();
            style.remove();
        }
    });
    
    console.log(`Abrindo detalhes do ${testamentNames[testament]}`);
}

// Animações na timeline ao fazer scroll
function initTimelineAnimations() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, { threshold: 0.2 });
    
    const timelineElements = document.querySelectorAll('.testament-section, .history-marker');
    timelineElements.forEach(el => observer.observe(el));
}

// Inicializar quando DOM carregar
document.addEventListener('DOMContentLoaded', () => {
    if (document.querySelector('.timeline')) {
        initTimelineAnimations();
        console.log('✅ Timeline bíblica inicializada');
    }
});
EOF

echo "✅ SCRIPT 11-fix-timeline-integration.sh EXECUTADO COM SUCESSO!"
echo ""
echo "🔧 CORREÇÕES IMPLEMENTADAS:"
echo "   ✅ Timeline integrada na seção #timeline do index.html"
echo "   ✅ Layout dividido: Antigo Testamento | Novo Testamento"
echo "   ✅ Visual horizontal como solicitado"
echo "   ✅ Stats e livros principais de cada testamento"
echo "   ✅ Linha cronológica histórica visual"
echo "   ✅ CSS responsivo integrado"
echo "   ✅ JavaScript para interações"
echo "   ✅ Remoção da página separada incorreta"
echo ""
echo "📱 FUNCIONALIDADES:"
echo "   • Hover effects nas seções"
echo "   • Botões para explorar cada testamento"
echo "   • Linha histórica com marcos importantes"
echo "   • Modal temporário (será página detalhada)"
echo "   • Layout responsivo mobile"
echo ""
echo "🌐 TESTE:"
echo "   Acesse: http://localhost:8005/#timeline"
echo "   A timeline agora está integrada no index!"
echo ""
echo "⏭️ PRÓXIMO PASSO:"
echo "   Digite 'continuar' para criar as páginas detalhadas"
echo "   de cada testamento com header/footer padrão"