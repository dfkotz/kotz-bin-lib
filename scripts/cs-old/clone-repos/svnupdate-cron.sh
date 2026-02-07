#!/usr/bin/env bash

cd "/net/kotz/projects-no-backup/clone-repos-svn" || exit 1
projects=$(ls -d */)

for project in $projects ; do
    ( svn update  --quiet --non-interactive $project ) || echo $project failed
done
