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

# check for missing hashcheck/metacheck files
echo look for missing directories...
rm -f "$log"
for dir in "$@"
do
    ls "$dir"/*/.metacheck | diff "$dir"/metachecklist - >> "$log"
    ls "$dir"/*/.hashcheck | diff "$dir"/hashchecklist - >> "$log"
done

if [[ -s "$log" ]]; then
    mail -s "missing expected directories" $USER < "$log"
fi

# look for new directories that are missing either file,
# or for directories that have both, but with different length
echo examine all YYYY directories...
rm -f "$log"
for dir in "$@"
do
    # look at all subdirs whose name starts with YYYY
    for subdir in "$dir"/[1-2][0-9][0-9][0-9]*
    do
        if [[ -d "$subdir" ]]; then
            # ensure this directory has each required file
            if [[ ! -f "$subdir/.hashcheck" ]]; then
                echo WARNING: missing "$subdir/.hashcheck" >> "$log"
            fi
            if [[ ! -f "$subdir/.metacheck" ]]; then
                echo WARNING: missing "$subdir/.metacheck" >> "$log"
            fi

            # if it has both files, they should be the same length
            if [[ -f "$subdir/.hashcheck" && -f "$subdir/.metacheck" ]]; then
               mcl=$(wc -l < "$subdir/.metacheck")
               hcl=$(wc -l < "$subdir/.hashcheck")
               if (( $mcl != $hcl )) ; then
                   echo "$subdir has $mcl in .meta and $hcl in .hash" >> "$log"
               fi
            fi
        fi
    done
done

if [[ -s "$log" ]]; then
    mail -s "meta/hashcheck missing or inconsistent" $USER < "$log"
fi

rm -f "$log"
