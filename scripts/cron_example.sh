#!/bin/bash
# Exemplo de script para CRON - Envio diário de versículos
# Execute: crontab -e e adicione: 0 8 * * * /caminho/para/scripts/cron_example.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "$(date): Executando envio diário de versículos..." >> "$PROJECT_DIR/json/cron.log"

# Executar script de envio
bash "$SCRIPT_DIR/send_random_verse.sh"

echo "$(date): Envio concluído." >> "$PROJECT_DIR/json/cron.log"
