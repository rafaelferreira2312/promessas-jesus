#!/bin/bash

# Script 10b: Linha do Tempo Bíblica - Página HTML e Finalização (VERSÃO CORRIGIDA)
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "📜 FINALIZANDO LINHA DO TEMPO BÍBLICA - PARTE 1b FINAL (CORRIGIDA)..."
echo "====================================================================="

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    echo "   Certifique-se de estar em promessas-jesus/"
    exit 1
fi

echo "✅ Diretório correto detectado"

# Criar estrutura se não existir (independente das partes anteriores)
echo "📁 Verificando e criando estrutura necessária..."

# Criar pastas se não existirem
mkdir -p pages/timeline/
mkdir -p assets/css/
mkdir -p assets/js/
mkdir -p json/timeline/
mkdir -p assets/images/timeline/archaeological/

echo "✅ Estrutura de pastas verificada"

# Verificar se os arquivos essenciais existem, se não, criar versões básicas
if [ ! -f "json/timeline/timeline-config.json" ]; then
    echo "📋 Criando timeline-config.json básico..."
    cat > json/timeline/timeline-config.json << 'EOF'
{
  "metadata": {
    "title": "Linha do Tempo Bíblica Interativa",
    "description": "Jornada cronológica através das Escrituras com evidências arqueológicas",
    "version": "1.0.0",
    "totalBooks": 66,
    "oldTestamentBooks": 39,
    "newTestamentBooks": 27
  },
  "settings": {
    "enableArchaeology": true,
    "showDates": true,
    "animationDuration": 800
  }
}
EOF
fi

if [ ! -f "assets/css/timeline.css" ]; then
    echo "🎨 Criando CSS básico da timeline..."
    cat > assets/css/timeline.css << 'EOF'
/* Timeline Bíblica - CSS Base */
.biblical-timeline {
    font-family: 'Montserrat', sans-serif;
    color: #d4af37;
    background: #1a1611;
    padding: 2rem;
    border-radius: 15px;
}

.timeline-loading {
    text-align: center;
    padding: 3rem;
    color: #d4af37;
}

.loading-spinner {
    width: 40px;
    height: 40px;
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

.timeline-error {
    text-align: center;
    padding: 3rem;
    background: rgba(220, 20, 60, 0.1);
    border: 1px solid rgba(220, 20, 60, 0.3);
    border-radius: 15px;
    color: #dc143c;
}
EOF
fi

if [ ! -f "assets/js/timeline.js" ]; then
    echo "🔧 Criando JavaScript básico da timeline..."
    cat > assets/js/timeline.js << 'EOF'
// Timeline Bíblica - JavaScript Base
class BiblicalTimeline {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.init();
    }
    
    async init() {
        if (!this.container) return;
        
        this.container.innerHTML = `
            <div class="timeline-loading">
                <div class="loading-spinner"></div>
                <p>Carregando linha do tempo bíblica...</p>
            </div>
        `;
        
        setTimeout(() => {
            this.container.innerHTML = `
                <div style="text-align: center; padding: 2rem;">
                    <h2 style="color: #d4af37;">📜 Timeline Bíblica</h2>
                    <p>Em desenvolvimento... Execute os scripts completos para funcionalidade total.</p>
                </div>
            `;
        }, 2000);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('biblical-timeline')) {
        new BiblicalTimeline('biblical-timeline');
    }
});
EOF
fi

# Criar página HTML da timeline
echo "🌐 Criando página HTML da timeline..."
cat > pages/timeline/index.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Linha do Tempo Bíblica | Promessas de Jesus</title>
    
    <!-- Meta Tags SEO -->
    <meta name="description" content="Explore a cronologia bíblica completa com evidências arqueológicas. Do Gênesis ao Apocalipse.">
    <meta name="keywords" content="linha do tempo bíblica, cronologia bíblica, arqueologia bíblica, brasil">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <link rel="stylesheet" href="../../css/style.css">
    <link rel="stylesheet" href="../../assets/css/timeline.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #1a1611 0%, #2c1810 100%);
            color: #d4af37;
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .header {
            text-align: center;
            padding: 2rem 0;
            border-bottom: 2px solid rgba(212, 175, 55, 0.3);
            margin-bottom: 2rem;
        }
        
        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        
        .nav-back {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background: rgba(212, 175, 55, 0.1);
            border: 1px solid #d4af37;
            color: #d4af37;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 1rem 0;
        }
        
        .nav-back:hover {
            background: #d4af37;
            color: #1a1611;
            transform: translateY(-2px);
        }
        
        .info-section {
            background: rgba(212, 175, 55, 0.1);
            border: 1px solid rgba(212, 175, 55, 0.2);
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
        }
        
        .status {
            background: rgba(34, 139, 34, 0.1);
            border: 1px solid rgba(34, 139, 34, 0.3);
            border-radius: 10px;
            padding: 1.5rem;
            margin: 2rem 0;
        }
        
        .status h3 {
            color: #32CD32;
            margin-top: 0;
        }
    </style>
</head>

<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>📜 Linha do Tempo Bíblica</h1>
            <p>Cronologia completa das Escrituras com evidências arqueológicas</p>
            <a href="../../index.html" class="nav-back">🏠 Voltar ao Início</a>
        </div>
        
        <!-- Status -->
        <div class="status">
            <h3>✅ Timeline Básica Instalada</h3>
            <p><strong>Versão:</strong> Base (Funcional)</p>
            <p><strong>Status:</strong> Para funcionalidade completa, execute:</p>
            <ol>
                <li><code>./10-timeline-biblical.sh</code></li>
                <li><code>./10a-timeline-biblical.sh</code></li>
                <li><code>./10b-timeline-biblical.sh</code> (este script)</li>
            </ol>
        </div>

        <!-- Timeline Container -->
        <div id="biblical-timeline" class="biblical-timeline">
            <!-- Conteúdo carregado via JavaScript -->
        </div>

        <!-- Info -->
        <div class="info-section">
            <h3>🏺 Sobre a Timeline</h3>
            <p>Esta timeline bíblica interativa apresenta:</p>
            <ul>
                <li>📖 66 livros da Bíblia</li>
                <li>🏺 Evidências arqueológicas</li>
                <li>🗺️ Localizações geográficas</li>
                <li>📱 Design responsivo</li>
                <li>⚡ Performance otimizada</li>
            </ul>
        </div>
    </div>

    <!-- Scripts -->
    <script src="../../assets/js/timeline.js"></script>
</body>
</html>
EOF

# Adicionar link para timeline no menu principal (se não existir)
echo "🔗 Verificando link da timeline no menu principal..."
if [ -f "index.html" ]; then
    if ! grep -q "timeline" index.html; then
        echo "   Adicionando link da timeline..."
        # Backup
        cp index.html index.html.backup-timeline-$(date +%Y%m%d_%H%M%S)
        
        # Adicionar link após o quiz se existir, senão adicionar no final dos links
        if grep -q "quiz" index.html; then
            sed -i '/quiz.*nav-link/a\                    <a href="pages/timeline/" class="nav-link">📜 Timeline</a>' index.html
        else
            sed -i 's|</nav>|                    <a href="pages/timeline/" class="nav-link">📜 Timeline</a>\n                </nav>|' index.html
        fi
        echo "✅ Link da timeline adicionado ao menu"
    else
        echo "✅ Link da timeline já existe no menu"
    fi
else
    echo "⚠️  index.html não encontrado - adicione manualmente: <a href='pages/timeline/'>📜 Timeline</a>"
fi

# Criar instruções de uso
echo "📝 Criando instruções de uso..."
cat > pages/timeline/README.md << 'EOF'
# 📜 Timeline Bíblica - Instruções

## ✅ Instalação Básica Concluída

Esta é a versão básica da Timeline Bíblica. Ela está funcional mas com recursos limitados.

## 🚀 Para Versão Completa

Execute os scripts na ordem:

```bash
# 1. Estrutura base + Antigo Testamento
chmod +x 10-timeline-biblical.sh && ./10-timeline-biblical.sh

# 2. Novo Testamento + JavaScript avançado  
chmod +x 10a-timeline-biblical.sh && ./10a-timeline-biblical.sh

# 3. Página HTML completa + finalização
chmod +x 10b-timeline-biblical.sh && ./10b-timeline-biblical.sh
```

## 📁 Arquivos Criados (Versão Básica)

- `pages/timeline/index.html` - Página da timeline
- `assets/css/timeline.css` - Estilos básicos
- `assets/js/timeline.js` - JavaScript básico
- `json/timeline/timeline-config.json` - Configurações

## 🌐 Acesso

- URL: `/pages/timeline/`
- Menu: 📜 Timeline (adicionado automaticamente)

## 📞 Suporte

contato@vancouvertec.com.br
EOF

# Verificar se tudo foi criado corretamente
echo "🔍 Verificação final..."
success=true

required_files=(
    "pages/timeline/index.html"
    "assets/css/timeline.css"
    "assets/js/timeline.js"
    "json/timeline/timeline-config.json"
    "pages/timeline/README.md"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Arquivo não criado: $file"
        success=false
    fi
done

if [ "$success" = true ]; then
    echo "✅ TODOS OS ARQUIVOS CRIADOS COM SUCESSO!"
    echo ""
    echo "🎉 TIMELINE BÍBLICA INSTALADA (VERSÃO BÁSICA)!"
    echo "=============================================="
    echo ""
    echo "📋 RESUMO:"
    echo "   ✅ Página HTML funcional"
    echo "   ✅ CSS responsivo básico"
    echo "   ✅ JavaScript com loading"
    echo "   ✅ Link adicionado ao menu"
    echo "   ✅ Instruções de uso criadas"
    echo ""
    echo "🌐 ACESSO:"
    echo "   • URL: http://localhost/pages/timeline/"
    echo "   • Menu: 📜 Timeline"
    echo ""
    echo "⚡ PARA VERSÃO COMPLETA:"
    echo "   Execute os 3 scripts na ordem correta"
    echo "   (veja pages/timeline/README.md)"
    echo ""
    echo "🚀 TESTANDO..."
    if command -v python3 &> /dev/null; then
        echo "   Execute: python3 -m http.server 8000"
        echo "   Acesse: http://localhost:8000/pages/timeline/"
    else
        echo "   Abra pages/timeline/index.html no navegador"
    fi
else
    echo "❌ ALGUNS ARQUIVOS NÃO FORAM CRIADOS!"
    echo "   Verifique as permissões do diretório"
fi