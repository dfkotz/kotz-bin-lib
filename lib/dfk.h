/* @TITLE "dfk.h: David Kotz standard definitions */
/* 
 * Some things I often use in programs. 
 * David Kotz
 */

/* Some convenient macros */
#define Bernoulli(p)    (((random() % 100 + 1) <= p) ? 1 : 0)
#define AVG(x,n)	    ((n) ? (float)(x) / (float)(n) : 0.0)
#define PCT(a,b)	    (AVG(a,b) * 100.)
#define max(x,y) ((x) > (y) ? (x) : (y))
#define min(x,y) ((x) < (y) ? (x) : (y))
#define two(x) (1 << (x)) 				/* 2^x */
#define sign(x) ( (x)==0 ? 0 : ( (x)<0 ? -1 : 1) )	/* sign of number */
#define CTRL(x) ((x) & 0100)	/* a control character for x */
#define CoreDump() 	/* cause a core dump (b=a shuts up lint) */	\
   { int a=1, b=0; fprintf(stderr, "\nCore Dumped\n"); a/=b; b=a; }

#define forever while(TRUE)

/* Boolean values */
typedef int boolean;		/* for use with TRUE/FALSE */
#ifndef TRUE
#define TRUE  ((boolean) 1)
#define FALSE ((boolean) 0)
#endif

/* should be defined but aren't */
extern char *malloc();

typedef char *ANYPTR;         /* arbitrary pointer */
