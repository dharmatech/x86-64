
int main ( int argc , char * argv[] )
{
    double a ;
    double b ;
    double c ;

    a = atof( argv[1] ) ;
    b = atof( argv[2] ) ;

    c = a + b ;

    printf( "%f\n" , c ) ;
    
    return 0 ;
}
