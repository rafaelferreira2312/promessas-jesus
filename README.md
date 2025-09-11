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
