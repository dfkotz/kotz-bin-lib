#!/bin/bash
#
# travel-backup - backup during travel
#
# usage:
#  travel-backup.sh
#
# Two phases:
#   Time-Machine backup to local hard drive; unmount backup drive.
#   Check photo directories for additions and changes.

log=/tmp/travel-backup-$$

function cleanup() {
    rm -f "$log"
}

trap cleanup ERR EXIT



echo
echo "TIME MACHINE backup (in background)"
tm-backup.sh &

echo
echo "PHOTOS update"
dir=~/Personal/Photos/Lightroom/

# check photo collections to add new files and warn about missing files
echo hashcheck update...
if hashcheck update "$dir"  > "$log-hash"
then
    echo hashcheck PASS
else
    echo hashcheck FAILED: | cat - "$log-hash" | less
    echo -n "Approve? hit return to agree, ^C to cancel: "
    read answer
    grep "hashcheck accept"  "$log-hash" | sh || echo FAILED
fi

echo metacheck update...
if metacheck update "$dir"  > "$log-meta"
then
    echo metacheck PASS
else
    echo metacheck FAILED: | cat - "$log-meta" | less
    echo -n "Approve? hit return to agree, ^C to cancel: "
    read answer
    grep "metacheck accept"  "$log-meta" | sh || echo FAILED
fi

rm -f "$log"*
