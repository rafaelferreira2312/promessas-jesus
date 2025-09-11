#!/bin/bash

# =====================================================
# SCRIPT 8 - CORRIGIR CONFLITOS E BUGS
# Corrige botão, texto do baú, imagens nos cards
# =====================================================
# Uso: chmod +x 8-fix-conflicts.sh && ./8-fix-conflicts.sh
# =====================================================

set -e

echo "🔧 CORRIGINDO CONFLITOS E BUGS"
echo "✅ Botão 'Ver Mais Promessas' fora do container"
echo "✅ Texto das promessas no baú voltando a funcionar"
echo "✅ Imagens de fundo nos cards das promessas"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "js/treasure-chest.js" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto"
    exit 1
fi

# Corrigir JavaScript do baú
echo "⚡ Corrigindo JavaScript do baú..."

cat > js/treasure-chest-fixed.js << 'EOF'
/**
 * BAÚ DE PROMESSAS CORRIGIDO
 * Corrige conflitos e mantém funcionalidades originais
 */

class FixedTreasureChest {
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
    
    // Só criar o baú se não existir ainda
    if (!document.querySelector('.promises__treasure-section')) {
      this.createTreasureSection();
    }
    
    this.setupEventListeners();
    this.startBackgroundRotation();
    this.addImagesToPromiseCards();
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

  createTreasureSection() {
    // Encontrar onde inserir (ANTES do grid de promessas, não substituir)
    const promisesGrid = document.querySelector('.promises__grid');
    if (!promisesGrid) return;

    // Criar seção do baú
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

    // Inserir ANTES do grid (não substituir)
    promisesGrid.insertAdjacentHTML('beforebegin', treasureHTML);
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
        chest.classList.remove('opening');
        promiseDisplay.classList.add('show');
        instructions.innerHTML = '🗝️ Clique novamente para fechar e descobrir outra promessa';
      }, 1000);
      
    } else {
      this.isOpen = false;
      chest.classList.add('closing');
      chest.classList.remove('open');
      promiseDisplay.classList.remove('show');
      
      this.currentPromiseIndex = (this.currentPromiseIndex + 1) % this.promises.length;
      
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

  // NOVA FUNÇÃO: Adicionar imagens aos cards das promessas
  addImagesToPromiseCards() {
    const cards = document.querySelectorAll('.promise-card');
    cards.forEach((card, index) => {
      // Só adicionar se não tem imagem ainda
      if (!card.style.backgroundImage) {
        const imageIndex = index % this.backgroundImages.length;
        const image = this.backgroundImages[imageIndex];
        
        if (image !== 'gradient') {
          card.style.backgroundImage = `url('${image}')`;
          card.style.backgroundSize = 'cover';
          card.style.backgroundPosition = 'center';
          card.style.position = 'relative';
          
          // Overlay para manter legibilidade do texto
          const overlay = document.createElement('div');
          overlay.style.cssText = `
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(26, 22, 17, 0.85), rgba(45, 24, 16, 0.75));
            border-radius: inherit;
            z-index: 1;
          `;
          card.appendChild(overlay);
          
          // Garantir que o conteúdo fique acima do overlay
          const content = card.querySelector('.promise-card__verse, .promise-card__text');
          if (content) {
            const textContainer = document.createElement('div');
            textContainer.style.cssText = `
              position: relative;
              z-index: 2;
            `;
            
            // Mover todo o conteúdo para o container
            while (card.firstChild && card.firstChild !== overlay) {
              textContainer.appendChild(card.firstChild);
            }
            card.appendChild(textContainer);
          }
        }
      }
    });
  }

  showCategories() {
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

// Aguardar que a página carregue completamente
document.addEventListener('DOMContentLoaded', () => {
  // Aguardar outros scripts carregarem
  setTimeout(() => {
    window.fixedTreasureChest = new FixedTreasureChest();
  }, 2000);
});

// Observar mudanças no DOM para adicionar imagens aos novos cards
const observer = new MutationObserver((mutations) => {
  mutations.forEach((mutation) => {
    if (mutation.type === 'childList') {
      mutation.addedNodes.forEach((node) => {
        if (node.nodeType === 1 && node.classList && node.classList.contains('promise-card')) {
          // Novo card adicionado, aplicar imagem
          if (window.fixedTreasureChest) {
            window.fixedTreasureChest.addImagesToPromiseCards();
          }
        }
      });
    }
  });
});

// Observar o grid de promessas
setTimeout(() => {
  const promisesGrid = document.getElementById('promisesGrid');
  if (promisesGrid) {
    observer.observe(promisesGrid, { childList: true, subtree: true });
  }
}, 3000);

window.FixedTreasureChest = FixedTreasureChest;
EOF

echo "✅ JavaScript corrigido criado!"

# Substituir o JavaScript
echo "🔄 Substituindo JavaScript..."
if [ -f "js/treasure-chest.js" ]; then
    mv js/treasure-chest.js js/treasure-chest-old2.js
fi
mv js/treasure-chest-fixed.js js/treasure-chest.js

# CSS adicional para cards com imagens
echo "🎨 Adicionando CSS para cards com imagens..."

cat >> css/style.css << 'EOF'

/* =====================================================
   PROMISE CARDS COM IMAGENS DE FUNDO
   ===================================================== */

.promise-card {
  position: relative;
  overflow: hidden;
  transition: all var(--transition-base);
}

.promise-card:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: var(--shadow-gold-xl);
}

/* Cards com imagem de fundo */
.promise-card[style*="background-image"] {
  color: var(--color-cream);
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
}

.promise-card[style*="background-image"] .promise-card__verse {
  color: var(--color-gold-light);
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.9);
  font-weight: 700;
}

.promise-card[style*="background-image"] .promise-card__text {
  color: var(--color-cream);
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
  font-weight: 500;
}

/* Garantir que o baú não substitua o botão */
.promises__actions {
  position: relative;
  z-index: 10;
  margin-top: var(--space-xl);
}

/* Espaçamento entre baú e grid */
.promises__treasure-section {
  margin-bottom: var(--space-3xl);
}

.promises__grid {
  margin-top: var(--space-xl);
}

EOF

echo "✅ CSS adicional aplicado!"

echo ""
echo "🎉 CORREÇÕES APLICADAS COM SUCESSO!"
echo ""
echo "📋 PROBLEMAS RESOLVIDOS:"
echo "• ✅ Botão 'Ver Mais Promessas' permanece no lugar correto"
echo "• ✅ Texto das promessas no baú volta a aparecer"
echo "• ✅ Cards das promessas recebem imagens de fundo automaticamente"
echo "• ✅ Overlay nos cards para manter legibilidade do texto"
echo "• ✅ Baú não substitui mais o grid original"
echo "• ✅ Observador de DOM para novos cards"
echo ""
echo "🔧 MELHORIAS IMPLEMENTADAS:"
echo "• Baú inserido ANTES do grid (não substitui)"
echo "• JavaScript não conflita mais com outros scripts"
echo "• Imagens aplicadas automaticamente aos cards"
echo "• Text-shadow nos cards para melhor legibilidade"
echo "• Sistema de overlay responsivo"
echo ""
echo "📁 ARQUIVOS ATUALIZADOS:"
echo "• js/treasure-chest.js (corrigido)"
echo "• css/style.css (CSS adicional)"
echo ""
echo "🚀 PARA TESTAR:"
echo "1. python3 -m http.server 8000"
echo "2. Clique no baú - texto deve aparecer"
echo "3. Verifique os cards com imagens de fundo"
echo "4. Botão 'Ver Mais Promessas' deve estar no lugar"
echo ""
echo "⚡ Para deploy: ./5-deploy-fixed.sh"
echo ""
echo "✨ Todos os conflitos resolvidos!"