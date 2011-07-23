
#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main ( int argc , char * argv[] )
{
    double a ;
    double b ;
    double c ;

    a = atof( argv[1] ) ;
    
    sincos( a , &b , &c ) ;

    printf( "%f %f\n" , b , c ) ;
    
    return 0 ;
}
