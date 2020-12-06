#!/usr/local/bin/bash
# This script is run daily by launchd
# see ~/Library/LaunchAgents/org.davidkotz.daily-biblio.plist

cd

# SCRIPTS, LIB, CRONTABS
# pull updates into lib and scripts once a day
(cd projects/kotz-bin-lib && git pull --quiet) |& cron-errors kotz-bin-lib

# BIBLIO
# Kotzgroup, THaW, Amulet, Auracle
# update bibliographies, every day
(cd projects/bib-kotzgroup    &&    bib-mendeley/bin/cron.sh bib-mendeley/group/kotzgroup kotzgroup.bib) |& cron-errors bib-kotzgroup
(cd projects/thaw-papers      &&    bib-mendeley/bin/cron.sh user-thaw.json thaw.bib) |& cron-errors thaw-papers
(cd projects/amulet-docs/web  && ../bib-mendeley/bin/cron.sh user-amulet.json amulet.bib) |& cron-errors amulet-docs
(cd projects/auracle-docs/web && ../bib-mendeley/bin/cron.sh user-auracle.json auracle.bib) |& cron-errors auracle-docs

# LAUNCH AGENT
# Save a copy of the launch agent, in case I get a new computer
plist=org.davidkotz.daily-biblio.plist
( cd lib/iMac; rsync -a ~/Library/LaunchAgents/$plist $plist && git-commit-quietly "daily-biblio plist" $plist)
