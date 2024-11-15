#include <stdio.h>
int f(char a, int b, char c, long d, char e, short f, int g, int h){
    printf("a: %p\n", &a);
    printf("b: %p\n", &b);
    printf("c: %p\n", &c);
    printf("d: %p\n", &d);
    printf("e: %p\n", &e);
    printf("f: %p\n", &f);
    printf("g: %p\n", &g);
    printf("h: %p\n", &h);
return 0;
}

int main(void){
    return f('1', '2', '3', 4, '5', 6, 7, 8);
}

// a) Realice un diagrama de la pila cuando se esta ejecutando f. Indique en el diagrama la
// ubicacion y el espacio utilizado por cada argumento.
// b) Indique la direccion dentro de la pila en donde esta almacenada la direccion de retorno
// de f y si es posible verifique con GDB. Sugerencia: utilice el comando si, para avanzar de a una
// instruccion