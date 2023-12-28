#!/bin/bash
# Backup master Lightroom photos to Dropbox
#
# Unfortunately this uses a different approach than photos-backup-disk
# because the rsync approach won't work with Dropbox.
#
# THIS ONLY BACKS UP THE MASTER DISK, NOT THE LAPTOP.
#

dropbox=~/Dropbox/backups/LightroomBackup

master=/Volumes/kotz-photos-master/Lightroom
backup=$dropbox/LightroomDisk

if [[ ! -d $master ]]; then
    echo FAILED: Hard drive missing: $master
    exit 1
fi

echo -n "Press return if you have run metacheck verify, otherwise ^C: "
read answer

echo -n "Press return if you have run hashcheck verify, otherwise ^C: "
read answer

echo =============================================================
echo ensure the relevant checkfiles are downloaded from Dropbox...
find $backup -name .hashcheck -print0 | xargs -0 open
find $backup -name .metacheck -print0 | xargs -0 open
echo -n "Press return when they are all open: "
read answer

echo ==============================
echo metacheck backup the photos...
metacheck backup $master || exit 1
echo
echo ==============================
echo hashcheck backup the photos...
hashcheck backup $master || exit 2
date > "$backup/BACKUP_DATE.txt"
echo done.


echo ====================================
echo backup catalog...
master=~/Personal/Photos/LightroomCatalog
backup="$dropbox/LightroomCatalog"
if rsync -a "$master"/*.lrcat "$backup/"
then
    date > "$backup/BACKUP_DATE.txt"
    echo done.
else
    echo FAILED
    exit 3
fi

echo "WARNING: laptop photos not backed-up, due to limited space on Dropbox."
exit 0
