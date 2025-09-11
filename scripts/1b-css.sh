#!/bin/bash

# =====================================================
# SCRIPT 1b - CSS CONTINUAÇÃO (SEÇÕES COMPLEXAS)
# Adiciona seções avançadas: Header, Hero, Promises, Timeline, Chat, etc.
# =====================================================
# Uso: chmod +x 1b-css.sh && ./1b-css.sh
# =====================================================

set -e

echo "🎨 CONTINUANDO CSS - SEÇÕES COMPLEXAS"
echo "📋 Adicionando: Header, Hero, Promises, Timeline, Chat..."
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "css/style.css" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto (onde existe css/style.css)"
    exit 1
fi

# Adicionar seções complexas ao CSS
cat >> css/style.css << 'EOF'

.btn--outline {
  background: transparent;
  color: var(--color-cream);
  border-color: var(--color-brown-400);
}

.btn--outline:hover {
  background: var(--color-brown-400);
  color: var(--color-dark-primary);
  border-color: var(--color-gold-primary);
}

.btn--full {
  width: 100%;
}

/* =====================================================
   HEADER & NAVIGATION
   ===================================================== */

.header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  background: rgba(26, 22, 17, 0.95);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--color-gold-primary);
  z-index: 1000;
  transition: all var(--transition-base);
}

.nav__container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 80px;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--space-md);
}

.nav__logo {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  font-weight: 700;
  color: var(--color-gold-primary);
  text-decoration: none;
}

.logo-icon {
  color: var(--color-gold-primary);
  transition: transform var(--transition-base);
  filter: drop-shadow(0 0 10px var(--color-gold-light));
}

.logo-icon:hover {
  transform: scale(1.1) rotate(5deg);
}

.logo-text {
  font-size: 1.25rem;
  font-family: var(--font-sacred);
  background: var(--gradient-gold);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.nav__controls {
  display: flex;
  align-items: center;
  gap: var(--space-md);
}

.lang-switch {
  padding: var(--space-xs) var(--space-sm);
  border: 1px solid var(--color-gold-primary);
  border-radius: var(--radius-md);
  background: var(--color-dark-secondary);
  color: var(--color-cream);
  font-size: 0.875rem;
  cursor: pointer;
  transition: all var(--transition-base);
}

.lang-switch:hover {
  background: var(--color-gold-primary);
  color: var(--color-dark-primary);
}

.nav__toggle {
  display: none;
  flex-direction: column;
  gap: 4px;
  background: none;
  border: none;
  cursor: pointer;
  padding: var(--space-xs);
}

.nav__toggle-line {
  width: 28px;
  height: 3px;
  background: var(--color-gold-primary);
  transition: all var(--transition-base);
  border-radius: 2px;
}

.nav__menu {
  display: flex;
  list-style: none;
  gap: var(--space-xl);
}

.nav__link {
  color: var(--color-cream);
  text-decoration: none;
  font-weight: 500;
  position: relative;
  transition: color var(--transition-base);
  font-family: var(--font-primary);
}

.nav__link::after {
  content: '';
  position: absolute;
  bottom: -6px;
  left: 0;
  width: 0;
  height: 3px;
  background: var(--gradient-gold);
  transition: width var(--transition-base);
  border-radius: 2px;
}

.nav__link:hover {
  color: var(--color-gold-primary);
}

.nav__link:hover::after {
  width: 100%;
}

/* =====================================================
   HERO SECTION
   ===================================================== */

.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  position: relative;
  background: linear-gradient(135deg, 
    var(--color-dark-secondary) 0%, 
    var(--color-dark-primary) 50%, 
    var(--color-dark-tertiary) 100%
  );
  overflow: hidden;
}

.hero__background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1;
}

.hero__particles {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="particles" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="%23d4af37" opacity="0.3"/></pattern></defs><rect width="100" height="100" fill="url(%23particles)"/></svg>');
  animation: particleFloat 20s linear infinite;
}

.hero__light {
  position: absolute;
  top: 20%;
  right: 20%;
  width: 300px;
  height: 300px;
  background: radial-gradient(circle, var(--color-gold-light) 0%, transparent 70%);
  opacity: 0.3;
  animation: lightPulse 4s ease-in-out infinite;
}

@keyframes particleFloat {
  0% { transform: translateY(0px); }
  100% { transform: translateY(-100px); }
}

@keyframes lightPulse {
  0%, 100% { opacity: 0.3; transform: scale(1); }
  50% { opacity: 0.6; transform: scale(1.2); }
}

.hero__container {
  display: grid;
  grid-template-columns: 1.2fr 1fr;
  gap: var(--space-3xl);
  align-items: center;
  max-width: 1200px;
  margin: 0 auto;
  padding: var(--space-3xl) var(--space-md);
  position: relative;
  z-index: 2;
}

.hero__content {
  animation: slideInLeft 1.2s ease;
}

.hero__subtitle-top {
  font-family: var(--font-primary);
  font-size: 0.875rem;
  font-weight: 600;
  color: var(--color-gold-primary);
  letter-spacing: 2px;
  margin-bottom: var(--space-sm);
  text-transform: uppercase;
}

.hero__title {
  font-family: var(--font-sacred);
  font-size: clamp(2.5rem, 6vw, 5rem);
  font-weight: 700;
  line-height: 1.1;
  margin-bottom: var(--space-lg);
  color: var(--color-cream);
}

.hero__verse {
  display: block;
  font-size: clamp(1rem, 2vw, 1.5rem);
  color: var(--color-gold-primary);
  margin-bottom: var(--space-sm);
  font-weight: 600;
}

.hero__highlight {
  background: var(--gradient-gold);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  position: relative;
  text-shadow: 0 0 30px var(--color-gold-light);
}

.hero__scripture {
  font-size: 1.25rem;
  color: var(--color-brown-200);
  margin-bottom: var(--space-xl);
  line-height: 1.6;
  font-style: italic;
  padding: var(--space-md);
  border-left: 4px solid var(--color-gold-primary);
  background: rgba(212, 175, 55, 0.1);
  border-radius: var(--radius-md);
}

.hero__actions {
  display: flex;
  gap: var(--space-lg);
  flex-wrap: wrap;
}

.hero__visual {
  display: flex;
  justify-content: center;
  align-items: center;
  animation: slideInRight 1.2s ease;
}

.bread-container {
  position: relative;
  filter: drop-shadow(0 25px 50px rgba(212, 175, 55, 0.3));
}

.bread-glow {
  position: absolute;
  top: -20px;
  left: -20px;
  right: -20px;
  bottom: -20px;
  background: radial-gradient(circle, var(--color-gold-light) 0%, transparent 70%);
  opacity: 0.4;
  animation: breathe 3s ease-in-out infinite;
}

.bread-svg {
  position: relative;
  z-index: 2;
  animation: float 6s ease-in-out infinite;
}

.bread-piece {
  animation: shimmer 4s ease-in-out infinite;
}

.holy-cross {
  filter: drop-shadow(0 0 15px var(--color-gold-light));
  animation: holyGlow 3s ease-in-out infinite;
}

.divine-light {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 200px;
  height: 200px;
  background: var(--gradient-sacred);
  border-radius: 50%;
  opacity: 0.2;
  transform: translate(-50%, -50%);
  animation: divineRotate 10s linear infinite;
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-80px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateX(80px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-15px); }
}

@keyframes breathe {
  0%, 100% { opacity: 0.4; transform: scale(1); }
  50% { opacity: 0.7; transform: scale(1.1); }
}

@keyframes shimmer {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.8; filter: brightness(1.2); }
}

@keyframes divineRotate {
  0% { transform: translate(-50%, -50%) rotate(0deg); }
  100% { transform: translate(-50%, -50%) rotate(360deg); }
}

.scroll-indicator {
  position: absolute;
  bottom: var(--space-xl);
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  animation: bounce 2s infinite;
  z-index: 3;
}

.scroll-text {
  color: var(--color-gold-primary);
  font-size: 0.875rem;
  font-weight: 500;
  margin-bottom: var(--space-xs);
}

.scroll-arrow {
  width: 2px;
  height: 30px;
  background: var(--color-gold-primary);
  margin: 0 auto;
  position: relative;
}

.scroll-arrow::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: -4px;
  width: 10px;
  height: 10px;
  border: 2px solid var(--color-gold-primary);
  border-top: none;
  border-left: none;
  transform: rotate(45deg);
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateX(-50%) translateY(0); }
  40% { transform: translateX(-50%) translateY(-10px); }
  60% { transform: translateX(-50%) translateY(-5px); }
}

/* =====================================================
   SECTIONS
   ===================================================== */

.section {
  padding: var(--space-3xl) 0;
  position: relative;
}

.section:nth-child(even) {
  background: var(--color-dark-secondary);
}

.section__header {
  text-align: center;
  margin-bottom: var(--space-3xl);
}

.section__subtitle {
  font-size: 0.875rem;
  font-weight: 600;
  color: var(--color-gold-primary);
  letter-spacing: 2px;
  margin-bottom: var(--space-sm);
  text-transform: uppercase;
}

.section__title {
  font-size: clamp(2rem, 5vw, 3.5rem);
  margin-bottom: var(--space-md);
  position: relative;
}

.section__title::after {
  content: '';
  position: absolute;
  bottom: -15px;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 4px;
  background: var(--gradient-gold);
  border-radius: 2px;
}

.section__description {
  font-size: 1.125rem;
  color: var(--color-brown-200);
  max-width: 700px;
  margin: 0 auto;
  line-height: 1.7;
}

EOF

echo "✅ Seções complexas adicionadas ao CSS!"
echo ""
echo "📋 RESUMO DO QUE FOI ADICIONADO:"
echo "• ✅ Header fixo com navegação dourada"
echo "• ✅ Hero section majestoso com animações"
echo "• ✅ Visual do cesto de pães (SVG animado)"
echo "• ✅ Efeitos de partículas flutuantes"
echo "• ✅ Gradientes e sombras douradas"
echo "• ✅ Animações sagradas (respiração, brilho)"
echo "• ✅ Scroll indicator animado"
echo "• ✅ Estrutura base para todas as seções"
echo ""
echo "📁 LOCALIZAÇÃO: css/style.css (atualizado)"
echo ""
echo "🚀 PRÓXIMOS PASSOS:"
echo "1. Digite 'continuar' para criar script 1c-css.sh (seções restantes)"
echo "2. Depois criar script 2-js.sh (JavaScript principal)"
echo ""
echo "⏳ Aguardando comando 'continuar'..."