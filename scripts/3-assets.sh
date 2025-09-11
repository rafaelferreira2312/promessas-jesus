#!/bin/bash

# =====================================================
# SCRIPT 3 - ASSETS E HERO COM IMAGEM REAL
# Remove visual SVG, adiciona imagem jesus-pao.webp + efeitos de luz
# =====================================================
# Uso: chmod +x 3-assets.sh && ./3-assets.sh
# =====================================================

set -e

echo "🖼️ ATUALIZANDO HERO COM IMAGEM REAL"
echo "✨ Removendo SVG complexo, adicionando jesus-pao.webp"
echo "💡 Criando efeito de luz divina de cima para baixo"
echo ""

# Verificar se estamos na pasta correta
if [ ! -d "assets/images" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto (onde existe assets/images/)"
    exit 1
fi

echo "📁 Criando placeholder da imagem jesus-pao.webp..."

# Criar placeholder da imagem (usuário deve colocar a imagem real)
cat > assets/images/README-images.md << 'EOF'
# IMAGENS NECESSÁRIAS

## OBRIGATÓRIO: jesus-pao.webp
- Coloque a imagem das mãos de Jesus segurando o pão em: `assets/images/jesus-pao.webp`
- Formato: WebP (otimizado)
- Dimensões recomendadas: 400x400px ou 500x500px
- A imagem será envolvida por efeitos de luz dourada automáticos

## Outras imagens opcionais:
- bread-background.webp (para banner carrossel)
- hope-background.webp (para banner carrossel)  
- peace-background.webp (para banner carrossel)
- og-image.webp (para Open Graph)
- favicon.svg (ícone do site)
- apple-touch-icon.png (ícone iOS)

## Como adicionar:
1. Coloque jesus-pao.webp na pasta assets/images/
2. Execute o script
3. A imagem será automaticamente envolvida por luz divina
EOF

echo "✅ README criado em assets/images/"

# Atualizar o JavaScript para usar imagem real ao invés do SVG
echo "🔧 Atualizando JavaScript para usar imagem real..."

cat > js/hero-update.js << 'EOF'
/**
 * Atualização do Hero - Substitui SVG por imagem real com efeitos
 */

// Função para atualizar o hero visual
function updateHeroWithRealImage() {
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
}

// Executar quando DOM estiver pronto
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', updateHeroWithRealImage);
} else {
  updateHeroWithRealImage();
}
EOF

echo "✅ Novo JavaScript do hero criado!"

# Adicionar CSS para a imagem real e efeitos
echo "🎨 Adicionando CSS para imagem real e efeitos de luz..."

cat >> css/style.css << 'EOF'

/* =====================================================
   HERO COM IMAGEM REAL - JESUS E O PÃO
   ===================================================== */

.sacred-image-container {
  position: relative;
  width: 450px;
  height: 450px;
  margin: 0 auto;
  filter: drop-shadow(0 0 40px var(--color-gold-primary));
}

/* Imagem principal do Jesus */
.jesus-image-wrapper {
  position: relative;
  width: 100%;
  height: 100%;
  z-index: 5;
}

.jesus-bread-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 50%;
  border: 4px solid var(--color-gold-primary);
  box-shadow: 
    0 0 30px var(--color-gold-light),
    0 0 60px rgba(244, 208, 63, 0.6),
    inset 0 0 20px rgba(255, 255, 255, 0.1);
  animation: imageGlow 3s ease-in-out infinite;
}

/* Fallback se imagem não carregar */
.image-fallback {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: var(--gradient-gold);
  border-radius: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--color-dark-primary);
  font-family: var(--font-sacred);
  text-align: center;
  padding: 2rem;
}

.fallback-bread {
  width: 80px;
  height: 60px;
  background: var(--color-wheat);
  border-radius: 40px 40px 35px 35px;
  margin-bottom: 1rem;
  box-shadow: 0 5px 15px rgba(0,0,0,0.3);
  position: relative;
}

.fallback-bread::before {
  content: '';
  position: absolute;
  top: 15%;
  left: 20%;
  width: 8px;
  height: 6px;
  background: var(--color-earth-primary);
  border-radius: 50%;
  box-shadow: 
    15px 3px 0 rgba(139, 69, 19, 0.8),
    6px 12px 0 rgba(139, 69, 19, 0.6),
    20px 15px 0 rgba(139, 69, 19, 0.7);
}

.fallback-text {
  font-size: 1rem;
  font-weight: 600;
  line-height: 1.2;
}

/* Efeitos de luz de cima para baixo */
.divine-light-beam {
  position: absolute;
  top: -50px;
  left: 50%;
  width: 3px;
  height: 150px;
  background: linear-gradient(
    to bottom,
    transparent 0%,
    var(--color-gold-light) 20%,
    var(--color-gold-primary) 50%,
    var(--color-gold-light) 80%,
    transparent 100%
  );
  transform: translateX(-50%);
  opacity: 0.8;
  animation: lightBeam 4s ease-in-out infinite;
  z-index: 1;
}

.divine-light-beam.beam-2 {
  left: 40%;
  width: 2px;
  height: 120px;
  animation: lightBeam 4s ease-in-out infinite 1s;
  opacity: 0.6;
}

.divine-light-beam.beam-3 {
  left: 60%;
  width: 2px;
  height: 130px;
  animation: lightBeam 4s ease-in-out infinite 2s;
  opacity: 0.7;
}

/* Glow principal ao redor da imagem */
.image-glow {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 120%;
  height: 120%;
  background: radial-gradient(
    circle,
    var(--color-gold-light) 0%,
    var(--color-gold-primary) 30%,
    transparent 70%
  );
  border-radius: 50%;
  transform: translate(-50%, -50%);
  opacity: 0.4;
  animation: pulseGlow 3s ease-in-out infinite;
  z-index: 2;
}

/* Partículas de luz flutuantes */
.light-particles {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 3;
}

.particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: var(--color-gold-light);
  border-radius: 50%;
  opacity: 0;
  animation: floatParticle 6s linear infinite;
  box-shadow: 0 0 6px var(--color-gold-light);
}

.particle:nth-child(1) {
  left: 20%;
  animation-delay: 0s;
}

.particle:nth-child(2) {
  left: 40%;
  animation-delay: 1.2s;
}

.particle:nth-child(3) {
  left: 60%;
  animation-delay: 2.4s;
}

.particle:nth-child(4) {
  left: 80%;
  animation-delay: 3.6s;
}

.particle:nth-child(5) {
  left: 30%;
  animation-delay: 4.8s;
}

/* Raios de luz em diferentes direções */
.light-rays {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 100%;
  height: 100%;
  transform: translate(-50%, -50%);
  z-index: 1;
}

.ray {
  position: absolute;
  background: linear-gradient(
    90deg,
    transparent 0%,
    var(--color-gold-light) 50%,
    transparent 100%
  );
  opacity: 0.3;
  animation: rayRotate 8s linear infinite;
}

.ray-1 {
  top: 50%;
  left: -20%;
  width: 140%;
  height: 1px;
  transform: translateY(-50%) rotate(0deg);
}

.ray-2 {
  top: 50%;
  left: -20%;
  width: 140%;
  height: 1px;
  transform: translateY(-50%) rotate(45deg);
  animation-delay: 1s;
}

.ray-3 {
  top: 50%;
  left: -20%;
  width: 140%;
  height: 1px;
  transform: translateY(-50%) rotate(90deg);
  animation-delay: 2s;
}

.ray-4 {
  top: 50%;
  left: -20%;
  width: 140%;
  height: 1px;
  transform: translateY(-50%) rotate(135deg);
  animation-delay: 3s;
}

.ray-5 {
  top: 50%;
  left: -20%;
  width: 140%;
  height: 1px;
  transform: translateY(-50%) rotate(180deg);
  animation-delay: 4s;
}

/* Halo dourado */
.divine-halo {
  position: absolute;
  top: 10%;
  left: 50%;
  width: 80%;
  height: 40px;
  background: linear-gradient(
    to right,
    transparent 0%,
    var(--color-gold-primary) 20%,
    var(--color-gold-light) 50%,
    var(--color-gold-primary) 80%,
    transparent 100%
  );
  border-radius: 50%;
  transform: translateX(-50%);
  opacity: 0.6;
  animation: haloGlow 5s ease-in-out infinite;
  z-index: 4;
}

/* Animações */
@keyframes imageGlow {
  0%, 100% {
    box-shadow: 
      0 0 30px var(--color-gold-light),
      0 0 60px rgba(244, 208, 63, 0.6),
      inset 0 0 20px rgba(255, 255, 255, 0.1);
  }
  50% {
    box-shadow: 
      0 0 50px var(--color-gold-primary),
      0 0 80px rgba(244, 208, 63, 0.8),
      0 0 100px rgba(212, 175, 55, 0.4),
      inset 0 0 30px rgba(255, 255, 255, 0.2);
  }
}

@keyframes lightBeam {
  0%, 100% { 
    opacity: 0.3; 
    transform: translateX(-50%) scaleY(1); 
  }
  50% { 
    opacity: 0.8; 
    transform: translateX(-50%) scaleY(1.2); 
  }
}

@keyframes pulseGlow {
  0%, 100% { 
    opacity: 0.4; 
    transform: translate(-50%, -50%) scale(1); 
  }
  50% { 
    opacity: 0.7; 
    transform: translate(-50%, -50%) scale(1.1); 
  }
}

@keyframes floatParticle {
  0% { 
    bottom: -10px; 
    opacity: 0; 
    transform: translateX(0px) scale(0.5); 
  }
  20% { 
    opacity: 1; 
    transform: translateX(10px) scale(1); 
  }
  80% { 
    opacity: 1; 
    transform: translateX(-10px) scale(1); 
  }
  100% { 
    top: -10px; 
    opacity: 0; 
    transform: translateX(0px) scale(0.5); 
  }
}

@keyframes rayRotate {
  0% { transform: translateY(-50%) rotate(0deg); opacity: 0.2; }
  50% { opacity: 0.4; }
  100% { transform: translateY(-50%) rotate(360deg); opacity: 0.2; }
}

@keyframes haloGlow {
  0%, 100% { 
    opacity: 0.6; 
    transform: translateX(-50%) scaleX(1); 
  }
  50% { 
    opacity: 0.9; 
    transform: translateX(-50%) scaleX(1.1); 
  }
}

/* Responsivo para imagem */
@media (max-width: 1024px) {
  .sacred-image-container {
    width: 350px;
    height: 350px;
  }
}

@media (max-width: 768px) {
  .sacred-image-container {
    width: 300px;
    height: 300px;
  }
}

@media (max-width: 480px) {
  .sacred-image-container {
    width: 250px;
    height: 250px;
  }
}

EOF

echo "✅ CSS para imagem real e efeitos adicionado!"

# Atualizar o JavaScript principal para incluir a nova função
echo "🔧 Atualizando JavaScript principal..."

# Adicionar a nova função ao final do main.js
cat >> js/main.js << 'EOF'

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

EOF

echo "✅ JavaScript principal atualizado!"

echo ""
echo "📋 RESUMO DO QUE FOI FEITO:"
echo "• ✅ Removido visual SVG complexo do hero"
echo "• ✅ Criado sistema para imagem real jesus-pao.webp"
echo "• ✅ Efeitos de luz divina de cima para baixo"
echo "• ✅ Partículas flutuantes douradas"
echo "• ✅ Glow e halo ao redor da imagem"
echo "• ✅ Raios de luz girando"
echo "• ✅ Fallback caso imagem não carregue"
echo "• ✅ Sistema responsivo"
echo ""
echo "🖼️ PRÓXIMO PASSO OBRIGATÓRIO:"
echo "1. Coloque a imagem 'jesus-pao.webp' na pasta assets/images/"
echo "2. A imagem será automaticamente envolvida por luz divina"
echo ""
echo "📁 ARQUIVOS CRIADOS/ATUALIZADOS:"
echo "• css/style.css (efeitos adicionados)"
echo "• js/main.js (função atualizada)"
echo "• js/hero-update.js (novo arquivo)"
echo "• assets/images/README-images.md (instruções)"
echo ""
echo "🚀 PRÓXIMOS PASSOS:"
echo "1. Adicionar imagem jesus-pao.webp em assets/images/"
echo "2. Digite 'continuar' para criar script 4-seo.sh (SEO e otimizações)"
echo "3. Testar: python3 -m http.server 8000"
echo ""
echo "⏳ Aguardando comando 'continuar'..."