#include <stdio.h>

#include <string.h>
#include <stdlib.h>

long long num[200];

int
add(int a, int b)
{
   return a + b;

}
int
dothething(int n )
{
  if (num[n] != -1)
  {
     return num[n];
  }
   if (n==0)
     {
       num[n] = 0;
     }  
    else if (n==1)
     { 
       num[n] = 1;
     }
    else
    {
      num[n] = add(dothething(n-1),dothething(n-2));
    }
return num[n];

}

int
main(int argc, char* argv[])
{

  int n = atoi(argv[1]); 
  
   
  int i = 0;
  while (i <= 199)
  {
    num[i] = -1;
    i++;
  }
  printf("Value: %d\n",dothething(n));


  return(0);
}



