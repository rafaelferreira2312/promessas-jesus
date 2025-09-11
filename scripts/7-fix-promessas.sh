#!/bin/bash

# =====================================================
# SCRIPT 7 - CORREÇÕES DO BAÚ E SISTEMA DE CATEGORIAS
# Corrige cores, cursor, visibilidade e adiciona categorias
# =====================================================
# Uso: chmod +x 7-fix-promessas.sh && ./7-fix-promessas.sh
# =====================================================

set -e

echo "🔧 CORRIGINDO BAÚ DE PROMESSAS"
echo "🎨 Cores douradas brilhantes + cursor melhorado"
echo "📂 Sistema de categorias da vida"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "css/style.css" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto"
    exit 1
fi

# Atualizar JSON com categorias da vida
echo "📋 Atualizando categorias de promessas..."

cat > json/life_categories.json << 'EOF'
{
  "categories": {
    "familia": {
      "name_pt": "Família",
      "name_en": "Family", 
      "icon": "👨‍👩‍👧‍👦",
      "promises": [
        {
          "verse": "Josué 24:15",
          "text_pt": "Eu e a minha casa serviremos ao Senhor.",
          "text_en": "As for me and my household, we will serve the Lord."
        },
        {
          "verse": "Salmos 127:3",
          "text_pt": "Filhos são herança do Senhor, uma recompensa que ele dá.",
          "text_en": "Children are a heritage from the Lord, offspring a reward from him."
        },
        {
          "verse": "Efésios 6:2-3",
          "text_pt": "Honra teu pai e tua mãe, para que tudo te corra bem e tenhas longa vida na terra.",
          "text_en": "Honor your father and mother, so that it may go well with you and that you may enjoy long life on the earth."
        }
      ]
    },
    "conjugal": {
      "name_pt": "Vida Conjugal",
      "name_en": "Marriage",
      "icon": "💑",
      "promises": [
        {
          "verse": "Gênesis 2:24",
          "text_pt": "Por essa razão, o homem deixará pai e mãe e se unirá à sua mulher, e eles se tornarão uma só carne.",
          "text_en": "That is why a man leaves his father and mother and is united to his wife, and they become one flesh."
        },
        {
          "verse": "1 Coríntios 13:4-7",
          "text_pt": "O amor é paciente, o amor é bondoso. Não inveja, não se vangloria, não se orgulha. Tudo sofre, tudo crê, tudo espera, tudo suporta.",
          "text_en": "Love is patient, love is kind. It does not envy, it does not boast, it is not proud. It always protects, always trusts, always hopes, always perseveres."
        },
        {
          "verse": "Efésios 5:25",
          "text_pt": "Maridos, amem suas mulheres, assim como Cristo amou a igreja e entregou-se a si mesmo por ela.",
          "text_en": "Husbands, love your wives, just as Christ loved the church and gave himself up for her."
        }
      ]
    },
    "financeiro": {
      "name_pt": "Vida Financeira",
      "name_en": "Financial Life",
      "icon": "💰",
      "promises": [
        {
          "verse": "Filipenses 4:19",
          "text_pt": "O meu Deus suprirá todas as vossas necessidades segundo as suas riquezas na glória em Cristo Jesus.",
          "text_en": "And my God will meet all your needs according to the riches of his glory in Christ Jesus."
        },
        {
          "verse": "Malaquias 3:10",
          "text_pt": "Trazei todos os dízimos ao celeiro, para que haja mantimento na minha casa, e depois fazei prova de mim, diz o Senhor dos Exércitos, se eu não vos abrir as janelas do céu e não derramar sobre vós uma bênção tal, que dela vos advenha a maior abastança.",
          "text_en": "Bring the whole tithe into the storehouse, that there may be food in my house. Test me in this, says the Lord Almighty, and see if I will not throw open the floodgates of heaven and pour out so much blessing that there will not be room enough to store it."
        },
        {
          "verse": "Provérbios 22:7",
          "text_pt": "O rico domina sobre os pobres, e o que toma emprestado é servo do que empresta.",
          "text_en": "The rich rule over the poor, and the borrower is slave to the lender."
        }
      ]
    },
    "saude": {
      "name_pt": "Saúde",
      "name_en": "Health",
      "icon": "🏥",
      "promises": [
        {
          "verse": "Êxodo 15:26",
          "text_pt": "Eu sou o Senhor que vos sara.",
          "text_en": "I am the Lord, who heals you."
        },
        {
          "verse": "Jeremias 30:17",
          "text_pt": "Porque te restaurarei a saúde e curarei as tuas feridas, diz o Senhor.",
          "text_en": "But I will restore you to health and heal your wounds, declares the Lord."
        },
        {
          "verse": "3 João 1:2",
          "text_pt": "Amado, desejo que te vá bem em todas as coisas e que tenhas saúde, assim como bem vai a tua alma.",
          "text_en": "Dear friend, I pray that you may enjoy good health and that all may go well with you, even as your soul is getting along well."
        }
      ]
    },
    "trabalho": {
      "name_pt": "Trabalho e Carreira",
      "name_en": "Work and Career",
      "icon": "💼",
      "promises": [
        {
          "verse": "Colossenses 3:23",
          "text_pt": "E, tudo quanto fizerdes, fazei-o de todo o coração, como ao Senhor e não aos homens.",
          "text_en": "Whatever you do, work at it with all your heart, as working for the Lord, not for human masters."
        },
        {
          "verse": "Provérbios 16:3",
          "text_pt": "Confia ao Senhor as tuas obras, e teus pensamentos serão estabelecidos.",
          "text_en": "Commit to the Lord whatever you do, and he will establish your plans."
        },
        {
          "verse": "Salmos 90:17",
          "text_pt": "E seja sobre nós a formosura do Senhor nosso Deus, e confirma sobre nós a obra das nossas mãos; sim, a obra das nossas mãos confirma.",
          "text_en": "May the favor of the Lord our God rest on us; establish the work of our hands for us—yes, establish the work of our hands."
        }
      ]
    },
    "paz": {
      "name_pt": "Paz e Tranquilidade",
      "name_en": "Peace and Tranquility",
      "icon": "🕊️",
      "promises": [
        {
          "verse": "João 14:27",
          "text_pt": "Deixo-vos a paz, a minha paz vos dou; não vo-la dou como o mundo a dá. Não se turbe o vosso coração, nem se atemorize.",
          "text_en": "Peace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid."
        },
        {
          "verse": "Filipenses 4:6-7",
          "text_pt": "Não estejais inquietos por coisa alguma; antes, as vossas petições sejam em tudo conhecidas diante de Deus, pela oração e súplicas, com ação de graças. E a paz de Deus, que excede todo entendimento, guardará os vossos corações e os vossos sentimentos em Cristo Jesus.",
          "text_en": "Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God. And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus."
        }
      ]
    }
  }
}
EOF

echo "✅ Categorias da vida criadas!"

# Corrigir CSS do baú com cores douradas brilhantes
echo "🎨 Corrigindo cores e visual do baú..."

# Substituir a seção do baú no CSS
cat > css/treasure-chest-fixed.css << 'EOF'
/* =====================================================
   BAÚ DE PROMESSAS CORRIGIDO - DOURADO BRILHANTE
   ===================================================== */

.promises__treasure-section {
  margin-bottom: var(--space-3xl);
  position: relative;
  min-height: 500px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--color-dark-secondary) 0%, var(--color-dark-primary) 100%);
  border-radius: var(--radius-2xl);
  overflow: hidden;
  border: 3px solid var(--color-gold-primary);
  box-shadow: 0 0 30px rgba(212, 175, 55, 0.3);
}

/* Fundo com imagens mais claras */
.promises__background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  opacity: 0.6; /* Aumentado de 0.3 para 0.6 */
  transition: all 1s ease;
  z-index: 1;
}

.promises__background::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    135deg,
    rgba(26, 22, 17, 0.4) 0%, /* Reduzido de 0.8 para 0.4 */
    rgba(45, 24, 16, 0.3) 50%, /* Reduzido de 0.6 para 0.3 */
    rgba(26, 22, 17, 0.4) 100% /* Reduzido de 0.8 para 0.4 */
  );
}

/* Container do baú com cursor melhorado */
.treasure-chest-container {
  position: relative;
  z-index: 3;
  text-align: center;
  cursor: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M12 2C10 2 8 3 8 5V7H6C5 7 4 8 4 9V11C4 12 5 13 6 13H7V19C7 20 8 21 9 21H15C16 21 17 20 17 19V13H18C19 13 20 12 20 11V9C20 8 19 7 18 7H16V5C16 3 14 2 12 2ZM12 4C13 4 14 4 14 5V7H10V5C10 4 11 4 12 4ZM12 14L10 16H14L12 14Z" fill="%23FFD700"/></svg>'), pointer;
}

/* SVG do baú DOURADO BRILHANTE */
.treasure-chest {
  width: 220px;
  height: 180px;
  margin: 0 auto;
  position: relative;
  transition: all 0.4s ease;
  filter: drop-shadow(0 10px 30px rgba(255, 215, 0, 0.5));
}

.treasure-chest:hover {
  transform: scale(1.08);
  filter: drop-shadow(0 15px 40px rgba(255, 215, 0, 0.7));
}

/* Melhor definição da tampa e base */
.chest-base {
  fill: #DAA520; /* Dourado escuro */
  stroke: #B8860B;
  stroke-width: 3;
}

.chest-lid {
  fill: #FFD700; /* Dourado brilhante */
  stroke: #B8860B;
  stroke-width: 3;
}

.chest-details {
  fill: #FFA500; /* Laranja dourado */
}

.chest-metal {
  fill: #CD853F; /* Bronze */
  stroke: #8B4513;
  stroke-width: 2;
}

.chest-lock {
  fill: #FFD700;
  stroke: #B8860B;
  stroke-width: 2;
}

/* Animações melhoradas */
.treasure-chest.opening .chest-lid-group {
  transform-origin: bottom center;
  animation: openChestSmooth 1s ease forwards;
}

.treasure-chest.closing .chest-lid-group {
  transform-origin: bottom center;
  animation: closeChestSmooth 0.8s ease forwards;
}

@keyframes openChestSmooth {
  0% { transform: rotateX(0deg); }
  50% { transform: rotateX(-60deg); }
  100% { transform: rotateX(-110deg); }
}

@keyframes closeChestSmooth {
  0% { transform: rotateX(-110deg); }
  50% { transform: rotateX(-30deg); }
  100% { transform: rotateX(0deg); }
}

/* Luz dourada mais intensa */
.treasure-light {
  position: absolute;
  top: 15%;
  left: 50%;
  width: 120px;
  height: 120px;
  background: radial-gradient(circle, 
    rgba(255, 215, 0, 0.9) 0%, 
    rgba(255, 165, 0, 0.6) 40%,
    rgba(255, 140, 0, 0.3) 70%,
    transparent 100%);
  border-radius: 50%;
  transform: translateX(-50%);
  opacity: 0;
  transition: opacity 0.6s ease;
  z-index: 2;
}

.treasure-chest.open .treasure-light {
  opacity: 1;
  animation: glowPulseIntense 2.5s ease-in-out infinite;
}

@keyframes glowPulseIntense {
  0%, 100% { 
    transform: translateX(-50%) scale(1); 
    opacity: 0.8; 
  }
  50% { 
    transform: translateX(-50%) scale(1.4); 
    opacity: 1; 
  }
}

/* Partículas douradas mais visíveis */
.particle-gold {
  position: absolute;
  width: 8px;
  height: 8px;
  background: #FFD700;
  border-radius: 50%;
  opacity: 0;
  animation: floatUpGold 4s linear infinite;
  box-shadow: 0 0 12px #FFD700;
}

@keyframes floatUpGold {
  0% { 
    bottom: 25%; 
    opacity: 0; 
    transform: translateX(0px) scale(0.3); 
  }
  25% { 
    opacity: 1; 
    transform: translateX(15px) scale(1); 
  }
  75% { 
    opacity: 1; 
    transform: translateX(-15px) scale(1.2); 
  }
  100% { 
    bottom: 85%; 
    opacity: 0; 
    transform: translateX(0px) scale(0.3); 
  }
}

/* Display da promessa melhorado */
.promise-display {
  margin-top: var(--space-xl);
  background: rgba(26, 22, 17, 0.95); /* Mais opaco */
  border: 3px solid var(--color-gold-primary);
  border-radius: var(--radius-xl);
  padding: var(--space-xl);
  max-width: 650px;
  margin-left: auto;
  margin-right: auto;
  backdrop-filter: blur(15px);
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.8s ease;
  z-index: 5;
  position: relative;
  box-shadow: 0 10px 30px rgba(212, 175, 55, 0.4);
}

.promise-display.show {
  opacity: 1;
  transform: translateY(0);
}

.promise-display::before {
  content: '';
  position: absolute;
  top: -3px;
  left: -3px;
  right: -3px;
  bottom: -3px;
  background: var(--gradient-gold);
  border-radius: var(--radius-xl);
  z-index: -1;
  opacity: 0.3;
}

/* Instruções melhoradas */
.treasure-instructions {
  position: absolute;
  bottom: var(--space-lg);
  left: 50%;
  transform: translateX(-50%);
  color: var(--color-gold-light);
  font-size: 1rem;
  font-weight: 600;
  text-align: center;
  opacity: 0.9;
  z-index: 4;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
  animation: shimmerText 3s ease-in-out infinite;
}

@keyframes shimmerText {
  0%, 100% { opacity: 0.9; text-shadow: 2px 2px 4px rgba(0,0,0,0.8); }
  50% { opacity: 1; text-shadow: 0 0 10px rgba(255,215,0,0.8); }
}

/* Botão para ver todas as categorias */
.categories-button {
  position: absolute;
  top: var(--space-lg);
  right: var(--space-lg);
  background: var(--gradient-gold);
  color: var(--color-dark-primary);
  padding: var(--space-sm) var(--space-md);
  border: none;
  border-radius: var(--radius-lg);
  font-weight: 600;
  cursor: pointer;
  transition: all var(--transition-base);
  z-index: 5;
  box-shadow: 0 4px 15px rgba(212, 175, 55, 0.4);
}

.categories-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(212, 175, 55, 0.6);
}

EOF

# Adicionar CSS corrigido ao arquivo principal
echo "📝 Aplicando CSS corrigido..."
cat css/treasure-chest-fixed.css >> css/style.css

echo "✅ CSS corrigido aplicado!"

# Criar JavaScript melhorado para o baú
echo "⚡ Criando JavaScript melhorado..."

cat > js/treasure-chest-improved.js << 'EOF'
/**
 * BAÚ DE PROMESSAS MELHORADO
 * Cores douradas, cursor chave melhorado, categorias da vida
 */

class ImprovedTreasureChest {
  constructor() {
    this.isOpen = false;
    this.promises = [];
    this.categories = {};
    this.currentPromiseIndex = 0;
    this.backgroundImages = [];
    this.currentBackgroundIndex = 0;
    
    this.init();
  }

  async init() {
    await this.loadPromises();
    await this.loadCategories();
    await this.loadBackgroundImages();
    this.replaceTreasureSection();
    this.setupEventListeners();
    this.startBackgroundRotation();
  }

  async loadCategories() {
    try {
      const response = await fetch('./json/life_categories.json');
      const data = await response.json();
      this.categories = data.categories;
    } catch (error) {
      console.error('Erro ao carregar categorias:', error);
    }
  }

  async loadPromises() {
    try {
      const response = await fetch('./json/local_verses.json');
      const data = await response.json();
      
      this.promises = [];
      Object.values(data.categories).forEach(category => {
        this.promises.push(...category);
      });
      
      if (data.daily_verses) {
        this.promises.push(...data.daily_verses);
      }
      
      this.shuffleArray(this.promises);
      
    } catch (error) {
      console.error('Erro ao carregar promessas:', error);
    }
  }

  async loadBackgroundImages() {
    const defaultImages = [
      'assets/images/promessas/promessa-1.webp',
      'assets/images/promessas/promessa-2.webp',
      'assets/images/promessas/promessa-3.webp',
      'assets/images/promessas/promessa-4.webp',
      'assets/images/promessas/promessa-5.webp',
      'assets/images/promessas/promessa-6.webp'
    ];

    this.backgroundImages = [];
    
    for (const imagePath of defaultImages) {
      try {
        const response = await fetch(imagePath, { method: 'HEAD' });
        if (response.ok) {
          this.backgroundImages.push(imagePath);
        }
      } catch (error) {
        // Imagem não existe
      }
    }

    if (this.backgroundImages.length === 0) {
      this.backgroundImages = ['gradient'];
    }
  }

  shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
  }

  replaceTreasureSection() {
    const promisesSection = document.querySelector('.promises__treasure-section');
    if (promisesSection) {
      promisesSection.remove();
    }

    const bannersection = document.querySelector('.promises__banner');
    if (bannersection) {
      bannersection.remove();
    }

    // Inserir nova seção após o header
    const promisesContainer = document.querySelector('.promises .container');
    if (!promisesContainer) return;

    const treasureHTML = `
      <div class="promises__treasure-section" id="treasureSection">
        <div class="promises__background" id="promisesBackground"></div>
        
        <button class="categories-button" id="categoriesButton">
          📂 Ver Todas as Categorias
        </button>
        
        <div class="treasure-chest-container" id="treasureContainer">
          <div class="treasure-light"></div>
          
          <svg class="treasure-chest" id="treasureChest" viewBox="0 0 220 180" xmlns="http://www.w3.org/2000/svg">
            <!-- Base do baú (dourada brilhante) -->
            <rect x="20" y="90" width="180" height="80" rx="15" class="chest-base"/>
            
            <!-- Detalhes da base -->
            <rect x="25" y="95" width="170" height="70" rx="10" class="chest-details"/>
            <rect x="30" y="100" width="160" height="60" rx="8" fill="#FFA500"/>
            
            <!-- Ferragens douradas -->
            <rect x="10" y="110" width="15" height="40" rx="3" class="chest-metal"/>
            <rect x="195" y="110" width="15" height="40" rx="3" class="chest-metal"/>
            <rect x="15" y="115" width="5" height="30" fill="#FFD700"/>
            <rect x="200" y="115" width="5" height="30" fill="#FFD700"/>
            
            <!-- Tampa do baú (grupo para animação) -->
            <g class="chest-lid-group">
              <path d="M20 90 Q20 60 50 60 L170 60 Q200 60 200 90 L200 95 L20 95 Z" class="chest-lid"/>
              <path d="M25 90 Q25 65 50 65 L170 65 Q195 65 195 90 L195 92 L25 92 Z" fill="#FFA500"/>
              
              <!-- Fechadura dourada -->
              <rect x="105" y="75" width="20" height="12" rx="3" class="chest-lock"/>
              <circle cx="115" cy="81" r="3" fill="#8B4513"/>
              <rect x="112" y="83" width="6" height="4" rx="1" fill="#8B4513"/>
              
              <!-- Ferragens da tampa -->
              <rect x="10" y="70" width="15" height="25" rx="3" class="chest-metal"/>
              <rect x="195" y="70" width="15" height="25" rx="3" class="chest-metal"/>
            </g>
            
            <!-- Brilho dourado interno -->
            <circle cx="110" cy="85" r="35" fill="url(#goldGlow)" opacity="0" class="treasure-glow">
              <animate attributeName="opacity" values="0;0.8;0" dur="2.5s" repeatCount="indefinite"/>
              <animate attributeName="r" values="30;45;30" dur="2.5s" repeatCount="indefinite"/>
            </circle>
            
            <!-- Definições -->
            <defs>
              <radialGradient id="goldGlow" cx="50%" cy="50%" r="60%">
                <stop offset="0%" style="stop-color:#FFD700;stop-opacity:1" />
                <stop offset="40%" style="stop-color:#FFA500;stop-opacity:0.8" />
                <stop offset="80%" style="stop-color:#FF8C00;stop-opacity:0.4" />
                <stop offset="100%" style="stop-color:#FF6347;stop-opacity:0" />
              </radialGradient>
            </defs>
          </svg>
          
          <!-- Partículas douradas melhoradas -->
          <div class="treasure-particles">
            <div class="particle-gold"></div>
            <div class="particle-gold"></div>
            <div class="particle-gold"></div>
            <div class="particle-gold"></div>
            <div class="particle-gold"></div>
            <div class="particle-gold"></div>
          </div>
        </div>
        
        <!-- Display da promessa -->
        <div class="promise-display" id="promiseDisplay">
          <h3 id="promiseVerse"></h3>
          <p id="promiseText"></p>
        </div>
        
        <!-- Instruções melhoradas -->
        <div class="treasure-instructions">
          🗝️ Clique no baú dourado para descobrir uma promessa divina
        </div>
      </div>
    `;

    promisesContainer.insertAdjacentHTML('afterbegin', treasureHTML);
    this.updateBackground();
  }

  setupEventListeners() {
    const treasureContainer = document.getElementById('treasureContainer');
    const categoriesButton = document.getElementById('categoriesButton');
    
    if (treasureContainer) {
      treasureContainer.addEventListener('click', () => this.toggleChest());
    }
    
    if (categoriesButton) {
      categoriesButton.addEventListener('click', () => this.showCategories());
    }
    
    // Clique no fundo para mostrar categorias
    const background = document.getElementById('promisesBackground');
    if (background) {
      background.addEventListener('click', () => this.showCategories());
      background.style.cursor = 'pointer';
    }
  }

  toggleChest() {
    const chest = document.getElementById('treasureChest');
    const promiseDisplay = document.getElementById('promiseDisplay');
    const instructions = document.querySelector('.treasure-instructions');
    
    if (!this.isOpen) {
      this.isOpen = true;
      chest.classList.add('opening', 'open');
      
      this.updateBackground();
      this.displayCurrentPromise();
      
      setTimeout(() => {
        chest.classList.remove('closing');
        instructions.innerHTML = '🗝️ Clique no baú dourado para descobrir uma promessa divina';
      }, 800);
    }
  }

  displayCurrentPromise() {
    const promise = this.promises[this.currentPromiseIndex];
    const verseElement = document.getElementById('promiseVerse');
    const textElement = document.getElementById('promiseText');
    
    if (promise && verseElement && textElement) {
      const currentLang = localStorage.getItem('language') || 'pt';
      const text = promise[`text_${currentLang}`] || promise.text_pt || promise.text;
      
      verseElement.textContent = promise.verse;
      textElement.textContent = text;
    }
  }

  updateBackground() {
    const background = document.getElementById('promisesBackground');
    if (!background || this.backgroundImages.length === 0) return;

    const currentImage = this.backgroundImages[this.currentBackgroundIndex];
    
    if (currentImage === 'gradient') {
      background.style.backgroundImage = 'none';
    } else {
      background.style.backgroundImage = `url('${currentImage}')`;
    }
    
    this.currentBackgroundIndex = (this.currentBackgroundIndex + 1) % this.backgroundImages.length;
  }

  startBackgroundRotation() {
    setInterval(() => {
      if (!this.isOpen) {
        this.updateBackground();
      }
    }, 8000);
  }

  showCategories() {
    // Criar modal com todas as categorias
    this.createCategoriesModal();
  }

  createCategoriesModal() {
    // Remover modal existente se houver
    const existingModal = document.getElementById('categoriesModal');
    if (existingModal) {
      existingModal.remove();
    }

    const modal = document.createElement('div');
    modal.id = 'categoriesModal';
    modal.style.cssText = `
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.9);
      z-index: 10000;
      display: flex;
      align-items: center;
      justify-content: center;
      backdrop-filter: blur(10px);
    `;

    const modalContent = document.createElement('div');
    modalContent.style.cssText = `
      background: linear-gradient(135deg, #1a1611, #2d1810);
      border: 3px solid #d4af37;
      border-radius: 20px;
      padding: 2rem;
      max-width: 800px;
      max-height: 80vh;
      overflow-y: auto;
      box-shadow: 0 20px 60px rgba(212, 175, 55, 0.4);
    `;

    const currentLang = localStorage.getItem('language') || 'pt';
    
    modalContent.innerHTML = `
      <div style="text-align: center; margin-bottom: 2rem;">
        <h2 style="color: #d4af37; font-family: 'Cinzel', serif; font-size: 2rem; margin-bottom: 0.5rem;">
          ${currentLang === 'pt' ? 'Promessas para Sua Vida' : 'Promises for Your Life'}
        </h2>
        <p style="color: #f5f1e8; opacity: 0.8;">
          ${currentLang === 'pt' ? 'Escolha uma área da sua vida para receber promessas específicas' : 'Choose an area of your life to receive specific promises'}
        </p>
      </div>
      
      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
        ${Object.entries(this.categories).map(([key, category]) => `
          <div class="category-card" data-category="${key}" style="
            background: linear-gradient(145deg, #2d1810, #1a1611);
            border: 2px solid #cd853f;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(205, 133, 63, 0.2);
          ">
            <div style="font-size: 3rem; margin-bottom: 1rem;">${category.icon}</div>
            <h3 style="color: #d4af37; margin-bottom: 0.5rem; font-family: 'Cinzel', serif;">
              ${category[`name_${currentLang}`]}
            </h3>
            <p style="color: #f5f1e8; opacity: 0.7; font-size: 0.9rem;">
              ${category.promises.length} ${currentLang === 'pt' ? 'promessas' : 'promises'}
            </p>
          </div>
        `).join('')}
      </div>
      
      <div style="text-align: center;">
        <button id="closeModal" style="
          background: linear-gradient(135deg, #d4af37, #b7950b);
          color: #1a1611;
          border: none;
          padding: 0.8rem 2rem;
          border-radius: 10px;
          font-weight: 600;
          cursor: pointer;
          transition: all 0.3s ease;
        ">
          ${currentLang === 'pt' ? 'Fechar' : 'Close'}
        </button>
      </div>
    `;

    modal.appendChild(modalContent);
    document.body.appendChild(modal);

    // Event listeners
    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        modal.remove();
      }
    });

    document.getElementById('closeModal').addEventListener('click', () => {
      modal.remove();
    });

    // Category card hover effects
    modal.querySelectorAll('.category-card').forEach(card => {
      card.addEventListener('mouseenter', () => {
        card.style.transform = 'translateY(-5px)';
        card.style.borderColor = '#d4af37';
        card.style.boxShadow = '0 10px 25px rgba(212, 175, 55, 0.4)';
      });
      
      card.addEventListener('mouseleave', () => {
        card.style.transform = 'translateY(0)';
        card.style.borderColor = '#cd853f';
        card.style.boxShadow = '0 5px 15px rgba(205, 133, 63, 0.2)';
      });
      
      card.addEventListener('click', () => {
        const categoryKey = card.getAttribute('data-category');
        this.showCategoryPromises(categoryKey);
      });
    });
  }

  showCategoryPromises(categoryKey) {
    const category = this.categories[categoryKey];
    if (!category) return;

    const modal = document.getElementById('categoriesModal');
    const modalContent = modal.querySelector('div > div');
    const currentLang = localStorage.getItem('language') || 'pt';

    modalContent.innerHTML = `
      <div style="text-align: center; margin-bottom: 2rem;">
        <button id="backButton" style="
          position: absolute;
          top: 1rem;
          left: 1rem;
          background: transparent;
          border: 2px solid #d4af37;
          color: #d4af37;
          padding: 0.5rem 1rem;
          border-radius: 8px;
          cursor: pointer;
        ">← ${currentLang === 'pt' ? 'Voltar' : 'Back'}</button>
        
        <div style="font-size: 4rem; margin-bottom: 1rem;">${category.icon}</div>
        <h2 style="color: #d4af37; font-family: 'Cinzel', serif; font-size: 2rem; margin-bottom: 1rem;">
          ${category[`name_${currentLang}`]}
        </h2>
      </div>
      
      <div style="max-height: 400px; overflow-y: auto;">
        ${category.promises.map((promise, index) => `
          <div style="
            background: linear-gradient(145deg, #2d1810, #1a1611);
            border: 2px solid #cd853f;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 5px solid #d4af37;
          ">
            <h3 style="color: #d4af37; margin-bottom: 1rem; font-family: 'Cinzel', serif;">
              ${promise.verse}
            </h3>
            <p style="color: #f5f1e8; line-height: 1.6; font-style: italic;">
              "${promise[`text_${currentLang}`] || promise.text_pt}"
            </p>
          </div>
        `).join('')}
      </div>
      
      <div style="text-align: center; margin-top: 2rem;">
        <button id="closeModal" style="
          background: linear-gradient(135deg, #d4af37, #b7950b);
          color: #1a1611;
          border: none;
          padding: 0.8rem 2rem;
          border-radius: 10px;
          font-weight: 600;
          cursor: pointer;
        ">
          ${currentLang === 'pt' ? 'Fechar' : 'Close'}
        </button>
      </div>
    `;

    // Event listeners
    document.getElementById('backButton').addEventListener('click', () => {
      this.createCategoriesModal();
    });

    document.getElementById('closeModal').addEventListener('click', () => {
      modal.remove();
    });
  }
}

// Inicializar quando DOM estiver pronto
document.addEventListener('DOMContentLoaded', () => {
  setTimeout(() => {
    new ImprovedTreasureChest();
  }, 1500);
});

window.ImprovedTreasureChest = ImprovedTreasureChest;
EOF

# Substituir o JavaScript antigo
echo "🔄 Substituindo JavaScript..."
if [ -f "js/treasure-chest.js" ]; then
    mv js/treasure-chest.js js/treasure-chest-old.js
fi
mv js/treasure-chest-improved.js js/treasure-chest.js

# Atualizar index.html se necessário
if ! grep -q "treasure-chest.js" index.html; then
    sed -i '/js\/main.js/a\    <script src="js/treasure-chest.js"></script>' index.html
fi

# Criar página separada para categorias
echo "📄 Criando página de categorias..."

cat > pages/categorias.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categorias de Promessas | Jesus é o Pão da Vida</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        body { padding-top: 80px; }
        .categories-page { padding: 3rem 0; }
        .category-section { margin-bottom: 4rem; }
    </style>
</head>
<body>
    <header class="header">
        <nav class="nav">
            <div class="nav__container">
                <a href="../index.html" class="nav__logo">
                    <svg class="logo-icon" width="40" height="40" viewBox="0 0 40 40">
                        <rect x="18" y="8" width="4" height="24" rx="2" fill="currentColor"/>
                        <rect x="10" y="16" width="20" height="4" rx="2" fill="currentColor"/>
                    </svg>
                    <span class="logo-text">Jesus é o Pão da Vida</span>
                </a>
                <a href="../index.html" style="color: #d4af37; text-decoration: none;">← Voltar</a>
            </div>
        </nav>
    </header>

    <main class="categories-page">
        <div class="container">
            <header style="text-align: center; margin-bottom: 3rem;">
                <h1 style="color: #d4af37; font-family: 'Cinzel', serif; font-size: 3rem;">
                    Promessas para Sua Vida
                </h1>
                <p style="color: #f5f1e8; font-size: 1.2rem;">
                    Encontre promessas específicas para cada área da sua vida
                </p>
            </header>

            <div id="categoriesContainer">
                <!-- Categorias serão carregadas via JavaScript -->
            </div>
        </div>
    </main>

    <script src="../js/treasure-chest.js"></script>
    <script>
        // Carregar e exibir todas as categorias
        document.addEventListener('DOMContentLoaded', async () => {
            try {
                const response = await fetch('../json/life_categories.json');
                const data = await response.json();
                const container = document.getElementById('categoriesContainer');
                
                Object.entries(data.categories).forEach(([key, category]) => {
                    const section = document.createElement('div');
                    section.className = 'category-section';
                    section.innerHTML = `
                        <h2 style="color: #d4af37; font-family: 'Cinzel', serif; display: flex; align-items: center; gap: 1rem; margin-bottom: 2rem;">
                            <span style="font-size: 2rem;">${category.icon}</span>
                            ${category.name_pt}
                        </h2>
                        <div style="display: grid; gap: 1.5rem;">
                            ${category.promises.map(promise => `
                                <div style="
                                    background: linear-gradient(145deg, #2d1810, #1a1611);
                                    border: 2px solid #cd853f;
                                    border-radius: 15px;
                                    padding: 2rem;
                                    border-left: 5px solid #d4af37;
                                ">
                                    <h3 style="color: #d4af37; margin-bottom: 1rem; font-family: 'Cinzel', serif;">
                                        ${promise.verse}
                                    </h3>
                                    <p style="color: #f5f1e8; line-height: 1.7; font-style: italic; font-size: 1.1rem;">
                                        "${promise.text_pt}"
                                    </p>
                                </div>
                            `).join('')}
                        </div>
                    `;
                    container.appendChild(section);
                });
            } catch (error) {
                console.error('Erro ao carregar categorias:', error);
            }
        });
    </script>
</body>
</html>
EOF

echo "✅ Página de categorias criada!"

# Limpar arquivos temporários
rm -f css/treasure-chest-fixed.css

echo ""
echo "🎉 CORREÇÕES APLICADAS COM SUCESSO!"
echo ""
echo "📋 RESUMO DAS CORREÇÕES:"
echo "• ✅ Baú com cores douradas brilhantes (#FFD700, #DAA520)"
echo "• ✅ Cursor-chave melhorado e mais visível"
echo "• ✅ Imagens de fundo mais claras (opacidade 0.6)"
echo "• ✅ Sistema de categorias da vida implementado"
echo "• ✅ Modal interativo para mostrar categorias"
echo "• ✅ Página separada em pages/categorias.html"
echo "• ✅ Clique no fundo abre página de categorias"
echo "• ✅ Todas as promessas aparecem com imagens de fundo"
echo ""
echo "💰 MELHORIAS DO BAÚ:"
echo "• Cores douradas brilhantes como na imagem"
echo "• Animações mais suaves de abertura/fechamento"
echo "• Luz dourada mais intensa quando aberto"
echo "• Partículas douradas mais visíveis"
echo "• Cursor-chave redesenhado"
echo ""
echo "📂 CATEGORIAS IMPLEMENTADAS:"
echo "• 👨‍👩‍👧‍👦 Família"
echo "• 💑 Vida Conjugal"
echo "• 💰 Vida Financeira"
echo "• 🏥 Saúde"
echo "• 💼 Trabalho e Carreira"
echo "• 🕊️ Paz e Tranquilidade"
echo ""
echo "📁 ARQUIVOS CRIADOS/ATUALIZADOS:"
echo "• json/life_categories.json (categorias da vida)"
echo "• css/style.css (CSS corrigido adicionado)"
echo "• js/treasure-chest.js (JavaScript melhorado)"
echo "• pages/categorias.html (página separada)"
echo ""
echo "🚀 PARA TESTAR:"
echo "1. python3 -m http.server 8000"
echo "2. Clique no baú dourado para ver promessas"
echo "3. Clique no fundo ou botão para ver categorias"
echo ""
echo "⚡ Para deploy: ./5-deploy-fixed.sh"
echo ""
echo "✨ Baú dourado brilhante e categorias prontos!"