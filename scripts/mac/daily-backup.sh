#!/bin/bash
#
# daily-backup - a script to run a daily backup of my laptop
#
# Two aspects:
#   Check the photo directories for integrity;
#   Time-Machine backup to local hard drive.
#
# BUGS: photo-directory names must not have embedded spaces.

# Name of the backup volume, and its UUID
# (find these with `tmutil destinationinfo`
backup=Kotz-backup-SSD
UUID=1E4862C4-197B-4854-AE0E-79793A173D9F
dirs=( ~/Personal/Photos/Lightroom ~/Dropbox/Lightroom )

log=/tmp/daily-backup$$.log

# check photo collections for new files
echo metacheck --expand...
metacheck --expand "${dirs[@]}"  > "$log" \
    || mail -s "metacheck-expand" $USER < "$log"
echo hashcheck --update...
hashcheck --update "${dirs[@]}" > "$log" \
    || mail -s "hashcheck-update" $USER < "$log"
# check photo collections for integrity
echo metacheck --verify...
metacheck --verify "${dirs[@]}" > "$log" \
    || mail -s "metacheck-verify" $USER < "$log"


# verify presence of Time Machine backup
if [ ! -d /Volumes/$backup ]; then
    echo missing backup volume $backup
    echo NO TIME MACHINE BACKUP
    exit 1
else
    # start Time Machine backup
    echo "start Time Machine backup..."
    tmutil startbackup --block --destination $UUID

    eject $backup
fi
