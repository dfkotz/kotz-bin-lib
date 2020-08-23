#!/bin/bash
#
# tm-backup - a script to run a Time Machine backup of my laptop
#

# run a backup and eject the drive
function backup-then-eject() {
    # expect two parameters:
    # (find these with `tmutil destinationinfo`
    backup="$1" # basename of the backup volume
    UUID="$2"   # UUID of the TM on that volume
    # verify backup volume is available
    if [ -d "/Volumes/$backup" ]; then
        # start Time Machine backup
        echo "start Time Machine backup to $backup..."
        tmutil startbackup --block --destination "$UUID"
        eject "$backup"
        return 0
    else
        return 1
    fi
}

# backup to black SSD disk
backup-then-eject Kotz-TM-SSD-black 1E4862C4-197B-4854-AE0E-79793A173D9F
black=$?

# backup to blue SSD disk
backup-then-eject Kotz-TM-SSD-blue FB2E7472-CF6D-430F-9510-75B51F233DDB
blue=$?

if (( $black == 0 || $blue == 0 )); then
    echo at least one backup succeeded
    exit 0
else
    echo NO BACKUP DRIVES FOUND
    exit 1
fi
