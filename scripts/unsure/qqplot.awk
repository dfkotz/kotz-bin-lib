# From Graphical Methods for Data Analysis, p. 55

# First record has n and m
#  (Because of this we must look at think about NR-1 as NR from now on)
NR == 1 {
	   n = $1; m = $2;
	   nm = n/m;
	   i=1; findvjt();
}

# First of the two records we need
NR - 1 == j { 
	   if (t==0) {
	   		 print $1;
	   		 i++; findvjt();
	   		 next;
	   } else {
	   		 xj=$1
	   }
}

# Second of the two records we need
NR - 1 == j+1 { 
	   if (t==0) { print "BUG",NR,i,j,v,t; exit}
	   print (1-t)*xj + t*$1;
	   i++; findvjt();
}

# Compute the values of v, j, and t from a given i
func findvjt() {
	   v = int(nm*(i-.5)+.5);
	   j = int(v);
	   t = v-j;
	   return;
}
