#!/bin/bash

# Script 11b: Timeline Details - PARTE 1a (Páginas Detalhadas)
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "📜 CRIANDO PÁGINAS DETALHADAS DOS TESTAMENTOS - PARTE 1a..."
echo "========================================================="

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    exit 1
fi

# Verificar se PARTE 1 foi executada
if [ ! -f "css/timeline-fix.css" ]; then
    echo "❌ ERRO: Execute primeiro a PARTE 1 (11a-timeline-details.sh)"
    exit 1
fi

echo "✅ PARTE 1 detectada. Criando páginas detalhadas..."

# Criar estrutura de pastas
echo "📁 Criando estrutura de páginas..."
mkdir -p pages/timeline/antigo-testamento/
mkdir -p pages/timeline/novo-testamento/

# Criar página do Antigo Testamento
echo "📜 Criando página detalhada do Antigo Testamento..."
cat > pages/timeline/antigo-testamento/index.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📜 Antigo Testamento - Timeline Bíblica | Promessas de Jesus</title>
    
    <!-- Meta Tags SEO -->
    <meta name="description" content="Cronologia detalhada do Antigo Testamento com evidências arqueológicas. De Gênesis a Malaquias.">
    <meta name="keywords" content="antigo testamento, cronologia bíblica, arqueologia, gênesis, êxodo">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <link rel="stylesheet" href="../../../css/style.css">
    <link rel="stylesheet" href="../../../css/timeline-fix.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #1a1611 0%, #2c1810 100%);
            color: #f5f1e8;
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        .page-header {
            background: linear-gradient(135deg, #8B4513 0%, #d4af37 100%);
            padding: 3rem 0;
            text-align: center;
            color: #1a1611;
        }
        
        .page-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .page-subtitle {
            font-size: 1.2rem;
            opacity: 0.8;
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
        
        .book-name {
            color: #d4af37;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .book-period {
            color: #f4d03f;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            opacity: 0.8;
        }
        
        .book-facts {
            margin: 1rem 0;
        }
        
        .fact-item {
            background: rgba(139, 69, 19, 0.2);
            border-left: 4px solid #d4af37;
            padding: 1rem;
            margin: 0.5rem 0;
            border-radius: 0 8px 8px 0;
        }
        
        .fact-title {
            font-weight: 600;
            color: #f4d03f;
            margin-bottom: 0.5rem;
        }
        
        .nav-back {
            display: inline-block;
            margin: 2rem;
            padding: 1rem 2rem;
            background: rgba(212, 175, 55, 0.1);
            border: 2px solid #d4af37;
            color: #d4af37;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .nav-back:hover {
            background: #d4af37;
            color: #1a1611;
            transform: translateY(-2px);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
    </style>
</head>

<body>
    <!-- Header igual ao index.html -->
    <header class="header">
        <nav class="nav">
            <div class="nav__container">
                <div class="nav__logo">
                    <svg class="logo-icon" width="45" height="45" viewBox="0 0 45 45">
                        <defs>
                            <linearGradient id="crossGradient">
                                <stop offset="0%" style="stop-color:#d4af37"/>
                                <stop offset="100%" style="stop-color:#f4d03f"/>
                            </linearGradient>
                        </defs>
                        <circle cx="22.5" cy="22.5" r="21" stroke="url(#crossGradient)" stroke-width="3" fill="none"/>
                        <rect x="20" y="8" width="5" height="29" rx="2.5" fill="url(#crossGradient)"/>
                        <rect x="8" y="20" width="29" height="5" rx="2.5" fill="url(#crossGradient)"/>
                    </svg>
                    <span class="logo-text">Jesus é o Pão da Vida</span>
                </div>

                <ul class="nav__menu">
                    <li><a href="../../../index.html#home" class="nav__link">Início</a></li>
                    <li><a href="../../../index.html#promises" class="nav__link">Promessas</a></li>
                    <li><a href="../../../index.html#timeline" class="nav__link">Timeline</a></li>
                    <li><a href="../../../index.html#chat" class="nav__link">Chat</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <!-- Navegação -->
    <a href="../../../index.html#timeline" class="nav-back">🏠 ← Voltar para Timeline</a>

    <!-- Header da página -->
    <div class="page-header">
        <div class="container">
            <h1 class="page-title">📜 Antigo Testamento</h1>
            <p class="page-subtitle">~2000 AC - 400 AC | 39 Livros | A História do Povo de Deus</p>
        </div>
    </div>

    <!-- Conteúdo principal -->
    <main>
        <div class="container">
            <div class="books-grid">
                <!-- Gênesis -->
                <div class="book-card">
                    <h3 class="book-name">📖 Gênesis</h3>
                    <div class="book-period">~1400 AC | Moisés | 50 capítulos</div>
                    <p><strong>Tema:</strong> Começos - Criação, Queda, Promessa</p>
                    <div class="book-facts">
                        <div class="fact-item">
                            <div class="fact-title">🌍 Criação do Mundo</div>
                            <p>Deus criou os céus e a terra em seis dias</p>
                            <strong>Evidência:</strong> Big Bang corrobora início súbito do universo
                        </div>
                        <div class="fact-item">
                            <div class="fact-title">🌊 Dilúvio Universal</div>
                            <p>Noé salvo na arca durante julgamento mundial</p>
                            <strong>Evidência:</strong> Evidências geológicas de inundações catastróficas
                        </div>
                    </div>
                </div>

                <!-- Êxodo -->
                <div class="book-card">
                    <h3 class="book-name">📖 Êxodo</h3>
                    <div class="book-period">~1280 AC | Moisés | 40 capítulos</div>
                    <p><strong>Tema:</strong> Libertação - Do Egito para Terra Prometida</p>
                    <div class="book-facts">
                        <div class="fact-item">
                            <div class="fact-title">🏺 10 Pragas do Egito</div>
                            <p>Deus demonstra supremacia sobre deuses egípcios</p>
                            <strong>Evidência:</strong> Papiro Ipuwer descreve calamidades similares
                        </div>
                        <div class="fact-item">
                            <div class="fact-title">🌊 Travessia do Mar Vermelho</div>
                            <p>Milagre da abertura das águas</p>
                            <strong>Evidência:</strong> Carros de guerra encontrados no fundo do mar
                        </div>
                    </div>
                </div>

                <!-- Reis -->
                <div class="book-card">
                    <h3 class="book-name">📖 1 e 2 Reis</h3>
                    <div class="book-period">~970-586 AC | Jeremias | 47 capítulos</div>
                    <p><strong>Tema:</strong> Reino Unido e Dividido</p>
                    <div class="book-facts">
                        <div class="fact-item">
                            <div class="fact-title">🏛️ Templo de Salomão</div>
                            <p>Construção do primeiro templo em Jerusalém</p>
                            <strong>Evidência:</strong> Fundações identificadas no Monte do Templo
                        </div>
                    </div>
                </div>

                <!-- Daniel -->
                <div class="book-card">
                    <h3 class="book-name">📖 Daniel</h3>
                    <div class="book-period">~605-536 AC | Daniel | 12 capítulos</div>
                    <p><strong>Tema:</strong> Fidelidade em Terra Estrangeira</p>
                    <div class="book-facts">
                        <div class="fact-item">
                            <div class="fact-title">🦁 Cova dos Leões</div>
                            <p>Daniel preservado milagrosamente dos leões</p>
                            <strong>Evidência:</strong> Registros babilônicos confirmam práticas
                        </div>
                        <div class="fact-item">
                            <div class="fact-title">🏛️ Profecias dos Impérios</div>
                            <p>Visões sobre sucessão de impérios mundiais</p>
                            <strong>Evidência:</strong> História confirma exatidão das predições
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer__content">
                <div class="footer__brand">
                    <div class="footer__logo">
                        <svg width="40" height="40" viewBox="0 0 40 40">
                            <rect x="18" y="8" width="4" height="24" rx="2" fill="currentColor"/>
                            <rect x="10" y="16" width="20" height="4" rx="2" fill="currentColor"/>
                        </svg>
                        <span>Jesus é o Pão da Vida</span>
                    </div>
                    <p>Timeline do Antigo Testamento com evidências arqueológicas</p>
                </div>
            </div>
            <div class="footer__bottom">
                <p>&copy; 2025 Promessas de Jesus. Feito com ❤️ para a glória de Deus.</p>
            </div>
        </div>
    </footer>
</body>
</html>
EOF

# Criar página do Novo Testamento
echo "✝️ Criando página detalhada do Novo Testamento..."
cat > pages/timeline/novo-testamento/index.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>✝️ Novo Testamento - Timeline Bíblica | Promessas de Jesus</title>
    
    <!-- Meta Tags -->
    <meta name="description" content="Cronologia detalhada do Novo Testamento. Vida de Jesus e Igreja Primitiva.">
    <meta name="keywords" content="novo testamento, jesus cristo, evangelhos, atos, paulo">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <link rel="stylesheet" href="../../../css/style.css">
    <link rel="stylesheet" href="../../../css/timeline-fix.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #1a1611 0%, #2c1810 100%);
            color: #f5f1e8;
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        .page-header {
            background: linear-gradient(135deg, #4169E1 0%, #d4af37 100%);
            padding: 3rem 0;
            text-align: center;
            color: #fff;
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
        
        .fact-item {
            background: rgba(65, 105, 225, 0.1);
            border-left: 4px solid #4169E1;
            padding: 1rem;
            margin: 0.5rem 0;
            border-radius: 0 8px 8px 0;
        }
        
        .fact-title {
            font-weight: 600;
            color: #4169E1;
            margin-bottom: 0.5rem;
        }
        
        .nav-back {
            display: inline-block;
            margin: 2rem;
            padding: 1rem 2rem;
            background: rgba(212, 175, 55, 0.1);
            border: 2px solid #d4af37;
            color: #d4af37;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .nav-back:hover {
            background: #d4af37;
            color: #1a1611;
            transform: translateY(-2px);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
    </style>
</head>

<body>
    <!-- Header -->
    <header class="header">
        <nav class="nav">
            <div class="nav__container">
                <div class="nav__logo">
                    <svg class="logo-icon" width="45" height="45" viewBox="0 0 45 45">
                        <defs>
                            <linearGradient id="crossGradient">
                                <stop offset="0%" style="stop-color:#d4af37"/>
                                <stop offset="100%" style="stop-color:#f4d03f"/>
                            </linearGradient>
                        </defs>
                        <circle cx="22.5" cy="22.5" r="21" stroke="url(#crossGradient)" stroke-width="3" fill="none"/>
                        <rect x="20" y="8" width="5" height="29" rx="2.5" fill="url(#crossGradient)"/>
                        <rect x="8" y="20" width="29" height="5" rx="2.5" fill="url(#crossGradient)"/>
                    </svg>
                    <span class="logo-text">Jesus é o Pão da Vida</span>
                </div>
                <ul class="nav__menu">
                    <li><a href="../../../index.html#home" class="nav__link">Início</a></li>
                    <li><a href="../../../index.html#timeline" class="nav__link">Timeline</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <a href="../../../index.html#timeline" class="nav-back">🏠 ← Voltar para Timeline</a>

    <div class="page-header">
        <div class="container">
            <h1 class="page-title">✝️ Novo Testamento</h1>
            <p>6 AC - 100 DC | 27 Livros | Vida de Jesus e Igreja Primitiva</p>
        </div>
    </div>

    <main>
        <div class="container">
            <div class="books-grid">
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem;">📖 Mateus</h3>
                    <div style="color: #4169E1; margin-bottom: 1rem;">60-70 DC | Mateus | 28 capítulos</div>
                    <p><strong>Tema:</strong> Jesus, o Rei Prometido</p>
                    <div class="fact-item">
                        <div class="fact-title">🌟 Nascimento de Jesus</div>
                        <p>Emanuel nasce de uma virgem em Belém</p>
                        <strong>Evidência:</strong> Igreja da Natividade preserva local tradicional
                    </div>
                </div>
                
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem;">📖 João</h3>
                    <div style="color: #4169E1; margin-bottom: 1rem;">90-95 DC | João | 21 capítulos</div>
                    <p><strong>Tema:</strong> Jesus, o Filho de Deus</p>
                    <div class="fact-item">
                        <div class="fact-title">🍷 Água em Vinho</div>
                        <p>Primeiro milagre em Caná da Galileia</p>
                        <strong>Evidência:</strong> Sítio arqueológico confirma ocupação do séc I
                    </div>
                </div>
                
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem;">📖 Atos</h3>
                    <div style="color: #4169E1; margin-bottom: 1rem;">62-63 DC | Lucas | 28 capítulos</div>
                    <p><strong>Tema:</strong> Expansão da Igreja</p>
                    <div class="fact-item">
                        <div class="fact-title">🔥 Pentecostes</div>
                        <p>Nascimento da Igreja cristã universal</p>
                        <strong>Evidência:</strong> Cenáculo tradicional preservado
                    </div>
                </div>
                
                <div class="book-card">
                    <h3 style="color: #d4af37; font-size: 1.5rem;">📖 Apocalipse</h3>
                    <div style="color: #4169E1; margin-bottom: 1rem;">95-96 DC | João | 22 capítulos</div>
                    <p><strong>Tema:</strong> Vitória Final de Cristo</p>
                    <div class="fact-item">
                        <div class="fact-title">🌅 Nova Jerusalém</div>
                        <p>Visão da cidade celestial futura</p>
                        <strong>Evidência:</strong> Ilha de Patmos preserva tradições
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <div style="text-align: center; padding: 2rem;">
                <p>&copy; 2025 Promessas de Jesus. Timeline do Novo Testamento.</p>
            </div>
        </div>
    </footer>
</body>
</html>
EOF

echo "✅ SCRIPT 11b-timeline-details.sh PARTE 1a EXECUTADO COM SUCESSO!"
echo ""
echo "📋 PÁGINAS DETALHADAS CRIADAS:"
echo "   ✅ pages/timeline/antigo-testamento/index.html"
echo "   ✅ pages/timeline/novo-testamento/index.html"
echo ""
echo "🎨 RECURSOS IMPLEMENTADOS:"
echo "   ✅ Header/footer padrão do projeto"
echo "   ✅ Design consistente com paleta de cores"
echo "   ✅ Cards detalhados com fatos marcantes"
echo "   ✅ Evidências arqueológicas incluídas"
echo "   ✅ Navegação de volta funcional"
echo "   ✅ Layout responsivo"
echo ""
echo "🌐 TESTE AS PÁGINAS:"
echo "   • AT: http://localhost:8005/pages/timeline/antigo-testamento/"
echo "   • NT: http://localhost:8005/pages/timeline/novo-testamento/"
echo ""
echo "🎯 PRÓXIMO PASSO:"
echo "   Agora os botões da timeline principal direcionam"
echo "   para páginas reais ao invés do modal temporário!"
echo ""
echo "⚡ PARA EXECUTAR:"
echo "   chmod +x 11b-timeline-details.sh && ./11b-timeline-details.sh"