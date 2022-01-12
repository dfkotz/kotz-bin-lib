#!/bin/bash
#
# daily-backup - a daily backup of my laptop
#
# Two aspects:
#   Check the photo directories for integrity;
#   Time-Machine backup to local hard drive.

daily-photos.sh

# run the Time Machine backup, and check its exit status
if tm-backup.sh
then
    terminal-notifier -title "daily-backup" -sound Hero -message "backup succeeded"
else
    terminal-notifier -title "daily-backup" -sound Basso -message "backup failed"
fi
