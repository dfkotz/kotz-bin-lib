#!/bin/sh
# This script is run daily by launchd

DAVE=dfkotz@mac.com
PAM=pcjenkins@mac.com
JOHN=john.lyme@mac.com
MARA=mara.lyme@mac.com
ANDY=andy.lyme@mac.com
ISABEL=isabel_eich@hotmail.com
DAD=johnkotz@mac.com
MOM=katiekotz@icloud.com
AMY=aejenkins1263@gmail.com
KIDS=john.lyme@mac.com mara.lyme@mac.com andy.lyme@mac.com

# COMICS
# send me the daily comic strips (timed for morning delivery)
comic-arcamax doonesbury $DAVE  $DAD $MOM
comic-arcamax babyblues  $DAVE
comic-fbfw               $DAVE

# CALENDAR
# send the Kotz daily calendar
daily-calendar $DAVE
daily-calendar $ANDY
daily-calendar $PAM
daily-calendar $DAD $MOM
daily-calendar $AMY
daily-calendar $MARA
daily-calendar $ISABEL
daily-calendar $JOHN