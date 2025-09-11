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
