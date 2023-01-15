#!/bin/bash
#
# photos-sample - spot-check all arguments (directories):
# hash a random sample (about 1%) of all existing files.
#
# usage: photos-sample.sh dir...

log=/tmp/photos-sample$$.log

if [ $# -eq 0 ]; then
    echo usage: photos-sample.sh dir...
    exit 1
fi

echo hashcheck sample...
hashcheck sample "$@" > "$log" \
    || mail -s "hashcheck-sample" $USER < "$log"

rm -f "$log"
