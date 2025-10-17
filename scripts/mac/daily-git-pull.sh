#!/usr/bin/env bash
# This script is run daily by launchd
# see ~/lib/laptop/org.davidkotz.daily-git-pull.plist

cd ~/projects/kotz-bin-lib && git pull -q
