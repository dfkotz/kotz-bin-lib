#!/bin/bash
# This script is run daily by launchd
# see ~/lib/laptop/org.davidkotz.daily-email.plist

cd

DAVE=dfkotz@mac.com
PAM=pcjenkins@mac.com
JOHN=john.lyme@mac.com
MARA=mara.lyme@mac.com
ANDY=andy.lyme@mac.com
DAD=johnkotz@mac.com
MOM=katiekotz@icloud.com
AMY=aejenkins1263@gmail.com
ISABEL=isabel_eich@hotmail.com
DOE=doe.jenkins@gmail.com

# COMICS
# send the daily comic strips
comic-arcamax doonesbury $DAVE  $DAD $MOM
comic-arcamax babyblues  $DAVE
comic-fbfw               $DAVE

# flush the sendmail queue
# pause briefly so the comics stay grouped within inbox
postqueue -f >& /dev/null
sleep 5

# CALENDAR
# send the Kotz daily calendar
daily-calendar -- $DAVE $ANDY $PAM $MARA $JOHN $DAD $MOM $AMY $ISABEL $DOE

# flush the sendmail queue
# pause briefly to ensure queue is drained before system sleeps
postqueue -f >& /dev/null
sleep 5

# date | mutt -s "stuffing the mail queue" dfkotz@mac.com
