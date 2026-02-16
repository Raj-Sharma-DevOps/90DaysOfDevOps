#!/bin/bash


LOG_DIR="$1"

if [ ! -d "$LOG_DIR" ]; then
        echo "Error: Directory does not exist"
        exit 1
fi

COMPRESS_COUNT=$(find "$LOG_DIR" -name "*.log" -mtime +7 | wc -l)

find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \;

DELETE_COUNT=$(find "$LOG_DIR" -name "*.gz" -mtime +30 | wc -l)

find "$LOG_DIR" -name "*.gz" -mtime +30 -delete

echo "Compressed files: $COMPRESS_COUNT"
echo "Deleted files: $DELETE_COUNT"