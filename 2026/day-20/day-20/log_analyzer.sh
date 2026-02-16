#!/bin/bash


LOG_FILE="$1"
DATE=$(date +%Y-%m-%d)
REPORT_FILE="Log_Report_$DATE.txt"

if [ -z "$LOG_FILE" ]; then
    echo "Error: Please provide a log file path"
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Can't find file"
    exit 1
fi    
echo "Analyzing log file: $LOG_FILE"
echo "_____________________________"




ERROR_COUNT=$(grep -Ei "ERROR | WARN" "$LOG_FILE" | wc -l)
echo "ERROR COUNT is: $ERROR_COUNT"





INFO_EVENTS=$(grep -ni "INFO" "$LOG_FILE")
echo "_________________________"
echo "Info events: $INFO_EVENTS"
echo "_________________________"






TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" | awk -F ' - ' '{print $NF}' | sort | uniq -c | sort -rn | head -5 )
echo "--- Top 5 Error Messages ---"
echo "$TOP_ERRORS"




TOTAL_LINES=$(wc -l < "$LOG_FILE")
{
    echo "Log Analysis Report"
    echo "Date: $DATE"
    echo "Log File: $LOG_FILE"
    echo "Total Lines Processed: $TOTAL_LINES"
    echo "Total Errors: $ERROR_COUNT"
    echo
    echo "--- Top 5 Error Messages ---"
    echo "$TOP_ERRORS"
    echo
    echo "--- Critical Events ---"
    echo "$INFO_EVENTS"
} > "$REPORT_FILE"
echo
echo "Report generated: $REPORT_FILE"




ARCHIVE_DIR="archive"
mkdir -p "$ARCHIVE_DIR"
mv "$LOG_FILE" "$ARCHIVE_DIR/"
echo "Log file archived to $ARCHIVE_DIR/"

