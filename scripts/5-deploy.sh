#!/bin/bash

# =====================================================
# SCRIPT 5 - DEPLOY PARA SERVIDOR
# Deploy automático para https://promessasdejesus.vancouvertec.com.br
# =====================================================
# Uso: chmod +x 5-deploy.sh && ./5-deploy.sh
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

echo "🚀 INICIANDO DEPLOY - PORTAL JESUS É O PÃO DA VIDA"
echo "🌐 Domínio: https://$DOMAIN"
echo "🖥️ Servidor: $SERVER_HOST"
echo "📁 Path: $DEPLOY_PATH"
echo ""

# Verificar se estamos na pasta correta
if [ ! -f "index.html" ] || [ ! -f "sitemap.xml" ]; then
    echo "❌ Erro: Execute o script na pasta do projeto completo"
    echo "   Certifique-se que index.html e sitemap.xml existem"
    exit 1
fi

# Verificar se sshpass está instalado
if ! command -v sshpass &> /dev/null; then
    echo "⚠️ Instalando sshpass..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y sshpass
    elif command -v yum &> /dev/null; then
        sudo yum install -y sshpass
    elif command -v brew &> /dev/null; then
        brew install hudochenkov/sshpass/sshpass
    else
        echo "❌ Por favor instale sshpass manualmente"
        exit 1
    fi
fi

# Verificar se rsync está instalado
if ! command -v rsync &> /dev/null; then
    echo "⚠️ Instalando rsync..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y rsync
    elif command -v yum &> /dev/null; then
        sudo yum install -y rsync
    elif command -v brew &> /dev/null; then
        brew install rsync
    else
        echo "❌ Por favor instale rsync manualmente"
        exit 1
    fi
fi

echo "🔧 Preparando arquivos para deploy..."

# Criar pasta temporária para deploy
TEMP_DIR="deploy_temp_$(date +%s)"
mkdir -p "$TEMP_DIR"

# Copiar arquivos necessários
echo "📋 Copiando arquivos..."

cp -r css/ "$TEMP_DIR/" 2>/dev/null || echo "⚠️ Pasta css/ não encontrada"
cp -r js/ "$TEMP_DIR/" 2>/dev/null || echo "⚠️ Pasta js/ não encontrada"
cp -r assets/ "$TEMP_DIR/" 2>/dev/null || echo "⚠️ Pasta assets/ não encontrada"
cp -r json/ "$TEMP_DIR/" 2>/dev/null || echo "⚠️ Pasta json/ não encontrada"
cp -r blog/ "$TEMP_DIR/" 2>/dev/null || echo "⚠️ Pasta blog/ não encontrada"
cp -r pages/ "$TEMP_DIR/" 2>/dev/null || echo "⚠️ Pasta pages/ não encontrada"

# Arquivos da raiz
cp index.html "$TEMP_DIR/" 2>/dev/null || echo "❌ index.html é obrigatório!"
cp sitemap.xml "$TEMP_DIR/" 2>/dev/null || echo "⚠️ sitemap.xml não encontrado"
cp robots.txt "$TEMP_DIR/" 2>/dev/null || echo "⚠️ robots.txt não encontrado"
cp .htaccess "$TEMP_DIR/" 2>/dev/null || echo "⚠️ .htaccess não encontrado"
cp manifest.json "$TEMP_DIR/" 2>/dev/null || echo "⚠️ manifest.json não encontrado"
cp sw.js "$TEMP_DIR/" 2>/dev/null || echo "⚠️ sw.js não encontrado"
cp README.md "$TEMP_DIR/" 2>/dev/null || echo "⚠️ README.md não encontrado"

# Verificar se arquivo obrigatório existe
if [ ! -f "$TEMP_DIR/index.html" ]; then
    echo "❌ Erro: index.html é obrigatório para deploy"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "✅ Arquivos preparados em $TEMP_DIR"

# Função para executar comandos SSH
ssh_exec() {
    sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "$1"
}

# Função para copiar arquivos via SCP
scp_copy() {
    sshpass -p "$SERVER_PASSWORD" scp -o StrictHostKeyChecking=no -r "$1" "$SERVER_USER@$SERVER_HOST:$2"
}

# Testar conexão SSH
echo "🔐 Testando conexão com servidor..."
if ssh_exec "echo 'Conexão SSH funcionando'"; then
    echo "✅ Conexão SSH estabelecida"
else
    echo "❌ Erro: Não foi possível conectar ao servidor"
    echo "   Verifique:"
    echo "   - Host: $SERVER_HOST"
    echo "   - Usuário: $SERVER_USER"
    echo "   - Senha está correta"
    echo "   - Servidor está online"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Verificar se pasta de deploy existe
echo "📁 Verificando pasta de deploy..."
if ssh_exec "[ -d '$DEPLOY_PATH' ]"; then
    echo "✅ Pasta de deploy encontrada: $DEPLOY_PATH"
else
    echo "❌ Erro: Pasta $DEPLOY_PATH não encontrada no servidor"
    echo "   Criando pasta..."
    ssh_exec "mkdir -p '$DEPLOY_PATH'" || {
        echo "❌ Erro ao criar pasta. Verifique permissões."
        rm -rf "$TEMP_DIR"
        exit 1
    }
fi

# Fazer backup dos arquivos atuais
echo "💾 Fazendo backup dos arquivos atuais..."
BACKUP_DIR="/home/$SITE_USER/backups/backup_$(date +%Y%m%d_%H%M%S)"
ssh_exec "mkdir -p '$BACKUP_DIR' && cp -r '$DEPLOY_PATH'/* '$BACKUP_DIR'/ 2>/dev/null || echo 'Primeira instalação - sem backup necessário'"

echo "✅ Backup criado em: $BACKUP_DIR"

# Deploy dos arquivos
echo "🚀 Iniciando deploy..."

# Limpar pasta de destino (manter .htaccess se existir)
ssh_exec "cd '$DEPLOY_PATH' && find . -type f ! -name '.htaccess' -delete 2>/dev/null || echo 'Limpando pasta...'"

# Copiar novos arquivos
echo "📤 Enviando arquivos para servidor..."
scp_copy "$TEMP_DIR/*" "$DEPLOY_PATH/"

# Verificar se arquivos foram copiados
echo "🔍 Verificando arquivos no servidor..."
if ssh_exec "[ -f '$DEPLOY_PATH/index.html' ]"; then
    echo "✅ index.html encontrado no servidor"
else
    echo "❌ Erro: index.html não foi copiado corretamente"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Definir permissões corretas
echo "🔐 Configurando permissões..."
ssh_exec "chown -R $SITE_USER:$SITE_USER '$DEPLOY_PATH'"
ssh_exec "find '$DEPLOY_PATH' -type d -exec chmod 755 {} \;"
ssh_exec "find '$DEPLOY_PATH' -type f -exec chmod 644 {} \;"

# Permissões especiais para .htaccess
ssh_exec "[ -f '$DEPLOY_PATH/.htaccess' ] && chmod 644 '$DEPLOY_PATH/.htaccess'"

# Criar pasta scripts se não existir
ssh_exec "mkdir -p '$DEPLOY_PATH/../scripts'"
ssh_exec "chown $SITE_USER:$SITE_USER '$DEPLOY_PATH/../scripts'"

# Verificar se json/ está acessível mas protegido
echo "🛡️ Configurando segurança para pasta json/..."
ssh_exec "[ -d '$DEPLOY_PATH/json' ] && chmod 755 '$DEPLOY_PATH/json'"

# Proteger arquivos sensíveis
SENSITIVE_FILES=("json/submissions.json" "json/logs.txt")
for file in "${SENSITIVE_FILES[@]}"; do
    ssh_exec "[ -f '$DEPLOY_PATH/$file' ] && chmod 600 '$DEPLOY_PATH/$file' && chown $SITE_USER:$SITE_USER '$DEPLOY_PATH/$file'"
done

# Reiniciar nginx se necessário
echo "🔄 Reiniciando serviços web..."
ssh_exec "systemctl reload nginx" || echo "⚠️ Nginx reload falhou - mas site pode estar funcionando"

# Verificar se site está online
echo "🌐 Verificando se site está online..."
sleep 3

# Função para testar URL
test_url() {
    local url="$1"
    local expected_code="$2"
    
    if command -v curl &> /dev/null; then
        local response_code=$(curl -s -o /dev/null -w "%{http_code}" "$url" --max-time 10)
        if [ "$response_code" = "$expected_code" ]; then
            echo "✅ $url - Status: $response_code"
            return 0
        else
            echo "⚠️ $url - Status: $response_code (esperado: $expected_code)"
            return 1
        fi
    else
        echo "⚠️ curl não disponível - não foi possível testar URL"
        return 1
    fi
}

# Testar URLs principais
echo "🧪 Testando URLs do site..."
test_url "https://$DOMAIN" "200"
test_url "https://$DOMAIN/sitemap.xml" "200"
test_url "https://$DOMAIN/robots.txt" "200"
test_url "https://$DOMAIN/manifest.json" "200"

# Limpar arquivos temporários
echo "🧹 Limpando arquivos temporários..."
rm -rf "$TEMP_DIR"

# Estatísticas do deploy
echo ""
echo "📊 ESTATÍSTICAS DO DEPLOY:"
ssh_exec "echo 'Arquivos no servidor:'; find '$DEPLOY_PATH' -type f | wc -l"
ssh_exec "echo 'Tamanho total:'; du -sh '$DEPLOY_PATH' | cut -f1"
ssh_exec "echo 'Última modificação:'; stat -c '%y' '$DEPLOY_PATH/index.html' 2>/dev/null || echo 'N/A'"

echo ""
echo "🎉 DEPLOY CONCLUÍDO COM SUCESSO!"
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
echo "📝 PRÓXIMOS PASSOS OPCIONAIS:"
echo "1. Testar todas as funcionalidades no site"
echo "2. Configurar cron jobs para newsletter"
echo "3. Adicionar imagem jesus-pao.webp se ainda não foi feito"
echo "4. Monitorar logs em: $DEPLOY_PATH/../logs/"
echo ""
echo "🎯 PARA FUTURAS ATUALIZAÇÕES:"
echo "   Execute novamente: ./5-deploy.sh"
echo ""
echo "✨ Portal 'Jesus é o Pão da Vida' está online!"
echo "   Que Deus abençoe este ministério digital! 🙏"

# Função de rollback em caso de problemas
create_rollback_script() {
    cat > rollback.sh << 'ROLLBACK_EOF'
#!/bin/bash
# Script de Rollback - Portal Jesus é o Pão da Vida

SERVER_HOST="212.85.1.55"
SERVER_USER="root"
SERVER_PASSWORD="rdg5q@CKJ(JVvofef6F,"
DEPLOY_PATH="/home/vancouvertec-promessasdejesus/htdocs/promessasdejesus.vancouvertec.com.br"

echo "🔄 INICIANDO ROLLBACK..."

# Pegar o backup mais recente
LATEST_BACKUP=$(sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "ls -1t /home/vancouvertec-promessasdejesus/backups/ | head -1")

if [ -n "$LATEST_BACKUP" ]; then
    echo "📦 Restaurando backup: $LATEST_BACKUP"
    sshpass -p "$SERVER_PASSWORD" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_HOST" "
        rm -rf '$DEPLOY_PATH'/*
        cp -r '/home/vancouvertec-promessasdejesus/backups/$LATEST_BACKUP'/* '$DEPLOY_PATH'/
        chown -R vancouvertec-promessasdejesus:vancouvertec-promessasdejesus '$DEPLOY_PATH'
        systemctl reload nginx
    "
    echo "✅ Rollback concluído!"
    echo "🌐 Site restaurado: https://promessasdejesus.vancouvertec.com.br"
else
    echo "❌ Nenhum backup encontrado"
fi
ROLLBACK_EOF

    chmod +x rollback.sh
    echo "💾 Script de rollback criado: ./rollback.sh"
}

# Criar script de rollback
create_rollback_script

echo ""
echo "🆘 EM CASO DE PROBLEMAS:"
echo "   Execute: ./rollback.sh"
echo ""