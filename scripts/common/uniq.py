#!/usr/bin/env python3
#
# print a list of unique lines seen on stdin.
# (like 'uniq' but does not require input to be sorted)
#
# 2020 David Kotz kotz@dartmouth.edu

import sys

uniq = set()
for line in sys.stdin:
    uniq.add(line)

for line in sorted(uniq):
    print(line, end='')
