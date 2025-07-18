# usage:
#  awk -f extract-class.awk chubbers | sort -n
{
    line = $0;                   # the whole line
    sub(/.*'/, "", line);        # the line after the single quote
    class = substr(line, 1, 2);  # the first two characters after the quote

    email = $1;                  # email address
    $1 = "";                     # erase email address from $0
    nameAndClass = $0;           # leaving just the name

    if (class !~ /[0-9][0-9]/) { # valid two-digit number?
        class = "????";
    } else if (class < 30) {     # 21st century classes
        class += 2000;
    } else {                     # 20th century classes
        class += 1900
    }        
    print class, nameAndClass, "<" email ">";
}
