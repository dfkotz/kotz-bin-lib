# awk script
#
# Input: two files, each with a list of pathnames
# Output: a list of pathnames from the 'source' 
#   that are not found in the 'destination', 
#   based only on comparing the path's basename.
#
# usage:
#  gawk -f comm.awk -v DEST=destPathnames srcPathnames
# where the *Pathnames files each have one pathname per line
# 

function basename(pathname) {
    # extract the filename
    filename = pathname;
    sub(/.*\//, "", filename);
    return filename;
}

# start by loading the destPathnames into an array
BEGIN {
    while (getline < DEST) {
	pathname = $0;
	filename = basename(pathname);
	dest[filename] = pathname;
    }
}

# the following loops over lines of the srcPathnames
{
    # the pathname
    pathname = $0;
    filename = basename(pathname);

    if (filename in dest) {
	# this file already exists in the destination; do nothing
	; 
    } else {
	# this filename does not exist in destination, print the pathname
	print pathname;
    }
}
