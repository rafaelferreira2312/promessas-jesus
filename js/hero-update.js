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
