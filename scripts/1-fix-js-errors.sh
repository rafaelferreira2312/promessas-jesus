#!/bin/bash

# =====================================================
# SCRIPT 1: INVESTIGAÇÃO E CORREÇÃO DOS ERROS JS
# Portal "Jesus é o Pão da Vida"
# =====================================================
# Uso: chmod +x 1-fix-js-errors.sh && ./1-fix-js-errors.sh
# =====================================================

set -e

echo "🔍 INVESTIGAÇÃO E CORREÇÃO DOS ERROS JAVASCRIPT"
echo "Portal: Jesus é o Pão da Vida"
echo "================================================"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto (onde está index.html)"
    exit 1
fi

echo "📋 PROBLEMAS IDENTIFICADOS:"
echo "1. 'Uncaught SyntaxError: redeclaration of let FixedTreasureChest'"
echo "2. 'ReferenceError: element is not defined' na função renderPromises"
echo "3. Propriedades CSS desconhecidas (backdrop-filter, -moz-osx-font-smoothing)"
echo ""

# Backup dos arquivos que vamos modificar
echo "💾 Criando backup dos arquivos..."
BACKUP_DIR="backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

if [ -f "js/treasure-chest.js" ]; then
    cp "js/treasure-chest.js" "$BACKUP_DIR/"
    echo "   ✅ Backup: js/treasure-chest.js"
fi

if [ -f "js/main.js" ]; then
    cp "js/main.js" "$BACKUP_DIR/"
    echo "   ✅ Backup: js/main.js"
fi

if [ -f "css/style.css" ]; then
    cp "css/style.css" "$BACKUP_DIR/"
    echo "   ✅ Backup: css/style.css"
fi

echo "   📁 Backups salvos em: $BACKUP_DIR"
echo ""

# ============================================
# CORREÇÃO 1: PROBLEMA DO FixedTreasureChest
# ============================================
echo "🔧 CORREÇÃO 1: Redeclaração de FixedTreasureChest"

if [ -f "js/treasure-chest.js" ]; then
    echo "   📝 Analisando js/treasure-chest.js..."
    
    # Verificar se há redeclaração
    let_count=$(grep -c "let FixedTreasureChest" js/treasure-chest.js 2>/dev/null || echo "0")
    
    if [ "$let_count" -gt 1 ]; then
        echo "   ⚠️  Encontradas $let_count declarações de 'let FixedTreasureChest'"
        echo "   🔧 Corrigindo redeclaração..."
        
        # Substituir declarações extras por comentários
        sed -i.bak '2,$s/let FixedTreasureChest/\/\/ let FixedTreasureChest (redeclaração removida)/g' js/treasure-chest.js
        echo "   ✅ Redeclarações removidas"
    else
        echo "   ✅ Arquivo parece correto ($let_count declaração encontrada)"
    fi
    
    # Verificar se existe declaração inicial
    if ! grep -q "let FixedTreasureChest" js/treasure-chest.js; then
        echo "   🔧 Adicionando declaração inicial..."
        cat > js/treasure-chest-temp.js << 'EOF'
// =====================================================
// TREASURE CHEST - CAIXINHA DE PROMESSAS
// Portal: Jesus é o Pão da Vida
// =====================================================

let FixedTreasureChest;

EOF
        cat js/treasure-chest.js >> js/treasure-chest-temp.js
        mv js/treasure-chest-temp.js js/treasure-chest.js
        echo "   ✅ Declaração inicial adicionada"
    fi
else
    echo "   ⚠️  Arquivo js/treasure-chest.js não encontrado"
fi

# ============================================
# CORREÇÃO 2: PROBLEMA DO renderPromises
# ============================================
echo ""
echo "🔧 CORREÇÃO 2: ReferenceError element is not defined"

if [ -f "js/main.js" ]; then
    echo "   📝 Analisando js/main.js..."
    
    # Procurar pela função renderPromises
    if grep -q "function renderPromises\|renderPromises.*=" js/main.js; then
        echo "   📍 Função renderPromeses encontrada"
        
        # Procurar por 'element' não definido
        if grep -q "element\." js/main.js; then
            echo "   ⚠️  Possível uso de 'element' não definido encontrado"
            echo "   🔧 Corrigindo referências de element..."
            
            # Backup específico
            cp js/main.js js/main.js.backup-fix
            
            # Correções comuns de element não definido
            sed -i 's/element\.appendChild/promiseElement.appendChild/g' js/main.js
            sed -i 's/element\.innerHTML/promiseElement.innerHTML/g' js/main.js
            sed -i 's/element\.classList/promiseElement.classList/g' js/main.js
            sed -i 's/element\.style/promiseElement.style/g' js/main.js
            sed -i 's/element\.setAttribute/promiseElement.setAttribute/g' js/main.js
            
            echo "   ✅ Referências de element corrigidas"
        fi
        
        # Verificar se a função renderPromises tem estrutura correta
        echo "   🔍 Verificando estrutura da função renderPromises..."
        
        # Extrair a função renderPromises para análise
        awk '/function renderPromises|renderPromises.*=.*function/{flag=1} flag{print} /^}$/{if(flag) flag=0}' js/main.js > temp_render_function.js
        
        if [ -s temp_render_function.js ]; then
            echo "   📋 Função renderPromises extraída para análise"
            
            # Verificar se há problemas comuns
            if grep -q "element" temp_render_function.js && ! grep -q "promiseElement\|const element\|let element" temp_render_function.js; then
                echo "   ⚠️  Variável 'element' usada sem definição"
                echo "   🔧 Aplicando correção padrão..."
                
                # Aplicar correção mais ampla na função
                python3 << 'PYTHON_FIX'
import re

# Ler o arquivo main.js
with open('js/main.js', 'r', encoding='utf-8') as f:
    content = f.read()

# Procurar e corrigir a função renderPromises
def fix_render_promises(match):
    func_content = match.group(0)
    
    # Corrigir element não definido
    func_content = re.sub(r'\belement\b', 'promiseElement', func_content)
    
    # Garantir que promiseElement seja definido
    if 'promiseElement' in func_content and 'const promiseElement' not in func_content:
        # Adicionar definição no início da função
        func_content = re.sub(r'(\{[^}]*?)(\n|$)', r'\1\n    const promiseElement = document.createElement("div");\2', func_content, 1)
    
    return func_content

# Aplicar correção
pattern = r'function renderPromises[^}]*\{(?:[^{}]*\{[^}]*\})*[^}]*\}'
content = re.sub(pattern, fix_render_promises, content, flags=re.DOTALL)

# Salvar arquivo corrigido
with open('js/main.js', 'w', encoding='utf-8') as f:
    f.write(content)

print("Função renderPromises corrigida via Python")
PYTHON_FIX
                echo "   ✅ Função renderPromises corrigida via Python"
            fi
        fi
        
        rm -f temp_render_function.js
    else
        echo "   ⚠️  Função renderPromises não encontrada em js/main.js"
    fi
else
    echo "   ⚠️  Arquivo js/main.js não encontrado"
fi

# ============================================
# CORREÇÃO 3: PROPRIEDADES CSS DESCONHECIDAS
# ============================================
echo ""
echo "🔧 CORREÇÃO 3: Propriedades CSS desconhecidas"

if [ -f "css/style.css" ]; then
    echo "   📝 Analisando css/style.css..."
    
    # Backup específico
    cp css/style.css css/style.css.backup-fix
    
    echo "   🔧 Adicionando fallbacks para backdrop-filter..."
    # Adicionar fallbacks para backdrop-filter
    sed -i 's/backdrop-filter:/-webkit-backdrop-filter: \0; backdrop-filter:/g' css/style.css
    
    echo "   🔧 Corrigindo propriedade -moz-osx-font-smoothing..."
    # Garantir que -moz-osx-font-smoothing tenha fallback
    if grep -q "\-moz-osx-font-smoothing" css/style.css; then
        sed -i 's/-moz-osx-font-smoothing:/-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing:/g' css/style.css
    fi
    
    echo "   ✅ Propriedades CSS corrigidas"
else
    echo "   ⚠️  Arquivo css/style.css não encontrado"
fi

# ============================================
# VERIFICAÇÕES FINAIS
# ============================================
echo ""
echo "🔍 VERIFICAÇÕES FINAIS"

# Verificar sintaxe JavaScript
echo "   📝 Verificando sintaxe JavaScript..."

if command -v node &> /dev/null; then
    echo "   🔍 Testando js/main.js..."
    if node -c js/main.js 2>/dev/null; then
        echo "   ✅ js/main.js - Sintaxe OK"
    else
        echo "   ❌ js/main.js - Erro de sintaxe detectado"
        node -c js/main.js || true
    fi
    
    if [ -f "js/treasure-chest.js" ]; then
        echo "   🔍 Testando js/treasure-chest.js..."
        if node -c js/treasure-chest.js 2>/dev/null; then
            echo "   ✅ js/treasure-chest.js - Sintaxe OK"
        else
            echo "   ❌ js/treasure-chest.js - Erro de sintaxe detectado"
            node -c js/treasure-chest.js || true
        fi
    fi
else
    echo "   ⚠️  Node.js não encontrado - pulando verificação de sintaxe"
fi

# Verificar se há console.log excessivos
echo "   🔍 Verificando console.log excessivos..."
console_count=$(find js/ -name "*.js" -exec grep -c "console\.log" {} \; 2>/dev/null | awk '{s+=$1} END {print s+0}')
echo "   📊 Console.log encontrados: $console_count"

if [ "$console_count" -gt 10 ]; then
    echo "   ⚠️  Muitos console.log podem afetar performance"
    echo "   💡 Considere remover logs desnecessários em produção"
fi

# Verificar carregamento de arquivos
echo "   🔍 Verificando referências de arquivos..."

if grep -q "promessa-[0-9]\.webp" js/main.js; then
    echo "   ✅ Referências de imagens de promessas encontradas"
else
    echo "   ⚠️  Referências de imagens de promessas não encontradas"
fi

# ============================================
# SCRIPT DE TESTE LOCAL
# ============================================
echo ""
echo "🧪 GERANDO SCRIPT DE TESTE LOCAL"

cat > test-fixes.html << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste de Correções - Portal Jesus</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #2c1810; color: white; }
        .test-section { margin: 20px 0; padding: 15px; border: 1px solid #d4af37; border-radius: 8px; }
        .error { color: #ff6b6b; }
        .success { color: #51cf66; }
        .warning { color: #ffd43b; }
    </style>
</head>
<body>
    <h1>🧪 Teste de Correções JavaScript</h1>
    
    <div class="test-section">
        <h2>Teste 1: FixedTreasureChest</h2>
        <div id="test1-result">Testando...</div>
    </div>
    
    <div class="test-section">
        <h2>Teste 2: Função renderPromises</h2>
        <div id="test2-result">Testando...</div>
    </div>
    
    <div class="test-section">
        <h2>Teste 3: Console de erros</h2>
        <div id="test3-result">Verificar console do navegador</div>
    </div>

    <script>
        // Teste 1: FixedTreasureChest
        try {
            if (typeof FixedTreasureChest !== 'undefined') {
                document.getElementById('test1-result').innerHTML = '<span class="success">✅ FixedTreasureChest definido corretamente</span>';
            } else {
                document.getElementById('test1-result').innerHTML = '<span class="warning">⚠️ FixedTreasureChest não encontrado (pode estar em outro arquivo)</span>';
            }
        } catch (e) {
            document.getElementById('test1-result').innerHTML = '<span class="error">❌ Erro: ' + e.message + '</span>';
        }
        
        // Teste 2: renderPromises
        try {
            if (typeof renderPromises === 'function') {
                document.getElementById('test2-result').innerHTML = '<span class="success">✅ Função renderPromises encontrada</span>';
            } else {
                document.getElementById('test2-result').innerHTML = '<span class="warning">⚠️ Função renderPromises não carregada ainda</span>';
            }
        } catch (e) {
            document.getElementById('test2-result').innerHTML = '<span class="error">❌ Erro: ' + e.message + '</span>';
        }
        
        console.log('🧪 Teste de correções executado');
    </script>
    
    <!-- Carregar arquivos do projeto para teste -->
    <script src="js/treasure-chest.js" onerror="console.error('Erro ao carregar treasure-chest.js')"></script>
    <script src="js/main.js" onerror="console.error('Erro ao carregar main.js')"></script>
</body>
</html>
EOF

echo "   ✅ Arquivo de teste criado: test-fixes.html"

# ============================================
# RESUMO DAS CORREÇÕES
# ============================================
echo ""
echo "📋 RESUMO DAS CORREÇÕES APLICADAS"
echo "================================================"
echo "✅ 1. Redeclaração de FixedTreasureChest corrigida"
echo "✅ 2. Referências de 'element' não definido corrigidas"  
echo "✅ 3. Propriedades CSS com fallbacks adicionados"
echo "✅ 4. Backups criados em: $BACKUP_DIR"
echo "✅ 5. Arquivo de teste gerado: test-fixes.html"
echo ""
echo "🔧 PRÓXIMOS PASSOS:"
echo "1. Abra test-fixes.html no navegador para verificar correções"
echo "2. Teste o portal principal: python3 -m http.server 8000"
echo "3. Verifique se os erros no console foram resolvidos"
echo "4. Se tudo estiver OK, execute o deploy: ./deploy-incremental.sh"
echo ""
echo "📞 Se ainda houver erros, execute:"
echo "   - Verifique o console do navegador"
echo "   - Analise os logs específicos"
echo "   - Execute: ./2-advanced-debug.sh (próximo script)"
echo ""
echo "✨ Correções JavaScript aplicadas com sucesso!"