#!/usr/bin/env bash
#
# cr3 - copy CR3 files from a camera memory card
#       onto a designated volume for backups.
# usage:
#   cr3 destname
# where destname is the name of a directory on the destination drive;
# the name of the destination drive is hardcoded below.
#
# David Kotz 2022

# DESTINATION
if [ "$1" == "" ]; then
    echo usage: cr3 destname
    exit 1
else
    destvol=/Volumes/Kotz-photos-SSD/CR3
    destname="$1"
    destdir="$destvol/$destname"
fi

if [ -d "$destdir" ]; then
    date=$(date +%Y-%m-%d)
    destpath="$destdir/$date"
else
    echo "No backup directory $destdir"
    exit 2
fi

if mkdir -p "$destpath"; then
    echo "Created destination $destpath"
else
    echo "Failed to create directory $destpath"
    exit 3
fi

# SOURCE(S)
source=/Volumes/EOS_DIGITAL
if [ ! -d "$source" ]; then
    echo "Missing source $source"
    exit 4
fi

for photos in "$source"/DCIM/1??CANON
do
    echo "Found source $photos"

    n=$(ls "$photos"/ | wc -l)
    if [[ $n == 0 ]]; then
        echo "No photos in $photos"
        continue
    fi

    # COPY new photos to destination,
    # duplicating (not overwriting) same-named files
    echo "Sync $n photos from $photos"
    rsync -rai --backup "$photos"/ "$destpath"/ && echo SUCCESS
done
exit $?
