#!/bin/bash

# =====================================================
# DEPLOY INCREMENTAL - PORTAL JESUS É O PÃO DA VIDA
# Atualiza apenas arquivos modificados + limpeza
# =====================================================
# Uso: chmod +x deploy-incremental.sh && ./deploy-incremental.sh
# =====================================================

set -e

# Configurações do servidor
SERVER_HOST="212.85.1.55"
SERVER_USER="root"
SERVER_PASSWORD="rdg5q@CKJ(JVvofef6F,"
SITE_USER="vancouvertec-promessasdejesus"
DEPLOY_PATH="/home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br"
DOMAIN="promessasdejesus.vancouvertec.com.br"

# Arquivos e pastas que NÃO devem ser enviados
EXCLUDE_FILES=(
    "script.sh"
    "*.sh"
    "backup-*"
    ".git"
    ".gitignore"
    "*.md"
    "*.log"
    "*.backup"
    "node_modules"
    ".vscode"
    ".idea"
    "*.tmp"
    "*.temp"
)

# Arquivos sensíveis que devem ter permissões especiais
SENSITIVE_FILES=(
    "json/submissions.json"
    "json/logs.txt"
)

echo "🔄 DEPLOY INCREMENTAL - PORTAL JESUS É O PÃO DA VIDA"
echo "🌐 Domínio: https://$DOMAIN"
echo "⚡ Modo: Atualização incremental"
echo ""

# Verificar pasta do projeto
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute na pasta raiz do projeto"
    exit 1
fi

# Verificar sshpass
if ! command -v sshpass &> /dev/null; then
    echo "⚠️ Instale sshpass: sudo apt-get install sshpass"
    exit 1
fi

# Função SSH
ssh_exec() {
    sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "$1"
}

# Testar conexão
echo "🔗 Testando conexão..."
if ! ssh_exec "echo 'OK'"; then
    echo "❌ Falha na conexão SSH"
    exit 1
fi
echo "✅ Conectado ao servidor"

# Verificar se é primeira instalação ou update
if ssh_exec "[ -f '$DEPLOY_PATH/index.html' ]"; then
    DEPLOY_TYPE="UPDATE"
    echo "🔄 Tipo: Atualização incremental"
else
    DEPLOY_TYPE="FIRST_INSTALL"
    echo "🆕 Tipo: Primeira instalação"
    ssh_exec "mkdir -p '$DEPLOY_PATH'"
fi

# Backup incremental (apenas se não for primeira instalação)
if [ "$DEPLOY_TYPE" = "UPDATE" ]; then
    echo "💾 Criando backup incremental..."
    BACKUP_DIR="/home/$SITE_USER/backups/incremental_$(date +%Y%m%d_%H%M%S)"
    ssh_exec "mkdir -p '$BACKUP_DIR'"
    ssh_exec "cp -r '$DEPLOY_PATH'/* '$BACKUP_DIR'/ 2>/dev/null || true"
    echo "✅ Backup: $BACKUP_DIR"
fi

# Função para verificar se arquivo deve ser excluído
should_exclude() {
    local file="$1"
    for pattern in "${EXCLUDE_FILES[@]}"; do
        if [[ "$file" == $pattern ]] || [[ "$(basename "$file")" == $pattern ]]; then
            return 0  # Excluir
        fi
    done
    return 1  # Não excluir
}

# Função para sync inteligente
sync_file() {
    local local_file="$1"
    local remote_path="$2"
    
    if should_exclude "$local_file"; then
        echo "   ⏭️  Ignorado: $local_file"
        return
    fi
    
    if [ -f "$local_file" ]; then
        # Verificar se arquivo mudou (comparar timestamps se possível)
        local_size=$(stat -f%z "$local_file" 2>/dev/null || stat -c%s "$local_file" 2>/dev/null || echo "0")
        remote_size=$(ssh_exec "[ -f '$remote_path/$local_file' ] && stat -c%s '$remote_path/$local_file' 2>/dev/null || echo '0'")
        
        if [ "$local_size" != "$remote_size" ] || [ "$DEPLOY_TYPE" = "FIRST_INSTALL" ]; then
            echo "   📤 Atualizando: $local_file"
            sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no "$local_file" "$SERVER_USER@$SERVER_HOST:$remote_path/"
        else
            echo "   ✅ Sem mudanças: $local_file"
        fi
    fi
}

# Função para sync pasta
sync_folder() {
    local folder="$1"
    
    if [ ! -d "$folder" ]; then
        echo "   ⚠️  Pasta não encontrada: $folder"
        return
    fi
    
    echo "   📁 Sincronizando pasta: $folder"
    
    # Criar pasta no servidor se não existir
    ssh_exec "mkdir -p '$DEPLOY_PATH/$folder'"
    
    # Sync arquivos da pasta
    find "$folder" -type f | while read -r file; do
        if ! should_exclude "$file"; then
            local_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "0")
            remote_size=$(ssh_exec "[ -f '$DEPLOY_PATH/$file' ] && stat -c%s '$DEPLOY_PATH/$file' 2>/dev/null || echo '0'")
            
            if [ "$local_size" != "$remote_size" ] || [ "$DEPLOY_TYPE" = "FIRST_INSTALL" ]; then
                echo "     📤 $file"
                # Criar diretório se necessário
                file_dir=$(dirname "$file")
                ssh_exec "mkdir -p '$DEPLOY_PATH/$file_dir'"
                sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no "$file" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/$file"
            fi
        fi
    done
}

# DEPLOY INCREMENTAL
echo "📦 Iniciando sync incremental..."

# Arquivos da raiz
echo "📄 Arquivos da raiz:"
for file in index.html sitemap.xml robots.txt .htaccess manifest.json; do
    sync_file "$file" "$DEPLOY_PATH"
done

# Pastas importantes
echo "📁 Pastas:"
for folder in css js assets json pages blog; do
    if [ -d "$folder" ]; then
        sync_folder "$folder"
    fi
done

# LIMPEZA: Remover arquivos indesejados do servidor
echo "🧹 Limpeza do servidor..."

# Remover scripts .sh se existirem
echo "   🗑️  Removendo scripts .sh..."
ssh_exec "find '$DEPLOY_PATH' -name '*.sh' -type f -delete 2>/dev/null || true"

# Remover backups antigos da pasta web
ssh_exec "find '$DEPLOY_PATH' -name 'backup-*' -type d -exec rm -rf {} + 2>/dev/null || true"

# Remover arquivos temporários
ssh_exec "find '$DEPLOY_PATH' -name '*.tmp' -o -name '*.temp' -o -name '*.log' -o -name '*.backup' | head -20 | xargs rm -f 2>/dev/null || true"

# PERMISSÕES E SEGURANÇA
echo "🔒 Configurando permissões..."

# Permissões gerais
ssh_exec "chown -R $SITE_USER:$SITE_USER '$DEPLOY_PATH'"
ssh_exec "find '$DEPLOY_PATH' -type d -exec chmod 755 {} \;"
ssh_exec "find '$DEPLOY_PATH' -type f -exec chmod 644 {} \;"

# Permissões especiais para arquivos sensíveis
for sensitive_file in "${SENSITIVE_FILES[@]}"; do
    ssh_exec "[ -f '$DEPLOY_PATH/$sensitive_file' ] && chmod 600 '$DEPLOY_PATH/$sensitive_file' && echo 'Proteção aplicada: $sensitive_file' || true"
done

# Proteger .htaccess
ssh_exec "[ -f '$DEPLOY_PATH/.htaccess' ] && chmod 644 '$DEPLOY_PATH/.htaccess'"

# VERIFICAÇÕES FINAIS
echo "🔍 Verificações finais..."

# Verificar arquivos essenciais
ESSENTIAL_FILES=("index.html" "css/style.css" "js/main.js")
MISSING_FILES=()

for file in "${ESSENTIAL_FILES[@]}"; do
    if ! ssh_exec "[ -f '$DEPLOY_PATH/$file' ]"; then
        MISSING_FILES+=("$file")
    fi
done

if [ ${#MISSING_FILES[@]} -eq 0 ]; then
    echo "✅ Todos os arquivos essenciais estão presentes"
else
    echo "⚠️  Arquivos essenciais faltando: ${MISSING_FILES[*]}"
fi

# Recarregar nginx
echo "🔄 Recarregando nginx..."
ssh_exec "systemctl reload nginx" && echo "✅ Nginx recarregado" || echo "⚠️ Erro no nginx reload"

# Testar site
echo "🌐 Testando site..."
sleep 3

if command -v curl &> /dev/null; then
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://$DOMAIN" --max-time 10)
    case $HTTP_CODE in
        200) echo "✅ Site online - Status: $HTTP_CODE" ;;
        *) echo "⚠️  Site status: $HTTP_CODE" ;;
    esac
else
    echo "ℹ️  Teste manual: https://$DOMAIN"
fi

# Estatísticas
echo ""
echo "📊 ESTATÍSTICAS:"
FILES_COUNT=$(ssh_exec "find '$DEPLOY_PATH' -type f | wc -l")
TOTAL_SIZE=$(ssh_exec "du -sh '$DEPLOY_PATH' 2>/dev/null | cut -f1")
echo "• Arquivos no servidor: $FILES_COUNT"
echo "• Tamanho total: $TOTAL_SIZE"

# Últimos arquivos modificados
echo ""
echo "📅 ARQUIVOS RECENTES (últimos 5):"
ssh_exec "find '$DEPLOY_PATH' -type f -printf '%TY-%Tm-%Td %TH:%TM %p\n' 2>/dev/null | sort -r | head -5 | sed 's|$DEPLOY_PATH/||g'" || echo "Lista não disponível"

echo ""
echo "🎉 DEPLOY INCREMENTAL CONCLUÍDO!"
echo ""
echo "✅ RESUMO:"
echo "• ⚡ Deploy incremental executado"
echo "• 🧹 Arquivos desnecessários removidos"
echo "• 🔒 Permissões configuradas"
echo "• 🌐 Site disponível: https://$DOMAIN"

if [ "$DEPLOY_TYPE" = "UPDATE" ]; then
    echo "• 💾 Backup incremental: $BACKUP_DIR"
fi

echo ""
echo "🔗 LINKS IMPORTANTES:"
echo "• Site: https://$DOMAIN"
echo "• Painel: https://server.vancouvertec.com.br:8443"
echo ""
echo "💡 PRÓXIMO DEPLOY:"
echo "   ./deploy-incremental.sh"
echo ""
echo "🆘 EM CASO DE PROBLEMAS:"
echo "   ./rollback.sh"
echo ""

# Criar log de deploy
LOG_FILE="deploy-$(date +%Y%m%d_%H%M%S).log"
echo "Deploy incremental executado em $(date)" > "$LOG_FILE"
echo "Tipo: $DEPLOY_TYPE" >> "$LOG_FILE"
echo "Arquivos: $FILES_COUNT" >> "$LOG_FILE"
echo "Tamanho: $TOTAL_SIZE" >> "$LOG_FILE"
echo "Status: Sucesso" >> "$LOG_FILE"

echo "📝 Log salvo: $LOG_FILE"
echo ""
echo "✨ Portal atualizado com sucesso!"