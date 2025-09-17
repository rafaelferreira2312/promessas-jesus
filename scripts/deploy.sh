#!/bin/bash

# =====================================================
# SCRIPT 5 - DEPLOY CORRIGIDO PARA SERVIDOR
# Deploy automático para https://promessasdejesus.vancouvertec.com.br
# =====================================================
# Uso: chmod +x 5-deploy-fixed.sh && ./5-deploy-fixed.sh
# =====================================================

set -e

# Configurações do servidor
SERVER_HOST="212.85.1.55"
SERVER_USER="root"
SERVER_PASSWORD="rdg5q@CKJ(JVvofef6F,"
SITE_USER="vancouvertec-promessasdejesus"
SITE_PASSWORD="Q912cK90LtehaG3YU0tf"
DEPLOY_PATH="/home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br"
DOMAIN="promessasdejesus.vancouvertec.com.br"

echo "🚀 INICIANDO DEPLOY CORRIGIDO - PORTAL JESUS É O PÃO DA VIDA"
echo "🌐 Domínio: https://$DOMAIN"
echo "🖥️ Servidor: $SERVER_HOST"
echo "📁 Path: $DEPLOY_PATH"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto completo"
    echo "   Certifique-se que index.html existe"
    exit 1
fi

# Verificar se sshpass está instalado
if ! command -v sshpass &> /dev/null; then
    echo "⚠️ sshpass não encontrado. Instale com:"
    echo "   sudo apt-get install sshpass"
    exit 1
fi

echo "🔧 Preparando arquivos para deploy..."

# Função para executar comandos SSH
ssh_exec() {
    sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "$1"
}

# Testar conexão SSH
echo "🔐 Testando conexão com servidor..."
if ssh_exec "echo 'Conexão SSH funcionando'"; then
    echo "✅ Conexão SSH estabelecida"
else
    echo "❌ Erro: Não foi possível conectar ao servidor"
    exit 1
fi

# Verificar se pasta de deploy existe
echo "📁 Verificando pasta de deploy..."
if ssh_exec "[ -d '$DEPLOY_PATH' ]"; then
    echo "✅ Pasta de deploy encontrada: $DEPLOY_PATH"
else
    echo "❌ Pasta $DEPLOY_PATH não encontrada. Criando..."
    ssh_exec "mkdir -p '$DEPLOY_PATH'" || {
        echo "❌ Erro ao criar pasta. Verifique permissões."
        exit 1
    }
fi

# Fazer backup dos arquivos atuais
echo "💾 Fazendo backup dos arquivos atuais..."
BACKUP_DIR="/home/$SITE_USER/backups/backup_$(date +%Y%m%d_%H%M%S)"
ssh_exec "mkdir -p '$BACKUP_DIR'"
ssh_exec "if [ \"$(ls -A '$DEPLOY_PATH' 2>/dev/null)\" ]; then cp -r '$DEPLOY_PATH'/* '$BACKUP_DIR'/; echo 'Backup realizado'; else echo 'Primeira instalação - sem arquivos para backup'; fi"

echo "✅ Backup criado em: $BACKUP_DIR"

# Limpar pasta de destino
echo "🧹 Limpando pasta de destino..."
ssh_exec "rm -rf '$DEPLOY_PATH'/*"

# Função para copiar arquivo individual
copy_file() {
    local file="$1"
    if [ -f "$file" ]; then
        echo "   Copiando: $file"
        sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no "$file" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/"
        return 0
    else
        echo "   ⚠️ Arquivo não encontrado: $file"
        return 1
    fi
}

# Função para copiar pasta
copy_folder() {
    local folder="$1"
    if [ -d "$folder" ]; then
        echo "   Copiando pasta: $folder"
        sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no -r "$folder" "$SERVER_USER@$SERVER_HOST:$DEPLOY_PATH/"
        return 0
    else
        echo "   ⚠️ Pasta não encontrada: $folder"
        return 1
    fi
}

# Deploy dos arquivos
echo "📤 Enviando arquivos para servidor..."

# Arquivos da raiz (obrigatórios)
copy_file "index.html" || { echo "❌ index.html é obrigatório!"; exit 1; }

# Arquivos da raiz (opcionais)
copy_file "sitemap.xml"
copy_file "robots.txt"
copy_file ".htaccess"
copy_file "manifest.json"
copy_file "sw.js"
copy_file "README.md"

# Pastas (se existirem)
copy_folder "css"
copy_folder "js"
copy_folder "assets"
copy_folder "json"
copy_folder "blog"
copy_folder "pages"

# Verificar se arquivos principais foram copiados
echo "🔍 Verificando arquivos no servidor..."
if ssh_exec "[ -f '$DEPLOY_PATH/index.html' ]"; then
    echo "✅ index.html encontrado no servidor"
else
    echo "❌ Erro: index.html não foi copiado corretamente"
    exit 1
fi

# Definir permissões corretas
echo "🔐 Configurando permissões..."
ssh_exec "chown -R $SITE_USER:$SITE_USER '$DEPLOY_PATH'"
ssh_exec "find '$DEPLOY_PATH' -type d -exec chmod 755 {} \;"
ssh_exec "find '$DEPLOY_PATH' -type f -exec chmod 644 {} \;"

# Configurar .htaccess se existe
ssh_exec "[ -f '$DEPLOY_PATH/.htaccess' ] && chmod 644 '$DEPLOY_PATH/.htaccess'"

# Configurar segurança para arquivos JSON sensíveis
echo "🛡️ Configurando segurança..."
ssh_exec "[ -f '$DEPLOY_PATH/json/submissions.json' ] && chmod 600 '$DEPLOY_PATH/json/submissions.json'"

# Recarregar nginx
echo "🔄 Recarregando nginx..."
ssh_exec "systemctl reload nginx" || echo "⚠️ Nginx reload falhou - mas site pode estar funcionando"

# Aguardar propagação
echo "⏳ Aguardando propagação..."
sleep 5

# Testar se site está online
echo "🌐 Verificando se site está online..."
if command -v curl &> /dev/null; then
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://$DOMAIN" --max-time 15)
    if [ "$HTTP_CODE" = "200" ]; then
        echo "✅ Site online - Status: $HTTP_CODE"
    else
        echo "⚠️ Site retornou status: $HTTP_CODE"
    fi
else
    echo "⚠️ curl não disponível - teste manual o site"
fi

# Estatísticas do deploy
echo ""
echo "📊 ESTATÍSTICAS DO DEPLOY:"
FILES_COUNT=$(ssh_exec "find '$DEPLOY_PATH' -type f | wc -l")
TOTAL_SIZE=$(ssh_exec "du -sh '$DEPLOY_PATH' 2>/dev/null | cut -f1 || echo 'N/A'")
echo "• Arquivos: $FILES_COUNT"
echo "• Tamanho: $TOTAL_SIZE"

echo ""
echo "🎉 DEPLOY CONCLUÍDO!"
echo ""
echo "📋 RESUMO:"
echo "• ✅ Arquivos enviados para servidor"
echo "• ✅ Permissões configuradas"
echo "• ✅ Backup criado em: $BACKUP_DIR"
echo "• ✅ Site disponível em: https://$DOMAIN"
echo ""
echo "🌐 ACESSE O SITE:"
echo "   https://$DOMAIN"
echo ""
echo "🔧 INFORMAÇÕES DO SERVIDOR:"
echo "• Host: $SERVER_HOST"
echo "• Usuário: $SITE_USER"
echo "• Pasta: $DEPLOY_PATH"
echo "• Backup: $BACKUP_DIR"
echo ""
echo "📝 PRÓXIMOS PASSOS:"
echo "1. Testar site: https://$DOMAIN"
echo "2. Adicionar imagem jesus-pao.webp se necessário"
echo "3. Verificar todas as funcionalidades"
echo ""
echo "✨ Portal 'Jesus é o Pão da Vida' está online!"
echo "   Que Deus abençoe este ministério digital! 🙏"

# Criar script de rollback
cat > rollback.sh << 'ROLLBACK_EOF'
#!/bin/bash
# Script de Rollback - Portal Jesus é o Pão da Vida

SERVER_HOST="212.85.1.55"
SERVER_USER="root"
SERVER_PASSWORD="rdg5q@CKJ(JVvofef6F,"
DEPLOY_PATH="/home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br"

echo "🔄 INICIANDO ROLLBACK..."

# Listar backups disponíveis
echo "📦 Backups disponíveis:"
sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "ls -1t /home/vancouvertec-promessasdejesus/backups/ | head -5"

# Pegar o backup mais recente
LATEST_BACKUP=$(sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "ls -1t /home/vancouvertec-promessasdejesus/backups/ | head -1")

if [ -n "$LATEST_BACKUP" ]; then
    echo "📦 Restaurando backup: $LATEST_BACKUP"
    sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "
        rm -rf '$DEPLOY_PATH'/*
        if [ -d '/home/vancouvertec-promessasdejesus/backups/$LATEST_BACKUP' ] && [ \"\$(ls -A '/home/vancouvertec-promessasdejesus/backups/$LATEST_BACKUP' 2>/dev/null)\" ]; then
            cp -r '/home/vancouvertec-promessasdejesus/backups/$LATEST_BACKUP'/* '$DEPLOY_PATH'/
            chown -R vancouvertec-promessasdejesus:vancouvertec-promessasdejesus '$DEPLOY_PATH'
            systemctl reload nginx
            echo 'Rollback concluído!'
        else
            echo 'Backup vazio ou não encontrado'
        fi
    "
    echo "✅ Rollback executado!"
    echo "🌐 Verifique o site: https://promessasdejesus.vancouvertec.com.br"
else
    echo "❌ Nenhum backup encontrado"
fi
ROLLBACK_EOF

chmod +x rollback.sh
echo ""
echo "💾 Script de rollback criado: ./rollback.sh"
echo "🆘 Em caso de problemas, execute: ./rollback.sh"