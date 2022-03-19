#!/bin/bash
#
# daily-photos - a daily checkup of my photos
#

dirs=( ~/Personal/Photos/Lightroom/*/ ~/Dropbox/Lightroom/*/ )

log=/tmp/daily-photos$$.log

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

