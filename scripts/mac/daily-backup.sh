#!/bin/bash
#
# daily-backup - a script to run a daily backup of my laptop
#
# Two aspects:
#   Check the photo directories for integrity;
#   Time-Machine backup to local hard drive.
#
# BUGS: photo-directory names must not have embedded spaces.

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

# run the Time Machine backup, and inherit its exit status
tm-backup.sh
