#!/bin/bash
#
# tm-backup - a script to run a Time Machine backup of my laptop.
# Need to know the name of the backup drive and UUID of its backup;
# find them with `tmutil destinationinfo`

# return 0 (true) if the named backup ($1) is mounted
function is-mounted() {
    name="$1"
    echo "looking for $name"
    if [ -d "/Volumes/$name/Backups.backupdb" ]; then
        return 0
    else
        return 1
    fi
}

# Wait for one drive to be mounted; give up after fifteen minutes
for try in {1..30};
do
    name=Kotz-TM-SSD-black
    UUID=596A9425-4CBD-48CF-A090-5B868B9983F2
    is-mounted "$name" && break

    name=Kotz-TM-SSD-blue
    UUID=FB2E7472-CF6D-430F-9510-75B51F233DDB
    is-mounted "$name" && break

    name=
    UUID=
    sleep 30
done

if [ "$UUID" == "" ]; then
    echo BACKUP NOT FOUND
    exit 2
fi

# backup to that disk
echo "backing up to $name..."
if tmutil startbackup --block --destination "$UUID"; then
    eject "$name"
    echo backup succeeded
    exit 0
else
    eject "$name"
    echo BACKUP FAILED
    exit 1
fi
