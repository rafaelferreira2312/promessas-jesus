#!/bin/bash

# =====================================================
# SCRIPT 1c - CSS SEÇÕES FINAIS + MÃOS SAGRADAS
# Promises, Timeline, Chat, Newsletter, Footer + Visual das Mãos
# =====================================================
# Uso: chmod +x 1c-css.sh && ./1c-css.sh
# =====================================================

set -e

echo "🙏 FINALIZANDO CSS - SEÇÕES FINAIS + MÃOS SAGRADAS"
echo "✨ Adicionando: Promises, Timeline, Chat, Newsletter, Footer"
echo "🍞 Criando visual das mãos segurando pão brilhante"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "css/style.css" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto (onde existe css/style.css)"
    exit 1
fi

# Adicionar seções finais ao CSS
cat >> css/style.css << 'EOF'

/* =====================================================
   PROMISES SECTION
   ===================================================== */

.promises__banner {
  margin-bottom: var(--space-3xl);
  position: relative;
  border-radius: var(--radius-2xl);
  overflow: hidden;
  box-shadow: var(--shadow-gold-xl);
}

.banner-carousel {
  position: relative;
  height: 400px;
}

.banner-slide {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-size: cover;
  background-position: center;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 1s ease;
}

.banner-slide.active {
  opacity: 1;
}

.banner-content {
  text-align: center;
  color: var(--color-cream);
  max-width: 800px;
  padding: var(--space-xl);
}

.banner-content h3 {
  font-size: 2rem;
  color: var(--color-gold-light);
  margin-bottom: var(--space-md);
  text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
}

.banner-content p {
  font-size: 1.25rem;
  line-height: 1.6;
  font-style: italic;
  text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
}

.banner-controls {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  gap: var(--space-md);
}

.banner-prev,
.banner-next {
  background: rgba(212, 175, 55, 0.8);
  color: var(--color-dark-primary);
  border: none;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  cursor: pointer;
  font-size: 1.5rem;
  font-weight: bold;
  transition: all var(--transition-base);
}

.banner-prev:hover,
.banner-next:hover {
  background: var(--color-gold-primary);
  transform: scale(1.1);
}

.banner-dots {
  display: flex;
  gap: var(--space-xs);
}

.promises__grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: var(--space-xl);
  margin-bottom: var(--space-xl);
}

.promise-card {
  background: linear-gradient(145deg, var(--color-dark-secondary), var(--color-dark-primary));
  border-radius: var(--radius-xl);
  padding: var(--space-xl);
  box-shadow: var(--shadow-gold-md);
  border: 1px solid var(--color-gold-primary);
  transition: all var(--transition-base);
  position: relative;
  overflow: hidden;
}

.promise-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 5px;
  background: var(--gradient-gold);
}

.promise-card:hover {
  transform: translateY(-10px);
  box-shadow: var(--shadow-gold-xl);
  border-color: var(--color-gold-light);
}

.promise-card__verse {
  font-size: 1rem;
  color: var(--color-gold-primary);
  font-weight: 700;
  margin-bottom: var(--space-md);
  font-family: var(--font-sacred);
}

.promise-card__text {
  font-size: 1.125rem;
  line-height: 1.7;
  color: var(--color-cream);
  font-style: italic;
}

.promises__actions {
  text-align: center;
}

/* =====================================================
   VISUAL DAS MÃOS SAGRADAS (HERO ATUALIZADO)
   ===================================================== */

.sacred-hands {
  position: relative;
  width: 400px;
  height: 400px;
  margin: 0 auto;
}

.hands-container {
  position: relative;
  width: 100%;
  height: 100%;
  filter: drop-shadow(0 0 30px var(--color-gold-light));
}

.divine-glow {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, var(--color-gold-light) 0%, var(--color-gold-primary) 30%, transparent 70%);
  border-radius: 50%;
  transform: translate(-50%, -50%);
  opacity: 0.6;
  animation: pulseGlow 3s ease-in-out infinite;
}

.bread-in-hands {
  position: absolute;
  top: 55%;
  left: 50%;
  width: 120px;
  height: 80px;
  background: linear-gradient(145deg, #deb887, #f4a460, #daa520);
  border-radius: 50px 50px 45px 45px;
  transform: translate(-50%, -50%);
  box-shadow: 
    0 0 20px var(--color-gold-light),
    inset 0 5px 10px rgba(255,255,255,0.3);
  animation: breadGlow 2s ease-in-out infinite;
}

.bread-in-hands::before {
  content: '';
  position: absolute;
  top: 15%;
  left: 20%;
  width: 15px;
  height: 10px;
  background: rgba(139, 69, 19, 0.6);
  border-radius: 50%;
  box-shadow: 
    25px 5px 0 rgba(139, 69, 19, 0.5),
    10px 20px 0 rgba(139, 69, 19, 0.4),
    35px 25px 0 rgba(139, 69, 19, 0.5);
}

.holy-light-rays {
  position: absolute;
  top: 20%;
  left: 50%;
  width: 300px;
  height: 300px;
  transform: translate(-50%, -50%);
  opacity: 0.4;
  animation: rotateRays 8s linear infinite;
}

.holy-light-rays::before {
  content: '';
  position: absolute;
  top: 0;
  left: 50%;
  width: 2px;
  height: 100px;
  background: linear-gradient(to bottom, var(--color-gold-light), transparent);
  transform: translateX(-50%);
  box-shadow: 
    0 0 0 0,
    60px 0 0 var(--color-gold-light),
    -60px 0 0 var(--color-gold-light),
    120px 0 0 var(--color-gold-primary),
    -120px 0 0 var(--color-gold-primary);
}

.sacred-hands-svg {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 300px;
  height: 300px;
  transform: translate(-50%, -50%);
  z-index: 2;
}

@keyframes pulseGlow {
  0%, 100% { 
    opacity: 0.6; 
    transform: translate(-50%, -50%) scale(1); 
  }
  50% { 
    opacity: 0.9; 
    transform: translate(-50%, -50%) scale(1.2); 
  }
}

@keyframes breadGlow {
  0%, 100% { 
    box-shadow: 
      0 0 20px var(--color-gold-light),
      inset 0 5px 10px rgba(255,255,255,0.3);
  }
  50% { 
    box-shadow: 
      0 0 40px var(--color-gold-primary),
      0 0 60px var(--color-gold-light),
      inset 0 5px 10px rgba(255,255,255,0.5);
  }
}

@keyframes rotateRays {
  0% { transform: translate(-50%, -50%) rotate(0deg); }
  100% { transform: translate(-50%, -50%) rotate(360deg); }
}

/* =====================================================
   TIMELINE SECTION
   ===================================================== */

.timeline__container {
  position: relative;
  max-width: 1000px;
  margin: 0 auto;
}

.timeline__line {
  position: absolute;
  left: 50%;
  top: 0;
  bottom: 0;
  width: 4px;
  background: var(--gradient-gold);
  transform: translateX(-50%);
}

.timeline__events {
  display: flex;
  flex-direction: column;
  gap: var(--space-3xl);
}

.timeline-event {
  display: flex;
  align-items: center;
  position: relative;
}

.timeline-event:nth-child(even) {
  flex-direction: row-reverse;
}

.timeline-event__content {
  flex: 1;
  background: var(--color-dark-secondary);
  padding: var(--space-xl);
  border-radius: var(--radius-xl);
  border: 1px solid var(--color-gold-primary);
  box-shadow: var(--shadow-gold-md);
  max-width: 400px;
}

.timeline-event__icon {
  width: 60px;
  height: 60px;
  background: var(--gradient-gold);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--color-dark-primary);
  font-weight: bold;
  font-size: 1.5rem;
  position: relative;
  z-index: 2;
  box-shadow: var(--shadow-gold-lg);
}

/* =====================================================
   CHAT SECTION
   ===================================================== */

.chat__container {
  max-width: 800px;
  margin: 0 auto;
  background: var(--color-dark-secondary);
  border-radius: var(--radius-2xl);
  box-shadow: var(--shadow-gold-xl);
  overflow: hidden;
  border: 1px solid var(--color-gold-primary);
}

.chat__messages {
  height: 400px;
  overflow-y: auto;
  padding: var(--space-lg);
  background: linear-gradient(to bottom, var(--color-dark-primary), var(--color-dark-secondary));
}

.chat__message {
  display: flex;
  gap: var(--space-sm);
  margin-bottom: var(--space-lg);
}

.chat__message--user {
  flex-direction: row-reverse;
}

.chat__avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: var(--gradient-gold);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--color-dark-primary);
  flex-shrink: 0;
}

.chat__message--user .chat__avatar {
  background: var(--color-brown-600);
  color: var(--color-cream);
}

.chat__content {
  background: var(--color-dark-secondary);
  padding: var(--space-md);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-gold-sm);
  max-width: 70%;
  border: 1px solid var(--color-brown-600);
}

.chat__message--user .chat__content {
  background: var(--gradient-bronze);
  color: var(--color-cream);
  border-color: var(--color-bronze-light);
}

.chat__form {
  display: flex;
  gap: var(--space-sm);
  padding: var(--space-lg);
  background: var(--color-dark-primary);
  border-top: 1px solid var(--color-gold-primary);
}

.chat__input {
  flex: 1;
  padding: var(--space-md);
  border: 1px solid var(--color-brown-600);
  border-radius: var(--radius-lg);
  background: var(--color-dark-secondary);
  color: var(--color-cream);
  font-size: 1rem;
  outline: none;
  transition: border-color var(--transition-base);
}

.chat__input:focus {
  border-color: var(--color-gold-primary);
  box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.2);
}

.chat__send {
  padding: var(--space-md);
  background: var(--gradient-gold);
  color: var(--color-dark-primary);
  border: none;
  border-radius: var(--radius-lg);
  cursor: pointer;
  transition: all var(--transition-base);
  display: flex;
  align-items: center;
  justify-content: center;
}

.chat__send:hover {
  transform: scale(1.05);
  box-shadow: var(--shadow-gold-md);
}

/* =====================================================
   NEWSLETTER SECTION
   ===================================================== */

.newsletter {
  background: linear-gradient(135deg, var(--color-earth-dark) 0%, var(--color-dark-primary) 100%);
  color: var(--color-cream);
}

.newsletter__bg {
  position: relative;
  overflow: hidden;
}

.newsletter__bg::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="crosses" width="40" height="40" patternUnits="userSpaceOnUse"><path d="M18 15h4v10h-4zm-3 3h10v4h-10z" fill="%23d4af37" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23crosses)"/></svg>');
}

.newsletter__content {
  max-width: 600px;
  margin: 0 auto;
  text-align: center;
  position: relative;
  z-index: 2;
}

.newsletter__form {
  display: flex;
  flex-direction: column;
  gap: var(--space-md);
  margin-top: var(--space-xl);
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-md);
}

.form-group {
  display: flex;
  flex-direction: column;
}

.form-input {
  padding: var(--space-md);
  border: 1px solid var(--color-gold-primary);
  border-radius: var(--radius-lg);
  background: rgba(26, 22, 17, 0.8);
  color: var(--color-cream);
  font-size: 1rem;
  outline: none;
  transition: all var(--transition-base);
}

.form-input::placeholder {
  color: var(--color-brown-400);
}

.form-input:focus {
  border-color: var(--color-gold-light);
  background: rgba(26, 22, 17, 0.9);
  box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.2);
}

/* =====================================================
   FOOTER
   ===================================================== */

.footer {
  background: var(--color-dark-tertiary);
  color: var(--color-brown-300);
  padding: var(--space-3xl) 0 var(--space-lg);
  border-top: 1px solid var(--color-gold-primary);
}

.footer__content {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  gap: var(--space-3xl);
  margin-bottom: var(--space-xl);
}

.footer__logo {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  margin-bottom: var(--space-md);
  color: var(--color-gold-primary);
  font-weight: 600;
  font-family: var(--font-sacred);
}

.footer__tagline {
  color: var(--color-brown-300);
  font-size: 0.875rem;
  font-style: italic;
}

.footer__column h3 {
  color: var(--color-gold-primary);
  margin-bottom: var(--space-md);
  font-size: 1rem;
  font-family: var(--font-sacred);
}

.footer__column ul {
  list-style: none;
}

.footer__column a {
  color: var(--color-brown-300);
  text-decoration: none;
  transition: color var(--transition-base);
  font-size: 0.875rem;
  display: block;
  padding: var(--space-xs) 0;
}

.footer__column a:hover {
  color: var(--color-gold-primary);
}

.footer__bottom {
  text-align: center;
  padding-top: var(--space-lg);
  border-top: 1px solid var(--color-brown-800);
  font-size: 0.875rem;
  color: var(--color-brown-400);
}

.footer__bottom a {
  color: var(--color-gold-primary);
  text-decoration: none;
}

/* =====================================================
   RESPONSIVO
   ===================================================== */

@media (max-width: 1024px) {
  .hero__container {
    grid-template-columns: 1fr;
    gap: var(--space-xl);
    text-align: center;
  }
  
  .sacred-hands {
    width: 300px;
    height: 300px;
  }
}

@media (max-width: 768px) {
  .nav__menu {
    display: none;
  }
  
  .nav__toggle {
    display: flex;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .footer__content {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .timeline-event {
    flex-direction: column !important;
  }
  
  .timeline__line {
    display: none;
  }
}

@media (max-width: 480px) {
  .sacred-hands {
    width: 250px;
    height: 250px;
  }
  
  .hero__actions {
    flex-direction: column;
    align-items: center;
  }
  
  .promises__grid {
    grid-template-columns: 1fr;
  }
}

EOF

echo "✅ CSS finalizado com seções completas e mãos sagradas!"
echo ""
echo "📋 RESUMO DO QUE FOI ADICIONADO:"
echo "• ✅ Seção Promises com banner carrossel"
echo "• ✅ Visual das mãos sagradas segurando pão brilhante"
echo "• ✅ Timeline bíblica interativa"
echo "• ✅ Chat espiritual estilizado"
echo "• ✅ Newsletter com formulário dourado"
echo "• ✅ Footer majestoso"
echo "• ✅ Responsividade completa"
echo "• ✅ Animações de luz divina e raios sagrados"
echo ""
echo "🙏 VISUAL DAS MÃOS SAGRADAS:"
echo "• Mãos invisíveis (sugeridas) segurando pão dourado"
echo "• Pão com textura realista e brilho divino"
echo "• Raios de luz girando ao redor"
echo "• Efeito de respiração divina"
echo "• Sombras e reflexos dourados"
echo ""
echo "📁 LOCALIZAÇÃO: css/style.css (finalizado)"
echo ""
echo "🚀 PRÓXIMOS PASSOS:"
echo "1. Digite 'continuar' para criar script 2-js.sh (JavaScript principal)"
echo "2. Testar: python3 -m http.server 8000"
echo ""
echo "⏳ Aguardando comando 'continuar'..."