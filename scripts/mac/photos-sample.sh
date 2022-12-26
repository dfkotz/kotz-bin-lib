#!/bin/bash
#
# photos-sample - spot-check all arguments (directories):
# hash a random sample (about 3%) of all existing files.
# (Why 3%? we want to sample about 1/30 per day because Google has a 30-day
#  limit on the restoration of missing files or older versions.)
#
# usage: photos-sample.sh dir...

log=/tmp/daily-photos$$.log

echo hashcheck sample... first pass
hashcheck sample "$@" > "$log" \
    || mail -s "hashcheck-sample" $USER < "$log"

echo hashcheck sample... second pass
hashcheck sample "$@" > "$log" \
    || mail -s "hashcheck-sample" $USER < "$log"

echo hashcheck sample... third pass
hashcheck sample "$@" > "$log" \
    || mail -s "hashcheck-sample" $USER < "$log"

rm -f "$log"
