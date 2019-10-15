#include <stdio.h>
#include "nCr.h"
#include <stdlib.h>
#include <sys/time.h>
#include <string.h>
#include <ctype.h>
#include "formula.h"

typedef char byte;

int 
main(int argc, char* argv[])
{
  
  if(  
      !isdigit(*argv[1]) || atoi(argv[1]) < 0)
  {
    printf("Usage: formula <positive integer>\n");
    return 0;
  }
 
  struct timeval begin, end;
  double dtime;
  gettimeofday(&begin,NULL);

  byte power = atoi(argv[1]);
  Term* terms = calloc(power,sizeof(Term));
 
  int i = 0; 
  for (;i <= power;i++)
  {
    terms[i].coefficient = nCr(power,i);
    terms[i].variable = 'x';
    terms[i].exponent = i;
    printf("%d*%c^%d ",
          terms[i].coefficient,
          terms[i].variable,
          terms[i].exponent);
    if (i != power){ printf("+ ");}
  }
  printf("\n");
  gettimeofday(&end,NULL);
  dtime = (double)(end.tv_usec - begin.tv_usec);

  printf("Time: %.0f microsecond\n",dtime);

  return 0;
}
   
