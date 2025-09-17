#!/bin/bash

# Script 10: Linha do Tempo Bíblica - Antigo e Novo Testamento (PARTE 1)
# Projeto: Portal Promessas de Jesus
# Autor: Vancouver Tech
# Data: $(date +%Y-%m-%d)

echo "📜 CRIANDO LINHA DO TEMPO BÍBLICA INTERATIVA - PARTE 1..."
echo "========================================================"

# Verificar se estamos no diretório correto
if [ ! -f "index.html" ]; then
    echo "❌ ERRO: Execute o script na pasta raiz do projeto!"
    echo "   Certifique-se de estar em promessas-jesus/"
    exit 1
fi

# Backup
echo "💾 Criando backup..."
mkdir -p backups/timeline-$(date +%Y%m%d_%H%M%S)/
cp -r pages/ backups/timeline-$(date +%Y%m%d_%H%M%S)/pages/ 2>/dev/null
cp -r json/ backups/timeline-$(date +%Y%m%d_%H%M%S)/json/ 2>/dev/null
echo "✅ Backup criado em backups/timeline-$(date +%Y%m%d_%H%M%S)/"

# Criar estrutura de pastas para timeline
echo "📁 Criando estrutura de pastas da timeline..."
mkdir -p pages/timeline/
mkdir -p assets/images/timeline/
mkdir -p assets/images/timeline/old-testament/
mkdir -p assets/images/timeline/new-testament/
mkdir -p assets/images/timeline/archaeological/
mkdir -p json/timeline/

# Criar placeholder para imagens arqueológicas
echo "🖼️ Criando placeholders para imagens arqueológicas..."
cat > assets/images/timeline/archaeological/README.md << 'EOF'
# Imagens Arqueológicas - Timeline Bíblica

Esta pasta contém imagens de achados arqueológicos que comprovam os fatos bíblicos.

## Estrutura:
- old-testament/ - Achados do Antigo Testamento
- new-testament/ - Achados do Novo Testamento

## Formato recomendado:
- Formato: WebP, AVIF (fallback JPG)
- Tamanho: 800x600px otimizado
- Compressão: máxima qualidade 85%
- Alt text: sempre descrever o achado

## Exemplos de achados para incluir:
### Antigo Testamento:
- creation.webp - Evidências cosmológicas
- flood-evidence.webp - Evidências geológicas do dilúvio
- jericho-walls.webp - Muralhas de Jericó escavadas
- david-inscription.webp - Inscrição "Casa de Davi" em Tel Dan
- solomon-temple.webp - Fundações do Templo de Salomão

### Novo Testamento:
- nazareth-village.webp - Vila de Nazaré do séc I
- capernaum-synagogue.webp - Sinagoga de Cafarnaum
- pontius-pilate-stone.webp - Inscrição de Pôncio Pilatos
- ossuary-caiaphas.webp - Ossuário do sumo sacerdote Caifás
- early-christian-symbols.webp - Símbolos cristãos primitivos
EOF

# Criar JSON base da timeline (PARTE 1 - Estrutura principal)
echo "📋 Criando estrutura JSON da timeline..."
cat > json/timeline/timeline-config.json << 'EOF'
{
  "metadata": {
    "title": "Linha do Tempo Bíblica Interativa",
    "description": "Jornada cronológica através das Escrituras com evidências arqueológicas",
    "version": "1.0.0",
    "lastUpdated": "2025-01-15",
    "totalBooks": 66,
    "oldTestamentBooks": 39,
    "newTestamentBooks": 27,
    "timeSpan": "~2000 AC - 100 DC",
    "languages": ["Hebraico", "Aramaico", "Grego"],
    "manuscripts": "5800+ manuscritos do NT, 24000+ total"
  },
  "settings": {
    "enableArchaeology": true,
    "showDates": true,
    "showVerses": true,
    "defaultTestament": "old",
    "animationDuration": 800,
    "lazy loading": true,
    "imageFormat": "webp"
  },
  "periods": {
    "creation": "~2000+ AC",
    "patriarchs": "~2000-1500 AC",
    "exodus": "~1500-1400 AC",
    "judges": "~1400-1050 AC", 
    "united_kingdom": "~1050-930 AC",
    "divided_kingdom": "~930-586 AC",
    "exile": "~586-538 AC",
    "restoration": "~538-400 AC",
    "intertestamental": "~400 AC - 6 AC",
    "jesus_ministry": "~6-30 DC",
    "early_church": "~30-100 DC"
  }
}
EOF

# Criar dados do Antigo Testamento (PARTE 1 - Primeiros livros)
echo "📖 Criando dados do Antigo Testamento..."
cat > json/timeline/old-testament.json << 'EOF'
{
  "testament": "old",
  "title": "Antigo Testamento",
  "subtitle": "A História do Povo de Deus",
  "period": "~2000 AC - 400 AC",
  "description": "Desde a criação do mundo até a preparação para a vinda do Messias",
  "totalBooks": 39,
  "categories": [
    {
      "name": "Lei (Torá)",
      "books": ["Gênesis", "Êxodo", "Levítico", "Números", "Deuteronômio"],
      "description": "Os cinco primeiros livros, escritos por Moisés"
    },
    {
      "name": "Históricos",
      "books": ["Josué", "Juízes", "Rute", "1 e 2 Samuel", "1 e 2 Reis", "1 e 2 Crônicas", "Esdras", "Neemias", "Ester"],
      "description": "A história do povo de Israel"
    },
    {
      "name": "Poéticos",
      "books": ["Jó", "Salmos", "Provérbios", "Eclesiastes", "Cânticos"],
      "description": "Literatura sapiencial e poética"
    },
    {
      "name": "Profetas Maiores",
      "books": ["Isaías", "Jeremias", "Lamentações", "Ezequiel", "Daniel"],
      "description": "Profecias extensas sobre Israel e as nações"
    },
    {
      "name": "Profetas Menores",
      "books": ["Oseias", "Joel", "Amós", "Obadias", "Jonas", "Miquéias", "Naum", "Habacuque", "Sofonias", "Ageu", "Zacarias", "Malaquias"],
      "description": "Doze livros proféticos menores em extensão"
    }
  ],
  "keyBooks": [
    {
      "id": "genesis",
      "name": "Gênesis",
      "order": 1,
      "period": "~1400 AC",
      "author": "Moisés",
      "chapters": 50,
      "theme": "Começos - Criação, Queda, Promessa",
      "keyVerse": {
        "reference": "Gênesis 1:1",
        "text": "No princípio, criou Deus os céus e a terra."
      },
      "summary": "O livro das origens: criação, queda do homem, promessa de redenção e história dos patriarcas.",
      "keyEvents": [
        {
          "id": "creation",
          "title": "Criação do Mundo",
          "description": "Deus criou o universo em seis dias e descansou no sétimo",
          "verse": "Gênesis 1:1-31",
          "significance": "Estabelece Deus como Criador soberano de tudo",
          "archaeological": {
            "evidence": "Descobertas cosmológicas modernas corroboram início súbito do universo",
            "description": "Evidências científicas do Big Bang confirmam criação ex nihilo",
            "image": "creation-universe.webp",
            "sources": ["NASA", "Observatório Hubble", "CERN"]
          },
          "coordinates": {"lat": 0, "lng": 0, "label": "Jardim do Éden (localização estimada)"}
        },
        {
          "id": "fall",
          "title": "Queda do Homem",
          "description": "Adão e Eva desobedecem a Deus e trazem pecado ao mundo",
          "verse": "Gênesis 3:1-24",
          "significance": "Origem do pecado e necessidade de redenção",
          "archaeological": {
            "evidence": "Rios do Éden identificados na Mesopotâmia",
            "description": "Tigre, Eufrates e outros rios mencionados localização geográfica real",
            "image": "eden-rivers.webp",
            "sources": ["Instituto Arqueológico", "Universidade de Oxford"]
          },
          "coordinates": {"lat": 33.2, "lng": 44.4, "label": "Mesopotâmia - Região do Éden"}
        },
        {
          "id": "flood",
          "title": "Dilúvio Universal",
          "description": "Deus julgou a humanidade corrupta, salvando apenas Noé e sua família",
          "verse": "Gênesis 6:5-9:17",
          "significance": "Juízo divino e misericórdia - novo começoí para humanidade",
          "archaeological": {
            "evidence": "Evidências geológicas globais de grandes inundações",
            "description": "Camadas sedimentares e fósseis marinhos em montanhas comprovam dilúvios catastróficos",
            "image": "flood-evidence.webp",
            "sources": ["Instituto de Pesquisa da Criação", "Museu de História Natural"]
          },
          "coordinates": {"lat": 39.5, "lng": 44.2, "label": "Monte Ararat - Descanso da Arca"}
        },
        {
          "id": "babel",
          "title": "Torre de Babel",
          "description": "Humanidade tenta construir torre até o céu; Deus confunde as línguas",
          "verse": "Gênesis 11:1-9",
          "significance": "Origem das nações e línguas; orgulho humano vs soberania divina",
          "archaeological": {
            "evidence": "Zigurates mesopotâmicos confirmam arquitetura descrita",
            "description": "Torres escalonadas como Torre de Babel encontradas em Ur, Babilônia",
            "image": "babel-ziggurat.webp",
            "sources": ["Museu Britânico", "Expedições em Babilônia"]
          },
          "coordinates": {"lat": 32.5, "lng": 44.4, "label": "Babilônia - Local da Torre"}
        }
      ],
      "timeline": {
        "start": "-2000",
        "end": "-1800", 
        "color": "#8B4513"
      }
    },
    {
      "id": "exodus",
      "name": "Êxodo",
      "order": 2,
      "period": "~1280 AC",
      "author": "Moisés",
      "chapters": 40,
      "theme": "Libertação - Escravidão ao Serviço de Deus",
      "keyVerse": {
        "reference": "Êxodo 14:13",
        "text": "Não temais; ficai firmes e vede o livramento do SENHOR."
      },
      "summary": "A libertação miraculosa de Israel do Egito e o recebimento da Lei no Monte Sinai.",
      "keyEvents": [
        {
          "id": "plagues",
          "title": "Dez Pragas do Egito",
          "description": "Deus demonstra Sua supremacia sobre os deuses egípcios através de dez pragas",
          "verse": "Êxodo 7:14-12:30",
          "significance": "Poder soberano de Deus sobre todas as nações e falsos deuses",
          "archaeological": {
            "evidence": "Papiro Ipuwer descreve calamidades similares às pragas bíblicas",
            "description": "Documento egípcio antigo relata pragas: águas em sangue, trevas, morte dos primogênitos",
            "image": "plagues-papyrus.webp",
            "sources": ["Museu de Leiden", "Papiros Egípcios"]
          },
          "coordinates": {"lat": 30.0, "lng": 31.2, "label": "Egito - Terra das Pragas"}
        },
        {
          "id": "red_sea",
          "title": "Travessia do Mar Vermelho",
          "description": "Deus abre o Mar Vermelho para Israel escapar do exército egípcio",
          "verse": "Êxodo 14:13-31",
          "significance": "Poder milagroso de Deus e libertação completa da escravidão",
          "archaeological": {
            "evidence": "Carros de guerra egípcios encontrados no fundo do mar",
            "description": "Destroços de carruagens e ossos de cavalos descobertos no Mar Vermelho",
            "image": "red-sea-crossing.webp",
            "sources": ["Instituto Red Sea Crossing", "Arqueologia Submarina"]
          },
          "coordinates": {"lat": 28.0, "lng": 34.5, "label": "Mar Vermelho - Local da Travessia"}
        }
      ],
      "timeline": {
        "start": "-1300",
        "end": "-1200",
        "color": "#DC143C"
      }
    }
  ]
}
EOF

# Criar CSS base para timeline
echo "🎨 Criando estilos CSS da timeline..."
cat > assets/css/timeline.css << 'EOF'
/* ============================================
   TIMELINE BÍBLICA - ESTILOS PRINCIPAIS
   ============================================ */

.biblical-timeline {
    position: relative;
    max-width: 1200px;
    margin: 0 auto;
    font-family: 'Montserrat', sans-serif;
}

/* Container principal */
.timeline-container {
    position: relative;
    padding: 2rem 0;
    background: linear-gradient(135deg, #1a1611 0%, #2c1810 100%);
    color: #d4af37;
}

/* Linha central da timeline */
.timeline-line {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    width: 4px;
    height: 100%;
    background: linear-gradient(to bottom, #d4af37 0%, #f4d03f 50%, #b7950b 100%);
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.5);
}

/* Divisor entre testamentos */
.testament-divider {
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 4rem 0;
    position: relative;
}

.testament-divider::before {
    content: '';
    position: absolute;
    width: 100%;
    height: 2px;
    background: linear-gradient(90deg, transparent 0%, #d4af37 50%, transparent 100%);
    z-index: 1;
}

.testament-title {
    background: #1a1611;
    padding: 1rem 2rem;
    border: 2px solid #d4af37;
    border-radius: 50px;
    font-size: 1.5rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 2px;
    z-index: 2;
    box-shadow: 0 0 30px rgba(212, 175, 55, 0.3);
}

/* Cards dos livros bíblicos */
.bible-book {
    position: relative;
    margin: 3rem 0;
    display: flex;
    align-items: center;
}

.bible-book:nth-child(even) {
    flex-direction: row-reverse;
}

.book-content {
    width: 45%;
    padding: 2rem;
    background: rgba(212, 175, 55, 0.1);
    border: 1px solid #d4af37;
    border-radius: 15px;
    backdrop-filter: blur(10px);
    position: relative;
    transition: all 0.3s ease;
}

.book-content:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(212, 175, 55, 0.2);
    border-color: #f4d03f;
}

/* Indicador na timeline */
.timeline-marker {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    width: 20px;
    height: 20px;
    background: #d4af37;
    border: 4px solid #1a1611;
    border-radius: 50%;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.7);
    z-index: 3;
    cursor: pointer;
    transition: all 0.3s ease;
}

.timeline-marker:hover {
    transform: translateX(-50%) scale(1.2);
    box-shadow: 0 0 30px rgba(212, 175, 55, 0.9);
}

/* Conectores */
.book-connector {
    position: absolute;
    width: 2px;
    height: 30px;
    background: #d4af37;
    left: 50%;
    transform: translateX(-50%);
}

.bible-book:nth-child(even) .book-connector {
    left: 50%;
}

/* Responsivo */
@media (max-width: 768px) {
    .bible-book {
        flex-direction: column !important;
        text-align: center;
    }
    
    .bible-book:nth-child(even) {
        flex-direction: column !important;
    }
    
    .book-content {
        width: 90%;
        margin: 1rem 0;
    }
    
    .timeline-line {
        left: 20px;
        transform: none;
    }
    
    .timeline-marker {
        left: 20px;
        transform: translateX(-50%);
    }
    
    .book-connector {
        left: 20px;
    }
}
EOF

echo "✅ SCRIPT 10-timeline-biblical.sh PARTE 1 EXECUTADO COM SUCESSO!"
echo ""
echo "📋 RESUMO - PARTE 1 CRIADA:"
echo "   ✓ Estrutura de pastas para timeline criada"
echo "   ✓ Configurações base da timeline (JSON)"
echo "   ✓ Dados do Antigo Testamento - primeiros livros"  
echo "   ✓ CSS base para timeline interativa"
echo "   ✓ Placeholders para imagens arqueológicas"
echo "   ✓ Backup automático criado"
echo ""
echo "📁 ARQUIVOS CRIADOS:"
echo "   • json/timeline/timeline-config.json"
echo "   • json/timeline/old-testament.json"  
echo "   • assets/css/timeline.css"
echo "   • assets/images/timeline/ (estrutura)"
echo ""
echo "🚀 PARA EXECUTAR ESTA PARTE 1:"
echo "   chmod +x 10-timeline-biblical.sh && ./10-timeline-biblical.sh"
echo ""
echo "⏭️  PRÓXIMOS PASSOS:"
echo "   Digite 'continuar' para criar PARTE 1a com:"
echo "   • Dados completos do Novo Testamento"
echo "   • JavaScript interativo da timeline"
echo "   • Sistema de filtros por testamento"
echo "   • Integração com evidências arqueológicas"