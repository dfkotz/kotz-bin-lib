#!/bin/bash
#
# daily-backup - a daily backup of my laptop
#
# usage:
#  daily-backup.sh [sample]
#
# Three phases:
#   Time-Machine backup to local hard drive;
#   Check photo directories for additions and changes;
#   Sample photo directories for unexpected changes [optional].
# The third phase only runs if $1 is 'sample'.

echo
echo -n "Time machine start: "; date
tm-backup.sh

echo
echo -n "Photos checkup: "; date

echo
echo CHECK LAPTOP DIRECTORIES...; date
photos-check.sh ~/Personal/Photos/Lightroom/

echo
echo CHECK GOOGLE DIRECTORIES...; date
photos-check.sh ~/Lightroom/

if [ "$1" == "sample" ]
then
    echo
    echo -n "Photos sample: "; date

    echo
    echo SAMPLE LAPTOP DIRECTORIES...; date
    photos-sample.sh ~/Personal/Photos/Lightroom/

    echo
    echo SAMPLE GOOGLE DIRECTORIES...; date
    photos-sample.sh ~/Lightroom/
fi

echo
echo -n "DONE: "; date
