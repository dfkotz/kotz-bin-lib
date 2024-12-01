#!/bin/sh
# print a summary of the photos listed in args
exiftool -s -Model -ExposureTime -Aperture -ISO -Caption-Abstract "$@"
