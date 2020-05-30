# boxplot2.awk: parse the sorted box plot info, to form the 
#  linefile, pointfile, and the 'set ytics' line.
#
# we output directly to linefile and pointfile, and output the ytics
# line to stdout.

# lines are of the form
#  filename min lower-fourth median upper-fourth max
# and are sorted by increasing median.

BEGIN {count = 0}

{
    	   count++;

    	   name=$1;
    	   min=$2;
	   lowf=$3;
	   median=$4;
	   highf=$5;
	   max=$6;

	   print median, count > "pointfile"

        print min, count > "linefile"
	   print lowf, count > "linefile"
    	   print "" > "linefile"

	   print highf, count > "linefile"
	   print max, count > "linefile"
	   print "" > "linefile"

        if (count == 1)
    	   	  printf "set ytics(\"%s\" %d", name, count;
    	   else
    	   	  printf ",\"%s\" %d", name, count;
}

END { printf ")\n" }
