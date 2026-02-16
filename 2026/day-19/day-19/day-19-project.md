# Day 19 – Shell Scripting Project

## Scripts Created
- log_rotate.sh
- backup.sh
- maintenance.sh

## Log Rotation
- Compresses .log files older than 7 days
- Deletes .gz files older than 30 days

## Backup Script
- Creates timestamped backup
- Deletes backups older than 14 days
- Verifies archive creation

## Cron Jobs
```cron
0 2 * * * log_rotate.sh
0 3 * * 0 backup.sh
*/5 * * * * health_check.sh
0 1 * * * maintenance.sh
