#!/usr/bin/env bash
# track all the branches in all the repos, so future gitpull will update all branches.

cd "/net/kotz/projects-no-backup/clone-repos-github" || exit 1
projects=$(ls -d */)

for project in $projects ; do
    ( cd $project \
	&& git branch -r | grep -v '\->' | \
	    while read remote; do
		git branch --track "${remote#origin/}" "$remote";
	    done
    ) |& grep -v 'fatal: A branch named .* already exists.' \
	&& echo preceding messages from $project \
	&& echo ""
done
