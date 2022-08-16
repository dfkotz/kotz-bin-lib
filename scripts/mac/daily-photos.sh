#!/bin/bash
#
# daily-photos - a daily checkup of my photos
#

log=/tmp/daily-photos$$.log

# check all arguments (directories) for new and missing files
function checkdirs()
{
    # check photo collections for new files, and add them
    echo metacheck --expand...
    time metacheck --expand "$@"  > "$log" \
        || mail -s "metacheck-expand" $USER < "$log"

    echo hashcheck --update...
    time hashcheck --update "$@" > "$log" \
        || mail -s "hashcheck-update" $USER < "$log"

    # check photo collections for integrity
    echo metacheck --verify...
    time metacheck --verify "$@" > "$log" \
        || mail -s "metacheck-verify" $USER < "$log"

    echo hashcheck --random...
    time hashcheck --random "$@" > "$log" \
        || mail -s "hashcheck-random" $USER < "$log"
}

echo LAPTOP DIRECTORIES...
cd ~/Personal/Photos/Lightroom/ && checkdirs *

echo
echo GOOGLE DIRECTORIES...
cd ~/Lightroom/ && checkdirs *

rm -f "$log"
