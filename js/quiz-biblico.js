// Quiz Bíblico - Integração com seção existente
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
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.setup());
        } else {
            this.setup();
        }
    }
    
    async setup() {
        await this.loadData();
        this.setupEventListeners();
        this.renderQuizHome();
        console.log('✅ Quiz integrado à seção existente');
    }
    
    async loadData() {
        try {
            const [questionsResponse, configResponse] = await Promise.all([
                fetch('./json/quiz_questions.json'),
                fetch('./json/quiz_config.json')
            ]);
            
            if (questionsResponse.ok && configResponse.ok) {
                const questionsData = await questionsResponse.json();
                const configData = await configResponse.json();
                
                this.questions = questionsData.questions;
                this.categories = questionsData.categories;
                this.config = configData.settings;
            } else {
                throw new Error('Arquivos não encontrados');
            }
        } catch (error) {
            console.log('📝 Usando dados padrão');
            this.setupFallbackData();
        }
    }
    
    setupFallbackData() {
        this.categories = [
            { id: "antigo_testamento", name: "Antigo Testamento", description: "Perguntas sobre os livros do Antigo Testamento", icon: "📜" },
            { id: "novo_testamento", name: "Novo Testamento", description: "Perguntas sobre os livros do Novo Testamento", icon: "✝️" },
            { id: "vida_jesus", name: "Vida de Jesus", description: "Perguntas sobre a vida e ministério de Jesus Cristo", icon: "👑" },
            { id: "sabedoria", name: "Livros de Sabedoria", description: "Salmos, Provérbios, Eclesiastes", icon: "💡" }
        ];
        
        this.questions = [
            {
                id: 1, category: "antigo_testamento", 
                question: "Quantos dias Deus levou para criar o mundo?",
                options: ["5 dias", "6 dias", "7 dias", "8 dias"], 
                correct: 1,
                explanation: "Gênesis nos conta que Deus criou o mundo em 6 dias e descansou no 7º.",
                verse: "Gênesis 2:2", 
                difficulty: "easy"
            },
            {
                id: 2, category: "novo_testamento",
                question: "Em qual cidade Jesus nasceu?",
                options: ["Nazaré", "Jerusalém", "Belém", "Cafarnaum"], 
                correct: 2,
                explanation: "Jesus nasceu em Belém, cumprindo a profecia.",
                verse: "Mateus 2:1", 
                difficulty: "easy"
            },
            {
                id: 3, category: "vida_jesus",
                question: "Quantos discípulos Jesus escolheu?",
                options: ["10", "11", "12", "13"], 
                correct: 2,
                explanation: "Jesus escolheu 12 discípulos para serem seus apóstolos.",
                verse: "Marcos 3:14", 
                difficulty: "easy"
            },
            {
                id: 4, category: "sabedoria",
                question: "Complete: 'O Senhor é o meu pastor...'",
                options: ["...nada me faltará", "...me guiará", "...me protegerá", "...me abençoará"], 
                correct: 0,
                explanation: "Este é o início do Salmo 23, um dos mais conhecidos da Bíblia.",
                verse: "Salmos 23:1", 
                difficulty: "easy"
            }
        ];
        
        this.config = {
            questions_per_quiz: 4,
            time_per_question: 30,
            points: { easy: 10, medium: 20, hard: 30, bonus_speed: 5 }
        };
    }
    
    setupEventListeners() {
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('quiz-start-btn')) {
                const categoryId = e.target.dataset.category;
                this.startQuiz(categoryId);
            }
            
            if (e.target.classList.contains('quiz-option')) {
                this.selectAnswer(e.target);
            }
            
            if (e.target.classList.contains('quiz-next')) {
                this.nextQuestion();
            }
            
            if (e.target.classList.contains('quiz-restart')) {
                this.renderQuizHome();
            }
        });
    }
    
    renderQuizHome() {
        const container = document.querySelector('#quiz .quiz__container') || 
                         document.querySelector('#quizContainer') || 
                         document.querySelector('.quiz__container');
        
        if (!container) {
            console.error('❌ Container do quiz não encontrado na seção');
            return;
        }
        
        const html = `
            <div class="quiz-home">
                <div class="quiz-stats">
                    <div class="stat-item">
                        <span class="stat-number">${this.userStats.totalQuizzes}</span>
                        <span class="stat-label">Quizzes</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${this.userStats.totalScore}</span>
                        <span class="stat-label">Pontos</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">${Math.round(this.userStats.averageScore)}%</span>
                        <span class="stat-label">Média</span>
                    </div>
                </div>
                
                <div class="quiz-categories">
                    ${this.categories.map(category => {
                        const qCount = this.questions.filter(q => q.category === category.id).length;
                        return `
                            <div class="quiz-category">
                                <div class="category-icon">${category.icon}</div>
                                <h3>${category.name}</h3>
                                <p>${category.description}</p>
                                <div class="category-info">${qCount} perguntas</div>
                                <button class="quiz-start-btn btn btn--primary" data-category="${category.id}">
                                    Iniciar
                                </button>
                            </div>
                        `;
                    }).join('')}
                </div>
            </div>
        `;
        
        container.innerHTML = html;
    }
    
    startQuiz(categoryId) {
        let questions = this.questions.filter(q => q.category === categoryId);
        questions = this.shuffleArray(questions);
        this.currentQuiz = questions.slice(0, this.config.questions_per_quiz);
        
        this.currentQuestionIndex = 0;
        this.score = 0;
        this.userAnswers = [];
        
        this.renderQuestion();
    }
    
    renderQuestion() {
        const container = document.querySelector('#quiz .quiz__container') || 
                         document.querySelector('#quizContainer') || 
                         document.querySelector('.quiz__container');
        
        const question = this.currentQuiz[this.currentQuestionIndex];
        const questionNum = this.currentQuestionIndex + 1;
        const total = this.currentQuiz.length;
        
        this.timeLeft = this.config.time_per_question;
        this.startTimer();
        
        const html = `
            <div class="quiz-question">
                <div class="quiz-progress">
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${(questionNum/total)*100}%"></div>
                    </div>
                    <span class="progress-text">Pergunta ${questionNum} de ${total}</span>
                </div>
                
                <div class="quiz-timer">
                    <div class="timer-circle">
                        <span class="timer-text">${this.timeLeft}s</span>
                    </div>
                </div>
                
                <div class="question-content">
                    <h3>${question.question}</h3>
                    <div class="difficulty ${question.difficulty}">
                        ${question.difficulty === 'easy' ? 'Fácil' : question.difficulty === 'medium' ? 'Médio' : 'Difícil'}
                    </div>
                </div>
                
                <div class="quiz-options">
                    ${question.options.map((option, index) => `
                        <button class="quiz-option" data-index="${index}">
                            <span class="option-letter">${String.fromCharCode(65 + index)}</span>
                            <span class="option-text">${option}</span>
                        </button>
                    `).join('')}
                </div>
            </div>
        `;
        
        container.innerHTML = html;
    }
    
    startTimer() {
        this.stopTimer();
        this.timer = setInterval(() => {
            this.timeLeft--;
            const timerEl = document.querySelector('.timer-text');
            if (timerEl) timerEl.textContent = `${this.timeLeft}s`;
            if (this.timeLeft <= 0) this.timeUp();
        }, 1000);
    }
    
    stopTimer() {
        if (this.timer) {
            clearInterval(this.timer);
            this.timer = null;
        }
    }
    
    selectAnswer(button) {
        const options = document.querySelectorAll('.quiz-option');
        options.forEach(opt => {
            opt.disabled = true;
            opt.classList.remove('selected');
        });
        
        button.classList.add('selected');
        this.stopTimer();
        
        const selectedIndex = parseInt(button.dataset.index);
        this.processAnswer(selectedIndex);
    }
    
    processAnswer(selectedIndex) {
        const question = this.currentQuiz[this.currentQuestionIndex];
        const isCorrect = selectedIndex === question.correct;
        const timeBonus = this.timeLeft > 20 ? this.config.points.bonus_speed : 0;
        
        let points = 0;
        if (isCorrect) {
            points = this.config.points[question.difficulty] + timeBonus;
            this.score += points;
        }
        
        this.userAnswers.push({
            questionId: question.id,
            selectedIndex,
            correct: question.correct,
            isCorrect,
            points,
            timeLeft: this.timeLeft
        });
        
        this.showResult(isCorrect, points, question);
    }
    
    showResult(isCorrect, points, question) {
        const options = document.querySelectorAll('.quiz-option');
        options[question.correct].classList.add('correct');
        
        const selected = document.querySelector('.quiz-option.selected');
        if (!isCorrect && selected) {
            selected.classList.add('incorrect');
        }
        
        const resultHtml = `
            <div class="quiz-result">
                <div class="result-feedback ${isCorrect ? 'correct' : 'incorrect'}">
                    <span>${isCorrect ? '✅ Correto!' : '❌ Incorreto'}</span>
                    ${points > 0 ? ` (+${points} pts)` : ''}
                </div>
                <div class="result-explanation">
                    <p>${question.explanation}</p>
                    ${question.verse ? `<p class="verse"><strong>${question.verse}</strong></p>` : ''}
                </div>
                <button class="quiz-next btn btn--primary">
                    ${this.currentQuestionIndex < this.currentQuiz.length - 1 ? 'Próxima' : 'Resultado'}
                </button>
            </div>
        `;
        
        const container = document.querySelector('#quiz .quiz__container') || 
                         document.querySelector('#quizContainer') || 
                         document.querySelector('.quiz__container');
        container.insertAdjacentHTML('beforeend', resultHtml);
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
        this.processAnswer(-1);
    }
    
    showFinalResult() {
        const total = this.currentQuiz.length;
        const correct = this.userAnswers.filter(a => a.isCorrect).length;
        const percentage = Math.round((correct / total) * 100);
        
        this.updateUserStats(correct, total, this.score);
        
        let message, icon;
        if (percentage >= 80) {
            message = 'Excelente conhecimento das Escrituras!';
            icon = '🏆';
        } else if (percentage >= 60) {
            message = 'Bom trabalho! Continue estudando.';
            icon = '👏';
        } else {
            message = 'Continue se dedicando ao estudo da Palavra.';
            icon = '📖';
        }
        
        const container = document.querySelector('#quiz .quiz__container') || 
                         document.querySelector('#quizContainer') || 
                         document.querySelector('.quiz__container');
        
        const html = `
            <div class="quiz-final">
                <div class="result-header">
                    <div class="result-icon">${icon}</div>
                    <h3>Quiz Concluído!</h3>
                    <p>${message}</p>
                </div>
                
                <div class="result-stats">
                    <div class="result-score">
                        <div class="score-circle">
                            <span class="percentage">${percentage}%</span>
                        </div>
                    </div>
                    
                    <div class="result-details">
                        <div class="detail">
                            <span>Pontuação:</span>
                            <span>${this.score}</span>
                        </div>
                        <div class="detail">
                            <span>Acertos:</span>
                            <span>${correct}/${total}</span>
                        </div>
                    </div>
                </div>
                
                <button class="quiz-restart btn btn--primary">Novo Quiz</button>
            </div>
        `;
        
        container.innerHTML = html;
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
        const saved = localStorage.getItem('quiz-stats');
        if (saved) return JSON.parse(saved);
        return { totalQuizzes: 0, totalScore: 0, totalQuestions: 0, totalCorrect: 0, averageScore: 0 };
    }
    
    updateUserStats(correct, total, score) {
        this.userStats.totalQuizzes++;
        this.userStats.totalScore += score;
        this.userStats.totalQuestions += total;
        this.userStats.totalCorrect += correct;
        this.userStats.averageScore = (this.userStats.totalCorrect / this.userStats.totalQuestions) * 100;
        
        localStorage.setItem('quiz-stats', JSON.stringify(this.userStats));
    }
}

// Inicializar
document.addEventListener('DOMContentLoaded', () => {
    setTimeout(() => {
        if (document.querySelector('#quiz')) {
            window.quizBiblico = new QuizBiblico();
        }
    }, 500);
});
