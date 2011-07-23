
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main ( int argc , char * argv[] )
{
    double y ;
    double m ;
    double d ;
    double a ;
    double b ;
    double c ;
    double e ;
    double res ;

    y = atof( argv[1] ) ;
    m = atof( argv[2] ) ;
    d = atof( argv[3] ) ;

    if ( m == 1.0 || m == 2.0 )
    {
        y = y -  1.0 ;
        m = m + 12.0 ;
    }

    if ( ( y*10000 + m*100 + d ) >= ( 1582*10000 + 10*100 + 15 ) )
    {
        a = trunc( y / 100.0 ) ;

        b = 2 - a + trunc( a / 4.0 ) ;
    } else {
        b = 0 ;
    }

    if ( y < 0 )
        c = trunc( 365.25 * y - 0.75 ) ;
    else
        c = trunc( 365.25 * y ) ;

    e = trunc( 30.6001 * (m+1) ) ;

    res = b + c + e + d + 1720994.5 ;

    printf( "%f\n" , res ) ;
    
    return 0 ;
}
