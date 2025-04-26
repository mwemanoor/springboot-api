#!/bin/bash

LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
BACKUP_DIR="/home/ubuntu/backups"
mkdir -p $BACKUP_DIR

# Backup API files
tar -czf "$BACKUP_DIR/api_backup_$(date +%F).tar.gz" --absolute-names /home/ubuntu/rest-api-*.jar
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] API backup succeeded." >> $LOG_FILE
else
    echo "[$TIMESTAMP] ERROR: API backup failed." >> $LOG_FILE
fi

# Backup PostgreSQL
sudo -u postgres pg_dump rest-api > "$BACKUP_DIR/db_backup_$(date +%F).sql"
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] Database backup succeeded." >> $LOG_FILE
else
    echo "[$TIMESTAMP] ERROR: Database backup failed." >> $LOG_FILE
fi

# Delete backups older than 7 days
find $BACKUP_DIR -type f -mtime +7 -delete