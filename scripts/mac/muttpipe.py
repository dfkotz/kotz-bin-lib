# Demonstration script - not an actual script!
#  I wrote this script to demonstrate how to use a pipe to 'mutt' in python.
# David Kotz 2024

from subprocess import *

# Set up pipe to mutt
subject = "testing a pipe"
email = "andy.lyme@mac.com"
cmd = "mutt -s '%s' '%s'" % (subject, email)
process = Popen(cmd, shell=True, stdin=PIPE)

# pipe the message to mutt (must be a byte string)
process.stdin.write(b"First line of message\n")
process.stdin.write(b"Second line of message\n")
process.stdin.close() # message will send at this point

# wait for process to finish
if process.wait() != 0:
    print("There were errors!")
