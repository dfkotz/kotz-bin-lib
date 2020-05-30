#!/bin/bash
#
# list all the large files in a git history
#
# from raphinesse at https://stackoverflow.com/questions/10622179/how-to-find-identify-large-commits-in-git-history
# which also has more detail and more variants, like:
# to show only files exceeding given size (e.g. 1 MiB = 220 B), 
# insert the following line:
# | awk '$2 >= 2^20' \

git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 \
| cut -c 1-12,41- \
| $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
