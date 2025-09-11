#!/bin/bash

# =====================================================
# PORTAL "JESUS É O PÃO DA VIDA" - SETUP AUTOMÁTICO
# =====================================================
# Autor: Criado para rafaelferreira2312
# Repositório: git@github.com:rafaelferreira2312/promessas-jesus.git
# Domínio: promessasdejesus.vancouvertec.com.br
# =====================================================

set -e

PROJECT_NAME="promessas-jesus-site"
GIT_REMOTE="git@github.com:rafaelferreira2312/promessas-jesus.git"
DOMAIN="promessasdejesus.vancouvertec.com.br"

echo "🚀 Iniciando criação do Portal 'Jesus é o Pão da Vida'..."
echo "📁 Projeto: $PROJECT_NAME"
echo "🌐 Domínio: $DOMAIN"
echo "📦 Git: $GIT_REMOTE"
echo ""

# Criar diretório principal
if [ -d "$PROJECT_NAME" ]; then
    echo "⚠️  Diretório $PROJECT_NAME já existe. Removendo..."
    rm -rf "$PROJECT_NAME"
fi

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

echo "📂 Criando estrutura de pastas na raiz..."

# Limpar pasta scripts se já existe (foi criada incorretamente)
rm -rf scripts 2>/dev/null || true

# Estrutura de pastas conforme especificação - DIRETAMENTE NA RAIZ
mkdir -p css
mkdir -p js/i18n
mkdir -p js/libs
mkdir -p assets/images
mkdir -p json/blog_posts
mkdir -p blog
mkdir -p pages
mkdir -p scripts

echo "✅ Estrutura de pastas criada!"

# =====================================================
# ARQUIVOS JSON BASE
# =====================================================

echo "📄 Criando arquivos JSON base..."

# json/config.json
cat > json/config.json << 'EOF'
{
  "site": {
    "name": "Jesus é o Pão da Vida",
    "domain": "promessasdejesus.vancouvertec.com.br",
    "version": "1.0.0",
    "default_language": "pt"
  },
  "apis": {
    "bible_api_almeida": {
      "enabled": false,
      "base_url": "https://www.abibliadigital.com.br/api",
      "key": "YOUR_API_KEY_HERE",
      "cors_proxy": "https://cors-anywhere.herokuapp.com/"
    },
    "api_bible": {
      "enabled": false,
      "base_url": "https://api.scripture.api.bible/v1",
      "key": "YOUR_API_KEY_HERE",
      "bible_id": "de4e12af7f28f599-02"
    },
    "esv_api": {
      "enabled": false,
      "base_url": "https://api.esv.org/v3",
      "key": "YOUR_ESV_TOKEN_HERE"
    }
  },
  "features": {
    "chat_enabled": true,
    "quiz_enabled": true,
    "newsletter_enabled": true,
    "blog_enabled": true
  }
}
EOF

# json/submissions.json
cat > json/submissions.json << 'EOF'
{
  "submissions": [],
  "quiz_results": [],
  "chat_logs": [],
  "last_updated": ""
}
EOF

# json/local_verses.json
cat > json/local_verses.json << 'EOF'
{
  "categories": {
    "medo": [
      {
        "verse": "Filipenses 4:6-7",
        "text_pt": "Não andem ansiosos por coisa nenhuma, mas em tudo, pela oração e súplicas, e com ação de graças, apresentem seus pedidos a Deus. E a paz de Deus, que excede todo o entendimento, guardará o coração e a mente de vocês em Cristo Jesus.",
        "text_en": "Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God. And the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus."
      }
    ],
    "tristeza": [
      {
        "verse": "Salmos 34:18",
        "text_pt": "Perto está o Senhor dos que têm o coração quebrantado e salva os de espírito abatido.",
        "text_en": "The Lord is close to the brokenhearted and saves those who are crushed in spirit."
      }
    ],
    "esperanca": [
      {
        "verse": "Jeremias 29:11",
        "text_pt": "Porque eu sei os planos que tenho para vocês, diz o Senhor, planos de fazê-los prosperar e não de causar dano, planos de dar esperança e um futuro.",
        "text_en": "For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, plans to give you hope and a future."
      }
    ],
    "amor": [
      {
        "verse": "João 3:16",
        "text_pt": "Porque Deus tanto amou o mundo que deu o seu Filho Unigênito, para que todo o que nele crer não pereça, mas tenha a vida eterna.",
        "text_en": "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life."
      }
    ]
  },
  "daily_verses": [
    {
      "verse": "Mateus 6:26",
      "text_pt": "Observem as aves do céu: não semeiam nem colhem nem ajuntam em celeiros; contudo, o Pai celestial as alimenta. Não têm vocês muito mais valor do que elas?",
      "text_en": "Look at the birds of the air; they do not sow or reap or store away in barns, and yet your heavenly Father feeds them. Are you not much more valuable than they?"
    }
  ]
}
EOF

# json/blog_index.json
cat > json/blog_index.json << 'EOF'
{
  "posts": [
    {
      "id": "1",
      "title_pt": "O Poder da Oração em Tempos Difíceis",
      "title_en": "The Power of Prayer in Difficult Times",
      "excerpt_pt": "Descubra como a oração pode transformar momentos de angústia em oportunidades de crescimento espiritual.",
      "excerpt_en": "Discover how prayer can transform moments of anguish into opportunities for spiritual growth.",
      "author": "Equipe Promessas de Jesus",
      "date": "2025-09-11",
      "image": "assets/images/blog-prayer.webp",
      "slug": "poder-da-oracao",
      "tags": ["oração", "fé", "esperança"]
    }
  ]
}
EOF

echo "✅ Arquivos JSON criados!"

# =====================================================
# ARQUIVOS DE TRADUÇÃO (i18n)
# =====================================================

echo "🌍 Criando arquivos de internacionalização..."

# js/i18n/pt.js
cat > js/i18n/pt.js << 'EOF'
const pt = {
  // Navegação
  nav: {
    home: "Início",
    promises: "Promessas",
    timeline: "Linha do Tempo",
    chat: "Chat",
    quiz: "Quiz",
    blog: "Blog",
    resources: "Recursos",
    about: "Sobre"
  },
  
  // Seção Hero
  hero: {
    title: "Jesus é o Pão da Vida",
    subtitle: "Encontre paz, esperança e orientação nas promessas eternas de Jesus Cristo",
    cta_primary: "Explorar Promessas",
    cta_secondary: "Iniciar Chat"
  },
  
  // Seções principais
  sections: {
    promises_title: "Promessas Divinas",
    promises_subtitle: "Versículos que transformam vidas",
    timeline_title: "Jornada Bíblica",
    timeline_subtitle: "Da Criação ao Apocalipse",
    resources_title: "Recursos Cristãos",
    chat_title: "Chat Espiritual",
    chat_subtitle: "Encontre versículos para seus momentos"
  },
  
  // Chat
  chat: {
    placeholder: "Digite sua pergunta ou situação...",
    send: "Enviar",
    thinking: "Buscando orientação...",
    no_response: "Desculpe, não encontrei uma resposta específica. Que tal explorar nossas promessas?"
  },
  
  // Newsletter
  newsletter: {
    title: "Receba Versículos Diários",
    subtitle: "Cadastre-se e receba uma promessa de Jesus todos os dias",
    name_placeholder: "Seu nome",
    email_placeholder: "Seu email",
    whatsapp_placeholder: "WhatsApp (opcional)",
    subscribe: "Inscrever-se",
    success: "Inscrição realizada com sucesso!",
    error: "Erro ao processar inscrição. Tente novamente."
  },
  
  // Footer
  footer: {
    tagline: "Compartilhando o amor de Cristo através de Suas promessas",
    links: "Links Úteis",
    contact: "Contato",
    social: "Redes Sociais"
  }
};

// Exportar para uso global
if (typeof module !== 'undefined' && module.exports) {
  module.exports = pt;
} else {
  window.translations = window.translations || {};
  window.translations.pt = pt;
}
EOF

# js/i18n/en.js
cat > js/i18n/en.js << 'EOF'
const en = {
  // Navigation
  nav: {
    home: "Home",
    promises: "Promises",
    timeline: "Timeline",
    chat: "Chat",
    quiz: "Quiz",
    blog: "Blog",
    resources: "Resources",
    about: "About"
  },
  
  // Hero Section
  hero: {
    title: "Jesus is the Bread of Life",
    subtitle: "Find peace, hope and guidance in the eternal promises of Jesus Christ",
    cta_primary: "Explore Promises",
    cta_secondary: "Start Chat"
  },
  
  // Main sections
  sections: {
    promises_title: "Divine Promises",
    promises_subtitle: "Verses that transform lives",
    timeline_title: "Biblical Journey",
    timeline_subtitle: "From Creation to Revelation",
    resources_title: "Christian Resources",
    chat_title: "Spiritual Chat",
    chat_subtitle: "Find verses for your moments"
  },
  
  // Chat
  chat: {
    placeholder: "Type your question or situation...",
    send: "Send",
    thinking: "Seeking guidance...",
    no_response: "Sorry, I couldn't find a specific answer. How about exploring our promises?"
  },
  
  // Newsletter
  newsletter: {
    title: "Receive Daily Verses",
    subtitle: "Subscribe and receive a promise from Jesus every day",
    name_placeholder: "Your name",
    email_placeholder: "Your email",
    whatsapp_placeholder: "WhatsApp (optional)",
    subscribe: "Subscribe",
    success: "Successfully subscribed!",
    error: "Error processing subscription. Please try again."
  },
  
  // Footer
  footer: {
    tagline: "Sharing Christ's love through His promises",
    links: "Useful Links",
    contact: "Contact",
    social: "Social Media"
  }
};

// Export for global use
if (typeof module !== 'undefined' && module.exports) {
  module.exports = en;
} else {
  window.translations = window.translations || {};
  window.translations.en = en;
}
EOF

echo "✅ Arquivos de tradução criados!"

# =====================================================
# SCRIPTS DE AUTOMAÇÃO
# =====================================================

echo "🔧 Criando scripts de automação..."

# scripts/cron_example.sh
cat > scripts/cron_example.sh << 'EOF'
#!/bin/bash
# Exemplo de script para CRON - Envio diário de versículos
# Execute: crontab -e e adicione: 0 8 * * * /caminho/para/scripts/cron_example.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "$(date): Executando envio diário de versículos..." >> "$PROJECT_DIR/json/cron.log"

# Executar script de envio
bash "$SCRIPT_DIR/send_random_verse.sh"

echo "$(date): Envio concluído." >> "$PROJECT_DIR/json/cron.log"
EOF

# scripts/send_random_verse.sh
cat > scripts/send_random_verse.sh << 'EOF'
#!/bin/bash
# Script para enviar versículo aleatório aos inscritos

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
SUBMISSIONS_FILE="$PROJECT_DIR/json/submissions.json"
VERSES_FILE="$PROJECT_DIR/json/local_verses.json"

# Verificar se arquivos existem
if [[ ! -f "$SUBMISSIONS_FILE" ]] || [[ ! -f "$VERSES_FILE" ]]; then
    echo "Erro: Arquivos necessários não encontrados."
    exit 1
fi

echo "$(date): Iniciando envio de versículos..."

# TODO: Implementar lógica de envio
# 1. Ler submissions.json
# 2. Selecionar versículo aleatório de local_verses.json
# 3. Enviar por email/WhatsApp usando serviços externos
# 4. Registrar envio em log

# PLACEHOLDER - Integrar com:
# - SendGrid/Mailgun para email
# - WhatsApp Business API
# - Twilio para SMS

echo "$(date): Placeholder - Versículo selecionado e pronto para envio."
echo "Configure sua integração de email/WhatsApp aqui."
EOF

chmod +x scripts/*.sh

echo "✅ Scripts de automação criados!"

# =====================================================
# ARQUIVOS DE CONFIGURAÇÃO
# =====================================================

echo "⚙️  Criando arquivos de configuração..."

# .gitignore
cat > .gitignore << 'EOF'
# Logs
*.log
json/cron.log
json/error.log

# Environment variables
.env
.env.local
.env.production

# API Keys (nunca commitar)
config/secrets.json

# Cache e temporários
.DS_Store
Thumbs.db
*.tmp
*.temp

# Build outputs
dist/
build/

# IDE
.vscode/
.idea/
*.swp
*.swo

# Node modules (se usar ferramentas de build)
node_modules/

# Backup files
*.backup
*.bak
EOF

echo "✅ Arquivos de configuração criados!"

echo ""
echo "🎉 ESTRUTURA BASE CRIADA COM SUCESSO!"
echo "📁 Diretório: $CURRENT_DIR"
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Aguarde o comando 'continuar' para criar o HTML principal"
echo "2. Depois criaremos o CSS minimalista e futurista"
echo "3. Em seguida, o JavaScript funcional"
echo "4. Por fim, o logo SVG e otimizações"
echo ""
echo "🔧 Para testar localmente após conclusão:"
echo "   python3 -m http.server 8000"
echo "   Acesse: http://localhost:8000"
echo ""
echo "⏳ Aguardando comando 'continuar'..."