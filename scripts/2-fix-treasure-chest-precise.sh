#!/bin/bash

# =====================================================
# SCRIPT 2: CORREÇÃO PRECISA DO TREASURECHEST
# Portal "Jesus é o Pão da Vida" - Problema de redeclaração
# =====================================================
# Uso: chmod +x 2-fix-treasure-chest-precise.sh && ./2-fix-treasure-chest-precise.sh
# =====================================================

set -e

echo "🔧 CORREÇÃO PRECISA DO TREASURECHEST"
echo "Portal: Jesus é o Pão da Vida"
echo "====================================="
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto (onde está index.html)"
    exit 1
fi

# Verificar se o arquivo treasure-chest.js existe
if [ ! -f "js/treasure-chest.js" ]; then
    echo "❌ Erro: js/treasure-chest.js não encontrado"
    exit 1
fi

echo "📋 PROBLEMA IDENTIFICADO:"
echo "SyntaxError: Identifier 'FixedTreasureChest' has already been declared"
echo ""

# Backup específico
echo "💾 Criando backup específico..."
BACKUP_DIR="backup-treasure-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp "js/treasure-chest.js" "$BACKUP_DIR/"
echo "   ✅ Backup: js/treasure-chest.js -> $BACKUP_DIR/"
echo ""

# Analisar o arquivo atual
echo "🔍 ANÁLISE DO ARQUIVO ATUAL:"
echo "   📄 Arquivo: js/treasure-chest.js"

# Contar declarações
let_count=$(grep -n "let FixedTreasureChest" js/treasure-chest.js 2>/dev/null | wc -l)
class_count=$(grep -n "class FixedTreasureChest" js/treasure-chest.js 2>/dev/null | wc -l)
const_count=$(grep -n "const FixedTreasureChest" js/treasure-chest.js 2>/dev/null | wc -l)

echo "   📊 Declarações encontradas:"
echo "      - let FixedTreasureChest: $let_count"
echo "      - class FixedTreasureChest: $class_count"
echo "      - const FixedTreasureChest: $const_count"

# Mostrar linhas problemáticas
echo ""
echo "   📍 Linhas com declarações:"
grep -n "FixedTreasureChest" js/treasure-chest.js | head -10

echo ""
echo "🔧 APLICANDO CORREÇÃO..."

# Verificar se há declaração múltipla e corrigir
if [ $let_count -gt 0 ] && [ $class_count -gt 0 ]; then
    echo "   ⚠️  Conflito: Declaração 'let' + 'class' detectado"
    echo "   🔧 Removendo declaração 'let' duplicada..."
    
    # Remover linhas que começam com 'let FixedTreasureChest'
    sed -i '/^let FixedTreasureChest/d' js/treasure-chest.js
    echo "   ✅ Declaração 'let' removida"
    
elif [ $let_count -gt 1 ]; then
    echo "   ⚠️  Múltiplas declarações 'let' detectadas"
    echo "   🔧 Mantendo apenas a primeira..."
    
    # Manter apenas a primeira declaração let
    awk '!(/^let FixedTreasureChest/ && ++count > 1)' js/treasure-chest.js > js/treasure-chest-temp.js
    mv js/treasure-chest-temp.js js/treasure-chest.js
    echo "   ✅ Declarações extras removidas"
    
elif [ $class_count -gt 1 ]; then
    echo "   ⚠️  Múltiplas declarações 'class' detectadas"
    echo "   🔧 Mantendo apenas a primeira..."
    
    # Manter apenas a primeira declaração class
    awk '!(/^class FixedTreasureChest/ && ++count > 1)' js/treasure-chest.js > js/treasure-chest-temp.js
    mv js/treasure-chest-temp.js js/treasure-chest.js
    echo "   ✅ Declarações extras removidas"
else
    echo "   ℹ️  Declarações parecem normais, verificando estrutura..."
fi

# Verificar se há problema de estrutura no arquivo
echo ""
echo "🔍 VERIFICAÇÃO DE ESTRUTURA:"

# Verificar se há conteúdo duplicado
duplicate_lines=$(sort js/treasure-chest.js | uniq -d | wc -l)
if [ $duplicate_lines -gt 0 ]; then
    echo "   ⚠️  $duplicate_lines linhas duplicadas encontradas"
    echo "   🔧 Removendo duplicatas..."
    
    awk '!seen[$0]++' js/treasure-chest.js > js/treasure-chest-temp.js
    mv js/treasure-chest-temp.js js/treasure-chest.js
    echo "   ✅ Duplicatas removidas"
fi

# Criar versão limpa se necessário
echo ""
echo "🧹 CRIANDO VERSÃO LIMPA:"

cat > js/treasure-chest-clean.js << 'EOF'
// =====================================================
// TREASURE CHEST - CAIXINHA DE PROMESSAS (LIMPO)
// Portal: Jesus é o Pão da Vida
// =====================================================

class FixedTreasureChest {
    constructor() {
        this.isOpen = false;
        this.currentPromise = null;
        this.promises = [];
        this.init();
    }

    init() {
        this.createChestElement();
        this.loadPromises();
        this.bindEvents();
    }

    createChestElement() {
        // Verificar se já existe
        if (document.querySelector('.treasure-chest')) {
            return;
        }

        const chestContainer = document.createElement('div');
        chestContainer.className = 'treasure-chest-container';
        
        const chest = document.createElement('div');
        chest.className = 'treasure-chest';
        chest.innerHTML = `
            <div class="chest-lid"></div>
            <div class="chest-body"></div>
            <div class="chest-click-area" title="Clique para descobrir uma promessa divina"></div>
        `;
        
        chestContainer.appendChild(chest);
        
        // Inserir no DOM
        const promiseSection = document.querySelector('.promise-section') || 
                              document.querySelector('#promessas') ||
                              document.body;
        
        if (promiseSection) {
            promiseSection.appendChild(chestContainer);
        }
    }

    async loadPromises() {
        try {
            const response = await fetch('/json/local_verses.json');
            if (!response.ok) {
                throw new Error('Erro ao carregar promessas');
            }
            
            const data = await response.json();
            this.promises = data.verses || data.promessas || [];
            
            console.log('✅ Promessas carregadas:', this.promises.length);
        } catch (error) {
            console.error('❌ Erro ao carregar promessas:', error);
            // Fallback com promessas padrão
            this.promises = [
                {
                    verse: "João 6:35",
                    text: "Jesus disse: Eu sou o pão da vida; aquele que vem a mim não terá fome."
                },
                {
                    verse: "Filipenses 4:19",
                    text: "Meu Deus suprirá todas as suas necessidades, segundo a sua riqueza em glória em Cristo Jesus."
                }
            ];
        }
    }

    bindEvents() {
        const clickArea = document.querySelector('.chest-click-area');
        if (clickArea) {
            clickArea.addEventListener('click', () => this.openChest());
        }
    }

    openChest() {
        if (this.isOpen || this.promises.length === 0) {
            return;
        }

        this.isOpen = true;
        
        // Animação de abertura
        const chest = document.querySelector('.treasure-chest');
        if (chest) {
            chest.classList.add('opening');
        }

        // Selecionar promessa aleatória
        const randomIndex = Math.floor(Math.random() * this.promises.length);
        this.currentPromise = this.promises[randomIndex];

        // Mostrar promessa após animação
        setTimeout(() => {
            this.showPromise();
        }, 800);
    }

    showPromise() {
        if (!this.currentPromise) return;

        // Criar modal ou área de exibição
        const promiseDisplay = document.createElement('div');
        promiseDisplay.className = 'promise-display';
        promiseDisplay.innerHTML = `
            <div class="promise-content">
                <h3>🙏 Promessa de Deus</h3>
                <p class="promise-verse">${this.currentPromise.verse}</p>
                <p class="promise-text">"${this.currentPromise.text}"</p>
                <button class="close-promise">Amém 🙏</button>
            </div>
        `;

        document.body.appendChild(promiseDisplay);

        // Fechar promessa
        const closeBtn = promiseDisplay.querySelector('.close-promise');
        if (closeBtn) {
            closeBtn.addEventListener('click', () => {
                this.closePromise(promiseDisplay);
            });
        }

        // Fechar ao clicar fora
        promiseDisplay.addEventListener('click', (e) => {
            if (e.target === promiseDisplay) {
                this.closePromise(promiseDisplay);
            }
        });
    }

    closePromise(promiseDisplay) {
        if (promiseDisplay) {
            promiseDisplay.remove();
        }

        // Reset do baú
        const chest = document.querySelector('.treasure-chest');
        if (chest) {
            chest.classList.remove('opening');
        }

        this.isOpen = false;
        this.currentPromise = null;
    }
}

// Inicializar quando o DOM estiver pronto
document.addEventListener('DOMContentLoaded', () => {
    console.log('🎁 Inicializando Treasure Chest...');
    window.treasureChest = new FixedTreasureChest();
});

// Fallback para carregamento tardio
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        if (!window.treasureChest) {
            window.treasureChest = new FixedTreasureChest();
        }
    });
} else {
    if (!window.treasureChest) {
        window.treasureChest = new FixedTreasureChest();
    }
}
EOF

echo "   ✅ Versão limpa criada: js/treasure-chest-clean.js"

# Substituir arquivo original pela versão limpa
echo ""
echo "🔄 SUBSTITUINDO ARQUIVO ORIGINAL:"
cp js/treasure-chest.js js/treasure-chest-original-backup.js
cp js/treasure-chest-clean.js js/treasure-chest.js

echo "   ✅ Arquivo original substituído"
echo "   💾 Backup adicional: js/treasure-chest-original-backup.js"

# Verificar sintaxe do novo arquivo
echo ""
echo "🔍 VERIFICAÇÃO FINAL:"

if command -v node &> /dev/null; then
    echo "   📝 Testando sintaxe JavaScript..."
    if node -c js/treasure-chest.js 2>/dev/null; then
        echo "   ✅ js/treasure-chest.js - Sintaxe OK"
    else
        echo "   ❌ js/treasure-chest.js - Ainda há erro de sintaxe:"
        node -c js/treasure-chest.js || true
    fi
else
    echo "   ⚠️  Node.js não encontrado - pulando verificação de sintaxe"
fi

# Verificar se não há mais declarações conflitantes
new_let_count=$(grep -c "let FixedTreasureChest" js/treasure-chest.js 2>/dev/null || echo "0")
new_class_count=$(grep -c "class FixedTreasureChest" js/treasure-chest.js 2>/dev/null || echo "0")

echo "   📊 Declarações no arquivo novo:"
echo "      - let FixedTreasureChest: $new_let_count"
echo "      - class FixedTreasureChest: $new_class_count"

if [ "$new_let_count" -eq 0 ] && [ "$new_class_count" -eq 1 ]; then
    echo "   ✅ Estrutura correta: apenas 1 class, sem lets"
elif [ "$new_let_count" -eq 1 ] && [ "$new_class_count" -eq 0 ]; then
    echo "   ✅ Estrutura correta: apenas 1 let, sem classes"
else
    echo "   ⚠️  Estrutura pode ainda ter problemas"
fi

# Criar arquivo de teste específico
echo ""
echo "🧪 CRIANDO TESTE ESPECÍFICO:"

cat > test-treasure-chest.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste TreasureChest - Portal Jesus</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            padding: 20px; 
            background: #2c1810; 
            color: white; 
        }
        .test-result { 
            margin: 10px 0; 
            padding: 10px; 
            border-radius: 5px; 
        }
        .success { background: #1a4d3a; color: #51cf66; }
        .error { background: #4d1a1a; color: #ff6b6b; }
        .warning { background: #4d3a1a; color: #ffd43b; }
        .treasure-chest-container {
            margin: 20px 0;
            text-align: center;
        }
        .treasure-chest {
            width: 80px;
            height: 60px;
            background: #8b4513;
            margin: 0 auto;
            border-radius: 10px;
            position: relative;
            cursor: pointer;
            border: 2px solid #d4af37;
        }
        .chest-click-area {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            cursor: pointer;
        }
        .promise-display {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .promise-content {
            background: white;
            color: black;
            padding: 30px;
            border-radius: 10px;
            max-width: 500px;
            text-align: center;
        }
        .close-promise {
            background: #d4af37;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <h1>🧪 Teste Específico: TreasureChest</h1>
    
    <div id="test-results"></div>
    
    <div class="treasure-chest-container">
        <h3>Teste Visual:</h3>
        <p>O baú deve aparecer abaixo e ser clicável:</p>
        <!-- O baú será inserido aqui pelo JavaScript -->
    </div>

    <script>
        const results = document.getElementById('test-results');
        
        function addResult(type, message) {
            const div = document.createElement('div');
            div.className = `test-result ${type}`;
            div.textContent = message;
            results.appendChild(div);
        }
        
        // Teste 1: Carregamento do script
        try {
            addResult('success', '✅ Teste iniciado - verificando carregamento...');
        } catch (e) {
            addResult('error', '❌ Erro no teste inicial: ' + e.message);
        }
        
        // Aguardar carregamento do script
        setTimeout(() => {
            // Teste 2: Verificar se FixedTreasureChest existe
            try {
                if (typeof FixedTreasureChest !== 'undefined') {
                    addResult('success', '✅ Classe FixedTreasureChest carregada');
                    
                    // Teste 3: Verificar se pode instanciar
                    try {
                        const testChest = new FixedTreasureChest();
                        addResult('success', '✅ Instância criada com sucesso');
                        
                        // Teste 4: Verificar se window.treasureChest existe
                        if (window.treasureChest) {
                            addResult('success', '✅ window.treasureChest disponível');
                        } else {
                            addResult('warning', '⚠️ window.treasureChest não encontrado');
                        }
                        
                    } catch (e) {
                        addResult('error', '❌ Erro ao instanciar: ' + e.message);
                    }
                } else {
                    addResult('error', '❌ FixedTreasureChest não encontrado');
                }
            } catch (e) {
                addResult('error', '❌ Erro na verificação: ' + e.message);
            }
            
            // Teste 5: Verificar elementos DOM
            setTimeout(() => {
                const chestElement = document.querySelector('.treasure-chest');
                if (chestElement) {
                    addResult('success', '✅ Elemento do baú encontrado no DOM');
                } else {
                    addResult('warning', '⚠️ Elemento do baú não encontrado');
                }
            }, 1000);
            
        }, 500);
        
        console.log('🧪 Teste TreasureChest iniciado');
    </script>
    
    <!-- Carregar o arquivo corrigido -->
    <script src="js/treasure-chest.js"></script>
</body>
</html>
EOF

echo "   ✅ Teste específico criado: test-treasure-chest.html"

# Limpar arquivos temporários
rm -f js/treasure-chest-clean.js 2>/dev/null || true

echo ""
echo "📋 RESUMO DA CORREÇÃO:"
echo "================================================"
echo "✅ 1. Backup criado em: $BACKUP_DIR"
echo "✅ 2. Arquivo original substituído por versão limpa"
echo "✅ 3. Declarações conflitantes removidas"
echo "✅ 4. Estrutura de classe limpa implementada"
echo "✅ 5. Teste específico criado: test-treasure-chest.html"
echo ""
echo "🔧 PRÓXIMOS PASSOS:"
echo "1. Teste o arquivo corrigido:"
echo "   python3 -m http.server 8000"
echo "   Abra: http://localhost:8000/test-treasure-chest.html"
echo ""
echo "2. Teste no portal principal:"
echo "   Abra: http://localhost:8000"
echo "   Verifique se o baú aparece e funciona"
echo ""
echo "3. Verifique o console do navegador - não deve ter mais erros"
echo ""
echo "📞 SE AINDA HOUVER PROBLEMAS:"
echo "   - Verifique o console do navegador"
echo "   - Execute: ./3-debug-promises.sh (próximo script)"
echo ""
echo "✨ TreasureChest corrigido com versão limpa!"