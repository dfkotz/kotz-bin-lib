#!/bin/sh
# Backup master Lightroom photos to hard drive
#

master=/Volumes/kotz-photos-master/Lightroom
backup=/Volumes/Kotz-photos-backup/Lightroom

photos-backup.sh "$master" "$backup" && date > "$backup/BACKUP_DATE.txt"
exit $?


