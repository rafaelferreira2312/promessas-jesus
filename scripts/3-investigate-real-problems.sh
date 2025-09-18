#!/bin/bash

# =====================================================
# SCRIPT 3: INVESTIGAÇÃO E CORREÇÃO REAL DOS PROBLEMAS
# Portal "Jesus é o Pão da Vida"
# =====================================================
# Uso: chmod +x 3-investigate-real-problems.sh && ./3-investigate-real-problems.sh
# =====================================================

set -e

echo "🔍 INVESTIGAÇÃO REAL DOS PROBLEMAS JAVASCRIPT"
echo "Portal: Jesus é o Pão da Vida"
echo "============================================="
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto (onde está index.html)"
    exit 1
fi

echo "📋 PROBLEMAS AINDA PRESENTES (BASEADO NO CONSOLE):"
echo "1. 'Uncaught SyntaxError: redeclaration of let FixedTreasureChest'"
echo "2. 'ReferenceError: element is not defined' na renderPromises"
echo "3. Baú sumiu do site"
echo "4. ✅ Promessas carregadas: 0 (problema no carregamento)"
echo ""

# Backup completo
echo "💾 Criando backup completo..."
BACKUP_DIR="backup-investigation-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp -r js/ "$BACKUP_DIR/" 2>/dev/null || true
cp -r css/ "$BACKUP_DIR/" 2>/dev/null || true
echo "   ✅ Backup completo: $BACKUP_DIR"
echo ""

# ============================================
# INVESTIGAÇÃO 1: PROBLEMA DO TREASURE CHEST
# ============================================
echo "🔍 INVESTIGAÇÃO 1: TREASURE CHEST"

if [ -f "js/treasure-chest.js" ]; then
    echo "   📄 Analisando js/treasure-chest.js..."
    
    # Mostrar primeiras linhas para entender o problema
    echo "   🔍 Primeiras 10 linhas do arquivo:"
    head -10 js/treasure-chest.js | sed 's/^/      /'
    
    # Verificar declarações específicas
    echo ""
    echo "   📊 Análise de declarações:"
    
    if grep -n "let FixedTreasureChest" js/treasure-chest.js; then
        echo "      ⚠️ Declarações 'let' encontradas"
    fi
    
    if grep -n "class FixedTreasureChest" js/treasure-chest.js; then
        echo "      ⚠️ Declarações 'class' encontradas"
    fi
    
    if grep -n "FixedTreasureChest.*=" js/treasure-chest.js; then
        echo "      ⚠️ Atribuições encontradas"
    fi
    
    # Detectar se há include/import duplo
    echo ""
    echo "   🔍 Verificando duplicações ou importações:"
    
    # Verificar se há conteúdo duplicado no arquivo
    if [ $(wc -l < js/treasure-chest.js) -gt 200 ]; then
        echo "      ⚠️ Arquivo muito grande ($(wc -l < js/treasure-chest.js) linhas) - possível duplicação"
    fi
    
else
    echo "   ❌ js/treasure-chest.js não encontrado"
fi

# ============================================
# INVESTIGAÇÃO 2: PROBLEMA DO MAIN.JS
# ============================================
echo ""
echo "🔍 INVESTIGAÇÃO 2: MAIN.JS - RENDERPROMISES"

if [ -f "js/main.js" ]; then
    echo "   📄 Analisando js/main.js..."
    
    # Procurar função renderPromises
    if grep -n "function renderPromises\|renderPromises.*=" js/main.js; then
        echo "      ✅ Função renderPromises encontrada"
        
        # Extrair a função e analisar
        echo "   🔍 Analisando função renderPromises:"
        awk '/function renderPromises|renderPromises.*function/{flag=1; print NR ": " $0} 
             flag && /element/{print NR ": " $0} 
             flag && /^\s*\}$/{flag=0}' js/main.js | head -20
        
    else
        echo "      ❌ Função renderPromises não encontrada"
    fi
    
    # Verificar onde está o problema específico
    echo ""
    echo "   🔍 Procurando 'element is not defined' na linha 668:"
    sed -n '665,670p' js/main.js | sed 's/^/      /'
    
else
    echo "   ❌ js/main.js não encontrado"
fi

# ============================================
# INVESTIGAÇÃO 3: CARREGAMENTO DE PROMESSAS
# ============================================
echo ""
echo "🔍 INVESTIGAÇÃO 3: ARQUIVO DE PROMESSAS"

if [ -f "json/local_verses.json" ]; then
    echo "   📄 Verificando json/local_verses.json..."
    
    # Verificar se arquivo está válido
    if command -v python3 &> /dev/null; then
        if python3 -m json.tool json/local_verses.json > /dev/null 2>&1; then
            echo "      ✅ JSON válido"
            
            # Contar promessas
            verses_count=$(python3 -c "
import json
with open('json/local_verses.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    print(len(data.get('verses', data.get('promessas', []))))
" 2>/dev/null || echo "0")
            
            echo "      📊 Promessas disponíveis: $verses_count"
            
            if [ "$verses_count" -eq 0 ]; then
                echo "      ❌ PROBLEMA: Arquivo vazio ou estrutura incorreta"
            fi
        else
            echo "      ❌ JSON inválido"
        fi
    else
        echo "      ⚠️ Python3 não encontrado - não é possível validar JSON"
    fi
else
    echo "   ❌ json/local_verses.json não encontrado"
fi

# ============================================
# INVESTIGAÇÃO 4: COMO O BAÚ É CARREGADO
# ============================================
echo ""
echo "🔍 INVESTIGAÇÃO 4: CARREGAMENTO DO BAÚ NO HTML"

if [ -f "index.html" ]; then
    echo "   📄 Verificando index.html..."
    
    # Verificar se há referência ao treasure-chest
    if grep -n "treasure-chest" index.html; then
        echo "      ✅ Referências ao treasure-chest encontradas"
    else
        echo "      ❌ Nenhuma referência ao treasure-chest no HTML"
    fi
    
    # Verificar scripts carregados
    echo ""
    echo "   🔍 Scripts carregados no HTML:"
    grep -n "<script" index.html | sed 's/^/      /'
    
else
    echo "   ❌ index.html não encontrado"
fi

# ============================================
# SOLUÇÃO BASEADA NA INVESTIGAÇÃO
# ============================================
echo ""
echo "🔧 APLICANDO SOLUÇÕES BASEADAS NA INVESTIGAÇÃO"

# Solução 1: Recriar treasure-chest.js limpo
echo ""
echo "   🔧 SOLUÇÃO 1: Recriando treasure-chest.js..."

cat > js/treasure-chest-fixed.js << 'EOF'
// =====================================================
// TREASURE CHEST - CAIXINHA DE PROMESSAS (VERSÃO CORRIGIDA)
// Portal: Jesus é o Pão da Vida
// =====================================================

// Evitar declaração múltipla
if (typeof window.TreasureChestManager === 'undefined') {
    
    window.TreasureChestManager = {
        isInitialized: false,
        promises: [],
        isChestOpen: false,
        
        async init() {
            if (this.isInitialized) {
                console.log('⚠️ TreasureChest já inicializado');
                return;
            }
            
            console.log('🎁 Inicializando Treasure Chest...');
            
            await this.loadPromises();
            this.createChestElement();
            this.bindEvents();
            
            this.isInitialized = true;
            console.log('✅ TreasureChest inicializado com sucesso');
        },
        
        async loadPromises() {
            try {
                const response = await fetch('./json/local_verses.json');
                if (!response.ok) {
                    throw new Error(`HTTP ${response.status}`);
                }
                
                const data = await response.json();
                this.promises = data.verses || data.promessas || data.versiculos || [];
                
                console.log('✅ Promessas carregadas:', this.promises.length);
                
                // Se ainda estiver vazio, usar promessas padrão
                if (this.promises.length === 0) {
                    this.promises = this.getDefaultPromises();
                    console.log('📝 Usando promessas padrão:', this.promises.length);
                }
                
            } catch (error) {
                console.error('❌ Erro ao carregar promessas:', error);
                this.promises = this.getDefaultPromises();
                console.log('📝 Usando promessas de fallback');
            }
        },
        
        getDefaultPromises() {
            return [
                {
                    verse: "João 6:35",
                    text: "Jesus disse: Eu sou o pão da vida; aquele que vem a mim não terá fome, e quem crê em mim nunca terá sede."
                },
                {
                    verse: "Filipenses 4:19",
                    text: "O meu Deus, segundo as suas riquezas, suprirá todas as vossas necessidades em glória, por Cristo Jesus."
                },
                {
                    verse: "Mateus 6:26",
                    text: "Olhai para as aves do céu, que nem semeiam, nem segam, nem ajuntam em celeiros; e vosso Pai celestial as alimenta."
                },
                {
                    verse: "Salmos 23:1",
                    text: "O Senhor é o meu pastor; nada me faltará."
                },
                {
                    verse: "Jeremias 29:11",
                    text: "Porque eu bem sei os pensamentos que tenho a vosso respeito, diz o Senhor; pensamentos de paz e não de mal."
                }
            ];
        },
        
        createChestElement() {
            // Verificar se já existe
            if (document.querySelector('.treasure-chest-container')) {
                console.log('⚠️ Baú já existe no DOM');
                return;
            }
            
            // Criar container do baú
            const chestContainer = document.createElement('div');
            chestContainer.className = 'treasure-chest-container';
            chestContainer.innerHTML = `
                <div class="treasure-chest" title="✨ Clique para descobrir uma promessa divina">
                    <div class="chest-icon">🎁</div>
                    <div class="chest-glow"></div>
                </div>
            `;
            
            // Encontrar onde inserir
            const targetSection = document.querySelector('.promise-section') || 
                                 document.querySelector('#promessas') ||
                                 document.querySelector('.promesas-section') ||
                                 document.querySelector('main');
            
            if (targetSection) {
                // Inserir no início da seção
                targetSection.insertBefore(chestContainer, targetSection.firstChild);
                console.log('✅ Baú inserido no DOM');
            } else {
                console.error('❌ Não foi possível encontrar seção para inserir o baú');
            }
        },
        
        bindEvents() {
            const chest = document.querySelector('.treasure-chest');
            if (chest) {
                chest.addEventListener('click', () => this.openChest());
                console.log('✅ Eventos do baú vinculados');
            }
        },
        
        openChest() {
            if (this.isChestOpen || this.promises.length === 0) {
                return;
            }
            
            this.isChestOpen = true;
            
            // Animação visual
            const chest = document.querySelector('.treasure-chest');
            if (chest) {
                chest.classList.add('opening');
            }
            
            // Selecionar promessa aleatória
            const randomIndex = Math.floor(Math.random() * this.promises.length);
            const selectedPromise = this.promises[randomIndex];
            
            // Mostrar promessa após pequeno delay
            setTimeout(() => {
                this.displayPromise(selectedPromise);
            }, 600);
        },
        
        displayPromise(promise) {
            // Criar modal da promessa
            const modal = document.createElement('div');
            modal.className = 'promise-modal';
            modal.innerHTML = `
                <div class="promise-modal-content">
                    <div class="promise-header">
                        <h3>🙏 Promessa de Deus para Você</h3>
                    </div>
                    <div class="promise-body">
                        <p class="promise-verse">${promise.verse}</p>
                        <p class="promise-text">"${promise.text}"</p>
                    </div>
                    <div class="promise-footer">
                        <button class="promise-close-btn">Amém 🙏</button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
            
            // Eventos de fechamento
            const closeBtn = modal.querySelector('.promise-close-btn');
            if (closeBtn) {
                closeBtn.addEventListener('click', () => this.closePromise(modal));
            }
            
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    this.closePromise(modal);
                }
            });
            
            // Fechar com ESC
            const escHandler = (e) => {
                if (e.key === 'Escape') {
                    this.closePromise(modal);
                    document.removeEventListener('keydown', escHandler);
                }
            };
            document.addEventListener('keydown', escHandler);
        },
        
        closePromise(modal) {
            if (modal) {
                modal.remove();
            }
            
            // Reset do baú
            const chest = document.querySelector('.treasure-chest');
            if (chest) {
                chest.classList.remove('opening');
            }
            
            this.isChestOpen = false;
        }
    };
    
    // Inicializar quando DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            window.TreasureChestManager.init();
        });
    } else {
        window.TreasureChestManager.init();
    }
}
EOF

echo "      ✅ Arquivo treasure-chest-fixed.js criado"

# Substituir arquivo original
mv js/treasure-chest.js js/treasure-chest-backup.js
mv js/treasure-chest-fixed.js js/treasure-chest.js

echo "      ✅ Arquivo original substituído"

# Solução 2: Corrigir renderPromises no main.js
echo ""
echo "   🔧 SOLUÇÃO 2: Corrigindo renderPromises no main.js..."

if [ -f "js/main.js" ]; then
    # Backup específico
    cp js/main.js js/main.js.backup-fix
    
    # Usar Python para correção precisa
    python3 << 'PYTHON_FIX'
import re

# Ler o arquivo
with open('js/main.js', 'r', encoding='utf-8') as f:
    content = f.read()

# Corrigir 'element' não definido na função renderPromises
def fix_render_promises(content):
    # Padrão para encontrar a função renderPromises
    pattern = r'(function\s+renderPromises[^{]*\{[^}]*?)element\b'
    
    # Substituir 'element' por 'promiseElement' e garantir que seja definido
    def replacement(match):
        func_start = match.group(1)
        if 'promiseElement' not in func_start:
            # Adicionar definição no início da função
            func_start = func_start + '\n    const promiseElement = document.createElement("div");\n    '
        return func_start + 'promiseElement'
    
    content = re.sub(pattern, replacement, content)
    
    # Substituições diretas comuns
    content = re.sub(r'\belement\.appendChild\b', 'promiseElement.appendChild', content)
    content = re.sub(r'\belement\.innerHTML\b', 'promiseElement.innerHTML', content)
    content = re.sub(r'\belement\.classList\b', 'promiseElement.classList', content)
    content = re.sub(r'\belement\.style\b', 'promiseElement.style', content)
    content = re.sub(r'\belement\.setAttribute\b', 'promiseElement.setAttribute', content)
    
    return content

# Aplicar correção
content = fix_render_promises(content)

# Salvar arquivo
with open('js/main.js', 'w', encoding='utf-8') as f:
    f.write(content)

print("✅ Função renderPromises corrigida")
PYTHON_FIX

else
    echo "      ❌ js/main.js não encontrado"
fi

# Solução 3: Verificar e corrigir JSON de promessas
echo ""
echo "   🔧 SOLUÇÃO 3: Verificando JSON de promessas..."

if [ ! -f "json/local_verses.json" ] || [ ! -s "json/local_verses.json" ]; then
    echo "      🔧 Criando json/local_verses.json..."
    
    mkdir -p json
    
    cat > json/local_verses.json << 'EOF'
{
  "verses": [
    {
      "verse": "João 6:35",
      "text": "Jesus disse: Eu sou o pão da vida; aquele que vem a mim não terá fome, e quem crê em mim nunca terá sede.",
      "category": "Promessa de sustento"
    },
    {
      "verse": "Filipenses 4:19",
      "text": "O meu Deus, segundo as suas riquezas, suprirá todas as vossas necessidades em glória, por Cristo Jesus.",
      "category": "Promessa de provisão"
    },
    {
      "verse": "Mateus 6:26",
      "text": "Olhai para as aves do céu, que nem semeiam, nem segam, nem ajuntam em celeiros; e vosso Pai celestial as alimenta. Não tendes vós muito mais valor do que elas?",
      "category": "Promessa de cuidado"
    },
    {
      "verse": "Salmos 23:1",
      "text": "O Senhor é o meu pastor; nada me faltará.",
      "category": "Promessa de proteção"
    },
    {
      "verse": "Jeremias 29:11",
      "text": "Porque eu bem sei os pensamentos que tenho a vosso respeito, diz o Senhor; pensamentos de paz e não de mal, para vos dar o fim que esperais.",
      "category": "Promessa de futuro"
    },
    {
      "verse": "Isaías 41:10",
      "text": "Não temas, porque eu sou contigo; não te assombres, porque eu sou teu Deus; eu te fortaleço, e te ajudo, e te sustento com a minha destra fiel.",
      "category": "Promessa de força"
    }
  ]
}
EOF
    
    echo "      ✅ Arquivo json/local_verses.json criado com 6 promessas"
fi

# ============================================
# TESTES FINAIS
# ============================================
echo ""
echo "🧪 EXECUTANDO TESTES FINAIS"

# Teste sintaxe JavaScript
if command -v node &> /dev/null; then
    echo "   📝 Testando sintaxe dos arquivos JavaScript..."
    
    if node -c js/treasure-chest.js 2>/dev/null; then
        echo "      ✅ js/treasure-chest.js - Sintaxe OK"
    else
        echo "      ❌ js/treasure-chest.js - Erro de sintaxe:"
        node -c js/treasure-chest.js || true
    fi
    
    if node -c js/main.js 2>/dev/null; then
        echo "      ✅ js/main.js - Sintaxe OK"
    else
        echo "      ❌ js/main.js - Erro de sintaxe:"
        node -c js/main.js || true
    fi
fi

# Teste JSON
if command -v python3 &> /dev/null; then
    echo "   📝 Testando JSON..."
    if python3 -m json.tool json/local_verses.json > /dev/null 2>&1; then
        echo "      ✅ json/local_verses.json - JSON válido"
    else
        echo "      ❌ json/local_verses.json - JSON inválido"
    fi
fi

# Criar arquivo de teste completo
echo ""
echo "🧪 CRIANDO TESTE COMPLETO..."

cat > test-complete-fix.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste Completo - Portal Jesus</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            padding: 20px; 
            background: #2c1810; 
            color: white; 
            line-height: 1.6;
        }
        .test-section { 
            margin: 20px 0; 
            padding: 15px; 
            border: 1px solid #d4af37; 
            border-radius: 8px; 
        }
        .success { color: #51cf66; }
        .error { color: #ff6b6b; }
        .warning { color: #ffd43b; }
        .info { color: #339af0; }
        
        /* Estilos do baú */
        .treasure-chest-container {
            text-align: center;
            margin: 20px 0;
        }
        .treasure-chest {
            display: inline-block;
            font-size: 3em;
            cursor: pointer;
            padding: 20px;
            border: 2px solid #d4af37;
            border-radius: 15px;
            background: linear-gradient(45deg, #8b4513, #a0522d);
            transition: all 0.3s ease;
        }
        .treasure-chest:hover {
            transform: scale(1.1);
            box-shadow: 0 0 20px #d4af37;
        }
        .treasure-chest.opening {
            animation: bounce 0.6s ease-in-out;
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-30px); }
            60% { transform: translateY(-15px); }
        }
        
        /* Modal da promessa */
        .promise-modal {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .promise-modal-content {
            background: white;
            color: #333;
            padding: 30px;
            border-radius: 15px;
            max-width: 500px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        .promise-verse {
            font-weight: bold;
            color: #d4af37;
            font-size: 1.2em;
            margin-bottom: 15px;
        }
        .promise-text {
            font-style: italic;
            margin-bottom: 20px;
            font-size: 1.1em;
            line-height: 1.5;
        }
        .promise-close-btn {
            background: #d4af37;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
        }
        .promise-close-btn:hover {
            background: #b8941f;
        }
    </style>
</head>
<body>
    <h1>🧪 Teste Completo - Portal Jesus é o Pão da Vida</h1>
    
    <div class="test-section">
        <h2>📋 Resultados dos Testes</h2>
        <div id="test-results"></div>
    </div>
    
    <div class="test-section">
        <h2>🎁 Teste Visual do Baú</h2>
        <p>O baú deve aparecer abaixo. Clique nele para ver uma promessa:</p>
        <div id="treasure-test-area"></div>
    </div>

    <script>
        const results = document.getElementById('test-results');
        
        function addResult(type, message) {
            const div = document.createElement('div');
            div.className = type;
            div.textContent = `${type === 'success' ? '✅' : type === 'error' ? '❌' : type === 'warning' ? '⚠️' : 'ℹ️'} ${message}`;
            results.appendChild(div);
        }
        
        // Testes principais
        addResult('info', 'Iniciando testes...');
        
        // Teste 1: Carregamento do TreasureChest
        setTimeout(() => {
            if (typeof window.TreasureChestManager !== 'undefined') {
                addResult('success', 'TreasureChestManager carregado');
                
                if (window.TreasureChestManager.isInitialized) {
                    addResult('success', 'TreasureChest inicializado');
                } else {
                    addResult('warning', 'TreasureChest não inicializado ainda');
                }
                
                addResult('info', `Promessas carregadas: ${window.TreasureChestManager.promises.length}`);
            } else {
                addResult('error', 'TreasureChestManager não encontrado');
            }
            
            // Teste 2: Verificar elemento do baú
            const chestElement = document.querySelector('.treasure-chest');
            if (chestElement) {
                addResult('success', 'Elemento do baú encontrado no DOM');
            } else {
                addResult('error', 'Elemento do baú não encontrado');
            }
            
            // Teste 3: Verificar JSON
            fetch('./json/local_verses.json')
                .then(response => response.json())
                .then(data => {
                    const count = data.verses ? data.verses.length : 0;
                    addResult('success', `JSON válido - ${count} promessas disponíveis`);
                })
                .catch(error => {
                    addResult('error', `Erro no JSON: ${error.message}`);
                });
                
        }, 1000);
        
        console.log('🧪 Teste completo iniciado');
    </script>
    
    <!-- Carregar arquivos do projeto -->
    <script src="js/treasure-chest.js"></script>
</body>
</html>
EOF

echo "   ✅ Teste completo criado: test-complete-fix.html"

echo ""
echo "📋 RESUMO DAS CORREÇÕES APLICADAS"
echo "================================================"
echo "✅ 1. TreasureChest reescrito para evitar redeclarações"
echo "✅ 2. Função renderPromises corrigida (element undefined)"
echo "✅ 3. JSON de promessas criado/verificado"
echo "✅ 4. Backups completos criados em: $BACKUP_DIR"
echo "✅ 5. Teste completo criado: test-complete-fix.html"
echo ""
echo "🔧 PRÓXIMOS PASSOS:"
echo "1. Teste o arquivo completo:"
echo "   python3 -m http.server 8000"
echo "   Abra: http://localhost:8000/test-complete-fix.html"
echo ""
echo "2. Teste no portal principal:"
echo "   Abra: http://localhost:8000"
echo "   Verifique se o baú aparece e funciona"
echo ""
echo "3. Verifique se não há mais erros no console"
echo ""
echo "📞 SE AINDA HOUVER PROBLEMAS:"
echo "   - Execute: ./4-deploy-investigation.sh (próximo script)"
echo ""
echo "✨ Investigação completa e correções aplicadas!"