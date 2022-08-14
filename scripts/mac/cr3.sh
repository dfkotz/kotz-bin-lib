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

# SOURCE
source=/Volumes/EOS_DIGITAL
photos="$source/DCIM/100CANON"
if [ -d "$photos" ]; then
    echo "Found source $photos"
else
    echo "Missing source $photos"
    exit 4
fi

n=$(ls "$photos" | wc -l)
if [[ $n == 0 ]]; then
    echo "No photos on source volume"
    exit 5
fi


# DESTINATION
if [ "$1" == "" ]; then
    echo usage: cr3 destname
    exit 1
else
#    destvol=/Volumes/KotzPhotoBackup
    destvol=~/cr3test
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

# COPY new photos to destination,
# duplicating (not overwriting) same-named files
echo Sync $n photos from source to destination
rsync -rai --backup "$photos"/ "$destpath"/ && echo SUCCESS
exit $?
