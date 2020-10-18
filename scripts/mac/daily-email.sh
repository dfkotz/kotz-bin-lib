#!/bin/sh
# This script is run daily by launchd
# see ~/Library/LaunchAgents/org.davidkotz.daily-email.plist
cd

DAVE=dfkotz@mac.com
PAM=pcjenkins@mac.com
JOHN=john.lyme@mac.com
MARA=mara.lyme@mac.com
ANDY=andy.lyme@mac.com
ISABEL=isabel_eich@hotmail.com
DAD=johnkotz@mac.com
MOM=katiekotz@icloud.com
AMY=aejenkins1263@gmail.com
KIDS="$JOHN $MARA $ANDY"

# COMICS
# send me the daily comic strips (timed for morning delivery)
comic-arcamax doonesbury $DAVE  $DAD $MOM
comic-arcamax babyblues  $DAVE
comic-fbfw               $DAVE

# CALENDAR
# send the Kotz daily calendar
daily-calendar $DAVE $ANDY $PAM $MARA $JOHN $DAD $MOM $AMY $ISABEL

# Save a copy of the launch agent, in case I get a new laptop
plist=org.davidkotz.daily-email.plist
(cd ~/lib/mac && rsync -a ~/Library/LaunchAgents/$plist $plist && git-commit-quietly "daily-email plist" $plist)
