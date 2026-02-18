#!/bin/csh -f
# find all the unsubscribe URLs in message headers;
# usage:
#   email-unsubscribe.sh file.eml...
# For those messages that allow unsubscribe by email, it will only work for
# subscriptions by dfkotz@mac.com (because the unsubscribe message will come
# from that address).
#
# For those messages that provide a List-Unsubscribe URL, they must be pasted
# into a browser.

set mailto=/tmp/dfk-unsub$$

# some appear as mailto: links
cat  $argv:q | tr \\r \\n | grep -h ^List-Unsubscribe | grep -v http: | grep mailto: | sort -u | sed -e 's/.*mailto:/mailto:/' -e 's/http.*//' -e 's/>$//' -e 's/>,$//' -e 's/$/'\'/  > $mailto

if (! -z $mailto) then
    # some do not have a subject, and are easier:
    grep -v \? $mailto|  sed -e 's/mailto:/mutt -s unsubscribe '\'/  -e 's|$| </dev/null|' | sh -v

    # some have a subject and need to be parsed:
    grep \? $mailto |  sed -e 's/mailto:/mutt '\'/ -e 's/?subject=/'\'" -s "\'/ -e 's|$| </dev/null|' | sh -v
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
