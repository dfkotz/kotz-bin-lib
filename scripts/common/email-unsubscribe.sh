#!/bin/csh -f
# find all the unsubscribe URLs in message headers;
# commandline is a list of files with email messages as content

set mailto=/tmp/dfk-unsub$$

# some appear as mailto: links
grep -h ^List-Unsubscribe $argv:q | grep -v http: | grep mailto: | sort -u | sed -e 's/.*mailto:/mailto:/' -e 's/http.*//' -e 's/>$//' -e 's/>,$//' -e 's/$/'\'/  > $mailto

if (! -z $mailto) then
    # some do not have a subject, and are easier:
    grep -v \? $mailto|  sed -e 's/mailto:/mail -s unsubscribe '\'/  -e 's|$| </dev/null|' | sh -v

    # some have a subject and need to be parsed:
    grep \? $mailto |  sed -e 's/mailto:/mail '\'/ -e 's/?subject=/'\'" -s "\'/ -e 's|$| </dev/null|' | sh -v
endif

rm -f $mailto

echo
echo " ----- start of http list; copy this into clipboard and paste into mac window -----"
echo

# copy the commands into the clipboard
grep -h ^List-Unsubscribe $argv:q | grep http: | sort -u | sed -e 's/.*http/open '\'http/ -e 's/>$//' -e 's/>,$//' -e 's/$/'\'/

echo
echo " ----- end of http list -----"
echo
