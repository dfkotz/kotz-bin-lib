# checkfiles.awk  - companion to checkfiles bash script

# caller should set variables on command line:
#  warning=1 (to print warnings as well as errors)
#  linux=1 (to print Linux-related messages)
#  macos=1 (to print MacOS-related messages)
#  windows=1 (to print Windows-related messages)
#  onedrive=1 (to print OneDrive-related messages)
#  google=1 (to print GoogleDrive-related messages)
#  dropbox=1 (to print Dropbox-related messages)
#  dartfs=1 (to print DartFS-related messages)

# some information here: https://en.wikipedia.org/wiki/Filename#Reserved_characters_and_words

BEGIN {
    # count the number of errors we encounter
    errors = 0;
}

####################################################
function warn(mesg) {
    if (warning)
	print mesg ": '" pathname "'";
}

function error(mesg) {
    print mesg ": '" pathname "'";
    errors++;
}

####################################################
# save the full pathname
{ pathname = $0 }
# but focus most pattern matching on the basename, not the full path
{ sub(/.*\//, "") }

####################################################
# generic warnings
/[^\x00-\x7F]/ { warn("non-ASCII characters can cause trouble on any platform") }
/\\/           { warn("backslashes can cause trouble for many systems") }

#########################################################
# Linux warnings
linux && /[[:space:]]/ { warn("Linux shell may be confused by whitespace") }
linux && /[][(){}<>]/ { warn("Linux shell may be confused by bracket characters") }
linux && /[`'"]/ { warn("Linux shell may be confused by quotation marks") }
linux && /[;#|?*!&]/ { warn("Linux shell may be confused by certain punctuation chars") }
linux && /^~/ { warn("Linux shell may be confused by leading tilde character") }
linux && /^$/ { warn("Linux shell may be confused by leading dollar-sign") }

#########################################################
# MacOS warnings
macos && /:/ { warn("MacOS may not like colon") }

#########################################################
# Windows errors
windows && /[<>"|?*]/ { error("Windows sees certain punctuation as illegal") }
windows && /:/ { error("Windows sees colon as illegal") }

#########################################################
# Google errors - none? 
# Google warnings - none?

#########################################################
# Dropbox - https://www.dropbox.com/help/syncing-uploads/files-not-syncing
# Dropbox errors
dropbox && /^desktop.ini$/ { error("Dropbox will not sync this file") }
dropbox && /^thumbs.db$/ { error("Dropbox will not sync this file") }
dropbox && /^.ds_store$/ { error("Dropbox will not sync this file") }
dropbox && /^icon\r$/ { error("Dropbox will not sync this file") }
dropbox && /^.dropbox$/ { error("Dropbox will not sync this file") }
dropbox && /^.dropbox.attr$/ { error("Dropbox will not sync this file") }

dropbox && (length(pathname) > 260) { error("Dropbox limits pathnames to 260 characters") }
dropbox && /?\.$/ { error("Dropbox may not sync files whose name ends in a period") }

# Dropbox warnings
dropbox && /^~\$/ { warn("Dropbox will not sync files whose name starts with ~$") }
dropbox && /^.~/ { warn("Dropbox will not sync files whose name starts with .~") }
dropbox && /^~/ && /\.tmp$/ { warn("Dropbox will not sync files whose name starts with ~ and ends with .tmp") }

# Dropbox: Avoid syncing files that use metadata (or resource forks), including Mac aliases.
# (no easy way to check for this, here)

# Dropbox: Avoid syncing files that are symlinks.
# (no easy way to check for this, here)

#########################################################
# OneDrive: https://support.office.com/en-us/article/invalid-file-names-and-file-types-in-onedrive-onedrive-for-business-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa
# OneDrive errors
onedrive && /[:]/ { error("OneDrive will not sync files with colon character") }
onedrive && /["*<>?\\|]/ { error("OneDrive will not sync files with this character") }
onedrive && /^\.lock$/ { error("OneDrive will not sync file with this name") }
onedrive && /^CON$/ { error("OneDrive will not sync file with this name") }
onedrive && /^PRN$/ { error("OneDrive will not sync file with this name") }
onedrive && /^AUX$/ { error("OneDrive will not sync file with this name") }
onedrive && /^NUL$/ { error("OneDrive will not sync file with this name") }
onedrive && /^COM[1-9]$/ { error("OneDrive will not sync file with this name") }
onedrive && /^LPT[1-9]$/ { error("OneDrive will not sync file with this name") }
onedrive && /^desktop.ini$/ { error("OneDrive will not sync file with this name") }
onedrive && /^~\$/ { warn("OneDrive will not sync files whose name starts with ~$") }
onedrive && /_vti_/ { error("OneDrive will not sync file with this name") }
onedrive && pathname ~/^forms/ { error("OneDrive will not sync file with this name") }
onedrive && /^~/ { error("OneDrive will not sync folder with this name") }
onedrive && (length(pathname) > 400) { error("OneDrive will not allow pathname this long") }

# OneDrive filesize is limited to 15GB
# (no easy way to check for this, here)

# OneDrive warnings
# (none)

#########################################################
# DartFS has several limitations:
# https://services.dartmouth.edu/TDClient/KB/ArticleDet?ID=70649

dartfs && /[<>"/|\?\*]/ { error("DartFS disallows certain punctuation") }
dartfs && /[\\]/ { error("DartFS disallows backslash in filenames") }
dartfs && /:/ { error("DartFS disallows colon in filenames") }
dartfs && /[\x00-\x1F]/ { warn("DartFS disallows control chars in filenames") }

# convert the filename to lower-case so remaining matches are case-insensitive
{ $0 = tolower($0) }
dartfs && (/\.0x0$/ \
      ||   /\.1999$/ \
      ||   /\.ctb2$/ \
      ||   /\.ctbl$/ \
      ||   /\.enciphered$/ \
      ||   /\.ha3$/ \
      ||   /\.lol! $/ \
      ||   /\.lechiffre$/ \
      ||   /\.omg!$/ \
      ||   /\.r16m01d05$/ \
      ||   /\.rdm$/ \
      ||   /\.rrk$/ \
      ||   /\.supercrypt$/ \
      ||   /\.xrnt$/ \
      ||   /\.xtbl$/ \
      ||   /\._crypt$/ \
      ||   /\.aaa$/ \
      ||   /\.abc$/ \
      ||   /\.bleep$/ \
      ||   /\.ccc$/ \
      ||   /\.crinf$/ \
      ||   /\.crjoker$/ \
      ||   /\.crypt$/ \
      ||   /\.crypto$/ \
      ||   /\.ecc$/ \
      ||   /\.encrypted$/ \
      ||   /\.encryptedrsa$/ \
      ||   /\.exx$/ \
      ||   /\.ezz$/ \
      ||   /\.good$/ \
      ||   /\.keybtc@inbox_com$/ \
      ||   /\.locked$/ \
      ||   /\.locky$/ \
      ||   /\.magic$/ \
      ||   /\.micro$/ \
      ||   /\.pzdc$/ \
      ||   /\.r5a$/ \
      ||   /\.toxcrypt$/ \
      ||   /\.ttt$/ \
      ||   /\.vault$/ \
      ||   /\.vvv$/ \
      ||   /\.xxx$/ \
      ||   /\.xyz$/ \
      ||   /\.zzz$/ \
    ) { error("DartFS disallows filename with this extension") }

#########################################################
# exit with status reporting the number of errors
END {
    exit(errors);
}
