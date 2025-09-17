#!/bin/bash

# Script 10b: Linha do Tempo Bíblica - Página HTML e Finalização (PARTE 1b FINAL)
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "📜 FINALIZANDO LINHA DO TEMPO BÍBLICA - PARTE 1b FINAL..."
echo "========================================================"

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    exit 1
fi

# Verificar se PARTEs anteriores foram executadas
if [ ! -f "json/timeline/timeline-config.json" ] || [ ! -f "assets/js/timeline.js" ]; then
    echo "❌ ERRO: Execute primeiro as PARTEs 1 e 1a dos scripts anteriores"
    exit 1
fi

echo "✅ PARTEs 1 e 1a detectadas. Finalizando com PARTE 1b..."

# Criar página HTML completa da timeline
echo "🌐 Criando página HTML completa da timeline..."
cat > pages/timeline/index.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Linha do Tempo Bíblica Interativa | Promessas de Jesus</title>
    
    <!-- Meta Tags SEO -->
    <meta name="description" content="Explore a cronologia bíblica completa com evidências arqueológicas. Do Gênesis ao Apocalipse com fatos marcantes e descobertas científicas.">
    <meta name="keywords" content="linha do tempo bíblica, cronologia bíblica, arqueologia bíblica, antigo testamento, novo testamento, evidências arqueológicas, história bíblica, brasil">
    <meta name="author" content="Vancouver Tech - Promessas de Jesus">
    <meta name="robots" content="index, follow">
    
    <!-- Open Graph -->
    <meta property="og:title" content="Linha do Tempo Bíblica Interativa">
    <meta property="og:description" content="Jornada cronológica através das Escrituras com evidências arqueológicas únicas">
    <meta property="og:image" content="../../assets/images/timeline/timeline-preview.jpg">
    <meta property="og:url" content="https://promessasdejesus.vancouvertec.com.br/pages/timeline/">
    <meta property="og:type" content="website">
    
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Linha do Tempo Bíblica Interativa">
    <meta name="twitter:description" content="Explore a cronologia bíblica com evidências arqueológicas">
    <meta name="twitter:image" content="../../assets/images/timeline/timeline-preview.jpg">
    
    <!-- Canonical -->
    <link rel="canonical" href="https://promessasdejesus.vancouvertec.com.br/pages/timeline/">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <link rel="stylesheet" href="../../css/style.css">
    <link rel="stylesheet" href="../../assets/css/timeline.css">
    
    <!-- Schema.org Structured Data -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "Article",
        "headline": "Linha do Tempo Bíblica Interativa",
        "description": "Cronologia completa da Bíblia com evidências arqueológicas",
        "author": {
            "@type": "Organization",
            "name": "Vancouver Tech",
            "url": "https://vancouvertec.com.br"
        },
        "publisher": {
            "@type": "Organization",
            "name": "Promessas de Jesus",
            "logo": {
                "@type": "ImageObject",
                "url": "https://promessasdejesus.vancouvertec.com.br/assets/images/logo.svg"
            }
        },
        "datePublished": "2025-01-15",
        "dateModified": "2025-01-15",
        "mainEntityOfPage": {
            "@type": "WebPage",
            "@id": "https://promessasdejesus.vancouvertec.com.br/pages/timeline/"
        },
        "image": "https://promessasdejesus.vancouvertec.com.br/assets/images/timeline/timeline-preview.jpg"
    }
    </script>
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../assets/images/favicon.ico">
    <link rel="apple-touch-icon" href="../../assets/images/apple-touch-icon.png">
</head>

<body class="timeline-page">
    <!-- Header com navegação -->
    <header class="site-header">
        <nav class="navbar">
            <div class="nav-container">
                <a href="../../index.html" class="nav-logo">
                    <img src="../../assets/images/logo.svg" alt="Promessas de Jesus" width="40" height="40">
                    <span>Promessas de Jesus</span>
                </a>
                
                <div class="nav-menu" id="nav-menu">
                    <a href="../../index.html" class="nav-link">🏠 Início</a>
                    <a href="../quiz/" class="nav-link">📝 Quiz</a>
                    <a href="../blog/" class="nav-link">📖 Blog</a>
                    <a href="../recursos/" class="nav-link">📚 Recursos</a>
                    <a href="#" class="nav-link active">📜 Timeline</a>
                    <a href="../chat/" class="nav-link">💬 Chat</a>
                </div>
                
                <div class="nav-toggle" id="nav-toggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </nav>
    </header>

    <!-- Breadcrumb -->
    <nav class="breadcrumb" aria-label="Navegação da página">
        <div class="container">
            <ol class="breadcrumb-list">
                <li><a href="../../index.html">🏠 Início</a></li>
                <li><a href="../">📄 Páginas</a></li>
                <li class="active">📜 Timeline Bíblica</li>
            </ol>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Hero Section -->
            <section class="timeline-hero">
                <div class="hero-content">
                    <h1 class="hero-title">
                        📜 Linha do Tempo Bíblica
                        <span class="hero-subtitle">Do Gênesis ao Apocalipse</span>
                    </h1>
                    <p class="hero-description">
                        Explore a cronologia completa das Escrituras com evidências arqueológicas 
                        que comprovam a veracidade dos fatos bíblicos. Uma jornada de 4.000 anos 
                        através da história da salvação.
                    </p>
                    <div class="hero-stats">
                        <div class="stat-item">
                            <span class="stat-number">66</span>
                            <span class="stat-label">Livros</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">4.000+</span>
                            <span class="stat-label">Anos</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">100+</span>
                            <span class="stat-label">Evidências</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Timeline Container -->
            <section class="biblical-timeline-section">
                <div id="biblical-timeline" class="biblical-timeline">
                    <!-- Conteúdo será carregado via JavaScript -->
                </div>
            </section>

            <!-- Informações Adicionais -->
            <section class="timeline-info">
                <div class="info-grid">
                    <div class="info-card">
                        <h3>🏺 Evidências Arqueológicas</h3>
                        <p>Cada evento bíblico é acompanhado de descobertas arqueológicas que confirmam os relatos das Escrituras.</p>
                    </div>
                    <div class="info-card">
                        <h3>🗺️ Localizações Geográficas</h3>
                        <p>Coordenadas precisas dos locais onde os eventos ocorreram, com mapas interativos.</p>
                    </div>
                    <div class="info-card">
                        <h3>📚 Fontes Acadêmicas</h3>
                        <p>Todas as informações são baseadas em pesquisas de universidades e institutos renomados.</p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <!-- Footer -->
    <footer class="site-footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>📜 Timeline Bíblica</h4>
                    <p>Explore 4.000 anos da história sagrada com evidências científicas.</p>
                </div>
                <div class="footer-section">
                    <h4>🔗 Links Úteis</h4>
                    <ul>
                        <li><a href="../../index.html">Início</a></li>
                        <li><a href="../quiz/">Quiz Bíblico</a></li>
                        <li><a href="../recursos/">Recursos</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>📞 Contato</h4>
                    <p>Email: contato@vancouvertec.com.br</p>
                    <p>Site: vancouvertec.com.br</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Promessas de Jesus | Desenvolvido por Vancouver Tech ❤️</p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="../../js/main.js"></script>
    <script src="../../assets/js/timeline.js"></script>
    
    <!-- Google Maps API (se necessário) -->
    <script async defer 
            src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap">
    </script>
    
    <!-- Análise de Performance -->
    <script>
        // Lazy loading de imagens arqueológicas
        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.src = img.dataset.src;
                        img.classList.remove('lazy');
                        observer.unobserve(img);
                    }
                });
            });

            document.querySelectorAll('img[data-src]').forEach(img => {
                imageObserver.observe(img);
            });
        }
    </script>
</body>
</html>
EOF

# Atualizar CSS com animações avançadas
echo "🎨 Atualizando CSS com animações avançadas..."
cat >> assets/css/timeline.css << 'EOF'

/* ============================================
   ANIMAÇÕES E EFEITOS AVANÇADOS - PARTE 1b
   ============================================ */

/* Hero Section */
.timeline-hero {
    background: linear-gradient(135deg, #1a1611 0%, #2c1810 100%);
    padding: 4rem 0;
    color: #d4af37;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.timeline-hero::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('../../assets/images/timeline/hero-pattern.webp') center/cover;
    opacity: 0.1;
    z-index: 1;
}

.hero-content {
    position: relative;
    z-index: 2;
}

.hero-title {
    font-size: clamp(2rem, 5vw, 4rem);
    font-weight: 800;
    margin-bottom: 1rem;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

.hero-subtitle {
    display: block;
    font-size: 0.6em;
    color: #f4d03f;
    font-weight: 400;
    margin-top: 0.5rem;
}

.hero-description {
    font-size: 1.2rem;
    max-width: 600px;
    margin: 0 auto 2rem;
    opacity: 0.9;
    line-height: 1.6;
}

.hero-stats {
    display: flex;
    justify-content: center;
    gap: 2rem;
    margin-top: 2rem;
}

.stat-item {
    text-align: center;
}

.stat-number {
    display: block;
    font-size: 2.5rem;
    font-weight: 700;
    color: #f4d03f;
    text-shadow: 0 0 10px rgba(244, 208, 63, 0.5);
}

.stat-label {
    display: block;
    font-size: 0.9rem;
    opacity: 0.8;
    text-transform: uppercase;
    letter-spacing: 1px;
}

/* Timeline Header */
.timeline-header {
    text-align: center;
    padding: 2rem 0;
    background: rgba(212, 175, 55, 0.05);
    margin-bottom: 2rem;
    border-radius: 20px;
}

.timeline-title {
    font-size: 2.5rem;
    color: #d4af37;
    margin-bottom: 1rem;
    font-weight: 700;
}

.timeline-description {
    font-size: 1.1rem;
    opacity: 0.8;
    max-width: 600px;
    margin: 0 auto 2rem;
}

/* Testament Selector */
.testament-selector {
    display: flex;
    justify-content: center;
    gap: 1rem;
    margin: 2rem 0;
}

.testament-btn {
    padding: 1rem 2rem;
    background: transparent;
    border: 2px solid #d4af37;
    color: #d4af37;
    border-radius: 50px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 600;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.testament-btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(244, 208, 63, 0.2), transparent);
    transition: left 0.5s;
}

.testament-btn:hover::before {
    left: 100%;
}

.testament-btn:hover {
    background: rgba(212, 175, 55, 0.1);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
}

.testament-btn.active {
    background: #d4af37;
    color: #1a1611;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.5);
}

/* Testament Section */
.testament-section {
    animation: fadeInUp 0.8s ease;
}

.testament-header {
    text-align: center;
    margin-bottom: 3rem;
    padding: 2rem;
    background: rgba(212, 175, 55, 0.05);
    border-radius: 20px;
    border: 1px solid rgba(212, 175, 55, 0.2);
}

.testament-title-main {
    font-size: 2.5rem;
    color: #d4af37;
    margin-bottom: 0.5rem;
    font-weight: 700;
}

.testament-subtitle {
    font-size: 1.3rem;
    color: #f4d03f;
    margin-bottom: 1rem;
    font-style: italic;
}

.testament-period {
    display: inline-block;
    background: rgba(212, 175, 55, 0.2);
    color: #d4af37;
    padding: 0.5rem 1.5rem;
    border-radius: 25px;
    font-weight: 600;
    font-size: 1rem;
}

/* Book Content Animations */
.bible-book {
    opacity: 0;
    transform: translateY(50px);
    transition: all 0.6s ease;
}

.bible-book.animate-in {
    opacity: 1;
    transform: translateY(0);
}

.bible-book.odd {
    animation-delay: 0.1s;
}

.bible-book.even {
    animation-delay: 0.2s;
}

/* Archaeological Evidence */
.archaeological-evidence {
    background: rgba(205, 133, 63, 0.1);
    border: 1px solid rgba(205, 133, 63, 0.3);
    border-radius: 15px;
    padding: 1.5rem;
    margin: 1rem 0;
}

.archaeological-evidence h6 {
    color: #cd853f;
    font-size: 1.1rem;
    margin-bottom: 1rem;
    font-weight: 600;
}

.evidence-content {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 1rem;
    align-items: start;
}

.evidence-image img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    filter: sepia(20%) saturate(80%);
    transition: filter 0.3s ease;
}

.evidence-image img:hover {
    filter: sepia(0%) saturate(100%);
}

.evidence-sources {
    margin-top: 1rem;
    font-size: 0.9rem;
    opacity: 0.8;
    font-style: italic;
}

/* Location Info */
.location-info {
    background: rgba(34, 139, 34, 0.1);
    border: 1px solid rgba(34, 139, 34, 0.3);
    border-radius: 10px;
    padding: 1rem;
    margin: 1rem 0;
}

.btn-map {
    background: #228B22;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    cursor: pointer;
    font-family: 'Montserrat', sans-serif;
    font-weight: 500;
    margin-left: 1rem;
    transition: all 0.3s ease;
}

.btn-map:hover {
    background: #32CD32;
    transform: translateY(-2px);
    box-shadow: 0 3px 10px rgba(34, 139, 34, 0.3);
}

/* Expand Button */
.btn-expand {
    width: 100%;
    padding: 1rem;
    background: linear-gradient(135deg, #d4af37 0%, #f4d03f 100%);
    color: #1a1611;
    border: none;
    border-radius: 10px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 600;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 1rem;
}

.btn-expand:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
}

.bible-book.expanded .book-events {
    max-height: none;
}

/* Timeline Stats */
.timeline-stats {
    text-align: center;
    padding: 2rem;
    background: rgba(212, 175, 55, 0.05);
    border-radius: 15px;
    margin-top: 3rem;
    font-size: 1.1rem;
    color: #d4af37;
    border: 1px solid rgba(212, 175, 55, 0.2);
}

/* Info Grid */
.timeline-info {
    margin: 4rem 0;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    margin-top: 2rem;
}

.info-card {
    background: rgba(212, 175, 55, 0.1);
    border: 1px solid rgba(212, 175, 55, 0.2);
    border-radius: 15px;
    padding: 2rem;
    text-align: center;
    transition: all 0.3s ease;
}

.info-card:hover {
    transform: translateY(-5px);
    border-color: #d4af37;
    box-shadow: 0 10px 20px rgba(212, 175, 55, 0.2);
}

.info-card h3 {
    color: #d4af37;
    font-size: 1.3rem;
    margin-bottom: 1rem;
    font-weight: 600;
}

.info-card p {
    opacity: 0.9;
    line-height: 1.6;
}

/* Loading States */
.timeline-loading {
    text-align: center;
    padding: 4rem 2rem;
    color: #d4af37;
}

.loading-spinner {
    width: 50px;
    height: 50px;
    border: 4px solid rgba(212, 175, 55, 0.1);
    border-top: 4px solid #d4af37;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 1rem;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Keyframe Animations */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
}

.timeline-marker:hover {
    animation: pulse 1s ease-in-out;
}

/* Responsivo Mobile */
@media (max-width: 768px) {
    .hero-stats {
        flex-direction: column;
        gap: 1rem;
    }
    
    .testament-selector {
        flex-direction: column;
        align-items: center;
    }
    
    .testament-btn {
        width: 80%;
        max-width: 300px;
    }
    
    .evidence-content {
        grid-template-columns: 1fr;
    }
    
    .info-grid {
        grid-template-columns: 1fr;
    }
    
    .timeline-stats {
        font-size: 0.9rem;
        padding: 1rem;
    }
}
EOF

# Adicionar link para timeline no menu principal
echo "🔗 Adicionando link da timeline ao menu principal..."
if [ -f "index.html" ]; then
    # Backup do index.html
    cp index.html index.html.backup-timeline-$(date +%Y%m%d_%H%M%S)
    
    # Adicionar link da timeline se não existir
    if ! grep -q "timeline" index.html; then
        sed -i '/quiz.*nav-link/a\                    <a href="pages/timeline/" class="nav-link">📜 Timeline</a>' index.html
    fi
    
    echo "✅ Link da timeline adicionado ao menu principal"
else
    echo "⚠️  index.html não encontrado - adicione manualmente o link da timeline"
fi

# Criar arquivo de instruções de uso
echo "📝 Criando arquivo de instruções..."
cat > pages/timeline/README.md << 'EOF'
# 📜 Linha do Tempo Bíblica Interativa

## 🎯 Visão Geral
Linha do tempo cronológica completa da Bíblia, do Gênesis ao Apocalipse, com evidências arqueológicas e coordenadas geográficas precisas.

## 🔧 Funcionalidades
- ✅ Timeline visual interativa
- ✅ Filtros por Antigo/Novo Testamento  
- ✅ Evidências arqueológicas com imagens
- ✅ Coordenadas geográficas de eventos
- ✅ Animações e efeitos visuais
- ✅ Design responsivo (mobile-first)

## 📁 Estrutura de Arquivos
```
pages/timeline/
├── index.html              # Página principal
└── README.md              # Este arquivo

assets/
├── css/timeline.css       # Estilos da timeline
├── js/timeline.js         # JavaScript interativo
└── images/timeline/       # Imagens arqueológicas
    ├── old-testament/     # AT
    ├── new-testament/     # NT
    └── archaeological/    # Evidências

json/timeline/
├── timeline-config.json   # Configurações
├── old-testament.json     # Dados do AT
└── new-testament.json     # Dados do NT
```

## 🚀 Como Usar
1. Acesse: `/pages/timeline/`
2. Escolha testamento: AT ou NT
3. Navegue pelos eventos
4. Clique em "Ver Detalhes" para expandir
5. Use botões "Ver no Mapa" para localização

## 🖼️ Adicionando Imagens Arqueológicas
1. Coloque imagens em `assets/images/timeline/archaeological/`
2. Use formato WebP (fallback JPG)
3. Tamanho recomendado: 800x600px
4. Nomeação: `evento-evidencia.webp`

## 📱 Responsividade
- Desktop: Layout em duas colunas
- Tablet: Layout adaptativo
- Mobile: Timeline vertical simplificada

## 🔍 SEO Otimizado
- Meta tags completas
- Schema.org structured data
- OpenGraph e Twitter Cards
- Sitemap incluído automaticamente

## 📞 Suporte
Para dúvidas: contato@vancouvertec.com.br
EOF

echo "✅ SCRIPT 10b-timeline-biblical.sh PARTE 1b FINAL EXECUTADO COM SUCESSO!"
echo ""
echo "🎉 LINHA DO TEMPO BÍBLICA COMPLETAMENTE IMPLEMENTADA!"
echo "========================================================="
echo ""
echo "📋 RESUMO COMPLETO - TODAS AS PARTES:"
echo "   ✅ PARTE 1: Estrutura base e Antigo Testamento"
echo "   ✅ PARTE 1a: Novo Testamento e JavaScript"
echo "   ✅ PARTE 1b: Página HTML e finalização"
echo ""
echo "📁 TODOS OS ARQUIVOS CRIADOS:"
echo "   • pages/timeline/index.html - Página principal"
echo "   • pages/timeline/README.md - Instruções de uso"
echo "   • json/timeline/*.json - Dados completos"
echo "   • assets/css/timeline.css - Estilos avançados"
echo "   • assets/js/timeline.js - JavaScript interativo"
echo "   • assets/images/timeline/ - Estrutura de imagens"
echo ""
echo "🌟 RECURSOS IMPLEMENTADOS:"
echo "   📜 66 livros bíblicos detalhados"
echo "   🏺 100+ evidências arqueológicas"
echo "   🗺️ Coordenadas geográficas precisas"
echo "   🎨 Animações e efeitos visuais"
echo "   📱 Design completamente responsivo"
echo "   🔍 SEO otimizado com Schema.org"
echo "   ⚡ Performance otimizada (lazy loading)"
echo ""
echo "🚀 PARA EXECUTAR TODAS AS PARTES:"
echo "   chmod +x 10-timeline-biblical.sh && ./10-timeline-biblical.sh"
echo "   chmod +x 10a-timeline-biblical.sh && ./10a-timeline-biblical.sh"
echo "   chmod +x 10b-timeline-biblical.sh && ./10b-timeline-biblical.sh"
echo ""
echo "🌐 ACESSO:"
echo "   URL: https://promessasdejesus.vancouvertec.com.br/pages/timeline/"
echo "   Menu: 📜 Timeline (adicionado automaticamente)"
echo ""
echo "📚 PRÓXIMOS PASSOS RECOMENDADOS:"
echo "   1. Adicionar imagens arqueológicas reais"