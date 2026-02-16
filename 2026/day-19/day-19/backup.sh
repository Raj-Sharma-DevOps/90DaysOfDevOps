#!/bin/bash

SRC_DIR="$1"
DEST_DIR="$2"

DATE=$(date +%Y-%m-%d)

ARCHIVE_NAME="backup-$DATE.tar.gz"

if [ ! -d $SRC_DIR ]; then
        echo "Error: Source directory not found"
        exit 1
fi

mkdir -p $DEST_DIR

tar -czf "$DEST_DIR/$ARCHIVE_NAME" "$SRC_DIR"

if [ ! -f "$DEST_DIR/$ARCHIVE_NAME" ]; then
        echo "Backup failed"
        exit 1
fi

SIZE=$(du -h "$DEST_DIR/$ARCHIVE_NAME" | cut -f1)
 echo "Backup created: $ARCHIVE_NAME"
 echo "Size: $SIZE"

 find "$DEST_DIR" -name "backup-*.tar.gz" -mtime +14 -delete