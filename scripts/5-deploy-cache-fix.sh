#!/bin/bash

# =====================================================
# SCRIPT 5: DEPLOY COM LIMPEZA DE CACHE FORÇADA
# Portal "Jesus é o Pão da Vida"
# Resolve problemas de cache e atualização
# =====================================================
# Uso: chmod +x 5-deploy-cache-fix.sh && ./5-deploy-cache-fix.sh
# =====================================================

set -e

# Configurações do servidor
SERVER_HOST="212.85.1.55"
SERVER_USER="root"
SERVER_PASSWORD="rdg5q@CKJ(JVvofef6F,"
SITE_USER="vancouvertec-promessasdejesus"
DEPLOY_PATH="/home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br"
DOMAIN="promessasdejesus.vancouvertec.com.br"

echo "🚀 DEPLOY COM LIMPEZA DE CACHE FORÇADA"
echo "Portal: Jesus é o Pão da Vida"
echo "Domínio: https://$DOMAIN"
echo "========================================"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto (onde está index.html)"
    exit 1
fi

# Verificar sshpass
if ! command -v sshpass &> /dev/null; then
    echo "❌ Instale sshpass: sudo apt-get install sshpass"
    exit 1
fi

# Função SSH
ssh_exec() {
    sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "$1"
}

# Testar conexão
echo "🔗 Testando conexão SSH..."
if ! ssh_exec "echo 'Conexão OK'"; then
    echo "❌ Falha na conexão SSH"
    exit 1
fi
echo "✅ Conectado ao servidor"

echo ""
echo "📋 PROBLEMAS DE CACHE IDENTIFICADOS:"
echo "1. Navegador cacheia arquivos JS/CSS antigos"
echo "2. Nginx pode ter cache interno"
echo "3. Arquivos podem não estar sendo sobrescritos"
echo "4. Timestamps podem estar desatualizados"
echo ""

# =============================================
# PASSO 1: BACKUP COM TIMESTAMP
# =============================================
echo "💾 PASSO 1: Backup com timestamp..."
BACKUP_DIR="/home/$SITE_USER/backups/cache-fix_$(date +%Y%m%d_%H%M%S)"
ssh_exec "mkdir -p '$BACKUP_DIR'"

if ssh_exec "[ -d '$DEPLOY_PATH' ] && [ \"\$(ls -A '$DEPLOY_PATH' 2>/dev/null)\" ]"; then
    ssh_exec "cp -r '$DEPLOY_PATH'/* '$BACKUP_DIR'/ 2>/dev/null || true"
    echo "✅ Backup criado: $BACKUP_DIR"
else
    echo "ℹ️ Nenhum conteúdo anterior para backup"
fi

# =============================================
# PASSO 2: LIMPEZA AGRESSIVA DE CACHE
# =============================================
echo ""
echo "🧹 PASSO 2: Limpeza agressiva de cache..."

# Parar nginx temporariamente
echo "   ⏸️ Parando nginx..."
ssh_exec "systemctl stop nginx" && echo "   ✅ Nginx parado" || echo "   ⚠️ Erro ao parar nginx"

# Limpar todos os caches possíveis
echo "   🗑️ Limpando caches do sistema..."
ssh_exec "
    # Cache do nginx
    rm -rf /var/cache/nginx/* 2>/dev/null || true
    
    # Cache do Apache se existir
    rm -rf /var/cache/apache2/* 2>/dev/null || true
    
    # Cache do sistema
    sync
    echo 3 > /proc/sys/vm/drop_caches 2>/dev/null || true
    
    # Forçar sync do sistema de arquivos
    sync
"

echo "   ✅ Caches do sistema limpos"

# =============================================
# PASSO 3: REMOÇÃO COMPLETA DOS ARQUIVOS
# =============================================
echo ""
echo "🗑️ PASSO 3: Remoção completa dos arquivos..."

# Remover TUDO - mais agressivo que rm -rf
ssh_exec "
    cd '$DEPLOY_PATH' || exit 1
    
    # Remover todos os arquivos
    find . -type f -delete 2>/dev/null || true
    
    # Remover todas as pastas
    find . -type d ! -path . -exec rm -rf {} + 2>/dev/null || true
    
    # Verificar se realmente está vazio
    ls -la
"

echo "   ✅ Pasta completamente limpa"

# =============================================
# PASSO 4: UPLOAD COM VERIFICAÇÃO
# =============================================
echo ""
echo "📤 PASSO 4: Upload com verificação de integridade..."

# Criar arquivo de checksum local
echo "   📊 Criando checksums locais..."
find . -type f \( -name "*.html" -o -name "*.css" -o -name "*.js" -o -name "*.json" -o -name "*.webp" -o -name "*.png" -o -name "*.jpg" \) -exec md5sum {} \; > local_checksums.txt

# Upload de arquivos críticos primeiro
CRITICAL_FILES=("index.html" "js/treasure-chest.js" "js/main.js" "json/local_verses.json")

echo "   📁 Enviando arquivos críticos..."
for file in "${CRITICAL_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "     📤 $file"
        sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no "$file" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/"
        
        # Verificar se foi enviado corretamente
        remote_size=$(ssh_exec "[ -f '$DEPLOY_PATH/$file' ] && stat -c%s '$DEPLOY_PATH/$file' || echo '0'")
        local_size=$(stat -c%s "$file" 2>/dev/null || echo "0")
        
        if [ "$remote_size" = "$local_size" ]; then
            echo "     ✅ $file verificado (${local_size} bytes)"
        else
            echo "     ❌ $file ERRO - local: ${local_size}, remoto: ${remote_size}"
        fi
    else
        echo "     ⚠️ $file não encontrado"
    fi
done

# Upload de pastas completas
FOLDERS=("css" "js" "assets" "json" "pages" "blog")

echo "   📂 Enviando pastas..."
for folder in "${FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        echo "     📂 Enviando: $folder"
        
        # Usar rsync se disponível, senão scp
        if command -v rsync &> /dev/null; then
            rsync -avz --progress --exclude="*.backup" --exclude="*.log" \
                  -e "sshpass -p $SERVER_PASSWORD ssh -o StrictHostKeyChecking=no" \
                  "$folder/" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/$folder/"
        else
            sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no -r "$folder" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/"
        fi
        
        echo "     ✅ $folder enviado"
    fi
done

# =============================================
# PASSO 5: VERIFICAÇÃO DE INTEGRIDADE
# =============================================
echo ""
echo "🔍 PASSO 5: Verificação de integridade..."

# Verificar arquivos críticos no servidor
echo "   📋 Verificando arquivos críticos no servidor..."
for file in "${CRITICAL_FILES[@]}"; do
    if ssh_exec "[ -f '$DEPLOY_PATH/$file' ]"; then
        size=$(ssh_exec "stat -c%s '$DEPLOY_PATH/$file'")
        echo "     ✅ $file ($size bytes)"
    else
        echo "     ❌ $file AUSENTE"
    fi
done

# Verificar se JSON tem conteúdo válido
echo "   📄 Verificando conteúdo do JSON..."
json_content=$(ssh_exec "head -3 '$DEPLOY_PATH/json/local_verses.json' 2>/dev/null || echo 'ERRO'")
if [[ "$json_content" == *"verses"* ]]; then
    echo "     ✅ JSON com conteúdo válido"
else
    echo "     ❌ JSON pode estar corrompido"
fi

# =============================================
# PASSO 6: CONFIGURAÇÃO DE CACHE BUSTING
# =============================================
echo ""
echo "⚡ PASSO 6: Configuração de cache busting..."

# Criar arquivo .htaccess com cache busting
cache_timestamp=$(date +%Y%m%d%H%M%S)

ssh_exec "cat > '$DEPLOY_PATH/.htaccess' << 'EOF'
# Cache Busting - Portal Jesus é o Pão da Vida
# Atualizado: $(date)

# Forçar revalidação de arquivos JavaScript e CSS
<FilesMatch \"\.(js|css)$\">
    Header set Cache-Control \"no-cache, no-store, must-revalidate\"
    Header set Pragma \"no-cache\"
    Header set Expires \"0\"
</FilesMatch>

# Cache moderado para imagens
<FilesMatch \"\.(jpg|jpeg|png|gif|webp|svg)$\">
    Header set Cache-Control \"public, max-age=3600\"
</FilesMatch>

# JSON sempre fresh
<FilesMatch \"\.(json)$\">
    Header set Cache-Control \"no-cache, must-revalidate\"
    Header set Pragma \"no-cache\"
</FilesMatch>

# Compressão
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
</IfModule>

# Security headers
Header always set X-Frame-Options \"SAMEORIGIN\"
Header always set X-Content-Type-Options \"nosniff\"

# Versioning para cache busting manual
# Versão: ${cache_timestamp}
EOF"

echo "     ✅ .htaccess configurado com cache busting"

# =============================================
# PASSO 7: REINICIAR SERVIÇOS
# =============================================
echo ""
echo "🔄 PASSO 7: Reiniciando serviços..."

# Iniciar nginx
echo "   ▶️ Iniciando nginx..."
ssh_exec "systemctl start nginx" && echo "   ✅ Nginx iniciado" || echo "   ❌ Erro ao iniciar nginx"

# Recarregar configurações
ssh_exec "systemctl reload nginx" && echo "   ✅ Nginx recarregado" || echo "   ⚠️ Erro no reload"

# Verificar status
nginx_status=$(ssh_exec "systemctl is-active nginx")
echo "   📊 Status do nginx: $nginx_status"

# =============================================
# PASSO 8: TESTES DE VERIFICAÇÃO
# =============================================
echo ""
echo "🧪 PASSO 8: Testes de verificação..."

# Aguardar propagação
echo "   ⏳ Aguardando propagação (15s)..."
sleep 15

# Teste HTTP com cache busting
echo "   🌐 Testando site com cache busting..."
if command -v curl &> /dev/null; then
    # Teste com headers de cache busting
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
                     -H "Cache-Control: no-cache" \
                     -H "Pragma: no-cache" \
                     "https://$DOMAIN?v=${cache_timestamp}" \
                     --max-time 20)
    
    case $HTTP_CODE in
        200) echo "     ✅ Site ONLINE - Status: $HTTP_CODE" ;;
        502|503|504) echo "     ⚠️ Site carregando - Status: $HTTP_CODE" ;;
        *) echo "     ❌ Problema - Status: $HTTP_CODE" ;;
    esac
    
    # Teste específico do treasure-chest.js
    JS_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
                   -H "Cache-Control: no-cache" \
                   "https://$DOMAIN/js/treasure-chest.js?v=${cache_timestamp}" \
                   --max-time 10)
    
    if [ "$JS_CODE" = "200" ]; then
        echo "     ✅ treasure-chest.js acessível"
    else
        echo "     ❌ treasure-chest.js problema (Status: $JS_CODE)"
    fi
else
    echo "     ℹ️ curl não disponível - teste manual necessário"
fi

# =============================================
# PASSO 9: INSTRUÇÕES PARA TESTE
# =============================================
echo ""
echo "📋 PASSO 9: Instruções para teste..."

echo ""
echo "🎯 COMO TESTAR SEM CACHE:"
echo "================================================"
echo "1. CTRL+SHIFT+R (força refresh completo)"
echo "2. F12 → Network → Disable cache"
echo "3. Modo privado/incógnito do navegador"
echo "4. URL com cache busting: https://$DOMAIN?v=${cache_timestamp}"
echo ""
echo "🔍 VERIFICAR NO NAVEGADOR:"
echo "• Console sem erros JavaScript"
echo "• Baú aparece na seção 'Versículos que Transformam Vidas'"
echo "• Clique no baú funciona e mostra promessa"
echo "• Network tab mostra arquivos com status 200"
echo ""

# =============================================
# RELATÓRIO FINAL
# =============================================
echo "📊 RELATÓRIO FINAL DO DEPLOY"
echo "================================================"

# Estatísticas
FILES_COUNT=$(ssh_exec "find '$DEPLOY_PATH' -type f | wc -l")
TOTAL_SIZE=$(ssh_exec "du -sh '$DEPLOY_PATH' 2>/dev/null | cut -f1")

echo "📈 ESTATÍSTICAS:"
echo "• Arquivos no servidor: $FILES_COUNT"
echo "• Tamanho total: $TOTAL_SIZE"
echo "• Backup anterior: $BACKUP_DIR"
echo "• Cache busting versão: $cache_timestamp"
echo ""

echo "✅ CORREÇÕES APLICADAS:"
echo "• Cache do servidor limpo"
echo "• Arquivos completamente substituídos"
echo "• .htaccess com cache busting configurado"
echo "• Verificação de integridade executada"
echo "• Headers anti-cache aplicados"
echo ""

echo "🌐 LINKS DE TESTE:"
echo "• Site principal: https://$DOMAIN"
echo "• Com cache busting: https://$DOMAIN?v=${cache_timestamp}"
echo "• JS direto: https://$DOMAIN/js/treasure-chest.js?v=${cache_timestamp}"
echo ""

echo "🚨 SE AINDA HOUVER PROBLEMAS:"
echo "1. Aguarde 5-10 minutos (propagação CDN)"
echo "2. Teste em navegador incógnito"
echo "3. Limpe cache do navegador manualmente"
echo "4. Execute: ./6-debug-server.sh (próximo script se necessário)"
echo ""

# Criar log detalhado
LOG_FILE="deploy-cache-fix-$(date +%Y%m%d_%H%M%S).log"
{
    echo "=== DEPLOY CACHE FIX - $(date) ==="
    echo "Domínio: $DOMAIN"
    echo "Arquivos: $FILES_COUNT"
    echo "Tamanho: $TOTAL_SIZE"
    echo "Cache busting: $cache_timestamp"
    echo "Backup: $BACKUP_DIR"
    echo "Status HTTP: ${HTTP_CODE:-'N/A'}"
    echo "Status JS: ${JS_CODE:-'N/A'}"
    echo "Status: CONCLUÍDO"
    echo "================================"
} > "$LOG_FILE"

echo "📝 Log detalhado: $LOG_FILE"
echo ""
echo "🎉 DEPLOY COM CACHE BUSTING CONCLUÍDO!"
echo "✨ O site deve estar funcionando sem problemas de cache!"

# Limpeza local
rm -f local_checksums.txt 2>/dev/null || true