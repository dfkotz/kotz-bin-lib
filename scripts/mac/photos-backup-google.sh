#!/bin/sh
# Backup master Lightroom photos to Google Drive
#

master=/Volumes/kotz-photos-master/Lightroom
backup=~/LightroomBackup

photos-backup.sh "$master" "$backup" && date > "$backup/BACKUP_DATE.txt"
exit $?


