//Compilation time is 1.96 seconds for prime numbers upto 1 million

#include <iostream> 
#include <cstdio>
#include <fstream>
#include <cmath>
#include <time.h>

int main()
{
     clock_t tStart = clock();
     int max;
     std::cout<<" What is the upper range ? : "; // range in which to generate prime numbers
     std::cin>>max;

     for (int n=2; n<max; n++) 
     {
          int flag = 0;
          // checks a numbers is prime or not
          for (int i=2; i<= sqrt(n); i++)
               if ( n%i == 0 )
               {
                    flag = 1;
                    break;
               }
               if ( flag == 0 )
               {
                    std::cout<<" "<<n;
               }
     }
     printf("Time: %.2fs\n", (double)(clock() - tStart)/CLOCKS_PER_SEC);
     return 0;
} 
