#!/bin/bash

# =====================================================
# SCRIPT 1a - CSS DOURADO MAJESTOSO
# Atualiza CSS com paleta dourada/terrosa (SEM AZUL)
# =====================================================
# Uso: chmod +x 1a-css.sh && ./1a-css.sh
# =====================================================

set -e

echo "🎨 ATUALIZANDO CSS - PALETA DOURADA MAJESTOSA"
echo "🚫 Removendo azul - Adicionando tons dourados/terrosos"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "css/style.css" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto (onde existe css/style.css)"
    exit 1
fi

# Backup do CSS atual
cp css/style.css css/style.css.backup
echo "📋 Backup criado: css/style.css.backup"

# Criar novo CSS com paleta dourada
cat > css/style.css << 'EOF'
/* =====================================================
   PORTAL "JESUS É O PÃO DA VIDA" - CSS DOURADO MAJESTOSO
   Paleta: Dourado, Bronze, Terroso (SEM AZUL)
   Design: Impactante, Sagrado, Único
   ===================================================== */

/* =====================================================
   RESET & FUNDAÇÕES
   ===================================================== */

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

:root {
  /* PALETA DOURADA SAGRADA - Inspirada no Cesto de Pães */
  --color-gold-primary: #d4af37;      /* Ouro puro */
  --color-gold-light: #f4d03f;        /* Ouro claro */
  --color-gold-dark: #b7950b;         /* Ouro escuro */
  --color-bronze: #cd853f;            /* Bronze */
  --color-bronze-light: #daa520;      /* Bronze claro */
  --color-bronze-dark: #a0522d;       /* Bronze escuro */
  
  /* TONS TERROSOS SAGRADOS */
  --color-earth-primary: #8b4513;     /* Terra queimada */
  --color-earth-light: #a0522d;       /* Terra clara */
  --color-earth-dark: #654321;        /* Terra escura */
  --color-wheat: #f5deb3;             /* Trigo */
  --color-wheat-dark: #deb887;        /* Trigo escuro */
  
  /* NEUTROS SOFISTICADOS */
  --color-cream: #f5f1e8;             /* Creme */
  --color-cream-dark: #e8e0d0;        /* Creme escuro */
  --color-brown-50: #faf8f5;
  --color-brown-100: #f5f1e8;
  --color-brown-200: #e8e0d0;
  --color-brown-300: #d6c7b3;
  --color-brown-400: #b8a082;
  --color-brown-500: #9a7b5c;
  --color-brown-600: #7d5a3a;
  --color-brown-700: #5d3e25;
  --color-brown-800: #3d2817;
  --color-brown-900: #1a1611;         /* Marrom escuro principal */
  
  /* ESCURIDÃO SAGRADA */
  --color-dark-primary: #1a1611;      /* Fundo escuro principal */
  --color-dark-secondary: #2d1810;    /* Escuro secundário */
  --color-dark-tertiary: #0f0d0a;     /* Preto sagrado */
  
  /* GRADIENTES CELESTIAIS */
  --gradient-gold: linear-gradient(135deg, var(--color-gold-primary) 0%, var(--color-gold-light) 50%, var(--color-gold-dark) 100%);
  --gradient-bronze: linear-gradient(135deg, var(--color-bronze) 0%, var(--color-bronze-light) 100%);
  --gradient-earth: linear-gradient(135deg, var(--color-earth-primary) 0%, var(--color-earth-light) 100%);
  --gradient-divine: linear-gradient(180deg, var(--color-gold-light) 0%, var(--color-gold-primary) 50%, var(--color-gold-dark) 100%);
  --gradient-sacred: radial-gradient(circle, var(--color-gold-light) 0%, var(--color-gold-primary) 70%, var(--color-gold-dark) 100%);
  
  /* TIPOGRAFIA SAGRADA */
  --font-sacred: 'Cinzel', Georgia, serif;
  --font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
  
  /* ESPAÇAMENTOS */
  --space-xs: 0.5rem;
  --space-sm: 1rem;
  --space-md: 1.5rem;
  --space-lg: 2rem;
  --space-xl: 3rem;
  --space-2xl: 4rem;
  --space-3xl: 6rem;
  
  /* BORDAS & SOMBRAS DOURADAS */
  --radius-sm: 0.5rem;
  --radius-md: 0.75rem;
  --radius-lg: 1rem;
  --radius-xl: 1.5rem;
  --radius-2xl: 2rem;
  
  --shadow-gold-sm: 0 2px 8px rgba(212, 175, 55, 0.15);
  --shadow-gold-md: 0 8px 25px rgba(212, 175, 55, 0.25);
  --shadow-gold-lg: 0 15px 35px rgba(212, 175, 55, 0.35);
  --shadow-gold-xl: 0 25px 50px rgba(212, 175, 55, 0.4);
  --shadow-divine: 0 0 50px rgba(244, 208, 63, 0.6);
  
  /* TRANSIÇÕES */
  --transition-fast: 0.2s ease;
  --transition-base: 0.4s ease;
  --transition-slow: 0.6s ease;
}

/* =====================================================
   BASE STYLES
   ===================================================== */

html {
  scroll-behavior: smooth;
  font-size: 16px;
}

body {
  font-family: var(--font-primary);
  font-size: 1rem;
  line-height: 1.7;
  color: var(--color-cream);
  background: var(--color-dark-primary);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  overflow-x: hidden;
}

/* =====================================================
   LOADING STATES
   ===================================================== */

.loading {
  overflow: hidden;
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: var(--color-dark-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
  opacity: 1;
  transition: opacity var(--transition-slow);
}

.loading-spinner {
  width: 80px;
  height: 80px;
  position: relative;
}

.spinner-cross {
  width: 100%;
  height: 100%;
  position: relative;
  transform-origin: center;
  animation: holyGlow 3s ease-in-out infinite;
}

.spinner-cross::before,
.spinner-cross::after {
  content: '';
  position: absolute;
  background: var(--gradient-gold);
  border-radius: var(--radius-sm);
  box-shadow: var(--shadow-divine);
}

.spinner-cross::before {
  top: 15%;
  left: 47%;
  width: 6%;
  height: 70%;
}

.spinner-cross::after {
  top: 47%;
  left: 15%;
  width: 70%;
  height: 6%;
}

.spinner-light {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  background: var(--color-gold-light);
  border-radius: 50%;
  transform: translate(-50%, -50%);
  box-shadow: 0 0 30px var(--color-gold-light);
  animation: pulse 2s ease-in-out infinite;
}

@keyframes holyGlow {
  0%, 100% { 
    transform: rotate(0deg) scale(1);
    filter: drop-shadow(0 0 20px var(--color-gold-light));
  }
  50% { 
    transform: rotate(180deg) scale(1.1);
    filter: drop-shadow(0 0 40px var(--color-gold-primary));
  }
}

@keyframes pulse {
  0%, 100% { opacity: 1; transform: translate(-50%, -50%) scale(1); }
  50% { opacity: 0.7; transform: translate(-50%, -50%) scale(1.2); }
}

/* =====================================================
   UTILITY CLASSES
   ===================================================== */

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--space-md);
}

.text-gold {
  background: var(--gradient-gold);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

/* =====================================================
   TYPOGRAPHY
   ===================================================== */

h1, h2, h3, h4, h5, h6 {
  font-family: var(--font-sacred);
  font-weight: 700;
  line-height: 1.2;
  color: var(--color-cream);
  margin-bottom: var(--space-sm);
}

h1 { font-size: clamp(2.5rem, 6vw, 5rem); }
h2 { font-size: clamp(2rem, 5vw, 3.5rem); }
h3 { font-size: clamp(1.5rem, 4vw, 2.5rem); }
h4 { font-size: 1.5rem; }

p {
  margin-bottom: var(--space-sm);
  color: var(--color-brown-200);
}

/* =====================================================
   BUTTONS
   ===================================================== */

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-xs);
  padding: var(--space-md) var(--space-xl);
  font-weight: 600;
  font-size: 1rem;
  line-height: 1;
  border: 2px solid transparent;
  border-radius: var(--radius-xl);
  cursor: pointer;
  transition: all var(--transition-base);
  text-decoration: none;
  position: relative;
  overflow: hidden;
  white-space: nowrap;
  font-family: var(--font-primary);
}

.btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
  transition: left 0.6s;
}

.btn:hover::before {
  left: 100%;
}

.btn--primary {
  background: var(--gradient-gold);
  color: var(--color-dark-primary);
  box-shadow: var(--shadow-gold-lg);
  font-weight: 700;
}

.btn--primary:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow-gold-xl);
  filter: brightness(1.1);
}

.btn--secondary {
  background: transparent;
  color: var(--color-gold-primary);
  border-color: var(--color-gold-primary);
  backdrop-filter: blur(10px);
}

.btn--secondary:hover {
  background: var(--color-gold-primary);
  color: var(--color-dark-primary);
  transform: translateY(-3px);
  box-shadow: var(--shadow-gold-md);
}

EOF

echo "✅ CSS base criado com paleta dourada!"
echo ""
echo "📋 RESUMO DO QUE FOI FEITO:"
echo "• ✅ Paleta dourada/terrosa implementada"
echo "• ✅ Removido completamente o azul"
echo "• ✅ Cores principais: #d4af37 (ouro), #cd853f (bronze), #8b4513 (terra)"
echo "• ✅ Background escuro: #1a1611"
echo "• ✅ Gradientes dourados criados"
echo "• ✅ Tipografia sagrada (Cinzel + Inter)"
echo "• ✅ Animações e efeitos luminosos"
echo "• ✅ Backup salvo em: css/style.css.backup"
echo ""
echo "📁 LOCALIZAÇÃO: css/style.css"
echo ""
echo "🚀 PRÓXIMOS PASSOS:"
echo "1. Digite 'continuar' para criar script 1b (continuação do CSS)"
echo "2. Testar localmente: python3 -m http.server 8000"
echo "3. Acessar: http://localhost:8000"
echo ""
echo "⏳ Aguardando comando 'continuar'..."