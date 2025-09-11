#!/bin/bash

# =====================================================
# SCRIPT 4 - SEO E OTIMIZAÇÕES FINAIS
# Sitemap, robots.txt, meta tags, performance
# =====================================================
# Uso: chmod +x 4-seo.sh && ./4-seo.sh
# =====================================================

set -e

echo "🔍 CRIANDO SEO E OTIMIZAÇÕES FINAIS"
echo "📊 Sitemap, robots.txt, meta tags, performance"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto (onde existe index.html)"
    exit 1
fi

# Criar sitemap.xml
echo "🗺️ Criando sitemap.xml..."

cat > sitemap.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://promessasdejesus.vancouvertec.com.br/</loc>
    <lastmod>2025-09-11</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://promessasdejesus.vancouvertec.com.br/#promises</loc>
    <lastmod>2025-09-11</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://promessasdejesus.vancouvertec.com.br/#timeline</loc>
    <lastmod>2025-09-11</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://promessasdejesus.vancouvertec.com.br/#chat</loc>
    <lastmod>2025-09-11</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://promessasdejesus.vancouvertec.com.br/#quiz</loc>
    <lastmod>2025-09-11</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>
  <url>
    <loc>https://promessasdejesus.vancouvertec.com.br/#resources</loc>
    <lastmod>2025-09-11</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>
  <url>
    <loc>https://promessasdejesus.vancouvertec.com.br/#blog</loc>
    <lastmod>2025-09-11</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.8</priority>
  </url>
</urlset>
EOF

echo "✅ sitemap.xml criado!"

# Criar robots.txt
echo "🤖 Criando robots.txt..."

cat > robots.txt << 'EOF'
User-agent: *
Allow: /

# Sitemap
Sitemap: https://promessasdejesus.vancouvertec.com.br/sitemap.xml

# Crawl-delay para proteger servidor
Crawl-delay: 1

# Bloquear arquivos de sistema
Disallow: /json/submissions.json
Disallow: /json/logs.txt
Disallow: /scripts/
Disallow: /*.backup$
Disallow: /*.log$

# Permitir recursos importantes
Allow: /css/
Allow: /js/
Allow: /assets/
Allow: /json/config.json
Allow: /json/local_verses.json
Allow: /json/blog_index.json

# Informações do site
# Site: Portal "Jesus é o Pão da Vida"
# Contato: contato@vancouvertec.com.br
# Tema: Promessas bíblicas e espiritualidade cristã
EOF

echo "✅ robots.txt criado!"

# Criar arquivo de configuração para performance
echo "⚡ Criando configurações de performance..."

cat > .htaccess << 'EOF'
# PERFORMANCE E CACHE - Portal Jesus é o Pão da Vida

# Compressão GZIP
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
    AddOutputFilterByType DEFLATE application/json
    AddOutputFilterByType DEFLATE application/font-woff
    AddOutputFilterByType DEFLATE application/font-woff2
    AddOutputFilterByType DEFLATE image/svg+xml
</IfModule>

# Cache Headers para Performance
<IfModule mod_expires.c>
    ExpiresActive on
    
    # Imagens
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/webp "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
    ExpiresByType image/x-icon "access plus 1 year"
    
    # CSS e JS
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType application/x-javascript "access plus 1 month"
    
    # Fonts
    ExpiresByType application/font-woff "access plus 1 year"
    ExpiresByType application/font-woff2 "access plus 1 year"
    ExpiresByType application/vnd.ms-fontobject "access plus 1 year"
    ExpiresByType font/ttf "access plus 1 year"
    ExpiresByType font/otf "access plus 1 year"
    
    # HTML
    ExpiresByType text/html "access plus 1 day"
    
    # JSON
    ExpiresByType application/json "access plus 1 hour"
</IfModule>

# Headers de Segurança
<IfModule mod_headers.c>
    # CORS para assets
    Header set Access-Control-Allow-Origin "*"
    
    # Segurança
    Header always set X-Content-Type-Options nosniff
    Header always set X-Frame-Options SAMEORIGIN
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
    
    # Cache Control
    <FilesMatch "\.(css|js|png|jpg|jpeg|gif|webp|svg|woff|woff2|ttf|otf|eot)$">
        Header set Cache-Control "public, max-age=31536000, immutable"
    </FilesMatch>
    
    <FilesMatch "\.(html|htm)$">
        Header set Cache-Control "public, max-age=86400"
    </FilesMatch>
    
    <FilesMatch "\.(json)$">
        Header set Cache-Control "public, max-age=3600"
    </FilesMatch>
</IfModule>

# Redirect HTTP para HTTPS
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Fallback para SPA (se necessário)
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.html [L]
EOF

echo "✅ .htaccess criado!"

# Criar favicon SVG
echo "🎨 Criando favicon SVG..."

mkdir -p assets/images

cat > assets/images/favicon.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
  <defs>
    <linearGradient id="crossGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#d4af37;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#b7950b;stop-opacity:1" />
    </linearGradient>
  </defs>
  
  <!-- Background circle -->
  <circle cx="16" cy="16" r="15" fill="#1a1611" stroke="url(#crossGrad)" stroke-width="2"/>
  
  <!-- Cross -->
  <rect x="14" y="6" width="4" height="20" rx="2" fill="url(#crossGrad)"/>
  <rect x="8" y="12" width="16" height="4" rx="2" fill="url(#crossGrad)"/>
  
  <!-- Center glow -->
  <circle cx="16" cy="16" r="2" fill="#f4d03f" opacity="0.8"/>
</svg>
EOF

echo "✅ favicon.svg criado!"

# Atualizar index.html com meta tags otimizadas
echo "📝 Atualizando meta tags no index.html..."

# Backup do index atual
cp index.html index.html.backup

# Adicionar meta tags estruturadas no head do index.html
sed -i '/<meta name="robots"/a\
    \
    <!-- Meta Tags Regionais Brasil -->\
    <meta name="geo.region" content="BR" />\
    <meta name="geo.placename" content="Brasil" />\
    <meta name="geo.position" content="-15.7939;-47.8828" />\
    <meta name="ICBM" content="-15.7939, -47.8828" />\
    \
    <!-- Schema.org Structured Data -->\
    <script type="application/ld+json">\
    {\
      "@context": "https://schema.org",\
      "@type": "WebSite",\
      "name": "Jesus é o Pão da Vida",\
      "description": "Portal cristão com promessas bíblicas, chat espiritual e recursos de fé",\
      "url": "https://promessasdejesus.vancouvertec.com.br",\
      "publisher": {\
        "@type": "Organization",\
        "name": "Vancouver Tech",\
        "url": "https://vancouvertec.com.br"\
      },\
      "potentialAction": {\
        "@type": "SearchAction",\
        "target": "https://promessasdejesus.vancouvertec.com.br/#chat?q={search_term_string}",\
        "query-input": "required name=search_term_string"\
      },\
      "mainEntity": {\
        "@type": "CreativeWork",\
        "@id": "https://promessasdejesus.vancouvertec.com.br/#promises",\
        "name": "Promessas Bíblicas",\
        "description": "Coleção de versículos e promessas divinas para transformar vidas"\
      }\
    }\
    </script>\
    \
    <!-- Performance Hints -->\
    <link rel="dns-prefetch" href="//fonts.googleapis.com">\
    <link rel="dns-prefetch" href="//fonts.gstatic.com">\
    <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>\
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>' index.html

echo "✅ Meta tags otimizadas adicionadas!"

# Criar manifest.json para PWA
echo "📱 Criando manifest.json..."

cat > manifest.json << 'EOF'
{
  "name": "Jesus é o Pão da Vida",
  "short_name": "Promessas de Jesus",
  "description": "Portal cristão com promessas bíblicas, chat espiritual e recursos de fé",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#1a1611",
  "theme_color": "#d4af37",
  "orientation": "portrait-primary",
  "categories": ["lifestyle", "spirituality", "education"],
  "lang": "pt-BR",
  "dir": "ltr",
  "icons": [
    {
      "src": "assets/images/favicon.svg",
      "sizes": "any",
      "type": "image/svg+xml",
      "purpose": "any maskable"
    },
    {
      "src": "assets/images/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "assets/images/icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ],
  "screenshots": [
    {
      "src": "assets/images/screenshot-desktop.webp",
      "sizes": "1280x720",
      "type": "image/webp",
      "form_factor": "wide"
    },
    {
      "src": "assets/images/screenshot-mobile.webp",
      "sizes": "375x812",
      "type": "image/webp",
      "form_factor": "narrow"
    }
  ]
}
EOF

echo "✅ manifest.json criado!"

# Adicionar link do manifest no index.html
sed -i '/<link rel="apple-touch-icon"/a\
    <link rel="manifest" href="manifest.json">' index.html

# Criar service worker básico
echo "⚙️ Criando service worker..."

cat > sw.js << 'EOF'
// Service Worker para Portal Jesus é o Pão da Vida
const CACHE_NAME = 'promessas-jesus-v1.0';
const urlsToCache = [
  '/',
  '/index.html',
  '/css/style.css',
  '/js/main.js',
  '/js/i18n/pt.js',
  '/js/i18n/en.js',
  '/json/config.json',
  '/json/local_verses.json',
  '/json/blog_index.json',
  '/assets/images/jesus-pao.webp',
  '/assets/images/favicon.svg',
  '/manifest.json'
];

// Instalar SW
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('Cache aberto');
        return cache.addAll(urlsToCache);
      })
  );
});

// Ativar SW
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            console.log('Removendo cache antigo:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Interceptar requests
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Retornar cache se disponível
        if (response) {
          return response;
        }
        return fetch(event.request);
      }
    )
  );
});
EOF

echo "✅ Service worker criado!"

# Criar README.md detalhado
echo "📚 Criando README.md..."

cat > README.md << 'EOF'
# Portal "Jesus é o Pão da Vida"

Portal cristão brasileiro com promessas bíblicas, chat espiritual e recursos de fé.

## 🌐 Site
**URL:** https://promessasdejesus.vancouvertec.com.br

## ✨ Características
- **Design dourado majestoso** inspirado no sagrado
- **Chat espiritual** com IA de versículos bíblicos
- **Promessas divinas** categorizadas por situações
- **Linha do tempo bíblica** interativa
- **Quiz bíblico** para testar conhecimentos
- **Recursos cristãos** (livros, músicas, filmes)
- **Newsletter** para versículos diários
- **Multilíngue** (Português/Inglês)
- **PWA** (Progressive Web App)
- **SEO otimizado** para todo Brasil

## 🛠️ Tecnologias
- **Frontend:** HTML5, CSS3, JavaScript (Vanilla)
- **Dados:** JSON files
- **Fontes:** Google Fonts (Cinzel, Inter)
- **Performance:** Cache headers, compressão, lazy loading
- **SEO:** Sitemap, robots.txt, schema.org

## 📁 Estrutura do Projeto
```
├── index.html              # Página principal
├── css/
│   └── style.css           # Estilos principais
├── js/
│   ├── main.js            # JavaScript principal
│   └── i18n/              # Traduções
│       ├── pt.js          # Português
│       └── en.js          # Inglês
├── assets/
│   └── images/            # Imagens e ícones
├── json/
│   ├── config.json        # Configurações
│   ├── local_verses.json  # Versículos locais
│   ├── submissions.json   # Inscrições
│   └── blog_index.json    # Índice do blog
├── scripts/               # Scripts de automação
├── sitemap.xml           # Mapa do site
├── robots.txt            # Instruções para bots
├── manifest.json         # PWA manifest
└── sw.js                 # Service worker
```

## 🚀 Deploy
### Servidor: CloudPanel
- **Host:** 212.85.1.55
- **User:** vancouvertec-promessasdejesus
- **Path:** /home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br

### Deploy via SSH:
```bash
# Conectar
ssh root@212.85.1.55

# Navegar para pasta
cd /home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br

# Upload dos arquivos
# (usar scp, rsync ou git)
```

## 📊 Performance
- **Objetivo:** PageSpeed ≥ 98
- **Otimizações:** Compressão, cache, lazy loading
- **Formatos:** WebP para imagens, minificação CSS/JS

## 🔧 Configuração

### APIs Bíblicas (Opcional)
Configure em `json/config.json`:
- Bible API Almeida
- API.Bible  
- ESV API

### Newsletter
Dados salvos em `json/submissions.json`
Scripts de envio em `scripts/`

### Cron Jobs
```bash
# Versículo diário (8h da manhã)
0 8 * * * /path/to/scripts/send_random_verse.sh
```

## 🎨 Paleta de Cores
- **Ouro primário:** #d4af37
- **Ouro claro:** #f4d03f  
- **Ouro escuro:** #b7950b
- **Bronze:** #cd853f
- **Terra:** #8b4513
- **Escuro:** #1a1611

## 📱 PWA Features
- Instalável no dispositivo
- Funciona offline (cache)
- Ícones personalizados
- Splash screen

## 🔍 SEO
- Meta tags otimizadas
- Schema.org structured data
- Sitemap XML
- Robots.txt
- Hreflang (PT-BR/EN)
- Keywords para todos estados brasileiros

## 📞 Contato
- **Desenvolvedor:** Vancouver Tech
- **Email:** contato@vancouvertec.com.br
- **Site:** https://vancouvertec.com.br

## 📄 Licença
© 2025 Jesus é o Pão da Vida. Feito com ❤️ para a glória de Deus.
EOF

echo "✅ README.md criado!"

# Adicionar service worker no index.html
echo "📱 Registrando service worker..."

sed -i '/window.addEventListener.*load.*function/a\
    \
    // Registrar Service Worker\
    if ("serviceWorker" in navigator) {\
      navigator.serviceWorker.register("/sw.js")\
        .then(registration => console.log("SW registrado:", registration.scope))\
        .catch(error => console.log("SW falhou:", error));\
    }' index.html

echo "✅ Service worker registrado!"

echo ""
echo "📋 RESUMO DO QUE FOI CRIADO:"
echo "• ✅ sitemap.xml (mapa do site)"
echo "• ✅ robots.txt (instruções para bots)"
echo "• ✅ .htaccess (performance e cache)"
echo "• ✅ favicon.svg (ícone do site)"
echo "• ✅ manifest.json (PWA)"
echo "• ✅ sw.js (service worker)"
echo "• ✅ README.md (documentação)"
echo "• ✅ Meta tags estruturadas"
echo "• ✅ Schema.org data"
echo "• ✅ Performance headers"
echo "• ✅ PWA features"
echo ""
echo "🎯 OTIMIZAÇÕES IMPLEMENTADAS:"
echo "• SEO para todos estados brasileiros"
echo "• Cache headers para performance"
echo "• Compressão GZIP"
echo "• Progressive Web App"
echo "• Structured data (Schema.org)"
echo "• Meta tags regionais"
echo "• Service worker para offline"
echo ""
echo "📁 ARQUIVOS CRIADOS:"
echo "• sitemap.xml"
echo "• robots.txt"
echo "• .htaccess"
echo "• manifest.json"
echo "• sw.js"
echo "• README.md"
echo "• assets/images/favicon.svg"
echo ""
echo "🚀 PRÓXIMOS PASSOS:"
echo "1. Digite 'continuar' para criar script 5-deploy.sh"
echo "2. Testar localmente: python3 -m http.server 8000"
echo "3. Fazer deploy para servidor"
echo ""
echo "⏳ Aguardando comando 'continuar'..."