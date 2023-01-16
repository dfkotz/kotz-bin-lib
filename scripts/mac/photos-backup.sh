#!/bin/sh
# backup Lightroom photos from one directory to another
#
# usage: photos-backup.sh sourceDir backupDir
#

if [ $# -lt 2 ]; then
    echo usage: photos-backup.sh sourceDir backupDir
    exit 1
fi

source="$1"
backup="$2"

cd "$source" || {
    echo "Cannot change directory to $source"
    exit 1
}

if [ ! -d "$backup" ]; then
    echo "not a directory: $backup"
    exit 2
fi

rsyncargs="-vi --delete -raHO"

echo "TEST RUN..."
echo rsync -n $rsyncargs ./ "$backup"/
if rsync -n $rsyncargs ./ "$backup"/ | less ; then
    echo "PROCEED? hit return if yes, otherwise ^C"
    read proceed
    
    echo "ACTUAL RUN..."
    rsync $rsyncargs ./ "$backup"/
    exit $?
else
    echo "rsync failed!"
    exit 3
fi
