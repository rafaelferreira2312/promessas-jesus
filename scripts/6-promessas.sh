#!/bin/bash

# =====================================================
# SCRIPT 6 - BAÚ DE PROMESSAS INTERATIVO
# Substitui banner por baú de tesouro com promessas individuais
# =====================================================
# Uso: chmod +x 6-promessas.sh && ./6-promessas.sh
# =====================================================

set -e

echo "💰 CRIANDO BAÚ DE PROMESSAS INTERATIVO"
echo "🗝️ Sistema de cursor chave + baú animado"
echo "🖼️ Imagens de fundo aleatórias das promessas"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "css/style.css" ] || [ ! -f "js/main.js" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto (onde existe css/ e js/)"
    exit 1
fi

# Criar pasta para imagens das promessas
echo "📁 Criando pasta para imagens das promessas..."
mkdir -p assets/images/promessas

# Criar arquivo README para as imagens
cat > assets/images/promessas/README.md << 'EOF'
# IMAGENS DAS PROMESSAS

## Pasta: assets/images/promessas/

Coloque aqui imagens relacionadas às promessas bíblicas que serão usadas como fundo:

### Sugestões de imagens:
- promessa-1.webp (paisagem serena, luz divina)
- promessa-2.webp (mãos em oração)
- promessa-3.webp (natureza, paz)
- promessa-4.webp (cruz no por do sol)
- promessa-5.webp (céu com nuvens douradas)
- promessa-6.webp (caminho de luz)

### Formato recomendado:
- Formato: WebP (otimizado)
- Tamanho: 800x600px ou similar
- Qualidade: Alta para fundos suaves
- Cores: Tons dourados/terrosos harmoniosos

### Como funciona:
- As imagens serão carregadas aleatoriamente como fundo
- Cada vez que o baú abrir, uma nova imagem pode aparecer
- O texto da promessa ficará sobreposto com legibilidade garantida
EOF

echo "✅ Pasta e instruções criadas!"

# Adicionar CSS para o baú de tesouros
echo "🎨 Adicionando CSS do baú de tesouros..."

cat >> css/style.css << 'EOF'

/* =====================================================
   BAÚ DE PROMESSAS INTERATIVO
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
  border: 2px solid var(--color-gold-primary);
}

/* Fundo com imagens aleatórias */
.promises__background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  opacity: 0.3;
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
    rgba(26, 22, 17, 0.8) 0%,
    rgba(45, 24, 16, 0.6) 50%,
    rgba(26, 22, 17, 0.8) 100%
  );
}

/* Container do baú */
.treasure-chest-container {
  position: relative;
  z-index: 3;
  text-align: center;
  cursor: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAzMiAzMiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTggMTZMMTYgOEwyNCA0TDI4IDhMMjAgMTZMMjggMjRMMjQgMjhMMTYgMjBMOCAyNEw0IDIwTDEyIDEyTDQgNEw4IDE2WiIgZmlsbD0iI2Q0YWYzNyIvPgo8L3N2Zz4K'), auto;
}

/* SVG do baú de tesouro */
.treasure-chest {
  width: 200px;
  height: 160px;
  margin: 0 auto;
  position: relative;
  transition: all 0.4s ease;
  filter: drop-shadow(0 10px 30px rgba(212, 175, 55, 0.4));
}

.treasure-chest:hover {
  transform: scale(1.05);
  filter: drop-shadow(0 15px 40px rgba(212, 175, 55, 0.6));
}

/* Animação de abertura do baú */
.treasure-chest.opening .chest-lid {
  transform-origin: bottom;
  animation: openChest 0.8s ease forwards;
}

.treasure-chest.closing .chest-lid {
  transform-origin: bottom;
  animation: closeChest 0.6s ease forwards;
}

@keyframes openChest {
  0% { transform: rotateX(0deg); }
  100% { transform: rotateX(-120deg); }
}

@keyframes closeChest {
  0% { transform: rotateX(-120deg); }
  100% { transform: rotateX(0deg); }
}

/* Luz dourada saindo do baú */
.treasure-light {
  position: absolute;
  top: 20%;
  left: 50%;
  width: 100px;
  height: 100px;
  background: radial-gradient(circle, var(--color-gold-light) 0%, transparent 70%);
  border-radius: 50%;
  transform: translateX(-50%);
  opacity: 0;
  transition: opacity 0.5s ease;
  z-index: 1;
}

.treasure-chest.open .treasure-light {
  opacity: 0.8;
  animation: glowPulse 2s ease-in-out infinite;
}

@keyframes glowPulse {
  0%, 100% { transform: translateX(-50%) scale(1); opacity: 0.8; }
  50% { transform: translateX(-50%) scale(1.3); opacity: 1; }
}

/* Partículas douradas */
.treasure-particles {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
  z-index: 2;
}

.particle-gold {
  position: absolute;
  width: 6px;
  height: 6px;
  background: var(--color-gold-light);
  border-radius: 50%;
  opacity: 0;
  animation: floatUp 3s linear infinite;
  box-shadow: 0 0 8px var(--color-gold-light);
}

.particle-gold:nth-child(1) { left: 30%; animation-delay: 0s; }
.particle-gold:nth-child(2) { left: 50%; animation-delay: 0.5s; }
.particle-gold:nth-child(3) { left: 70%; animation-delay: 1s; }
.particle-gold:nth-child(4) { left: 40%; animation-delay: 1.5s; }
.particle-gold:nth-child(5) { left: 60%; animation-delay: 2s; }

@keyframes floatUp {
  0% { 
    bottom: 30%; 
    opacity: 0; 
    transform: translateY(0px) scale(0.5); 
  }
  20% { 
    opacity: 1; 
    transform: translateY(-20px) scale(1); 
  }
  80% { 
    opacity: 1; 
    transform: translateY(-80px) scale(1); 
  }
  100% { 
    bottom: 80%; 
    opacity: 0; 
    transform: translateY(-100px) scale(0.5); 
  }
}

/* Texto da promessa */
.promise-display {
  margin-top: var(--space-xl);
  background: rgba(26, 22, 17, 0.9);
  border: 2px solid var(--color-gold-primary);
  border-radius: var(--radius-xl);
  padding: var(--space-xl);
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
  backdrop-filter: blur(10px);
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
  z-index: 4;
  position: relative;
}

.promise-display.show {
  opacity: 1;
  transform: translateY(0);
}

.promise-display h3 {
  color: var(--color-gold-primary);
  font-size: 1.5rem;
  margin-bottom: var(--space-md);
  font-family: var(--font-sacred);
  text-align: center;
}

.promise-display p {
  color: var(--color-cream);
  font-size: 1.125rem;
  line-height: 1.7;
  font-style: italic;
  text-align: center;
  margin: 0;
}

/* Instruções para o usuário */
.treasure-instructions {
  position: absolute;
  bottom: var(--space-lg);
  left: 50%;
  transform: translateX(-50%);
  color: var(--color-gold-primary);
  font-size: 0.875rem;
  text-align: center;
  opacity: 0.8;
  z-index: 4;
  animation: fadeInOut 3s ease-in-out infinite;
}

@keyframes fadeInOut {
  0%, 100% { opacity: 0.8; }
  50% { opacity: 0.4; }
}

/* Estados do cursor */
.treasure-chest-container {
  cursor: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"><path d="M16 2L12 6L8 2L4 6L8 10L4 14L8 18L12 14L16 18L20 14L24 18L28 14L24 10L28 6L24 2L20 6L16 2Z" fill="%23d4af37"/></svg>'), pointer;
}

/* Responsivo */
@media (max-width: 768px) {
  .treasure-chest {
    width: 150px;
    height: 120px;
  }
  
  .promise-display {
    margin: var(--space-lg);
    padding: var(--space-lg);
  }
  
  .promise-display h3 {
    font-size: 1.25rem;
  }
  
  .promise-display p {
    font-size: 1rem;
  }
}

@media (max-width: 480px) {
  .promises__treasure-section {
    min-height: 400px;
  }
  
  .treasure-chest {
    width: 120px;
    height: 100px;
  }
}

EOF

echo "✅ CSS do baú de tesouros adicionado!"

# Criar JavaScript para o baú interativo
echo "⚡ Criando JavaScript do baú interativo..."

cat > js/treasure-chest.js << 'EOF'
/**
 * BAÚ DE PROMESSAS INTERATIVO
 * Sistema de baú que abre com promessas individuais
 */

class TreasureChest {
  constructor() {
    this.isOpen = false;
    this.promises = [];
    this.currentPromiseIndex = 0;
    this.backgroundImages = [];
    this.currentBackgroundIndex = 0;
    
    this.init();
  }

  async init() {
    await this.loadPromises();
    await this.loadBackgroundImages();
    this.createTreasureSection();
    this.setupEventListeners();
    this.startBackgroundRotation();
  }

  async loadPromises() {
    try {
      const response = await fetch('./json/local_verses.json');
      const data = await response.json();
      
      // Combinar todas as promessas
      this.promises = [];
      Object.values(data.categories).forEach(category => {
        this.promises.push(...category);
      });
      
      if (data.daily_verses) {
        this.promises.push(...data.daily_verses);
      }
      
      // Embaralhar promessas
      this.shuffleArray(this.promises);
      
    } catch (error) {
      console.error('Erro ao carregar promessas:', error);
      // Promessas fallback
      this.promises = [
        {
          verse: "João 14:27",
          text_pt: "Deixo-lhes a paz; a minha paz lhes dou. Não a dou como o mundo a dá. Não se perturbe o seu coração, nem tenham medo.",
          text_en: "Peace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid."
        }
      ];
    }
  }

  async loadBackgroundImages() {
    // Lista de imagens padrão (usuário pode adicionar mais)
    const defaultImages = [
      'assets/images/promessas/promessa-1.webp',
      'assets/images/promessas/promessa-2.webp',
      'assets/images/promessas/promessa-3.webp',
      'assets/images/promessas/promessa-4.webp',
      'assets/images/promessas/promessa-5.webp',
      'assets/images/promessas/promessa-6.webp'
    ];

    this.backgroundImages = [];
    
    // Verificar quais imagens existem
    for (const imagePath of defaultImages) {
      try {
        const response = await fetch(imagePath, { method: 'HEAD' });
        if (response.ok) {
          this.backgroundImages.push(imagePath);
        }
      } catch (error) {
        // Imagem não existe, ignorar
      }
    }

    // Se nenhuma imagem foi encontrada, usar gradiente padrão
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

  createTreasureSection() {
    const promisesSection = document.querySelector('.promises__banner');
    if (!promisesSection) return;

    // Substituir o banner pelo baú de tesouros
    promisesSection.outerHTML = `
      <div class="promises__treasure-section" id="treasureSection">
        <div class="promises__background" id="promisesBackground"></div>
        
        <div class="treasure-chest-container" id="treasureContainer">
          <div class="treasure-light"></div>
          
          <svg class="treasure-chest" id="treasureChest" viewBox="0 0 200 160" xmlns="http://www.w3.org/2000/svg">
            <!-- Base do baú -->
            <rect x="20" y="80" width="160" height="70" rx="10" fill="#8B4513" stroke="#654321" stroke-width="2"/>
            
            <!-- Detalhes da base -->
            <rect x="25" y="85" width="150" height="60" rx="5" fill="#A0522D"/>
            <rect x="30" y="90" width="140" height="50" rx="3" fill="#8B4513"/>
            
            <!-- Ferragens da base -->
            <rect x="15" y="100" width="10" height="30" rx="2" fill="#4A4A4A"/>
            <rect x="175" y="100" width="10" height="30" rx="2" fill="#4A4A4A"/>
            
            <!-- Tampa do baú -->
            <g class="chest-lid">
              <path d="M20 80 Q20 60 40 60 L160 60 Q180 60 180 80 L180 85 L20 85 Z" fill="#8B4513" stroke="#654321" stroke-width="2"/>
              <path d="M25 80 Q25 65 40 65 L160 65 Q175 65 175 80 L175 82 L25 82 Z" fill="#A0522D"/>
              
              <!-- Fechadura -->
              <rect x="95" y="70" width="10" height="8" rx="2" fill="#FFD700" stroke="#B8860B" stroke-width="1"/>
              <circle cx="100" cy="74" r="2" fill="#4A4A4A"/>
              
              <!-- Ferragens da tampa -->
              <rect x="15" y="70" width="10" height="15" rx="2" fill="#4A4A4A"/>
              <rect x="175" y="70" width="10" height="15" rx="2" fill="#4A4A4A"/>
            </g>
            
            <!-- Brilho dourado (visível quando aberto) -->
            <circle cx="100" cy="75" r="30" fill="url(#goldGlow)" opacity="0" class="treasure-glow">
              <animate attributeName="opacity" values="0;0.6;0" dur="2s" repeatCount="indefinite" begin="0s"/>
            </circle>
            
            <!-- Definições de gradientes -->
            <defs>
              <radialGradient id="goldGlow" cx="50%" cy="50%" r="50%">
                <stop offset="0%" style="stop-color:#FFD700;stop-opacity:0.8" />
                <stop offset="70%" style="stop-color:#FFA500;stop-opacity:0.4" />
                <stop offset="100%" style="stop-color:#FF8C00;stop-opacity:0" />
              </radialGradient>
            </defs>
          </svg>
          
          <!-- Partículas douradas -->
          <div class="treasure-particles">
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
        
        <!-- Instruções -->
        <div class="treasure-instructions">
          🗝️ Clique no baú para descobrir uma promessa divina
        </div>
      </div>
    `;

    this.updateBackground();
  }

  setupEventListeners() {
    const treasureContainer = document.getElementById('treasureContainer');
    if (treasureContainer) {
      treasureContainer.addEventListener('click', () => this.toggleChest());
    }
  }

  toggleChest() {
    const chest = document.getElementById('treasureChest');
    const promiseDisplay = document.getElementById('promiseDisplay');
    const instructions = document.querySelector('.treasure-instructions');
    
    if (!this.isOpen) {
      // Abrir baú
      this.isOpen = true;
      chest.classList.add('opening', 'open');
      
      // Trocar fundo
      this.updateBackground();
      
      // Mostrar promessa atual
      this.displayCurrentPromise();
      
      setTimeout(() => {
        chest.classList.remove('opening');
        promiseDisplay.classList.add('show');
        instructions.textContent = '🗝️ Clique novamente para fechar e ver outra promessa';
      }, 800);
      
    } else {
      // Fechar baú
      this.isOpen = false;
      chest.classList.add('closing');
      chest.classList.remove('open');
      promiseDisplay.classList.remove('show');
      
      // Avançar para próxima promessa
      this.currentPromiseIndex = (this.currentPromiseIndex + 1) % this.promises.length;
      
      setTimeout(() => {
        chest.classList.remove('closing');
        instructions.textContent = '🗝️ Clique no baú para descobrir uma promessa divina';
      }, 600);
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
    // Trocar fundo a cada 10 segundos (apenas quando fechado)
    setInterval(() => {
      if (!this.isOpen) {
        this.updateBackground();
      }
    }, 10000);
  }
}

// Inicializar quando DOM estiver pronto
document.addEventListener('DOMContentLoaded', () => {
  // Aguardar um pouco para garantir que outros scripts carregaram
  setTimeout(() => {
    new TreasureChest();
  }, 1000);
});

// Exportar para uso global se necessário
window.TreasureChest = TreasureChest;
EOF

echo "✅ JavaScript do baú criado!"

# Atualizar index.html para incluir o novo script
echo "📝 Atualizando index.html..."

# Verificar se o script já foi adicionado
if ! grep -q "treasure-chest.js" index.html; then
    sed -i '/js\/main.js/a\    <script src="js/treasure-chest.js"></script>' index.html
    echo "✅ Script adicionado ao index.html"
else
    echo "⚠️ Script já existe no index.html"
fi

echo ""
echo "📋 RESUMO DO QUE FOI CRIADO:"
echo "• ✅ Pasta assets/images/promessas/ criada"
echo "• ✅ README com instruções para imagens"
echo "• ✅ CSS completo do baú de tesouros"
echo "• ✅ JavaScript interativo do baú"
echo "• ✅ Sistema de cursor-chave"
echo "• ✅ Animações de abertura/fechamento"
echo "• ✅ Partículas douradas"
echo "• ✅ Rotação de fundos aleatórios"
echo "• ✅ Promessas individuais"
echo ""
echo "💰 CARACTERÍSTICAS DO BAÚ:"
echo "• Cursor vira chave ao passar sobre o baú"
echo "• Animação suave de abertura/fechamento"
echo "• Luz dourada sai do baú quando aberto"
echo "• Partículas flutuantes douradas"
echo "• Fundo muda aleatoriamente"
echo "• Uma promessa por vez"
echo "• Responsivo para mobile"
echo ""
echo "🖼️ PRÓXIMO PASSO OBRIGATÓRIO:"
echo "1. Adicione imagens na pasta assets/images/promessas/"
echo "   - promessa-1.webp, promessa-2.webp, etc."
echo "   - Imagens serão usadas como fundo aleatório"
echo ""
echo "📁 ARQUIVOS CRIADOS/ATUALIZADOS:"
echo "• css/style.css (baú adicionado)"
echo "• js/treasure-chest.js (novo)"
echo "• index.html (script adicionado)"
echo "• assets/images/promessas/ (pasta criada)"
echo ""
echo "🚀 PARA TESTAR:"
echo "1. python3 -m http.server 8000"
echo "2. Acesse http://localhost:8000"
echo "3. Clique no baú para ver as promessas!"
echo ""
echo "⚡ Para deploy: ./5-deploy-fixed.sh"
echo ""
echo "🎉 Baú de promessas divinas criado com sucesso!"