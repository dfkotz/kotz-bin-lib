#!/bin/bash
#
# daily-photos - a daily checkup of my photos
#

dirs=( ~/Personal/Photos/Lightroom ~/Dropbox/Lightroom )

log=/tmp/daily-photos$$.log

# look for newly arrived subdirectories - which should maybe be checked -
# or for subdirectories that have disappeared.
for dir in "${dirs[@]}";
do
    (cd "$dir"; pwd; ls | diff .ls - ) > $log \
    || mail -s "daily-photos detected changes to $dir" $USER < "$log"
done

# check photo collections for new files, and add them
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

