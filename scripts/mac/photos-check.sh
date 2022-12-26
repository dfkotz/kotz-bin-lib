#!/bin/bash
#
# photos-check:
#    check all arguments (directories) for new and missing files, and
# for any new child directories that SHOULD have meta/hashcheck files
#
# usage: photos-check.sh dir...

log=/tmp/daily-photos$$.log

if [ $# -eq 0 ]; then
    echo usage: photos-check.sh dir...
    exit 1
fi

# check photo collections for new files, and add them
echo metacheck expand...
metacheck expand "$@"  > "$log" \
    || mail -s "metacheck-expand" $USER < "$log"

echo hashcheck update...
hashcheck update "$@" > "$log" \
    || mail -s "hashcheck-update" $USER < "$log"

# check photo collections for integrity
echo metacheck verify...
metacheck verify "$@" > "$log" \
    || mail -s "metacheck-verify" $USER < "$log"

echo look for new YYYY directories...
for dir in "$@"
do
    for subdir in "$dir"/[1-2][0-9][0-9][0-9]*
    do
        if [[ -d "$subdir" ]]; then
            for f in .hashcheck .metacheck
            do
                if [ ! -f "$subdir/$f" ]; then
                    echo WARNING: missing "$subdir/$f"
                fi
            done
        fi
    done
done

rm -f "$log"
