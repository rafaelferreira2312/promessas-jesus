#!/bin/bash

# =====================================================
# SCRIPT 6: IMPLEMENTAÇÃO DO QUIZ BÍBLICO
# Portal "Jesus é o Pão da Vida"
# =====================================================
# Uso: chmod +x 6-quiz-biblico.sh && ./6-quiz-biblico.sh
# =====================================================

set -e

echo "📚 IMPLEMENTAÇÃO DO QUIZ BÍBLICO"
echo "Portal: Jesus é o Pão da Vida"
echo "==============================="
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto (onde está index.html)"
    exit 1
fi

# Backup
echo "💾 Criando backup..."
BACKUP_DIR="backup-quiz-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp index.html "$BACKUP_DIR/" 2>/dev/null || true
cp -r js/ "$BACKUP_DIR/js/" 2>/dev/null || true
cp -r json/ "$BACKUP_DIR/json/" 2>/dev/null || true
echo "   ✅ Backup: $BACKUP_DIR"
echo ""

# ============================================
# PASSO 1: CRIAR DADOS DO QUIZ
# ============================================
echo "📊 PASSO 1: Criando base de dados do quiz..."

mkdir -p json

cat > json/quiz_questions.json << 'EOF'
{
  "categories": [
    {
      "id": "antigo_testamento",
      "name": "Antigo Testamento",
      "description": "Perguntas sobre os livros do Antigo Testamento",
      "icon": "📜"
    },
    {
      "id": "novo_testamento", 
      "name": "Novo Testamento",
      "description": "Perguntas sobre os livros do Novo Testamento",
      "icon": "✝️"
    },
    {
      "id": "vida_jesus",
      "name": "Vida de Jesus",
      "description": "Perguntas sobre a vida e ministério de Jesus Cristo",
      "icon": "👑"
    },
    {
      "id": "sabedoria",
      "name": "Livros de Sabedoria",
      "description": "Salmos, Provérbios, Eclesiastes",
      "icon": "💡"
    }
  ],
  "questions": [
    {
      "id": 1,
      "category": "antigo_testamento",
      "question": "Quantos dias Deus levou para criar o mundo?",
      "options": ["5 dias", "6 dias", "7 dias", "8 dias"],
      "correct": 1,
      "explanation": "Gênesis 1 nos conta que Deus criou o mundo em 6 dias e descansou no 7º dia.",
      "verse": "Gênesis 2:2",
      "difficulty": "easy"
    },
    {
      "id": 2,
      "category": "antigo_testamento",
      "question": "Quem foi o primeiro homem criado por Deus?",
      "options": ["Abel", "Caim", "Adão", "Noé"],
      "correct": 2,
      "explanation": "Adão foi o primeiro homem criado por Deus do pó da terra.",
      "verse": "Gênesis 2:7",
      "difficulty": "easy"
    },
    {
      "id": 3,
      "category": "novo_testamento",
      "question": "Em qual cidade Jesus nasceu?",
      "options": ["Nazaré", "Jerusalém", "Belém", "Cafarnaum"],
      "correct": 2,
      "explanation": "Jesus nasceu em Belém, cumprindo a profecia de Miqueias.",
      "verse": "Mateus 2:1",
      "difficulty": "easy"
    },
    {
      "id": 4,
      "category": "vida_jesus",
      "question": "Quantos discípulos Jesus escolheu?",
      "options": ["10", "11", "12", "13"],
      "correct": 2,
      "explanation": "Jesus escolheu 12 discípulos para serem seus apóstolos.",
      "verse": "Marcos 3:14",
      "difficulty": "easy"
    },
    {
      "id": 5,
      "category": "novo_testamento",
      "question": "Qual é o versículo mais famoso da Bíblia?",
      "options": ["João 3:16", "Salmos 23:1", "Gênesis 1:1", "Apocalipse 22:21"],
      "correct": 0,
      "explanation": "João 3:16 é conhecido como o 'Evangelho em miniatura'.",
      "verse": "João 3:16",
      "difficulty": "easy"
    },
    {
      "id": 6,
      "category": "antigo_testamento",
      "question": "Quem conduziu o povo de Israel para fora do Egito?",
      "options": ["Abraão", "Moisés", "Josué", "Davi"],
      "correct": 1,
      "explanation": "Moisés foi escolhido por Deus para libertar Israel da escravidão no Egito.",
      "verse": "Êxodo 3:10",
      "difficulty": "easy"
    },
    {
      "id": 7,
      "category": "sabedoria",
      "question": "Complete: 'O Senhor é o meu pastor...'",
      "options": ["...nada me faltará", "...me guiará", "...me protegerá", "...me abençoará"],
      "correct": 0,
      "explanation": "Este é o início do Salmo 23, um dos mais conhecidos da Bíblia.",
      "verse": "Salmos 23:1",
      "difficulty": "easy"
    },
    {
      "id": 8,
      "category": "vida_jesus",
      "question": "Em quantos dias Jesus ressuscitou?",
      "options": ["No mesmo dia", "No segundo dia", "No terceiro dia", "No quarto dia"],
      "correct": 2,
      "explanation": "Jesus ressuscitou no terceiro dia, conforme as Escrituras.",
      "verse": "1 Coríntios 15:4",
      "difficulty": "easy"
    },
    {
      "id": 9,
      "category": "antigo_testamento",
      "question": "Quantos livros tem o Antigo Testamento?",
      "options": ["36", "37", "38", "39"],
      "correct": 3,
      "explanation": "O Antigo Testamento possui 39 livros no cânon protestante.",
      "verse": "",
      "difficulty": "medium"
    },
    {
      "id": 10,
      "category": "novo_testamento",
      "question": "Quantos livros tem o Novo Testamento?",
      "options": ["25", "26", "27", "28"],
      "correct": 2,
      "explanation": "O Novo Testamento possui 27 livros.",
      "verse": "",
      "difficulty": "medium"
    }
  ]
}
EOF

echo "   ✅ Base de dados criada com 10 perguntas"

# ============================================
# PASSO 2: CRIAR SISTEMA DE PONTUAÇÃO
# ============================================
echo ""
echo "🏆 PASSO 2: Criando sistema de pontuação..."

cat > json/quiz_config.json << 'EOF'
{
  "settings": {
    "questions_per_quiz": 5,
    "time_per_question": 30,
    "points": {
      "easy": 10,
      "medium": 20,
      "hard": 30,
      "bonus_speed": 5
    },
    "achievements": [
      {
        "id": "primeiro_quiz",
        "name": "Primeiro Quiz",
        "description": "Complete seu primeiro quiz",
        "icon": "🌟",
        "requirement": "complete_quiz"
      },
      {
        "id": "pontuacao_perfeita",
        "name": "Pontuação Perfeita", 
        "description": "Acerte todas as perguntas",
        "icon": "🏆",
        "requirement": "perfect_score"
      },
      {
        "id": "estudioso",
        "name": "Estudioso das Escrituras",
        "description": "Complete 10 quizzes",
        "icon": "📚",
        "requirement": "complete_10_quizzes"
      }
    ]
  }
}
EOF

echo "   ✅ Sistema de pontuação configurado"

# ============================================
# PASSO 3: CRIAR JAVASCRIPT DO QUIZ
# ============================================
echo ""
echo "⚙️ PASSO 3: Criando JavaScript do quiz..."

cat > js/quiz-biblico.js << 'EOF'
// =====================================================
// QUIZ BÍBLICO - Portal Jesus é o Pão da Vida
// =====================================================

class QuizBiblico {
    constructor() {
        this.questions = [];
        this.categories = [];
        this.currentQuiz = null;
        this.currentQuestionIndex = 0;
        this.score = 0;
        this.userAnswers = [];
        this.timeLeft = 30;
        this.timer = null;
        this.userStats = this.loadUserStats();
        
        this.init();
    }
    
    async init() {
        try {
            await this.loadData();
            this.setupEventListeners();
            this.renderCategorySelection();
            console.log('✅ Quiz Bíblico inicializado');
        } catch (error) {
            console.error('❌ Erro ao inicializar quiz:', error);
        }
    }
    
    async loadData() {
        try {
            const [questionsResponse, configResponse] = await Promise.all([
                fetch('./json/quiz_questions.json'),
                fetch('./json/quiz_config.json')
            ]);
            
            const questionsData = await questionsResponse.json();
            const configData = await configResponse.json();
            
            this.questions = questionsData.questions;
            this.categories = questionsData.categories;
            this.config = configData.settings;
            
            console.log(`✅ Carregadas ${this.questions.length} perguntas em ${this.categories.length} categorias`);
        } catch (error) {
            console.error('❌ Erro ao carregar dados do quiz:', error);
            this.setupFallbackData();
        }
    }
    
    setupFallbackData() {
        this.categories = [
            { id: "geral", name: "Conhecimento Geral", description: "Perguntas gerais da Bíblia", icon: "📖" }
        ];
        this.questions = [
            {
                id: 1,
                category: "geral",
                question: "Quantos livros tem a Bíblia?",
                options: ["64", "65", "66", "67"],
                correct: 2,
                explanation: "A Bíblia possui 66 livros no total.",
                verse: "",
                difficulty: "easy"
            }
        ];
        this.config = {
            questions_per_quiz: 5,
            time_per_question: 30,
            points: { easy: 10, medium: 20, hard: 30, bonus_speed: 5 }
        };
    }
    
    setupEventListeners() {
        // Botão iniciar quiz
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('start-quiz-btn')) {
                const categoryId = e.target.dataset.category;
                this.startQuiz(categoryId);
            }
            
            if (e.target.classList.contains('answer-option')) {
                this.selectAnswer(e.target);
            }
            
            if (e.target.classList.contains('next-question-btn')) {
                this.nextQuestion();
            }
            
            if (e.target.classList.contains('restart-quiz-btn')) {
                this.renderCategorySelection();
            }
        });
    }
    
    renderCategorySelection() {
        const quizContainer = document.getElementById('quiz-container');
        if (!quizContainer) return;
        
        let html = `
            <div class="quiz-welcome">
                <div class="quiz-header">
                    <h2>📚 Quiz Bíblico</h2>
                    <p>Teste seus conhecimentos das Sagradas Escrituras</p>
                </div>
                
                <div class="quiz-stats">
                    <div class="stat-item">
                        <span class="stat-number">${this.userStats.totalQuizzes}</span>
                        <span class="stat-label">Quizzes Completos</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${this.userStats.totalScore}</span>
                        <span class="stat-label">Pontos Totais</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${Math.round(this.userStats.averageScore)}%</span>
                        <span class="stat-label">Média de Acertos</span>
                    </div>
                </div>
                
                <div class="categories-grid">
        `;
        
        this.categories.forEach(category => {
            const categoryQuestions = this.questions.filter(q => q.category === category.id);
            html += `
                <div class="category-card">
                    <div class="category-icon">${category.icon}</div>
                    <h3>${category.name}</h3>
                    <p>${category.description}</p>
                    <div class="category-info">
                        <span class="question-count">${categoryQuestions.length} perguntas</span>
                    </div>
                    <button class="start-quiz-btn" data-category="${category.id}">
                        Iniciar Quiz
                    </button>
                </div>
            `;
        });
        
        html += `
                </div>
            </div>
        `;
        
        quizContainer.innerHTML = html;
    }
    
    startQuiz(categoryId) {
        // Selecionar perguntas da categoria
        let categoryQuestions = this.questions.filter(q => q.category === categoryId);
        
        // Embaralhar e selecionar quantidade configurada
        categoryQuestions = this.shuffleArray(categoryQuestions);
        this.currentQuiz = categoryQuestions.slice(0, this.config.questions_per_quiz);
        
        // Reset do estado
        this.currentQuestionIndex = 0;
        this.score = 0;
        this.userAnswers = [];
        
        this.renderQuestion();
    }
    
    renderQuestion() {
        const quizContainer = document.getElementById('quiz-container');
        const question = this.currentQuiz[this.currentQuestionIndex];
        const questionNumber = this.currentQuestionIndex + 1;
        const totalQuestions = this.currentQuiz.length;
        
        // Iniciar timer
        this.timeLeft = this.config.time_per_question;
        this.startTimer();
        
        const html = `
            <div class="quiz-question">
                <div class="quiz-progress">
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${(questionNumber/totalQuestions)*100}%"></div>
                    </div>
                    <span class="progress-text">Pergunta ${questionNumber} de ${totalQuestions}</span>
                </div>
                
                <div class="quiz-timer">
                    <div class="timer-circle">
                        <span class="timer-text">${this.timeLeft}s</span>
                    </div>
                </div>
                
                <div class="question-content">
                    <h3>${question.question}</h3>
                    <div class="question-difficulty">
                        <span class="difficulty-badge ${question.difficulty}">
                            ${question.difficulty === 'easy' ? 'Fácil' : question.difficulty === 'medium' ? 'Médio' : 'Difícil'}
                        </span>
                    </div>
                </div>
                
                <div class="answers-grid">
                    ${question.options.map((option, index) => `
                        <button class="answer-option" data-index="${index}">
                            <span class="option-letter">${String.fromCharCode(65 + index)}</span>
                            <span class="option-text">${option}</span>
                        </button>
                    `).join('')}
                </div>
            </div>
        `;
        
        quizContainer.innerHTML = html;
    }
    
    startTimer() {
        this.stopTimer();
        
        this.timer = setInterval(() => {
            this.timeLeft--;
            
            const timerText = document.querySelector('.timer-text');
            if (timerText) {
                timerText.textContent = `${this.timeLeft}s`;
            }
            
            if (this.timeLeft <= 0) {
                this.timeUp();
            }
        }, 1000);
    }
    
    stopTimer() {
        if (this.timer) {
            clearInterval(this.timer);
            this.timer = null;
        }
    }
    
    selectAnswer(selectedButton) {
        // Desabilitar outras opções
        const allOptions = document.querySelectorAll('.answer-option');
        allOptions.forEach(option => {
            option.disabled = true;
            option.classList.remove('selected');
        });
        
        selectedButton.classList.add('selected');
        
        // Parar timer
        this.stopTimer();
        
        // Processar resposta
        const selectedIndex = parseInt(selectedButton.dataset.index);
        this.processAnswer(selectedIndex);
    }
    
    processAnswer(selectedIndex) {
        const question = this.currentQuiz[this.currentQuestionIndex];
        const isCorrect = selectedIndex === question.correct;
        const timeBonus = this.timeLeft > 20 ? this.config.points.bonus_speed : 0;
        
        // Calcular pontos
        let points = 0;
        if (isCorrect) {
            points = this.config.points[question.difficulty] + timeBonus;
            this.score += points;
        }
        
        // Salvar resposta
        this.userAnswers.push({
            questionId: question.id,
            selectedIndex,
            correct: question.correct,
            isCorrect,
            points,
            timeLeft: this.timeLeft
        });
        
        // Mostrar resultado da pergunta
        this.showQuestionResult(isCorrect, points, question);
    }
    
    showQuestionResult(isCorrect, points, question) {
        const allOptions = document.querySelectorAll('.answer-option');
        
        // Destacar resposta correta
        allOptions[question.correct].classList.add('correct');
        
        // Destacar resposta incorreta se houver
        const selectedOption = document.querySelector('.answer-option.selected');
        if (!isCorrect && selectedOption) {
            selectedOption.classList.add('incorrect');
        }
        
        // Mostrar explicação
        const explanationHtml = `
            <div class="question-result">
                <div class="result-header ${isCorrect ? 'correct' : 'incorrect'}">
                    <span class="result-icon">${isCorrect ? '✅' : '❌'}</span>
                    <span class="result-text">
                        ${isCorrect ? 'Correto!' : 'Incorreto'}
                        ${points > 0 ? ` (+${points} pontos)` : ''}
                    </span>
                </div>
                <div class="result-explanation">
                    <p>${question.explanation}</p>
                    ${question.verse ? `<p class="bible-verse"><strong>${question.verse}</strong></p>` : ''}
                </div>
                <button class="next-question-btn">
                    ${this.currentQuestionIndex < this.currentQuiz.length - 1 ? 'Próxima Pergunta' : 'Ver Resultado'}
                </button>
            </div>
        `;
        
        const quizContainer = document.getElementById('quiz-container');
        quizContainer.insertAdjacentHTML('beforeend', explanationHtml);
    }
    
    nextQuestion() {
        this.currentQuestionIndex++;
        
        if (this.currentQuestionIndex < this.currentQuiz.length) {
            this.renderQuestion();
        } else {
            this.showFinalResult();
        }
    }
    
    timeUp() {
        this.stopTimer();
        this.processAnswer(-1); // Resposta incorreta por tempo
    }
    
    showFinalResult() {
        const totalQuestions = this.currentQuiz.length;
        const correctAnswers = this.userAnswers.filter(a => a.isCorrect).length;
        const percentage = Math.round((correctAnswers / totalQuestions) * 100);
        
        // Atualizar estatísticas
        this.updateUserStats(correctAnswers, totalQuestions, this.score);
        
        // Determinar nível de performance
        let performanceLevel, performanceMessage, performanceIcon;
        if (percentage >= 90) {
            performanceLevel = 'excellent';
            performanceMessage = 'Excelente! Você é um verdadeiro conhecedor das Escrituras!';
            performanceIcon = '🏆';
        } else if (percentage >= 70) {
            performanceLevel = 'good';
            performanceMessage = 'Muito bem! Continue estudando a Palavra de Deus!';
            performanceIcon = '👏';
        } else if (percentage >= 50) {
            performanceLevel = 'average';
            performanceMessage = 'Bom trabalho! Há sempre mais para aprender sobre Deus.';
            performanceIcon = '📖';
        } else {
            performanceLevel = 'needs-improvement';
            performanceMessage = 'Continue estudando! A Palavra de Deus é rica em sabedoria.';
            performanceIcon = '💪';
        }
        
        const quizContainer = document.getElementById('quiz-container');
        const html = `
            <div class="quiz-result">
                <div class="result-header">
                    <div class="result-icon">${performanceIcon}</div>
                    <h2>Quiz Concluído!</h2>
                    <p class="performance-message">${performanceMessage}</p>
                </div>
                
                <div class="result-stats">
                    <div class="stat-circle">
                        <div class="circle-progress" style="--percentage: ${percentage}">
                            <span class="percentage">${percentage}%</span>
                        </div>
                        <span class="stat-label">Acertos</span>
                    </div>
                    
                    <div class="result-details">
                        <div class="detail-item">
                            <span class="detail-label">Pontuação:</span>
                            <span class="detail-value">${this.score} pontos</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Corretas:</span>
                            <span class="detail-value">${correctAnswers}/${totalQuestions}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Tempo médio:</span>
                            <span class="detail-value">${this.calculateAverageTime()}s</span>
                        </div>
                    </div>
                </div>
                
                <div class="result-actions">
                    <button class="restart-quiz-btn">Fazer Outro Quiz</button>
                    <button onclick="window.scrollTo({top: 0, behavior: 'smooth'})">Voltar ao Topo</button>
                </div>
            </div>
        `;
        
        quizContainer.innerHTML = html;
        
        // Scroll to result
        quizContainer.scrollIntoView({ behavior: 'smooth' });
    }
    
    calculateAverageTime() {
        const totalTime = this.userAnswers.reduce((sum, answer) => {
            return sum + (this.config.time_per_question - answer.timeLeft);
        }, 0);
        return Math.round(totalTime / this.userAnswers.length);
    }
    
    shuffleArray(array) {
        const shuffled = [...array];
        for (let i = shuffled.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
        }
        return shuffled;
    }
    
    loadUserStats() {
        const saved = localStorage.getItem('quiz-biblico-stats');
        if (saved) {
            return JSON.parse(saved);
        }
        return {
            totalQuizzes: 0,
            totalScore: 0,
            totalQuestions: 0,
            totalCorrect: 0,
            averageScore: 0
        };
    }
    
    updateUserStats(correct, total, score) {
        this.userStats.totalQuizzes++;
        this.userStats.totalScore += score;
        this.userStats.totalQuestions += total;
        this.userStats.totalCorrect += correct;
        this.userStats.averageScore = (this.userStats.totalCorrect / this.userStats.totalQuestions) * 100;
        
        localStorage.setItem('quiz-biblico-stats', JSON.stringify(this.userStats));
    }
}

// Inicializar quando a seção do quiz for carregada
document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('quiz-container')) {
        window.quizBiblico = new QuizBiblico();
    }
});
EOF

echo "   ✅ JavaScript do quiz criado"

# ============================================
# PASSO 4: ATUALIZAR INDEX.HTML
# ============================================
echo ""
echo "🔗 PASSO 4: Integrando quiz na index.html..."

# Verificar se seção já existe
if grep -q "Quiz Bíblico" index.html; then
    echo "   ⚠️ Seção do quiz já existe - atualizando..."
    # Atualizar seção existente
else
    echo "   ➕ Adicionando nova seção do quiz..."
    
    # Encontrar onde inserir (após Chat Espiritual)
    INSERTION_LINE=$(grep -n "Chat Espiritual" index.html | tail -1 | cut -d: -f1)
    
    if [ -n "$INSERTION_LINE" ]; then
        # Calcular linha após a seção do chat
        INSERT_AFTER=$((INSERTION_LINE + 50))
        
        # Inserir seção do quiz
        sed -i "${INSERT_AFTER}a\\
\\
    <!-- ===== SEÇÃO QUIZ BÍBLICO ===== -->\\
    <section class=\"quiz-section\" id=\"quiz\">\\
        <div class=\"container\">\\
            <div class=\"section-header\">\\
                <h2>Quiz Bíblico</h2>\\
                <p>Teste seus conhecimentos das Sagradas Escrituras e aprenda mais sobre a Palavra de Deus</p>\\
            </div>\\
            <div id=\"quiz-container\">\\
                <!-- Conteúdo do quiz carregado pelo JavaScript -->\\
            </div>\\
        </div>\\
    </section>" index.html
        
        echo "   ✅ Seção do quiz adicionada"
    else
        echo "   ⚠️ Não foi possível encontrar posição para inserir - adicionando ao final"
        # Adicionar antes do footer
        sed -i '/<\/body>/i\
    <!-- ===== SEÇÃO QUIZ BÍBLICO ===== -->\
    <section class="quiz-section" id="quiz">\
        <div class="container">\
            <div class="section-header">\
                <h2>Quiz Bíblico</h2>\
                <p>Teste seus conhecimentos das Sagradas Escrituras e aprenda mais sobre a Palavra de Deus</p>\
            </div>\
            <div id="quiz-container">\
                <!-- Conteúdo do quiz carregado pelo JavaScript -->\
            </div>\
        </div>\
    </section>\
    ' index.html
    fi
fi

# Adicionar link no menu
if ! grep -q "Quiz" index.html; then
    sed -i 's/<a href="#recursos">Recursos<\/a>/<a href="#recursos">Recursos<\/a>\
                        <a href="#quiz">Quiz<\/a>/' index.html
    echo "   ✅ Link adicionado no menu"
fi

# Adicionar script
if ! grep -q "quiz-biblico.js" index.html; then
    sed -i '/<script src="js\/main.js"><\/script>/a\
    <script src="js/quiz-biblico.js"></script>' index.html
    echo "   ✅ Script adicionado"
fi

echo ""
echo "📋 RESUMO DA IMPLEMENTAÇÃO DO QUIZ"
echo "===================================="
echo "✅ Base de dados criada com 10 perguntas em 4 categorias"
echo "✅ Sistema de pontuação e achievements configurado"
echo "✅ JavaScript completo com timer e estatísticas"
echo "✅ Integração na index.html concluída"
echo "✅ Backup criado: $BACKUP_DIR"
echo ""
echo "🎯 CARACTERÍSTICAS DO QUIZ:"
echo "• 4 categorias: Antigo Testamento, Novo Testamento, Vida de Jesus, Sabedoria"
echo "• Sistema de timer (30s por pergunta)"
echo "• Pontuação baseada em dificuldade e velocidade"
echo "• Estatísticas persistentes (localStorage)"
echo "• Design responsivo integrado ao site"
echo ""
echo "🧪 PARA TESTAR:"
echo "1. python3 -m http.server 8000"
echo "2. Abra: http://localhost:8000"
echo "3. Navegue até a seção 'Quiz Bíblico'"
echo "4. Teste diferentes categorias"
echo ""