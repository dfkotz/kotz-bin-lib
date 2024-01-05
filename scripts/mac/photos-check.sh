#!/bin/bash
#
# photos-check:
#    check all arguments (directories) for new and missing files, and
# for any new child directories that SHOULD have meta/hashcheck files
#
# usage: photos-check.sh dir...

log=/tmp/daily-photos$$.log
msg=/tmp/daily-photos$$.msg

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
cat > "$msg" <<EOF
Detected differences between the checklist and the set of checkfiles.
Either
a. a new directory (with checkfile) appeared, but is in the checklist,
b. a new directory is in the checklist, but is missing a checkfile.
Below is the diff;
< means the checkfile is missing, but is listed in the checkfile;
> means the checkfile exists, but is not listed in the checkfile.
To rebuild:
  cd to the directory above
  ls */.hashcheck > .hashchecklist
  ls */.metacheck > .metachecklist
EOF

for dir in "$@"
do
    rm -f "$log"
    (cd "$dir";
     ls */.metacheck | diff .metachecklist - >> "$log";
     ls */.hashcheck | diff .hashchecklist - >> "$log"
    )
    if [[ -s "$log" ]]; then
        echo "$dir" | cat - "$msg" "$log" \
            | mail -s "missing expected directories in $dir" $USER
    fi
done

# look for new directories that are missing either file,
# or for directories that have both, but with different length
echo examine all subdirectories...
rm -f "$log"
for dir in "$@"
do
    # look at all subdirs
    for subdir in "$dir"/*/
    do
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
    done
done

if [[ -s "$log" ]]; then
    mail -s "meta/hashcheck missing or inconsistent" $USER < "$log"
fi

rm -f "$log"
