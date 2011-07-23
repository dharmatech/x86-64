
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main ( int argc , char * argv[] )
{
    char * data = malloc( 1000 ) ;

    data[0] = '\0' ;
    
    strcat( data , argv[1] ) ;
    strcat( data , argv[2] ) ;

    printf( "%s\n" , data ) ;
    
    return 0 ;
}
