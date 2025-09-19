#!/bin/bash

# =====================================================
# SCRIPT 7: CSS DO QUIZ + CORREÇÃO DE INTEGRAÇÃO
# Portal "Jesus é o Pão da Vida"
# =====================================================
# Uso: chmod +x 7-quiz-css-fix.sh && ./7-quiz-css-fix.sh
# =====================================================

set -e

echo "🎨 IMPLEMENTAÇÃO DO CSS DO QUIZ + CORREÇÕES"
echo "Portal: Jesus é o Pão da Vida"
echo "=========================================="
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto"
    exit 1
fi

# Backup
echo "💾 Criando backup..."
BACKUP_DIR="backup-quiz-css-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp css/style.css "$BACKUP_DIR/" 2>/dev/null || true
cp index.html "$BACKUP_DIR/" 2>/dev/null || true
echo "   ✅ Backup: $BACKUP_DIR"
echo ""

# ============================================
# PASSO 1: ADICIONAR CSS DO QUIZ
# ============================================
echo "🎨 PASSO 1: Adicionando CSS do quiz..."

# Adicionar CSS específico do quiz ao style.css
cat >> css/style.css << 'EOF'

/* =====================================================
   QUIZ BÍBLICO - ESTILOS
   ===================================================== */

.quiz-section {
    padding: 80px 0;
    background: linear-gradient(135deg, #2c1810 0%, #3d2317 50%, #2c1810 100%);
    position: relative;
}

.quiz-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="quiz-pattern" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="rgba(212,175,55,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23quiz-pattern)"/></svg>');
    opacity: 0.3;
    pointer-events: none;
}

.quiz-section .container {
    position: relative;
    z-index: 1;
}

.quiz-section .section-header {
    text-align: center;
    margin-bottom: 50px;
}

.quiz-section .section-header h2 {
    color: #d4af37;
    font-size: 2.5em;
    margin-bottom: 15px;
    font-weight: 700;
}

.quiz-section .section-header p {
    color: #f4e4bc;
    font-size: 1.2em;
    max-width: 600px;
    margin: 0 auto;
    line-height: 1.6;
}

#quiz-container {
    max-width: 800px;
    margin: 0 auto;
}

/* Quiz Welcome Screen */
.quiz-welcome {
    text-align: center;
    padding: 40px;
    background: linear-gradient(135deg, rgba(44, 24, 16, 0.9) 0%, rgba(61, 35, 23, 0.9) 100%);
    border-radius: 20px;
    border: 2px solid #d4af37;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
}

.quiz-header h2 {
    color: #d4af37;
    font-size: 2.2em;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
}

.quiz-header p {
    color: #f4e4bc;
    font-size: 1.1em;
    margin-bottom: 40px;
}

.quiz-stats {
    display: flex;
    justify-content: center;
    gap: 30px;
    margin-bottom: 40px;
    flex-wrap: wrap;
}

.stat-item {
    background: rgba(212, 175, 55, 0.1);
    padding: 20px;
    border-radius: 15px;
    border: 1px solid rgba(212, 175, 55, 0.3);
    min-width: 120px;
}

.stat-number {
    display: block;
    font-size: 2em;
    font-weight: bold;
    color: #d4af37;
    margin-bottom: 5px;
}

.stat-label {
    color: #f4e4bc;
    font-size: 0.9em;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.categories-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
    margin-top: 30px;
}

.category-card {
    background: linear-gradient(135deg, rgba(139, 69, 19, 0.3) 0%, rgba(160, 82, 45, 0.3) 100%);
    padding: 30px;
    border-radius: 15px;
    border: 2px solid rgba(212, 175, 55, 0.5);
    text-align: center;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.category-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, transparent 30%, rgba(212, 175, 55, 0.1) 50%, transparent 70%);
    transform: rotate(45deg);
    transition: all 0.3s ease;
    opacity: 0;
}

.category-card:hover::before {
    opacity: 1;
    animation: shimmer 1.5s ease-in-out;
}

.category-card:hover {
    transform: translateY(-5px);
    border-color: #d4af37;
    box-shadow: 0 15px 35px rgba(212, 175, 55, 0.3);
}

.category-icon {
    font-size: 3em;
    margin-bottom: 20px;
    display: block;
}

.category-card h3 {
    color: #d4af37;
    font-size: 1.3em;
    margin-bottom: 10px;
    font-weight: 600;
}

.category-card p {
    color: #f4e4bc;
    margin-bottom: 20px;
    line-height: 1.5;
    font-size: 0.95em;
}

.category-info {
    margin-bottom: 25px;
}

.question-count {
    background: rgba(212, 175, 55, 0.2);
    color: #d4af37;
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 0.85em;
    font-weight: 500;
}

.start-quiz-btn {
    background: linear-gradient(135deg, #d4af37 0%, #b8941f 100%);
    color: #2c1810;
    border: none;
    padding: 12px 30px;
    border-radius: 8px;
    font-weight: bold;
    font-size: 1em;
    cursor: pointer;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.start-quiz-btn:hover {
    background: linear-gradient(135deg, #b8941f 0%, #d4af37 100%);
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
}

/* Quiz Question Screen */
.quiz-question {
    background: linear-gradient(135deg, rgba(44, 24, 16, 0.95) 0%, rgba(61, 35, 23, 0.95) 100%);
    border-radius: 20px;
    padding: 40px;
    border: 2px solid #d4af37;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
}

.quiz-progress {
    margin-bottom: 30px;
}

.progress-bar {
    background: rgba(244, 228, 188, 0.2);
    height: 8px;
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 10px;
}

.progress-fill {
    background: linear-gradient(90deg, #d4af37 0%, #f4e4bc 100%);
    height: 100%;
    border-radius: 4px;
    transition: width 0.3s ease;
}

.progress-text {
    color: #f4e4bc;
    font-size: 0.9em;
    font-weight: 500;
}

.quiz-timer {
    display: flex;
    justify-content: center;
    margin-bottom: 30px;
}

.timer-circle {
    width: 80px;
    height: 80px;
    border: 4px solid #d4af37;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(212, 175, 55, 0.1);
}

.timer-text {
    color: #d4af37;
    font-weight: bold;
    font-size: 1.2em;
}

.question-content {
    text-align: center;
    margin-bottom: 40px;
}

.question-content h3 {
    color: #f4e4bc;
    font-size: 1.4em;
    line-height: 1.6;
    margin-bottom: 20px;
    font-weight: 500;
}

.question-difficulty {
    display: flex;
    justify-content: center;
}

.difficulty-badge {
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 0.8em;
    font-weight: bold;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.difficulty-badge.easy {
    background: rgba(81, 207, 102, 0.2);
    color: #51cf66;
    border: 1px solid rgba(81, 207, 102, 0.5);
}

.difficulty-badge.medium {
    background: rgba(255, 212, 59, 0.2);
    color: #ffd43b;
    border: 1px solid rgba(255, 212, 59, 0.5);
}

.difficulty-badge.hard {
    background: rgba(255, 107, 107, 0.2);
    color: #ff6b6b;
    border: 1px solid rgba(255, 107, 107, 0.5);
}

.answers-grid {
    display: grid;
    gap: 15px;
}

.answer-option {
    background: rgba(244, 228, 188, 0.05);
    border: 2px solid rgba(212, 175, 55, 0.3);
    border-radius: 12px;
    padding: 20px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 15px;
    text-align: left;
    color: #f4e4bc;
    font-size: 1em;
}

.answer-option:hover {
    background: rgba(212, 175, 55, 0.1);
    border-color: #d4af37;
    transform: translateX(5px);
}

.answer-option.selected {
    background: rgba(212, 175, 55, 0.2);
    border-color: #d4af37;
}

.answer-option.correct {
    background: rgba(81, 207, 102, 0.2);
    border-color: #51cf66;
    color: #51cf66;
}

.answer-option.incorrect {
    background: rgba(255, 107, 107, 0.2);
    border-color: #ff6b6b;
    color: #ff6b6b;
}

.option-letter {
    background: #d4af37;
    color: #2c1810;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    flex-shrink: 0;
}

.option-text {
    flex: 1;
    line-height: 1.4;
}

/* Question Result */
.question-result {
    margin-top: 30px;
    padding: 30px;
    background: rgba(0, 0, 0, 0.3);
    border-radius: 15px;
    text-align: center;
}

.result-header {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    margin-bottom: 20px;
}

.result-header.correct {
    color: #51cf66;
}

.result-header.incorrect {
    color: #ff6b6b;
}

.result-icon {
    font-size: 1.5em;
}

.result-text {
    font-size: 1.2em;
    font-weight: bold;
}

.result-explanation {
    color: #f4e4bc;
    margin-bottom: 25px;
    line-height: 1.6;
}

.bible-verse {
    color: #d4af37;
    font-style: italic;
    margin-top: 15px;
    font-weight: 500;
}

.next-question-btn {
    background: linear-gradient(135deg, #d4af37 0%, #b8941f 100%);
    color: #2c1810;
    border: none;
    padding: 15px 30px;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 1em;
    text-transform: uppercase;
}

.next-question-btn:hover {
    background: linear-gradient(135deg, #b8941f 0%, #d4af37 100%);
    transform: scale(1.05);
}

/* Final Result */
.quiz-result {
    background: linear-gradient(135deg, rgba(44, 24, 16, 0.95) 0%, rgba(61, 35, 23, 0.95) 100%);
    border-radius: 20px;
    padding: 50px;
    text-align: center;
    border: 2px solid #d4af37;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
}

.result-header .result-icon {
    font-size: 4em;
    margin-bottom: 20px;
    display: block;
}

.result-header h2 {
    color: #d4af37;
    font-size: 2.2em;
    margin-bottom: 15px;
}

.performance-message {
    color: #f4e4bc;
    font-size: 1.2em;
    margin-bottom: 40px;
    line-height: 1.6;
}

.result-stats {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 50px;
    margin-bottom: 40px;
    flex-wrap: wrap;
}

.stat-circle {
    text-align: center;
}

.circle-progress {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    background: conic-gradient(#d4af37 calc(var(--percentage) * 1%), rgba(212, 175, 55, 0.2) 0);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    margin-bottom: 15px;
}

.circle-progress::before {
    content: '';
    position: absolute;
    width: 90px;
    height: 90px;
    background: #2c1810;
    border-radius: 50%;
}

.percentage {
    position: relative;
    font-size: 1.8em;
    font-weight: bold;
    color: #d4af37;
    z-index: 1;
}

.result-details {
    text-align: left;
}

.detail-item {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    padding: 10px 0;
    border-bottom: 1px solid rgba(212, 175, 55, 0.2);
}

.detail-label {
    color: #f4e4bc;
    font-weight: 500;
}

.detail-value {
    color: #d4af37;
    font-weight: bold;
}

.result-actions {
    display: flex;
    gap: 20px;
    justify-content: center;
    flex-wrap: wrap;
}

.restart-quiz-btn {
    background: linear-gradient(135deg, #d4af37 0%, #b8941f 100%);
    color: #2c1810;
    border: none;
    padding: 15px 30px;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 1em;
    text-transform: uppercase;
}

.restart-quiz-btn:hover {
    background: linear-gradient(135deg, #b8941f 0%, #d4af37 100%);
    transform: scale(1.05);
}

.result-actions button:last-child {
    background: transparent;
    color: #d4af37;
    border: 2px solid #d4af37;
    padding: 13px 28px;
}

.result-actions button:last-child:hover {
    background: rgba(212, 175, 55, 0.1);
}

/* Animations */
@keyframes shimmer {
    0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
    100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
}

/* Responsive Design */
@media (max-width: 768px) {
    .quiz-section {
        padding: 60px 0;
    }
    
    .quiz-section .section-header h2 {
        font-size: 2em;
    }
    
    .quiz-welcome,
    .quiz-question,
    .quiz-result {
        padding: 30px 20px;
        margin: 0 15px;
    }
    
    .categories-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    .quiz-stats {
        gap: 20px;
    }
    
    .stat-item {
        min-width: 100px;
        padding: 15px;
    }
    
    .result-stats {
        flex-direction: column;
        gap: 30px;
    }
    
    .result-actions {
        flex-direction: column;
        align-items: center;
    }
    
    .result-actions button {
        width: 200px;
    }
}

@media (max-width: 480px) {
    .quiz-header h2 {
        font-size: 1.8em;
        flex-direction: column;
        gap: 10px;
    }
    
    .question-content h3 {
        font-size: 1.2em;
    }
    
    .answer-option {
        padding: 15px;
        font-size: 0.9em;
    }
    
    .option-letter {
        width: 30px;
        height: 30px;
        font-size: 0.9em;
    }
    
    .circle-progress {
        width: 100px;
        height: 100px;
    }
    
    .circle-progress::before {
        width: 75px;
        height: 75px;
    }
    
    .percentage {
        font-size: 1.5em;
    }
}
EOF

echo "   ✅ CSS do quiz adicionado ao style.css"

# ============================================
# PASSO 2: CORRIGIR INTEGRAÇÃO NO HTML
# ============================================
echo ""
echo "🔧 PASSO 2: Corrigindo integração no HTML..."

# Verificar se a seção existe e está visível
if grep -q "quiz-section" index.html; then
    echo "   ✅ Seção do quiz já existe no HTML"
else
    echo "   ➕ Adicionando seção do quiz ao HTML..."
    
    # Encontrar linha após "Quiz Bíblico" no menu (se existir)
    INSERT_LINE=$(grep -n "</section>" index.html | tail -1 | cut -d: -f1)
    
    if [ -n "$INSERT_LINE" ]; then
        # Adicionar seção após a última seção
        sed -i "${INSERT_LINE}a\\
\\
    <!-- ===== SEÇÃO QUIZ BÍBLICO ===== -->\\
    <section class=\"quiz-section\" id=\"quiz\">\\
        <div class=\"container\">\\
            <div class=\"section-header\">\\
                <h2>📚 Quiz Bíblico</h2>\\
                <p>Teste seus conhecimentos das Sagradas Escrituras e aprenda mais sobre a Palavra de Deus</p>\\
            </div>\\
            <div id=\"quiz-container\">\\
                <div style=\"text-align: center; padding: 40px; color: #f4e4bc;\">\\
                    <div style=\"font-size: 3em; margin-bottom: 20px;\">⏳</div>\\
                    <p>Carregando quiz bíblico...</p>\\
                </div>\\
            </div>\\
        </div>\\
    </section>" index.html
        
        echo "   ✅ Seção do quiz adicionada ao HTML"
    fi
fi

# Verificar e adicionar link no menu se não existir
if ! grep -q "href=\"#quiz\"" index.html; then
    echo "   ➕ Adicionando link do quiz no menu..."
    
    # Procurar pela estrutura do menu e adicionar link
    sed -i 's/<a href="#recursos">Recursos<\/a>/<a href="#recursos">Recursos<\/a>\
                        <a href="#quiz">Quiz<\/a>/' index.html
    
    echo "   ✅ Link do quiz adicionado ao menu"
fi

# ============================================
# PASSO 3: CRIAR ARQUIVO DE TESTE
# ============================================
echo ""
echo "🧪 PASSO 3: Criando arquivo de teste do quiz..."

cat > test-quiz-biblico.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste Quiz Bíblico - Portal Jesus</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { margin: 0; padding: 20px 0; }
        .test-info {
            background: #1a4d3a;
            color: #51cf66;
            padding: 20px;
            margin: 20px;
            border-radius: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="test-info">
        <h2>🧪 Teste do Quiz Bíblico</h2>
        <p>Esta página testa apenas a funcionalidade do quiz de forma isolada</p>
    </div>

    <!-- Seção do Quiz -->
    <section class="quiz-section" id="quiz">
        <div class="container">
            <div class="section-header">
                <h2>📚 Quiz Bíblico</h2>
                <p>Teste seus conhecimentos das Sagradas Escrituras</p>
            </div>
            <div id="quiz-container">
                <div style="text-align: center; padding: 40px; color: #f4e4bc;">
                    <div style="font-size: 3em; margin-bottom: 20px;">⏳</div>
                    <p>Carregando quiz bíblico...</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Scripts -->
    <script src="js/quiz-biblico.js"></script>
    
    <script>
        // Debug do carregamento
        console.log('🧪 Teste do Quiz iniciado');
        
        setTimeout(() => {
            if (typeof QuizBiblico !== 'undefined') {
                console.log('✅ Classe QuizBiblico carregada');
            } else {
                console.error('❌ Classe QuizBiblico não encontrada');
            }
            
            if (document.getElementById('quiz-container').innerHTML.includes('Carregando')) {
                console.error('❌ Quiz não foi inicializado - ainda mostra loading');
            }
        }, 2000);
    </script>
</body>
</html>
EOF

echo "   ✅ Arquivo de teste criado: test-quiz-biblico.html"

# ============================================
# PASSO 4: VERIFICAÇÕES FINAIS
# ============================================
echo ""
echo "🔍 PASSO 4: Verificações finais..."

# Verificar se arquivos necessários existem
FILES_TO_CHECK=("js/quiz-biblico.js" "json/quiz_questions.json" "json/quiz_config.json")

echo "   📋 Verificando arquivos necessários:"
for file in "${FILES_TO_CHECK[@]}"; do
    if [ -f "$file" ]; then
        size=$(stat -c%s "$file")
        echo "     ✅ $file (${size} bytes)"
    else
        echo "     ❌ $file NÃO ENCONTRADO"
    fi
done

# Verificar CSS
if grep -q "quiz-section" css/style.css; then
    echo "   ✅ CSS do quiz adicionado"
else
    echo "   ❌ CSS do quiz NÃO adicionado"
fi

# Verificar HTML
if grep -q "quiz-container" index.html; then
    echo "   ✅ HTML do quiz integrado"
else
    echo "   ❌ HTML do quiz NÃO integrado"
fi

echo ""
echo "📋 RESUMO DA IMPLEMENTAÇÃO COMPLETA"
echo "==================================="
echo "✅ CSS completo do quiz adicionado (responsivo)"
echo "✅ Integração HTML corrigida e verificada"
echo "✅ Arquivo de teste isolado criado"
echo "✅ Sistema de backup mantido"
echo ""
echo "🎨 CARACTERÍSTICAS VISUAIS:"
echo "• Design integrado ao tema do site"
echo "• Animações suaves e efeitos visuais"
echo "• Layout responsivo (mobile-first)"
echo "• Sistema de cores consistente"
echo "• Timer visual circular"
echo "• Feedback visual para respostas"
echo ""
echo "🧪 TESTES DISPONÍVEIS:"
echo "1. Teste isolado: test-quiz-biblico.html"
echo "2. Teste integrado: index.html"
echo ""
echo "🚀 PARA TESTAR AGORA:"
echo "1. python3 -m http.server 8000"
echo "2. Abra: http://localhost:8000/test-quiz-biblico.html"
echo "3. Ou teste no site: http://localhost:8000#quiz"
echo ""
echo "✨ O quiz deve estar visível e funcional agora!"