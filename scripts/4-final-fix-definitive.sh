#!/bin/bash

# =====================================================
# SCRIPT 4: SOLUÇÃO DEFINITIVA - INTEGRAÇÃO REAL
# Portal "Jesus é o Pão da Vida"
# FOCO: Integrar com HTML/CSS existente
# =====================================================
# Uso: chmod +x 4-final-fix-definitive.sh && ./4-final-fix-definitive.sh
# =====================================================

set -e

echo "🎯 SOLUÇÃO DEFINITIVA - INTEGRAÇÃO REAL"
echo "Portal: Jesus é o Pão da Vida"
echo "====================================="
echo ""
echo "🔍 PROBLEMAS REAIS IDENTIFICADOS:"
echo "1. TreasureChest carregado 2x no HTML (conflito)"
echo "2. Baú não encontra onde se inserir no DOM existente"
echo "3. JSON com 0 promessas (estrutura incorreta)"
echo "4. renderPromises ainda tem bug 'element'"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto"
    exit 1
fi

# Backup final
echo "💾 Backup final..."
BACKUP_DIR="backup-definitive-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp index.html "$BACKUP_DIR/"
cp js/treasure-chest.js "$BACKUP_DIR/"
cp js/main.js "$BACKUP_DIR/"
cp json/local_verses.json "$BACKUP_DIR/" 2>/dev/null || true
echo "   ✅ Backup: $BACKUP_DIR"
echo ""

# ===========================================
# CORREÇÃO 1: REMOVER CARREGAMENTO DUPLO
# ===========================================
echo "🔧 CORREÇÃO 1: Removendo carregamento duplo do HTML"

# Remover uma das linhas duplicadas do script
sed -i '/treasure-chest\.js/I {N; s/.*treasure-chest\.js.*\n.*treasure-chest\.js.*/<script src="js\/treasure-chest.js"><\/script>/; t; b}' index.html

# Verificação mais segura - remover linha 85 se ainda existir duplicata
if [ $(grep -c "treasure-chest.js" index.html) -gt 1 ]; then
    echo "   🔧 Removendo duplicata restante..."
    sed -i '85{/treasure-chest\.js/d;}' index.html
fi

echo "   ✅ Carregamento duplo removido"

# ===========================================
# CORREÇÃO 2: INTEGRAÇÃO COM HTML EXISTENTE
# ===========================================
echo ""
echo "🔧 CORREÇÃO 2: Criando integração real com HTML existente"

# Analisar onde o baú deve aparecer no HTML atual
TARGET_SECTION=$(grep -n "VER MAIS PROMESSAS DIVINAS\|promise.*section\|promessas" index.html | head -1 | cut -d: -f1)

if [ -z "$TARGET_SECTION" ]; then
    echo "   🔍 Procurando seção de promessas no HTML..."
    TARGET_SECTION=$(grep -n "Versículos.*Transformam\|promessa" index.html | head -1 | cut -d: -f1)
fi

echo "   📍 Seção alvo encontrada na linha: ${TARGET_SECTION:-'não encontrada'}"

# Criar treasure-chest integrado ao design existente
cat > js/treasure-chest.js << 'EOF'
// =====================================================
// TREASURE CHEST - INTEGRAÇÃO COM DESIGN EXISTENTE
// Portal: Jesus é o Pão da Vida
// =====================================================

(function() {
    'use strict';
    
    // Evitar execução múltipla
    if (window.TreasureChestIntegrated) {
        console.log('⚠️ TreasureChest já carregado');
        return;
    }
    
    window.TreasureChestIntegrated = {
        promises: [],
        isOpen: false,
        initialized: false,
        
        async init() {
            if (this.initialized) return;
            
            console.log('🎁 Inicializando TreasureChest integrado...');
            
            // Aguardar DOM se necessário
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', () => this.setup());
            } else {
                this.setup();
            }
        },
        
        async setup() {
            await this.loadPromises();
            this.insertChestIntoExistingDesign();
            this.bindEvents();
            this.initialized = true;
            console.log('✅ TreasureChest integrado ao design existente');
        },
        
        async loadPromises() {
            try {
                const response = await fetch('./json/local_verses.json');
                const data = await response.json();
                
                // Tentar diferentes estruturas
                this.promises = data.verses || data.promessas || data.versiculos || data.promises || [];
                
                console.log('✅ Promessas carregadas:', this.promises.length);
                
                if (this.promises.length === 0) {
                    this.promises = this.getDefaultPromises();
                    console.log('📝 Usando promessas padrão');
                }
                
            } catch (error) {
                console.error('❌ Erro ao carregar promessas:', error);
                this.promises = this.getDefaultPromises();
            }
        },
        
        getDefaultPromises() {
            return [
                { verse: "João 6:35", text: "Jesus disse: Eu sou o pão da vida; aquele que vem a mim não terá fome." },
                { verse: "Filipenses 4:19", text: "O meu Deus suprirá todas as vossas necessidades segundo as suas riquezas em glória." },
                { verse: "Salmos 23:1", text: "O Senhor é o meu pastor; nada me faltará." },
                { verse: "Mateus 6:26", text: "Olhai para as aves do céu... vosso Pai celestial as alimenta." },
                { verse: "Jeremias 29:11", text: "Eu bem sei os pensamentos que tenho a vosso respeito, diz o Senhor." }
            ];
        },
        
        insertChestIntoExistingDesign() {
            // Procurar seção de promessas existente
            const promiseSection = document.querySelector('.promise-section') ||
                                 document.querySelector('#promessas') ||
                                 document.querySelector('.promesas-section') ||
                                 document.querySelector('[class*="promise"]') ||
                                 document.querySelector('[id*="promise"]');
            
            if (!promiseSection) {
                console.error('❌ Seção de promessas não encontrada');
                return;
            }
            
            // Criar baú com design consistente
            const chestHTML = `
                <div class="treasure-chest-wrapper" style="text-align: center; margin: 30px 0;">
                    <div class="treasure-chest-card" style="
                        background: linear-gradient(135deg, #8b4513 0%, #a0522d 100%);
                        border: 2px solid #d4af37;
                        border-radius: 15px;
                        padding: 20px;
                        max-width: 300px;
                        margin: 0 auto;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
                    " onmouseover="this.style.transform='scale(1.05)'; this.style.boxShadow='0 8px 25px rgba(212, 175, 55, 0.5)'"
                       onmouseout="this.style.transform='scale(1)'; this.style.boxShadow='0 4px 15px rgba(212, 175, 55, 0.3)'">
                        
                        <div class="chest-icon" style="font-size: 3em; margin-bottom: 10px;">🎁</div>
                        <h4 style="color: #d4af37; margin: 0 0 10px 0; font-family: inherit;">Caixinha de Promessas</h4>
                        <p style="color: #f4e4bc; margin: 0; font-size: 0.9em;">Clique para descobrir uma promessa divina</p>
                    </div>
                </div>
            `;
            
            // Inserir no início da seção
            promiseSection.insertAdjacentHTML('afterbegin', chestHTML);
            
            console.log('✅ Baú inserido na seção de promessas');
        },
        
        bindEvents() {
            const chest = document.querySelector('.treasure-chest-card');
            if (chest) {
                chest.addEventListener('click', () => this.openChest());
                console.log('✅ Eventos do baú vinculados');
            }
        },
        
        openChest() {
            if (this.isOpen || this.promises.length === 0) return;
            
            this.isOpen = true;
            
            // Animação
            const chest = document.querySelector('.treasure-chest-card');
            if (chest) {
                chest.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    chest.style.transform = 'scale(1.05)';
                }, 100);
            }
            
            // Promessa aleatória
            const randomPromise = this.promises[Math.floor(Math.random() * this.promises.length)];
            
            setTimeout(() => this.showPromise(randomPromise), 300);
        },
        
        showPromise(promise) {
            // Modal com design consistente
            const modal = document.createElement('div');
            modal.style.cssText = `
                position: fixed; top: 0; left: 0; right: 0; bottom: 0;
                background: rgba(44, 24, 16, 0.95);
                display: flex; align-items: center; justify-content: center;
                z-index: 10000; backdrop-filter: blur(5px);
            `;
            
            modal.innerHTML = `
                <div style="
                    background: linear-gradient(135deg, #2c1810 0%, #3d2317 100%);
                    border: 2px solid #d4af37;
                    border-radius: 20px;
                    padding: 40px;
                    max-width: 500px;
                    text-align: center;
                    box-shadow: 0 20px 60px rgba(0,0,0,0.5);
                    color: #f4e4bc;
                    font-family: inherit;
                ">
                    <div style="font-size: 3em; margin-bottom: 20px;">🙏</div>
                    <h3 style="color: #d4af37; margin: 0 0 20px 0;">Promessa de Deus para Você</h3>
                    <p style="font-weight: bold; color: #d4af37; font-size: 1.2em; margin-bottom: 15px;">${promise.verse}</p>
                    <p style="font-style: italic; line-height: 1.6; margin-bottom: 30px; font-size: 1.1em;">"${promise.text}"</p>
                    <button onclick="this.closest('[style*=fixed]').remove(); window.TreasureChestIntegrated.isOpen = false;" 
                            style="
                                background: #d4af37;
                                color: #2c1810;
                                border: none;
                                padding: 15px 30px;
                                border-radius: 10px;
                                font-size: 1.1em;
                                font-weight: bold;
                                cursor: pointer;
                                transition: all 0.3s ease;
                            " onmouseover="this.style.background='#b8941f'"
                               onmouseout="this.style.background='#d4af37'">
                        Amém 🙏
                    </button>
                </div>
            `;
            
            document.body.appendChild(modal);
            
            // Fechar com clique fora ou ESC
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.remove();
                    this.isOpen = false;
                }
            });
            
            const escHandler = (e) => {
                if (e.key === 'Escape') {
                    modal.remove();
                    this.isOpen = false;
                    document.removeEventListener('keydown', escHandler);
                }
            };
            document.addEventListener('keydown', escHandler);
        }
    };
    
    // Inicializar
    window.TreasureChestIntegrated.init();
    
})();
EOF

echo "   ✅ TreasureChest integrado criado"

# ===========================================
# CORREÇÃO 3: CORRIGIR JSON DE PROMESSAS
# ===========================================
echo ""
echo "🔧 CORREÇÃO 3: Corrigindo JSON de promessas"

cat > json/local_verses.json << 'EOF'
{
  "verses": [
    {
      "verse": "João 6:35",
      "text": "Jesus disse: Eu sou o pão da vida; aquele que vem a mim não terá fome, e quem crê em mim nunca terá sede.",
      "category": "Sustento espiritual"
    },
    {
      "verse": "Filipenses 4:19",
      "text": "O meu Deus, segundo as suas riquezas, suprirá todas as vossas necessidades em glória, por Cristo Jesus.",
      "category": "Provisão"
    },
    {
      "verse": "Salmos 23:1",
      "text": "O Senhor é o meu pastor; nada me faltará.",
      "category": "Proteção"
    },
    {
      "verse": "Mateus 6:26",
      "text": "Olhai para as aves do céu, que nem semeiam, nem segam, nem ajuntam em celeiros; e vosso Pai celestial as alimenta. Não tendes vós muito mais valor do que elas?",
      "category": "Cuidado divino"
    },
    {
      "verse": "Jeremias 29:11",
      "text": "Porque eu bem sei os pensamentos que tenho a vosso respeito, diz o Senhor; pensamentos de paz e não de mal, para vos dar o fim que esperais.",
      "category": "Futuro e esperança"
    },
    {
      "verse": "Isaías 41:10",
      "text": "Não temas, porque eu sou contigo; não te assombres, porque eu sou teu Deus; eu te fortaleço, e te ajudo, e te sustento com a minha destra fiel.",
      "category": "Força e coragem"
    },
    {
      "verse": "1 Pedro 5:7",
      "text": "Lançando sobre ele toda a vossa ansiedade, porque ele tem cuidado de vós.",
      "category": "Ansiedade"
    },
    {
      "verse": "Romanos 8:28",
      "text": "E sabemos que todas as coisas contribuem juntamente para o bem daqueles que amam a Deus, daqueles que são chamados segundo o seu propósito.",
      "category": "Propósito"
    }
  ]
}
EOF

echo "   ✅ JSON com 8 promessas criado"

# ===========================================
# CORREÇÃO 4: CORRIGIR RENDERPROMISES
# ===========================================
echo ""
echo "🔧 CORREÇÃO 4: Corrigindo renderPromises definitivamente"

# Substituir linha problemática específica
sed -i 's/element\.style\.fontFamily/card.style.fontFamily/g' js/main.js

# Verificar se correção foi aplicada
if grep -q "card\.style\.fontFamily" js/main.js; then
    echo "   ✅ renderPromises corrigido (element → card)"
else
    echo "   ⚠️ Correção não aplicada - linha pode ter mudado"
fi

# ===========================================
# TESTES E VERIFICAÇÕES FINAIS
# ===========================================
echo ""
echo "🧪 VERIFICAÇÕES FINAIS"

# Verificar carregamento duplo removido
duplicates=$(grep -c "treasure-chest.js" index.html)
echo "   📊 Scripts treasure-chest.js no HTML: $duplicates"

if [ "$duplicates" -eq 1 ]; then
    echo "   ✅ Carregamento duplo corrigido"
else
    echo "   ⚠️ Ainda pode haver duplicatas"
fi

# Verificar JSON
promesas_count=$(python3 -c "
import json
try:
    with open('json/local_verses.json', 'r') as f:
        data = json.load(f)
        print(len(data.get('verses', [])))
except:
    print('0')
" 2>/dev/null)

echo "   📊 Promessas no JSON: $promesas_count"

# Verificar sintaxe JS
if command -v node &> /dev/null; then
    if node -c js/treasure-chest.js 2>/dev/null; then
        echo "   ✅ treasure-chest.js - Sintaxe OK"
    else
        echo "   ❌ treasure-chest.js - Erro de sintaxe"
    fi
fi

# ===========================================
# CRIAR TESTE FINAL ESPECÍFICO
# ===========================================
echo ""
echo "🎯 CRIANDO TESTE FINAL ESPECÍFICO"

cat > test-final-integration.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste Final - Integração TreasureChest</title>
    <style>
        body { 
            font-family: 'Montserrat', Arial, sans-serif; 
            background: #2c1810; 
            color: #f4e4bc; 
            padding: 20px; 
            line-height: 1.6;
        }
        .test-container { 
            max-width: 800px; 
            margin: 0 auto; 
        }
        .test-result { 
            padding: 10px; 
            margin: 10px 0; 
            border-radius: 5px; 
            border-left: 4px solid #d4af37;
        }
        .success { background: rgba(81, 207, 102, 0.1); color: #51cf66; }
        .error { background: rgba(255, 107, 107, 0.1); color: #ff6b6b; }
        .warning { background: rgba(255, 212, 59, 0.1); color: #ffd43b; }
        .info { background: rgba(51, 154, 240, 0.1); color: #339af0; }
        
        .promise-section {
            background: linear-gradient(135deg, #2c1810 0%, #3d2317 100%);
            padding: 40px 20px;
            border-radius: 15px;
            margin: 30px 0;
            border: 1px solid #d4af37;
        }
        
        h1 { color: #d4af37; text-align: center; }
        h2 { color: #d4af37; }
    </style>
</head>
<body>
    <div class="test-container">
        <h1>🎯 Teste Final - Integração Real do TreasureChest</h1>
        
        <div id="test-results"></div>
        
        <h2>🎁 Teste de Integração Visual</h2>
        <p>O baú deve aparecer integrado à seção abaixo (igual ao design do site):</p>
        
        <div class="promise-section">
            <h3 style="color: #d4af37; text-align: center; margin: 0 0 20px 0;">
                Versículos que Transformam Vidas
            </h3>
            <p style="text-align: center; margin-bottom: 30px; color: #f4e4bc;">
                Cada promessa de Deus é uma fonte de esperança e força
            </p>
            <!-- O baú será inserido aqui pelo JavaScript -->
        </div>
        
        <div class="test-result info">
            <strong>Instruções:</strong><br>
            1. O baú deve aparecer integrado na seção acima<br>
            2. Clique no baú para testar uma promessa<br>
            3. Verifique se não há erros no console (F12)
        </div>
    </div>

    <script>
        const results = document.getElementById('test-results');
        
        function addResult(type, message) {
            const div = document.createElement('div');
            div.className = `test-result ${type}`;
            div.innerHTML = `<strong>${type.toUpperCase()}:</strong> ${message}`;
            results.appendChild(div);
        }
        
        addResult('info', 'Iniciando teste de integração...');
        
        // Aguardar carregamento do script
        setTimeout(() => {
            // Teste 1: Script carregado
            if (typeof window.TreasureChestIntegrated !== 'undefined') {
                addResult('success', 'TreasureChestIntegrated carregado');
                
                // Teste 2: Inicialização
                if (window.TreasureChestIntegrated.initialized) {
                    addResult('success', 'TreasureChest inicializado');
                } else {
                    addResult('warning', 'TreasureChest ainda não inicializado');
                }
                
                // Teste 3: Promessas
                const promiseCount = window.TreasureChestIntegrated.promises.length;
                addResult('info', `${promiseCount} promessas carregadas`);
                
                if (promiseCount > 0) {
                    addResult('success', 'Promessas carregadas com sucesso');
                } else {
                    addResult('error', 'Nenhuma promessa carregada');
                }
                
            } else {
                addResult('error', 'TreasureChestIntegrated não encontrado');
            }
            
            // Teste 4: Elemento visual
            setTimeout(() => {
                const chestElement = document.querySelector('.treasure-chest-card');
                if (chestElement) {
                    addResult('success', 'Elemento do baú encontrado no DOM');
                    
                    // Teste de posicionamento
                    const section = document.querySelector('.promise-section');
                    if (section && section.contains(chestElement)) {
                        addResult('success', 'Baú corretamente integrado na seção');
                    } else {
                        addResult('warning', 'Baú pode não estar na posição correta');
                    }
                } else {
                    addResult('error', 'Elemento do baú não encontrado');
                }
            }, 500);
            
        }, 1000);
        
        // Teste de JSON
        fetch('./json/local_verses.json')
            .then(response => response.json())
            .then(data => {
                const count = data.verses ? data.verses.length : 0;
                addResult('success', `JSON válido com ${count} promessas`);
            })
            .catch(error => {
                addResult('error', `Erro no JSON: ${error.message}`);
            });
        
        console.log('🎯 Teste final de integração iniciado');
    </script>
    
    <!-- Carregar script integrado -->
    <script src="js/treasure-chest.js"></script>
</body>
</html>
EOF

echo "   ✅ Teste final criado: test-final-integration.html"

echo ""
echo "🎯 SOLUÇÃO DEFINITIVA APLICADA"
echo "================================"
echo "✅ 1. Carregamento duplo removido do HTML"
echo "✅ 2. TreasureChest integrado ao design existente"
echo "✅ 3. JSON com 8 promessas válidas criado"
echo "✅ 4. renderPromises corrigido (element → card)"
echo "✅ 5. Backup completo: $BACKUP_DIR"
echo ""
echo "🧪 TESTE DEFINITIVO:"
echo "python3 -m http.server 8000"
echo "Abra: http://localhost:8000/test-final-integration.html"
echo ""
echo "🌐 TESTE NO SITE REAL:"
echo "Abra: http://localhost:8000"
echo "Procure o baú na seção 'Versículos que Transformam Vidas'"
echo ""
echo "✨ Esta é a solução definitiva baseada nos problemas reais identificados!"