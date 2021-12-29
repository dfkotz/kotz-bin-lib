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

# look for newly arrived subdirectories - which should maybe be checked

for dir in "${dirs[@]}";
do
    (cd "$dir"; pwd; ls | diff .ls - ) || exit 1
done

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
if tm-backup.sh
then
    terminal-notifier -title "daily-backup" -sound Hero -message "backup succeeded"
else
    terminal-notifier -title "daily-backup" -sound Basso -message "backup failed"
fi
