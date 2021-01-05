#!/usr/bin/env bash
# pull updates for each of the projects here
# (sleep a bit between each, because this script sometimes seems to have
#  connectivity problems when I do them in rapid succession.)

# important: run gitpull-track from time to time, to ensure tracking of new branches

cd "/net/kotz/projects-no-backup/clone-repos-github" || exit 1
projects=$(ls -d */)

for project in $projects ; do
    ( cd $project && git pull -q --all ) || echo $project pull failed
    sleep 10
done
