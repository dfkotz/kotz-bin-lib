#!/bin/sh
# Backup master Lightroom photos to destination $1
#

dest="$1"
if [ "$dest" == "" ]; then
    echo usage: "$0 dest-directory"
    exit 1
fi
if [ ! -d "$dest" ]; then
    echo destination unavailable: "$dest"
    exit 2
fi

let failures=0

echo ====================================
echo backup catalog...
master=~/Personal/Photos/LightroomCatalog
backup="$dest/LightroomCatalog"
if rsync -ravi "$master"/*.lrcat "$backup/"
then
    date > "$backup/BACKUP_DATE.txt"
    echo success
else
    echo FAILED
    let failures++
fi

echo ====================================
echo
echo backup laptop...
master=~/Personal/Photos/Lightroom
backup="$dest/LightroomLaptop"
if photos-backup.sh "$master" "$backup"
then
    date > "$backup/BACKUP_DATE.txt"
    echo success
else
    echo FAILED
    let failures++
fi

echo ====================================
echo
echo backup disk...
master=/Volumes/kotz-photos-master/Lightroom
backup="$dest/LightroomDisk"
if photos-backup.sh "$master" "$backup"
then
    date > "$backup/BACKUP_DATE.txt"
    echo success
else
    echo FAILED
    let failures++
fi

if (( $failures > 0 )); then
    echo "SOMETHING FAILED ($failures failures)"
else
    echo "Success ($failures failures)"
fi

exit $failures
