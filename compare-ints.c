
#include <stdio.h>
#include <stdlib.h>

int main ( int argc , char * argv[] )
{
    int a ;
    int b ;
    
    a = atoi( argv[1] ) ;
    b = atoi( argv[2] ) ;

    if ( a > b )
        printf( "greater than\n" ) ;
    else if ( a < b )
        printf ( "less than\n" ) ;
    else
        printf ( "equal\n" ) ;

    return 0 ;
}
