/**
 * =====================================================
 * PORTAL "JESUS É O PÃO DA VIDA" - JavaScript Principal
 * Sistema completo funcional
 * =====================================================
 */

// =====================================================
// CONFIGURAÇÕES GLOBAIS
// =====================================================

const CONFIG = {
  currentLanguage: localStorage.getItem('language') || 'pt',
  apiRetryAttempts: 3,
  apiTimeout: 5000,
  chatMaxMessages: 50,
  animationDuration: 300,
  bannerAutoPlay: true,
  bannerInterval: 5000
};

// Estado global da aplicação
const AppState = {
  isLoaded: false,
  activeSection: 'home',
  chatMessages: [],
  promises: [],
  apiConfig: null,
  translations: {},
  bannerCurrentSlide: 0,
  timelineEvents: []
};

// =====================================================
// SISTEMA DE TRADUÇÃO (i18n)
// =====================================================

class TranslationManager {
  constructor() {
    this.currentLang = CONFIG.currentLanguage;
    this.translations = {
      pt: window.translations?.pt || {},
      en: window.translations?.en || {}
    };
  }

  setLanguage(lang) {
    this.currentLang = lang;
    CONFIG.currentLanguage = lang;
    localStorage.setItem('language', lang);
    this.applyTranslations();
    document.documentElement.lang = lang === 'pt' ? 'pt-BR' : 'en';
  }

  translate(key) {
    const keys = key.split('.');
    let value = this.translations[this.currentLang];
    
    for (const k of keys) {
      value = value?.[k];
      if (value === undefined) break;
    }
    
    return value || key;
  }

  applyTranslations() {
    document.querySelectorAll('[data-i18n]').forEach(element => {
      const key = element.getAttribute('data-i18n');
      const translation = this.translate(key);
      
      if (element.tagName === 'INPUT' || element.tagName === 'TEXTAREA') {
        element.placeholder = translation;
      } else {
        element.textContent = translation;
      }
    });

    document.querySelectorAll('[data-i18n-placeholder]').forEach(element => {
      const key = element.getAttribute('data-i18n-placeholder');
      element.placeholder = this.translate(key);
    });
  }
}

// =====================================================
// BANNER CARROSSEL
// =====================================================

class BannerCarousel {
  constructor() {
    this.container = document.getElementById('promiseBanner');
    this.slides = [];
    this.currentSlide = 0;
    this.autoPlayInterval = null;
    this.init();
  }

  init() {
    if (!this.container) return;
    
    this.slides = this.container.querySelectorAll('.banner-slide');
    this.createControls();
    this.setupEventListeners();
    
    if (CONFIG.bannerAutoPlay) {
      this.startAutoPlay();
    }
  }

  createControls() {
    const controlsContainer = this.container.querySelector('.banner-controls');
    if (!controlsContainer) return;

    // Criar dots
    const dotsContainer = controlsContainer.querySelector('.banner-dots');
    if (dotsContainer) {
      dotsContainer.innerHTML = '';
      this.slides.forEach((_, index) => {
        const dot = document.createElement('div');
        dot.className = `banner-dot ${index === 0 ? 'active' : ''}`;
        dot.addEventListener('click', () => this.goToSlide(index));
        dotsContainer.appendChild(dot);
      });
    }
  }

  setupEventListeners() {
    const prevBtn = this.container.querySelector('.banner-prev');
    const nextBtn = this.container.querySelector('.banner-next');
    
    if (prevBtn) prevBtn.addEventListener('click', () => this.prevSlide());
    if (nextBtn) nextBtn.addEventListener('click', () => this.nextSlide());
    
    // Pausar autoplay ao hover
    this.container.addEventListener('mouseenter', () => this.stopAutoPlay());
    this.container.addEventListener('mouseleave', () => {
      if (CONFIG.bannerAutoPlay) this.startAutoPlay();
    });
  }

  goToSlide(index) {
    if (index < 0 || index >= this.slides.length) return;
    
    // Remover classe active de todos
    this.slides.forEach(slide => slide.classList.remove('active'));
    document.querySelectorAll('.banner-dot').forEach(dot => dot.classList.remove('active'));
    
    // Adicionar classe active ao slide atual
    this.slides[index].classList.add('active');
    document.querySelectorAll('.banner-dot')[index]?.classList.add('active');
    
    this.currentSlide = index;
  }

  nextSlide() {
    const nextIndex = (this.currentSlide + 1) % this.slides.length;
    this.goToSlide(nextIndex);
  }

  prevSlide() {
    const prevIndex = (this.currentSlide - 1 + this.slides.length) % this.slides.length;
    this.goToSlide(prevIndex);
  }

  startAutoPlay() {
    this.stopAutoPlay();
    this.autoPlayInterval = setInterval(() => this.nextSlide(), CONFIG.bannerInterval);
  }

  stopAutoPlay() {
    if (this.autoPlayInterval) {
      clearInterval(this.autoPlayInterval);
      this.autoPlayInterval = null;
    }
  }
}

// =====================================================
// SISTEMA DE CHAT ESPIRITUAL
// =====================================================

class SpiritualChat {
  constructor() {
    this.messages = [];
    this.localVerses = null;
    this.isProcessing = false;
    this.initializeChat();
  }

  async initializeChat() {
    try {
      const response = await fetch('./json/local_verses.json');
      this.localVerses = await response.json();
    } catch (error) {
      console.error('Erro ao carregar versículos locais:', error);
    }
  }

  async processMessage(userMessage) {
    if (this.isProcessing) return;
    
    this.isProcessing = true;
    this.addMessage(userMessage, 'user');
    this.showTypingIndicator();

    try {
      const response = await this.findBestResponse(userMessage);
      this.hideTypingIndicator();
      this.addMessage(response.text, 'bot', response);
    } catch (error) {
      this.hideTypingIndicator();
      const fallbackMessage = this.getFallbackMessage();
      this.addMessage(fallbackMessage, 'bot');
    }
    
    this.isProcessing = false;
  }

  async findBestResponse(message) {
    const normalizedMessage = this.normalizeMessage(message);
    
    // Procurar em categorias locais
    const localResponse = this.searchLocalVerses(normalizedMessage);
    if (localResponse) return localResponse;
    
    // Fallback para versículo aleatório
    return this.getRandomVerse();
  }

  normalizeMessage(message) {
    return message.toLowerCase()
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/[^\w\s]/g, '')
      .trim();
  }

  searchLocalVerses(normalizedMessage) {
    if (!this.localVerses) return null;

    const keywords = {
      medo: ['medo', 'ansiedade', 'ansioso', 'preocupacao', 'preocupado', 'futuro', 'receio'],
      tristeza: ['triste', 'tristeza', 'deprimido', 'abatido', 'desanimado', 'dor', 'sofrimento'],
      esperanca: ['esperanca', 'fe', 'confianca', 'futuro', 'sonho', 'objetivo'],
      amor: ['amor', 'amar', 'relacionamento', 'familia', 'perdao', 'perdoar']
    };

    let bestCategory = null;
    let maxMatches = 0;

    for (const [category, words] of Object.entries(keywords)) {
      const matches = words.filter(word => normalizedMessage.includes(word)).length;
      if (matches > maxMatches) {
        maxMatches = matches;
        bestCategory = category;
      }
    }

    if (bestCategory && this.localVerses.categories[bestCategory]) {
      const verses = this.localVerses.categories[bestCategory];
      const randomVerse = verses[Math.floor(Math.random() * verses.length)];
      
      const currentLang = CONFIG.currentLanguage;
      return {
        verse: randomVerse.verse,
        text: randomVerse[`text_${currentLang}`] || randomVerse.text_pt,
        category: bestCategory,
        type: 'local'
      };
    }

    return null;
  }

  getRandomVerse() {
    if (!this.localVerses?.daily_verses) {
      return {
        verse: "João 14:27",
        text: "Deixo-lhes a paz; a minha paz lhes dou. Não a dou como o mundo a dá. Não se perturbe o seu coração, nem tenham medo.",
        type: 'fallback'
      };
    }

    const verses = this.localVerses.daily_verses;
    const randomVerse = verses[Math.floor(Math.random() * verses.length)];
    const currentLang = CONFIG.currentLanguage;
    
    return {
      verse: randomVerse.verse,
      text: randomVerse[`text_${currentLang}`] || randomVerse.text_pt,
      type: 'random'
    };
  }

  getFallbackMessage() {
    const messages = {
      pt: "Peço desculpas, mas não consegui encontrar um versículo específico para sua situação. Que tal explorar nossas promessas divinas?",
      en: "I apologize, but I couldn't find a specific verse for your situation. How about exploring our divine promises?"
    };
    
    return messages[CONFIG.currentLanguage] || messages.pt;
  }

  addMessage(text, sender, metadata = {}) {
    const message = {
      id: Date.now(),
      text,
      sender,
      timestamp: new Date(),
      metadata
    };
    
    this.messages.push(message);
    
    if (this.messages.length > CONFIG.chatMaxMessages) {
      this.messages = this.messages.slice(-CONFIG.chatMaxMessages);
    }
    
    this.renderMessage(message);
    this.scrollToBottom();
  }

  renderMessage(message) {
    const messagesContainer = document.getElementById('chatMessages');
    if (!messagesContainer) return;

    const messageEl = document.createElement('div');
    messageEl.className = `chat__message chat__message--${message.sender}`;
    
    const avatar = document.createElement('div');
    avatar.className = 'chat__avatar';
    
    if (message.sender === 'bot') {
      avatar.innerHTML = `
        <svg width="32" height="32" viewBox="0 0 32 32">
          <rect x="14" y="6" width="4" height="20" rx="2" fill="currentColor"/>
          <rect x="8" y="12" width="16" height="4" rx="2" fill="currentColor"/>
        </svg>
      `;
    } else {
      avatar.innerHTML = `
        <svg width="32" height="32" viewBox="0 0 32 32" fill="currentColor">
          <path d="M16 16a6 6 0 100-12 6 6 0 000 12zM16 20c-6.627 0-12 2.686-12 6v2h24v-2c0-3.314-5.373-6-12-6z"/>
        </svg>
      `;
    }

    const content = document.createElement('div');
    content.className = 'chat__content';
    
    if (message.sender === 'bot' && message.metadata.verse) {
      content.innerHTML = `
        <div class="verse-reference" style="color: var(--color-gold-primary); font-weight: 600; margin-bottom: 8px;">${message.metadata.verse}</div>
        <div class="verse-text">${message.text}</div>
      `;
    } else {
      content.innerHTML = `<p>${message.text}</p>`;
    }

    messageEl.appendChild(avatar);
    messageEl.appendChild(content);
    
    messageEl.style.opacity = '0';
    messageEl.style.transform = 'translateY(20px)';
    messagesContainer.appendChild(messageEl);
    
    requestAnimationFrame(() => {
      messageEl.style.transition = 'all 0.3s ease';
      messageEl.style.opacity = '1';
      messageEl.style.transform = 'translateY(0)';
    });
  }

  showTypingIndicator() {
    const messagesContainer = document.getElementById('chatMessages');
    if (!messagesContainer) return;

    const indicator = document.createElement('div');
    indicator.className = 'chat__message chat__message--bot typing-indicator';
    indicator.id = 'typingIndicator';
    
    indicator.innerHTML = `
      <div class="chat__avatar">
        <svg width="32" height="32" viewBox="0 0 32 32">
          <rect x="14" y="6" width="4" height="20" rx="2" fill="currentColor"/>
          <rect x="8" y="12" width="16" height="4" rx="2" fill="currentColor"/>
        </svg>
      </div>
      <div class="chat__content">
        <div style="display: flex; gap: 4px;">
          <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--color-gold-primary); animation: pulse 1.5s infinite;"></div>
          <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--color-gold-primary); animation: pulse 1.5s infinite 0.2s;"></div>
          <div style="width: 8px; height: 8px; border-radius: 50%; background: var(--color-gold-primary); animation: pulse 1.5s infinite 0.4s;"></div>
        </div>
      </div>
    `;
    
    messagesContainer.appendChild(indicator);
    this.scrollToBottom();
  }

  hideTypingIndicator() {
    const indicator = document.getElementById('typingIndicator');
    if (indicator) indicator.remove();
  }

  scrollToBottom() {
    const messagesContainer = document.getElementById('chatMessages');
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }
}

// =====================================================
// SISTEMA DE NAVEGAÇÃO
// =====================================================

class NavigationManager {
  constructor() {
    this.setupEventListeners();
    this.setupMobileMenu();
    this.setupSmoothScrolling();
  }

  setupEventListeners() {
    // Language switcher
    const langSwitch = document.getElementById('langSwitch');
    if (langSwitch) {
      langSwitch.value = CONFIG.currentLanguage;
      langSwitch.addEventListener('change', (e) => {
        const translator = new TranslationManager();
        translator.setLanguage(e.target.value);
      });
    }

    // Navigation links
    document.querySelectorAll('.nav__link').forEach(link => {
      link.addEventListener('click', this.handleNavClick.bind(this));
    });

    // CTA buttons
    document.querySelectorAll('[data-section]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault();
        const section = btn.getAttribute('data-section');
        this.scrollToSection(section);
      });
    });

    document.getElementById('openChat')?.addEventListener('click', (e) => {
      e.preventDefault();
      this.scrollToSection('chat');
      setTimeout(() => {
        document.getElementById('chatInput')?.focus();
      }, 500);
    });
  }

  setupMobileMenu() {
    const toggle = document.getElementById('navToggle');
    const menu = document.getElementById('navMenu');
    
    if (toggle && menu) {
      toggle.addEventListener('click', () => {
        const isOpen = toggle.getAttribute('aria-expanded') === 'true';
        toggle.setAttribute('aria-expanded', !isOpen);
        menu.classList.toggle('nav__menu--open');
        toggle.classList.toggle('nav__toggle--active');
      });
    }
  }

  handleNavClick(event) {
    const href = event.target.getAttribute('href');
    if (href && href.startsWith('#')) {
      event.preventDefault();
      const sectionId = href.substring(1);
      this.scrollToSection(sectionId);
    }
  }

  scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
      const headerHeight = document.querySelector('.header').offsetHeight;
      const targetPosition = section.offsetTop - headerHeight - 20;
      
      window.scrollTo({
        top: targetPosition,
        behavior: 'smooth'
      });
    }
  }

  setupSmoothScrolling() {
    window.addEventListener('scroll', this.throttle(() => {
      this.updateActiveNavOnScroll();
    }, 100));
  }

  updateActiveNavOnScroll() {
    const sections = document.querySelectorAll('section[id]');
    const scrollPosition = window.scrollY + 100;

    sections.forEach(section => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      
      if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
        this.setActiveSection(section.id);
      }
    });
  }

  setActiveSection(sectionId) {
    document.querySelectorAll('.nav__link').forEach(link => {
      link.classList.remove('nav__link--active');
      if (link.getAttribute('href') === `#${sectionId}`) {
        link.classList.add('nav__link--active');
      }
    });
  }

  throttle(func, wait) {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }
}

// =====================================================
// INICIALIZAÇÃO DA APLICAÇÃO
// =====================================================

class App {
  constructor() {
    this.translator = new TranslationManager();
    this.navigation = new NavigationManager();
    this.chat = new SpiritualChat();
    this.banner = new BannerCarousel();
    this.init();
  }

  init() {
    this.setupEventListeners();
    this.updateHeroVisual();
    this.loadPromises();
    AppState.isLoaded = true;
  }

  setupEventListeners() {
    // Chat form
    const chatForm = document.getElementById('chatForm');
    if (chatForm) {
      chatForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const input = document.getElementById('chatInput');
        if (input && input.value.trim()) {
          this.chat.processMessage(input.value.trim());
          input.value = '';
        }
      });
    }

    // Newsletter form
    const newsletterForm = document.getElementById('newsletterForm');
    if (newsletterForm) {
      newsletterForm.addEventListener('submit', this.handleNewsletterSubmit.bind(this));
    }
  }

  updateHeroVisual() {
    // Substituir o visual do hero com mãos segurando pão brilhante
    const heroVisual = document.querySelector('.hero__visual');
    if (heroVisual) {
      heroVisual.innerHTML = `
        <div class="sacred-hands">
          <div class="divine-glow"></div>
          <div class="holy-light-rays"></div>
          <div class="bread-in-hands"></div>
          <svg class="sacred-hands-svg" viewBox="0 0 300 300">
            <!-- Mãos sagradas (sugeridas) -->
            <defs>
              <radialGradient id="lightGradient" cx="50%" cy="40%" r="60%">
                <stop offset="0%" style="stop-color:#f4d03f;stop-opacity:0.8" />
                <stop offset="50%" style="stop-color:#d4af37;stop-opacity:0.6" />
                <stop offset="100%" style="stop-color:#b7950b;stop-opacity:0.2" />
              </radialGradient>
              <filter id="glow">
                <feGaussianBlur stdDeviation="4" result="coloredBlur"/>
                <feMerge> 
                  <feMergeNode in="coloredBlur"/>
                  <feMergeNode in="SourceGraphic"/>
                </feMerge>
              </filter>
            </defs>
            
            <!-- Luz divina emanando -->
            <circle cx="150" cy="120" r="80" fill="url(#lightGradient)" opacity="0.6" filter="url(#glow)">
              <animate attributeName="r" values="70;90;70" dur="3s" repeatCount="indefinite"/>
              <animate attributeName="opacity" values="0.4;0.8;0.4" dur="3s" repeatCount="indefinite"/>
            </circle>
            
            <!-- Raios de luz -->
            <g stroke="#f4d03f" stroke-width="2" opacity="0.7">
              <line x1="150" y1="40" x2="150" y2="80" filter="url(#glow)">
                <animate attributeName="opacity" values="0.3;0.9;0.3" dur="2s" repeatCount="indefinite"/>
              </line>
              <line x1="190" y1="60" x2="170" y2="90" filter="url(#glow)">
                <animate attributeName="opacity" values="0.3;0.9;0.3" dur="2s" begin="0.5s" repeatCount="indefinite"/>
              </line>
              <line x1="110" y1="60" x2="130" y2="90" filter="url(#glow)">
                <animate attributeName="opacity" values="0.3;0.9;0.3" dur="2s" begin="1s" repeatCount="indefinite"/>
              </line>
              <line x1="200" y1="120" x2="180" y2="120" filter="url(#glow)">
                <animate attributeName="opacity" values="0.3;0.9;0.3" dur="2s" begin="1.5s" repeatCount="indefinite"/>
              </line>
              <line x1="100" y1="120" x2="120" y2="120" filter="url(#glow)">
                <animate attributeName="opacity" values="0.3;0.9;0.3" dur="2s" begin="1.5s" repeatCount="indefinite"/>
              </line>
            </g>
          </svg>
        </div>
      `;
    }
  }

  async loadPromises() {
    try {
      const response = await fetch('./json/local_verses.json');
      const data = await response.json();
      
      const promises = [];
      Object.values(data.categories).forEach(category => {
        promises.push(...category);
      });
      
      if (data.daily_verses) {
        promises.push(...data.daily_verses);
      }
      
      this.renderPromises(promises.slice(0, 6));
    } catch (error) {
      console.error('Erro ao carregar promessas:', error);
    }
  }

  renderPromises(promises) {
    const container = document.getElementById('promisesGrid');
    if (!container) return;

    container.innerHTML = '';
    promises.forEach((promise, index) => {
      const card = document.createElement('div');
      card.className = 'promise-card';
      
      const currentLang = CONFIG.currentLanguage;
      const text = promise[`text_${currentLang}`] || promise.text_pt || promise.text;
      
      card.innerHTML = `
        <div class="promise-card__verse">${promise.verse}</div>
        <div class="promise-card__text">"${text}"</div>
      `;

      container.appendChild(card);
    });
  }

  async handleNewsletterSubmit(event) {
    event.preventDefault();
    
    const formData = new FormData(event.target);
    const submissionData = {
      name: document.getElementById('subscriberName').value,
      email: document.getElementById('subscriberEmail').value,
      whatsapp: document.getElementById('subscriberWhatsapp').value,
      language: CONFIG.currentLanguage,
      timestamp: new Date().toISOString()
    };

    try {
      // Simular envio (localStorage para demo)
      const submissions = JSON.parse(localStorage.getItem('submissions') || '[]');
      submissions.push(submissionData);
      localStorage.setItem('submissions', JSON.stringify(submissions));
      
      this.showMessage('Inscrição realizada com sucesso!', 'success');
      event.target.reset();
    } catch (error) {
      this.showMessage('Erro ao processar inscrição. Tente novamente.', 'error');
    }
  }

  showMessage(message, type) {
    const toast = document.createElement('div');
    toast.className = `toast toast--${type}`;
    toast.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      padding: 16px 24px;
      background: ${type === 'success' ? 'var(--color-gold-primary)' : '#e74c3c'};
      color: var(--color-dark-primary);
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.3);
      z-index: 10000;
      opacity: 0;
      transform: translateX(100%);
      transition: all 0.3s ease;
    `;
    toast.textContent = message;
    
    document.body.appendChild(toast);
    
    requestAnimationFrame(() => {
      toast.style.opacity = '1';
      toast.style.transform = 'translateX(0)';
    });
    
    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateX(100%)';
      setTimeout(() => toast.remove(), 300);
    }, 3000);
  }
}

// =====================================================
// INICIALIZAÇÃO
// =====================================================

document.addEventListener('DOMContentLoaded', () => {
  const app = new App();
  
  // Remover loading overlay
  setTimeout(() => {
    document.body.classList.remove('loading');
    document.body.classList.add('loaded');
  }, 500);
});


// =====================================================
// ATUALIZAÇÃO DO HERO COM IMAGEM REAL
// =====================================================

// Sobrescrever a função updateHeroVisual
App.prototype.updateHeroVisual = function() {
  const heroVisual = document.querySelector('.hero__visual');
  if (!heroVisual) return;

  // Novo HTML com imagem real e efeitos de luz
  heroVisual.innerHTML = `
    <div class="sacred-image-container">
      <!-- Efeito de luz de cima para baixo -->
      <div class="divine-light-beam"></div>
      <div class="divine-light-beam beam-2"></div>
      <div class="divine-light-beam beam-3"></div>
      
      <!-- Partículas de luz flutuantes -->
      <div class="light-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
      </div>
      
      <!-- Glow principal ao redor da imagem -->
      <div class="image-glow"></div>
      
      <!-- Imagem principal do Jesus com pão -->
      <div class="jesus-image-wrapper">
        <img 
          src="assets/images/jesus-pao.webp" 
          alt="Jesus segurando o pão da vida"
          class="jesus-bread-image"
          loading="eager"
          onerror="this.style.display='none'; this.nextElementSibling.style.display='block';"
        >
        <!-- Fallback se imagem não carregar -->
        <div class="image-fallback" style="display: none;">
          <div class="fallback-bread"></div>
          <div class="fallback-text">Jesus é o Pão da Vida</div>
        </div>
      </div>
      
      <!-- Raios de luz adicionais -->
      <div class="light-rays">
        <div class="ray ray-1"></div>
        <div class="ray ray-2"></div>
        <div class="ray ray-3"></div>
        <div class="ray ray-4"></div>
        <div class="ray ray-5"></div>
      </div>
      
      <!-- Halo dourado -->
      <div class="divine-halo"></div>
    </div>
  `;
};

