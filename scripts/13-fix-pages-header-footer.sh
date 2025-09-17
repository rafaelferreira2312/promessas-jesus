#!/bin/bash

# Script 13: Corrigir Header e Footer das Páginas Timeline
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "🔧 CORRIGINDO HEADER/FOOTER DAS PÁGINAS TIMELINE..."
echo "================================================="

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    exit 1
fi

# Verificar se as páginas existem
if [ ! -d "pages/timeline/antigo-testamento" ] || [ ! -d "pages/timeline/novo-testamento" ]; then
    echo "❌ ERRO: Execute primeiro o script 11b-timeline-details.sh"
    exit 1
fi

echo "✅ Páginas detectadas. Corrigindo header/footer..."

# Backup das páginas
echo "💾 Criando backup das páginas..."
cp -r pages/timeline/ pages/timeline-backup-$(date +%Y%m%d_%H%M%S)/ 2>/dev/null

# Extrair header exato do index.html
echo "📤 Extraindo header do index.html..."
sed -n '/<header class="header"/,/<\/header>/p' index.html > /tmp/header_extract.html

# Extrair footer exato do index.html
echo "📥 Extraindo footer do index.html..."
sed -n '/<footer class="footer"/,/<\/footer>/p' index.html > /tmp/footer_extract.html

# Corrigir página do Antigo Testamento
echo "📜 Corrigindo página do Antigo Testamento..."
cat > pages/timeline/antigo-testamento/index.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- SEO Meta Tags -->
    <title>📜 Antigo Testamento - Linha do Tempo Bíblica | Promessas de Jesus</title>
    <meta name="description" content="Cronologia detalhada do Antigo Testamento com evidências arqueológicas. De Gênesis a Malaquias com fatos marcantes.">
    <meta name="keywords" content="antigo testamento, cronologia bíblica, arqueologia bíblica, gênesis, êxodo, reis, profetas, brasil">
    
    <!-- Performance Hints -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" href="https://fonts.gstatic.com/s/montserrat/v26/JTUSjIg1_i6t8kCHKm459Wlhyw.woff2" as="font" type="font/woff2" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="../../../assets/images/favicon.svg">
    
    <!-- Stylesheets -->
    <link rel="stylesheet" href="../../../css/style.css">
    <link rel="stylesheet" href="../../../css/timeline-fix.css">
    <link rel="stylesheet" href="../../../css/timeline-cross-fix.css">
    
    <!-- Critical CSS Inline -->
    <style>
        body { margin: 0; font-family: 'Montserrat', system-ui, sans-serif; background: #1a1611; color: #f5f1e8; }
        .page-content { min-height: 100vh; }
        .page-header {
            background: linear-gradient(135deg, #8B4513 0%, #d4af37 100%);
            padding: 3rem 0;
            text-align: center;
            color: #1a1611;
            margin-top: 80px;
        }
        .page-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            padding: 3rem 0;
        }
        .book-card {
            background: rgba(212, 175, 55, 0.1);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 15px;
            padding: 2rem;
            transition: all 0.3s ease;
        }
        .book-card:hover {
            transform: translateY(-5px);
            border-color: #d4af37;
            box-shadow: 0 10px 20px rgba(212, 175, 55, 0.2);
        }
        .nav-breadcrumb {
            background: rgba(0,0,0,0.5);
            padding: 1rem 0;
            margin-top: 80px;
        }
        .breadcrumb-links {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #d4af37;
        }
        .breadcrumb-links a {
            color: #d4af37;
            text-decoration: none;
            font-weight: 500;
        }
        .breadcrumb-links a:hover {
            color: #f4d03f;
        }
    </style>
</head>

<body class="loading">
EOF

# Inserir header extraído do index.html
echo "    <!-- Header idêntico ao index.html -->" >> pages/timeline/antigo-testamento/index.html
cat /tmp/header_extract.html >> pages/timeline/antigo-testamento/index.html

# Continuar com o conteúdo da página
cat >> pages/timeline/antigo-testamento/index.html << 'EOF'

    <!-- Breadcrumb Navigation -->
    <nav class="nav-breadcrumb">
        <div class="container">
            <div class="breadcrumb-links">
                <a href="../../../index.html">🏠 Início</a>
                <span>→</span>
                <a href="../../../index.html#timeline">📜 Timeline</a>
                <span>→</span>
                <span>Antigo Testamento</span>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main page-content">
        <div class="page-header">
            <div class="container">
                <h1 class="page-title">📜 Antigo Testamento</h1>
                <p class="page-subtitle">~2000 AC - 400 AC | 39 Livros | A História do Povo de Deus</p>
            </div>
        </div>

        <div class="container">
            <div class="books-grid">
                <!-- Gênesis -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 Gênesis</h3>
                    <div style="color: #f4d03f; font-size: 0.9rem; margin-bottom: 1rem;">~1400 AC | Moisés | 50 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Começos - Criação, Queda, Promessa</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(139, 69, 19, 0.2); border-left: 4px solid #d4af37; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #f4d03f; margin-bottom: 0.5rem;">🌍 Criação do Mundo</div>
                            <p style="margin: 0 0 0.5rem;">Deus criou os céus e a terra em seis dias</p>
                            <strong>Evidência:</strong> Descobertas cosmológicas corroboram início súbito do universo
                        </div>
                        <div style="background: rgba(139, 69, 19, 0.2); border-left: 4px solid #d4af37; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #f4d03f; margin-bottom: 0.5rem;">🌊 Dilúvio Universal</div>
                            <p style="margin: 0 0 0.5rem;">Noé salvo na arca durante julgamento mundial</p>
                            <strong>Evidência:</strong> Evidências geológicas de grandes inundações catastróficas
                        </div>
                    </div>
                </div>

                <!-- Êxodo -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 Êxodo</h3>
                    <div style="color: #f4d03f; font-size: 0.9rem; margin-bottom: 1rem;">~1280 AC | Moisés | 40 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Libertação - Do Egito para Terra Prometida</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(139, 69, 19, 0.2); border-left: 4px solid #d4af37; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #f4d03f; margin-bottom: 0.5rem;">🏺 10 Pragas do Egito</div>
                            <p style="margin: 0 0 0.5rem;">Deus demonstra supremacia sobre deuses egípcios</p>
                            <strong>Evidência:</strong> Papiro Ipuwer descreve calamidades similares
                        </div>
                        <div style="background: rgba(139, 69, 19, 0.2); border-left: 4px solid #d4af37; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #f4d03f; margin-bottom: 0.5rem;">🌊 Travessia do Mar Vermelho</div>
                            <p style="margin: 0 0 0.5rem;">Milagre da abertura das águas</p>
                            <strong>Evidência:</strong> Carros de guerra encontrados no fundo do mar
                        </div>
                    </div>
                </div>

                <!-- Reis -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 1 e 2 Reis</h3>
                    <div style="color: #f4d03f; font-size: 0.9rem; margin-bottom: 1rem;">~970-586 AC | Jeremias | 47 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Reino Unido e Dividido</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(139, 69, 19, 0.2); border-left: 4px solid #d4af37; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #f4d03f; margin-bottom: 0.5rem;">🏛️ Templo de Salomão</div>
                            <p style="margin: 0 0 0.5rem;">Construção do primeiro templo em Jerusalém</p>
                            <strong>Evidência:</strong> Fundações identificadas no Monte do Templo
                        </div>
                    </div>
                </div>

                <!-- Daniel -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 Daniel</h3>
                    <div style="color: #f4d03f; font-size: 0.9rem; margin-bottom: 1rem;">~605-536 AC | Daniel | 12 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Fidelidade em Terra Estrangeira</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(139, 69, 19, 0.2); border-left: 4px solid #d4af37; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #f4d03f; margin-bottom: 0.5rem;">🦁 Cova dos Leões</div>
                            <p style="margin: 0 0 0.5rem;">Daniel preservado milagrosamente dos leões</p>
                            <strong>Evidência:</strong> Registros babilônicos confirmam práticas de execução
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

EOF

# Inserir footer extraído do index.html
echo "    <!-- Footer idêntico ao index.html -->" >> pages/timeline/antigo-testamento/index.html
cat /tmp/footer_extract.html >> pages/timeline/antigo-testamento/index.html

# Finalizar página AT
cat >> pages/timeline/antigo-testamento/index.html << 'EOF'

    <!-- Scripts idênticos ao index.html -->
    <script src="../../../js/i18n/pt.js"></script>
    <script src="../../../js/i18n/en.js"></script>
    <script src="../../../js/main.js"></script>
    
    <!-- Performance Script -->
    <script>
        window.addEventListener('load', function() {
            document.body.classList.remove('loading');
            document.body.classList.add('loaded');
        });
    </script>
</body>
</html>
EOF

echo "✅ SCRIPT 13-fix-pages-header-footer.sh PARTE 1 CONCLUÍDO!"
echo ""
echo "📋 ANTIGO TESTAMENTO CORRIGIDO:"
echo "   ✅ Header extraído e aplicado do index.html original"
echo "   ✅ Footer extraído e aplicado do index.html original"
echo "   ✅ Breadcrumb navigation adicionado"
echo "   ✅ CSS e JavaScript idênticos"
echo "   ✅ Meta tags SEO otimizadas"
echo ""
echo "🌐 TESTE:"
echo "   http://localhost:8005/pages/timeline/antigo-testamento/"
echo ""
echo "⏭️ PRÓXIMO PASSO:"
echo "   Digite 'continuar' para corrigir página do Novo Testamento"