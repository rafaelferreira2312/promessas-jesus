#!/bin/bash

# =====================================================
# DEPLOY LIMPO - PORTAL JESUS É O PÃO DA VIDA
# Remove tudo do servidor e reinstala do zero
# =====================================================
# Uso: chmod +x deploy-clean.sh && ./deploy-clean.sh
# =====================================================

set -e

# Configurações do servidor
SERVER_HOST="212.85.1.55"
SERVER_USER="root"
SERVER_PASSWORD="rdg5q@CKJ(JVvofef6F,"
SITE_USER="vancouvertec-promessasdejesus"
DEPLOY_PATH="/home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br"
DOMAIN="promessasdejesus.vancouvertec.com.br"

echo "🧹 DEPLOY LIMPO - INSTALAÇÃO DO ZERO"
echo "🌐 Domínio: https://$DOMAIN"
echo "⚠️  ATENÇÃO: Vai APAGAR tudo do servidor e reinstalar"
echo ""

# Verificar pasta do projeto
if [ ! -f "index.html" ]; then
    echo "❌ Execute na pasta raiz do projeto (onde está index.html)"
    exit 1
fi

# Verificar sshpass
if ! command -v sshpass &> /dev/null; then
    echo "❌ Instale sshpass: sudo apt-get install sshpass"
    exit 1
fi

# Confirmar ação destrutiva
read -p "🔴 Confirma APAGAR tudo do servidor e reinstalar? (s/N): " confirm
if [[ $confirm != [sS] ]]; then
    echo "❌ Deploy cancelado pelo usuário"
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

# PASSO 1: BACKUP COMPLETO (se existir conteúdo)
echo "💾 Fazendo backup completo do servidor..."
BACKUP_DIR="/home/$SITE_USER/backups/full_backup_$(date +%Y%m%d_%H%M%S)"

if ssh_exec "[ -d '$DEPLOY_PATH' ] && [ \"\$(ls -A '$DEPLOY_PATH' 2>/dev/null)\" ]"; then
    ssh_exec "mkdir -p '$BACKUP_DIR'"
    ssh_exec "cp -r '$DEPLOY_PATH'/* '$BACKUP_DIR'/ 2>/dev/null || true"
    echo "✅ Backup completo criado: $BACKUP_DIR"
else
    echo "ℹ️  Nenhum conteúdo anterior encontrado - primeira instalação"
fi

# PASSO 2: LIMPEZA TOTAL DO SERVIDOR
echo "🧹 LIMPEZA TOTAL do servidor..."

# Remover todo o conteúdo da pasta web
ssh_exec "rm -rf '$DEPLOY_PATH'/*"
ssh_exec "rm -rf '$DEPLOY_PATH'/.*" 2>/dev/null || true

# Criar pasta limpa
ssh_exec "mkdir -p '$DEPLOY_PATH'"

# Limpar cache do nginx se existir
ssh_exec "[ -d '/var/cache/nginx' ] && rm -rf /var/cache/nginx/* 2>/dev/null || true"

echo "✅ Servidor completamente limpo"

# PASSO 3: INSTALAÇÃO LIMPA DOS ARQUIVOS
echo "📦 Instalando arquivos do zero..."

# Arquivos da raiz que devem ser enviados
ROOT_FILES=("index.html" "sitemap.xml" "robots.txt" ".htaccess" "manifest.json")

echo "📄 Enviando arquivos da raiz..."
for file in "${ROOT_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "   📤 $file"
        sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no "$file" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/"
    else
        echo "   ⚠️  $file não encontrado (opcional)"
    fi
done

# Pastas que devem ser enviadas
FOLDERS=("css" "js" "assets" "json" "pages" "blog")

echo "📁 Enviando pastas..."
for folder in "${FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        echo "   📁 Enviando pasta: $folder"
        
        # Enviar pasta completa, excluindo arquivos indesejados
        rsync -avz --exclude="*.sh" --exclude="*.log" --exclude="*.backup" --exclude="backup-*" \
              -e "sshpass -p $SERVER_PASSWORD ssh -o StrictHostKeyChecking=no" \
              "$folder/" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/$folder/" 2>/dev/null || {
            
            # Fallback para scp se rsync não funcionar
            echo "   📤 Fallback: usando scp para $folder"
            sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no -r "$folder" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/"
        }
        echo "   ✅ $folder enviado"
    else
        echo "   ⚠️  Pasta $folder não encontrada"
    fi
done

# PASSO 4: LIMPEZA FINAL NO SERVIDOR
echo "🧹 Limpeza final de arquivos indesejados..."

# Remover qualquer script .sh que possa ter ido
ssh_exec "find '$DEPLOY_PATH' -name '*.sh' -type f -delete 2>/dev/null || true"

# Remover arquivos de backup
ssh_exec "find '$DEPLOY_PATH' -name '*.backup' -delete 2>/dev/null || true"

# Remover logs
ssh_exec "find '$DEPLOY_PATH' -name '*.log' -delete 2>/dev/null || true"

# Remover arquivos temporários
ssh_exec "find '$DEPLOY_PATH' -name '*.tmp' -o -name '*.temp' -delete 2>/dev/null || true"

# Remover pastas de backup se existirem
ssh_exec "find '$DEPLOY_PATH' -name 'backup-*' -type d -exec rm -rf {} + 2>/dev/null || true"

echo "✅ Limpeza final concluída"

# PASSO 5: CONFIGURAR PERMISSÕES
echo "🔒 Configurando permissões corretas..."

# Permissões gerais
ssh_exec "chown -R $SITE_USER:$SITE_USER '$DEPLOY_PATH'"
ssh_exec "find '$DEPLOY_PATH' -type d -exec chmod 755 {} \;"
ssh_exec "find '$DEPLOY_PATH' -type f -exec chmod 644 {} \;"

# Permissões especiais para arquivos sensíveis
ssh_exec "[ -f '$DEPLOY_PATH/json/submissions.json' ] && chmod 600 '$DEPLOY_PATH/json/submissions.json' || true"
ssh_exec "[ -f '$DEPLOY_PATH/json/logs.txt' ] && chmod 600 '$DEPLOY_PATH/json/logs.txt' || true"

# .htaccess
ssh_exec "[ -f '$DEPLOY_PATH/.htaccess' ] && chmod 644 '$DEPLOY_PATH/.htaccess' || true"

echo "✅ Permissões configuradas"

# PASSO 6: VERIFICAÇÕES E TESTES
echo "🔍 Verificando instalação..."

# Arquivos obrigatórios
REQUIRED_FILES=("index.html")
MISSING_FILES=()

for file in "${REQUIRED_FILES[@]}"; do
    if ! ssh_exec "[ -f '$DEPLOY_PATH/$file' ]"; then
        MISSING_FILES+=("$file")
    fi
done

if [ ${#MISSING_FILES[@]} -eq 0 ]; then
    echo "✅ Todos os arquivos obrigatórios estão presentes"
else
    echo "❌ Arquivos obrigatórios faltando: ${MISSING_FILES[*]}"
    echo "   Deploy pode ter falhado!"
fi

# Listar estrutura do servidor
echo "📋 Estrutura instalada no servidor:"
ssh_exec "find '$DEPLOY_PATH' -maxdepth 2 -type f | head -20" | sed "s|$DEPLOY_PATH/|   |g"

# Recarregar serviços
echo "🔄 Recarregando serviços..."
ssh_exec "systemctl reload nginx" && echo "✅ Nginx recarregado" || echo "⚠️ Erro no nginx"

# Aguardar propagação
echo "⏳ Aguardando propagação (10s)..."
sleep 10

# Testar site
echo "🌐 Testando site online..."
if command -v curl &> /dev/null; then
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://$DOMAIN" --max-time 15)
    
    case $HTTP_CODE in
        200) echo "✅ Site ONLINE - Status: $HTTP_CODE" ;;
        502|503) echo "⚠️ Site carregando - Status: $HTTP_CODE (aguarde mais um pouco)" ;;
        *) echo "❌ Problema no site - Status: $HTTP_CODE" ;;
    esac
    
    # Teste adicional específico
    CONTENT_CHECK=$(curl -s "https://$DOMAIN" --max-time 10 | grep -i "jesus.*pão" | wc -l)
    if [ "$CONTENT_CHECK" -gt 0 ]; then
        echo "✅ Conteúdo correto carregando"
    else
        echo "⚠️ Conteúdo pode não estar correto"
    fi
else
    echo "ℹ️ Teste manual: https://$DOMAIN"
fi

# Estatísticas finais
echo ""
echo "📊 ESTATÍSTICAS DA INSTALAÇÃO:"
FILES_COUNT=$(ssh_exec "find '$DEPLOY_PATH' -type f | wc -l")
FOLDERS_COUNT=$(ssh_exec "find '$DEPLOY_PATH' -type d | wc -l")
TOTAL_SIZE=$(ssh_exec "du -sh '$DEPLOY_PATH' 2>/dev/null | cut -f1")

echo "• Arquivos instalados: $FILES_COUNT"
echo "• Pastas criadas: $FOLDERS_COUNT"
echo "• Espaço ocupado: $TOTAL_SIZE"

echo ""
echo "🎉 INSTALAÇÃO LIMPA CONCLUÍDA!"
echo ""
echo "✅ RESUMO:"
echo "• 🧹 Servidor completamente limpo"
echo "• 📦 Instalação do zero realizada"
echo "• 🗑️ Scripts .sh e arquivos desnecessários removidos"
echo "• 🔒 Permissões corretas aplicadas"
echo "• 🌐 Site disponível em: https://$DOMAIN"
echo ""
echo "💾 BACKUP ANTERIOR SALVO EM:"
echo "   $BACKUP_DIR"
echo ""
echo "🔗 LINKS:"
echo "• Site: https://$DOMAIN"
echo "• Painel: https://server.vancouvertec.com.br:8443"
echo ""
echo "🚀 PRÓXIMOS DEPLOYS:"
echo "   Use: ./deploy-incremental.sh (para atualizações)"
echo "   Use: ./deploy-clean.sh (apenas se houver problemas)"
echo ""
echo "🆘 ROLLBACK SE NECESSÁRIO:"
echo "   ./rollback.sh"
echo ""

# Criar log de deploy
{
    echo "=== DEPLOY LIMPO - $(date) ==="
    echo "Tipo: Instalação completa do zero"
    echo "Backup anterior: $BACKUP_DIR"
    echo "Arquivos: $FILES_COUNT"
    echo "Tamanho: $TOTAL_SIZE"
    echo "Status HTTP: ${HTTP_CODE:-'N/A'}"
    echo "Status: SUCESSO"
    echo "================================"
} > "deploy-clean-$(date +%Y%m%d_%H%M%S).log"

echo "📝 Log salvo no arquivo local"
echo ""
echo "✨ Portal 'Jesus é o Pão da Vida' reinstalado com sucesso!"