#!/usr/local/bin/bash
# This script is run daily by launchd
# see ~/Library/LaunchAgents/org.davidkotz.daily-biblio.plist

cd

# SCRIPTS, LIB, CRONTABS
# pull updates into lib and scripts once a day
(cd projects/kotz-bin-lib && git pull --quiet) |& cron-errors kotz-bin-lib

# BIBLIO
# update Mendeley bibliographies, every day
(cd projects/bib-kotzgroup    &&    bib-mendeley/bin/cron.sh bib-mendeley/group/kotzgroup kotzgroup.bib) |& cron-errors bib-kotzgroup
# update Zotero bibliographies, every day
(cd projects/auracle-docs/bib && ./cron.sh) |& cron-errors auracle-docs
