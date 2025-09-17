#!/bin/bash

# Script 13b: Corrigir Header/Footer - PARTE 2 (Novo Testamento)
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "✝️ CORRIGINDO PÁGINA DO NOVO TESTAMENTO - PARTE 2..."
echo "================================================"

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    exit 1
fi

# Verificar se PARTE 1 foi executada
if [ ! -f "pages/timeline/antigo-testamento/index.html" ]; then
    echo "❌ ERRO: Execute primeiro a PARTE 1 (13-fix-pages-header-footer.sh)"
    exit 1
fi

echo "✅ PARTE 1 detectada. Corrigindo Novo Testamento..."

# Extrair header e footer do index.html (caso não existam os arquivos temporários)
echo "📤 Extraindo header/footer do index.html..."
sed -n '/<header class="header"/,/<\/header>/p' index.html > /tmp/header_extract.html
sed -n '/<footer class="footer"/,/<\/footer>/p' index.html > /tmp/footer_extract.html

# Criar página corrigida do Novo Testamento
echo "✝️ Criando página corrigida do Novo Testamento..."
cat > pages/timeline/novo-testamento/index.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- SEO Meta Tags -->
    <title>✝️ Novo Testamento - Linha do Tempo Bíblica | Promessas de Jesus</title>
    <meta name="description" content="Cronologia detalhada do Novo Testamento com evidências arqueológicas. Vida de Jesus e Igreja Primitiva com fatos marcantes.">
    <meta name="keywords" content="novo testamento, jesus cristo, evangelhos, atos, paulo, apocalipse, arqueologia bíblica, brasil">
    
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
            background: linear-gradient(135deg, #4169E1 0%, #d4af37 100%);
            padding: 3rem 0;
            text-align: center;
            color: #fff;
            margin-top: 80px;
        }
        .page-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            padding: 3rem 0;
        }
        .book-card {
            background: rgba(212, 175, 55, 0.1);
            border: 1px solid rgba(65, 105, 225, 0.3);
            border-radius: 15px;
            padding: 2rem;
            transition: all 0.3s ease;
        }
        .book-card:hover {
            transform: translateY(-5px);
            border-color: #4169E1;
            box-shadow: 0 10px 20px rgba(65, 105, 225, 0.2);
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
echo "    <!-- Header idêntico ao index.html -->" >> pages/timeline/novo-testamento/index.html
cat /tmp/header_extract.html >> pages/timeline/novo-testamento/index.html

# Continuar com o conteúdo da página
cat >> pages/timeline/novo-testamento/index.html << 'EOF'

    <!-- Breadcrumb Navigation -->
    <nav class="nav-breadcrumb">
        <div class="container">
            <div class="breadcrumb-links">
                <a href="../../../index.html">🏠 Início</a>
                <span>→</span>
                <a href="../../../index.html#timeline">📜 Timeline</a>
                <span>→</span>
                <span>Novo Testamento</span>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main page-content">
        <div class="page-header">
            <div class="container">
                <h1 class="page-title">✝️ Novo Testamento</h1>
                <p class="page-subtitle">6 AC - 100 DC | 27 Livros | Vida de Jesus e Igreja Primitiva</p>
            </div>
        </div>

        <div class="container">
            <div class="books-grid">
                <!-- Mateus -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 Mateus</h3>
                    <div style="color: #4169E1; font-size: 0.9rem; margin-bottom: 1rem;">60-70 DC | Mateus | 28 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Jesus, o Rei Prometido</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">🌟 Nascimento de Jesus</div>
                            <p style="margin: 0 0 0.5rem;">Emanuel nasce de uma virgem em Belém</p>
                            <strong>Evidência:</strong> Igreja da Natividade preserva local tradicional
                        </div>
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">⛰️ Sermão do Monte</div>
                            <p style="margin: 0 0 0.5rem;">Jesus ensina as bem-aventuranças</p>
                            <strong>Evidência:</strong> Monte identificado com acústica natural ideal
                        </div>
                    </div>
                </div>

                <!-- João -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 João</h3>
                    <div style="color: #4169E1; font-size: 0.9rem; margin-bottom: 1rem;">90-95 DC | João | 21 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Jesus, o Filho de Deus</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">🍷 Água em Vinho</div>
                            <p style="margin: 0 0 0.5rem;">Primeiro milagre em Caná da Galileia</p>
                            <strong>Evidência:</strong> Sítio arqueológico confirma ocupação do séc I
                        </div>
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">💀 Ressurreição de Lázaro</div>
                            <p style="margin: 0 0 0.5rem;">Jesus ressuscita Lázaro após 4 dias</p>
                            <strong>Evidência:</strong> Betânia escavada revela túmulos do período
                        </div>
                    </div>
                </div>

                <!-- Atos -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 Atos</h3>
                    <div style="color: #4169E1; font-size: 0.9rem; margin-bottom: 1rem;">62-63 DC | Lucas | 28 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Expansão da Igreja pelo Espírito Santo</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">🔥 Pentecostes</div>
                            <p style="margin: 0 0 0.5rem;">Nascimento da Igreja cristã universal</p>
                            <strong>Evidência:</strong> Cenáculo tradicional preservado em Jerusalém
                        </div>
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">⚡ Conversão de Paulo</div>
                            <p style="margin: 0 0 0.5rem;">Saulo torna-se Paulo no caminho para Damasco</p>
                            <strong>Evidência:</strong> Via romana preservada arqueologicamente
                        </div>
                    </div>
                </div>

                <!-- Apocalipse -->
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem; margin-bottom: 0.5rem;">📖 Apocalipse</h3>
                    <div style="color: #4169E1; font-size: 0.9rem; margin-bottom: 1rem;">95-96 DC | João | 22 capítulos</div>
                    <p style="margin-bottom: 1rem;"><strong>Tema:</strong> Vitória Final de Cristo</p>
                    <div style="margin: 1rem 0;">
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">👁️ Visão do Cristo Glorificado</div>
                            <p style="margin: 0 0 0.5rem;">João vê Jesus em Sua glória celestial</p>
                            <strong>Evidência:</strong> Gruta da Apocalipse preserva tradições em Patmos
                        </div>
                        <div style="background: rgba(65, 105, 225, 0.1); border-left: 4px solid #4169E1; padding: 1rem; margin: 0.5rem 0; border-radius: 0 8px 8px 0;">
                            <div style="font-weight: 600; color: #4169E1; margin-bottom: 0.5rem;">🌅 Nova Jerusalém</div>
                            <p style="margin: 0 0 0.5rem;">Visão da cidade celestial descendo do céu</p>
                            <strong>Evidência:</strong> Simbolismo apocalíptico confirmado na literatura judaica
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

EOF

# Inserir footer extraído do index.html
echo "    <!-- Footer idêntico ao index.html -->" >> pages/timeline/novo-testamento/index.html
cat /tmp/footer_extract.html >> pages/timeline/novo-testamento/index.html

# Finalizar página NT
cat >> pages/timeline/novo-testamento/index.html << 'EOF'

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

# Limpeza dos arquivos temporários
echo "🧹 Limpando arquivos temporários..."
rm -f /tmp/header_extract.html /tmp/footer_extract.html

echo "✅ SCRIPT 13b-fix-pages-header-footer.sh PARTE 2 CONCLUÍDO!"
echo ""
echo "📋 NOVO TESTAMENTO CORRIGIDO:"
echo "   ✅ Header extraído e aplicado do index.html original"
echo "   ✅ Footer extraído e aplicado do index.html original"
echo "   ✅ Breadcrumb navigation adicionado"
echo "   ✅ CSS e JavaScript idênticos ao index.html"
echo "   ✅ Paleta de cores azul/dourada (NT)"
echo "   ✅ 4 livros principais com evidências arqueológicas"
echo ""
echo "🎨 DIFERENÇAS VISUAIS NT vs AT:"
echo "   • AT: Header dourado/marrom (Antigo Testamento)"
echo "   • NT: Header azul/dourado (Novo Testamento)"
echo "   • Bordas dos cards em cores correspondentes"
echo ""
echo "🌐 TESTE AMBAS AS PÁGINAS:"
echo "   • AT: http://localhost:8005/pages/timeline/antigo-testamento/"
echo "   • NT: http://localhost:8005/pages/timeline/novo-testamento/"
echo ""
echo "✅ PROJETO TIMELINE BÍBLICA COMPLETAMENTE FUNCIONAL!"
echo "   Header/Footer idênticos ao index.html"
echo "   Navegação completa funcionando"
echo "   Design consistente e responsivo"