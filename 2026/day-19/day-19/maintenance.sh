#!/bin/bash
BASE_DIR="/home/ubuntu/devops/shell-script"

LOG_FILE="/var/log/maintenance.log"

log_msg(){
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

log_msg "Maintenance started"

"$BASE_DIR/log_rotate.sh" /home/ubuntu/devops/shell-script/myapp >> "$LOG_FILE" 2>&1

log_msg "Log rotation completed"

"$BASE_DIR/backup.sh" /home/ubuntu/devops/shell-script /home/ubuntu/backups >> "$LOG_FILE" 2>&1

log_msg "Backup completed"
log_msg "Maintenance finished"