#!/bin/bash
#
# tm-backup - a script to run a Time Machine backup of my laptop.
# Need to know the name of the backup drive and UUID of its backup;
# find them with `tmutil destinationinfo`

# return 0 (true) if the named backup ($1) is mounted
function is-mounted() {
    name="$1"
    echo "looking for $name"
    if [ -d "/Volumes/$name/.Spotlight-V100/" ]; then
        return 0
    else
        return 1
    fi
}

# Wait for one drive to be mounted; give up after fifteen minutes
for try in {1..30};
do
    name=Kotz-TM-SSD-blue
    UUID=05B61232-31F8-4C54-A30F-D52BCA928A04
    is-mounted "$name" && break

    name=Kotz-TM-SSD-red
    UUID=11A41812-2D47-489F-A6E2-B06138520EB1
    is-mounted "$name" && break

    name=Kotz-TM-SSD-black
    UUID=596A9425-4CBD-48CF-A090-5B868B9983F2
    is-mounted "$name" && break

    name=
    UUID=
    sleep 30
done

if [ "$UUID" == "" ]; then
    echo BACKUP NOT FOUND
    terminal-notifier -title "daily-backup" -sound Basso -message "backup NOT FOUND"
    exit 2
fi

# backup to that disk
echo "backing up to $name..."
if tmutil startbackup --block --destination "$UUID"; then
    eject "$name"
    echo backup succeeded
    terminal-notifier -title "daily-backup" -sound Hero -message "backup succeeded"
    exit 0
else
    eject "$name"
    echo BACKUP FAILED
    terminal-notifier -title "daily-backup" -sound Basso -message "backup FAILED"
    exit 1
fi
