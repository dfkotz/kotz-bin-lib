BEGIN{
    subj="something";
    to="BOGUS";
    toaccum = 0;
    cc="BOGUS";
    ccaccum = 0;
    from="BOGUS";
    precedence="normal";
}
{
    if (toaccum > 0) to=to " " $0;
    if ($(NF) !~ /,$/) toaccum=0;
}
{
    if (ccaccum > 0) cc=cc " " $0;
    if ($(NF) !~ /,$/) ccaccum=0;
}
/^Subject: / {subject=substr($0,length("Subject: ")+1)};
/^From / {from=$2}
/^To: / {
    to= to " " substr($0,length("To: ")+1);
    if ($(NF) ~ /,$/) toaccum=1;
}
/^Cc: / {
    cc= cc " " substr($0,length("Cc: ")+1);
    if ($(NF) ~ /,$/) ccaccum=1;
}
/^Date: / {date=substr($0,length("Date: ")+1)}
/^Precedence: / {precedence=substr($0,length("Precedence: ")+1)}
/^$/ {exit}
END {
    # protect any quotes hiding in the strings, so our quoting works
    gsub(/"/, "\\\"", from);
    gsub(/"/, "\\\"", to);
    gsub(/"/, "\\\"", cc);
    gsub(/"/, "\\\"", date);
    gsub(/"/, "\\\"", precedence);
    gsub(/"/, "\\\"", subject);

    print "from=\"" from "\";";
    print "to=\"" to "\";";
    print "cc=\"" cc "\";";
    print "date=\"" date "\";";
    print "precedence=\"" precedence "\";";
    print "subject=\"" subject "\";";
}
