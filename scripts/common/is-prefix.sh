#!/bin/bash
# usage:
#  is-prefix fileA fileB
#
# prints one of the following:
# fileA equals fileB: fileA contents are exactly the same as fileB (status 0)
# fileA prefix fileB: fileA contents are a prefix of fileB (status 1)
# fileA extends fileB: fileB contents are a prefix of fileA (status 2)
# fileA differs fileB: none of the above (status 3)
# error: ... (status 4)
#
# works also if either or both are compressed (gz) files
#
# David Kotz 2020

if [[ $# != 2 ]]; then
    echo usage:  is-prefix fileA fileB
    exit 1
fi

fileA="$1"
fileB="$2"
tmp=/tmp/prefix$$

# if fileA is compressed, create an uncompressed copy
if [[ "$fileA" =~ .*\.gz ]]; then
    cmpA=$tmp.A
    gunzip -c "$fileA" > $cmpA
else
    cmpA="$fileA"
fi

# if fileB is compressed, create an uncompressed copy
if [[ "$fileB" =~ .*\.gz ]]; then
    cmpB=$tmp.B
    gunzip -c "$fileB" > $cmpB
else
    cmpB="$fileB"
fi

# compare the two uncompressed files, and save cmp's output and exit status
cmp "$cmpA" "$cmpB" &> $tmp.out
status=$?
cmpOut=$(<$tmp.out)

# clean up all temp files
rm -f $tmp.*

# fileA equals fileB: fileA contents are exactly the same as fileB (status 0)
if [ $status -eq 0 ]; then
    echo "$fileA equals $fileB"
    exit 0
fi

# error: ... (status 4)
if [ $status -ne 1 ]; then
    echo "error: $cmpOut"
    exit 4
fi

# fileA prefix fileB: fileA contents are a prefix of fileB (status 1)
pat="cmp: EOF on $fileA after .*"
if [[ "$cmpOut" =~ $pat ]]; then
    echo "$fileA prefix $fileB"
    exit 1
fi

# fileA extends fileB: fileB contents are a prefix of fileA (status 2)
pat="cmp: EOF on $fileB after .*"
if [[ "$cmpOut" =~ $pat ]]; then
    echo "$fileA extends $fileB"
    exit 2
fi

# fileA differs fileB: none of the above (status 3)
echo "$fileA differs $fileB"
exit 3
