#!/usr/bin/env bash
# This script is run daily by launchd
# see ~/lib/laptop/org.davidkotz.daily-biblio.plist

cd

# SCRIPTS, LIB, CRONTABS
# pull updates into lib and scripts once a day
(cd projects/kotz-bin-lib && git pull --quiet) |& cron-errors kotz-bin-lib

# BIBLIO
# update Mendeley bibliographies, every day
(cd projects/bib-kotzgroup    &&    bib-mendeley/bin/cron.sh bib-mendeley/group/kotzgroup kotzgroup.bib) |& cron-errors bib-kotzgroup
# update Zotero bibliographies, every day
(cd projects/auracle-docs/bib && ./cron.sh) |& cron-errors auracle-docs/bib
#(cd projects/amulet-docs/bib && ./cron.sh) |& cron-errors amulet-docs/bib
(cd projects/splice/bib && ./cron.sh) |& cron-errors splice/bib
(cd projects/crawdad/bib && ./cron.sh) |& cron-errors crawdad/bib
