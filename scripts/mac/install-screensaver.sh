#!/bin/bash
#
# install-screensaver: copy a video file (and jpg thumbnail) over top of
# existing MacOS screensaver content, as a hackish way of adding a custom
# screensaver video.  Inspired by:
#   https://github.com/FalconLee1011/Customized-Aerial-Screen-Saver
#
# A better solution would be to install this custom screensaver app:
#   https://aerialscreensaver.github.io
#
# usage:
#   install-screensaver.sh moviefile.jpg moviefile.mov
# This works by over-writing one of the MacOS-provided screensavers, which
# must have been downloaded and installed via Settings/Screensaver beforehand.
# The name of that file is hardcoded here.
#
# David Kotz 2023
#

if (( $# != 2 )); then
    echo "usage: $0 moviefile.jpg moviefile.mov"
    exit 1
fi

# check the source files
jpg="$1"
mov="$2"

if [ ! -r "$jpg" ]; then
    echo "missing jpg file: $jpg"
    exit 2
fi

if [ ! -r "$mov" ]; then
    echo "missing mov file: $mov"
    exit 2
fi

# check the destination files
jpgDest='/Library/Application Support/com.apple.idleassetsd/snapshots/asset-preview-9680B8EB-CE2A-4395-AF41-402801F4D6A6.jpg'

movDest='/Library/Application Support/com.apple.idleassetsd/Customer/4KSDR240FPS/9680B8EB-CE2A-4395-AF41-402801F4D6A6.mov'

if [ ! -f "$jpgDest" ]; then
    echo "missing jpg file at destination; read the instructions"
    exit 3
fi

if [ ! -f "$movDest" ]; then
    echo "missing mov file at destination; read the instructions"
    exit 3
fi

# move the files into place
echo "moving files into place; requires sudo password!"
sudo mv "$jpg" "$jpgDest" || exit 4
sudo mv "$mov" "$movDest" || exit 4
sudo chmod 644 "$jpgDest" "$movDest"

exit 0
