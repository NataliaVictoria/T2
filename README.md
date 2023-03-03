# T2:Programación de E/S en lenguaje ARM

*This repository contains the code corresponding to the practice T2: I/O programming in ARM language.*

---

El resultado de esta práctica es un archivo con código ensamblador ARM para Cortex-M3 que incluye 4 funciones:

1. Función que procesa los elementos de un arreglo 
2. Función de lectura 
3. Función de escritura
4. Función de conversión de código ASCII a números enteros
---

### Función Original (main y exhaustive search)

La función `**`main`** empezara` alamcenando 5 elementos del arreglo para despues entrar a un ciclo for donde dentro de este for va a leer cada uno de los valores por lo que entrara a **`read_user_input`** para despues ese valor sea guardado en el arreglo (siguiendo las convenciones del arreglo en ensamblador), despues de salir de ese for se inicializara los valor **`key`** y **`res`** para que luego llame la funcion **`exhaustive_search`**, en dodnde guardaremos nuestros argumentos que necesitemos (key, 10 y a) donde key es el numero que buscaremos, al final guardaremos nuestro resultado de la funcion en **`index`** para que sea comparado con el if y si entra al if este cambiara el valor de res para ver si se encontro el numero o no, despues de salir se entrara poco despues a la funcion **`int_to_string`** para tranformarnumeros enteros a un String y despues de terminar esa funcion usaremos el **`display`** para que imprima y cuando termine de imprimir comenzara el epilogo para terminar el programa.

La función **`exhaustive_search`** despues de iniciar el prologo empezar con guardando cada argumento que llamo (**`*a,size y key`**) para despues inicializar el index (con valor 9999 para evitar usar numeros negativos) y lo guardara para que luego entre a un bulbe for dentro de ese bucle for estara un if donde se hara una comparativa con el key y el arreglo de a donde siguiendo las convenciones correspondiente (convencione del arreglo y el if) veremos si key y el valor del arreglo a no sean iguales en caso que sean iguales no entreara al if y volvera a iniciar el ciclo for hasta que se cumpla la condicion pero encaso contrario cargara el

### Función de lectura

La función `read_user_input`, es una función de sistema que lee una cadena de entrada desde la consola y la devuelve como una cadena de caracteres. La función utiliza una llamada al sistema (syscall) para leer la entrada del usuario. El valor

### Función de conversión de código ASCII a números enteros

La función **`my_atoi`** convierte una cadena de caracteres en un número entero. Toma un argumento de entrada que es un puntero a la cadena de caracteres y devuelve el valor entero correspondiente. La implementación utiliza un bucle para leer los caracteres de la cadena y calcular el valor entero correspondiente.

Por último la función **`main`** es el punto de entrada de la aplicación. Llama a **`read_user_input`** para leer un número entero del usuario y luego llama a **`exhaustive_search`** para buscar ese número en la matriz. Finalmente, la función **`main`** imprime el resultado en la salida estándar.


# Compilación

Para poder compilar nuestro código necesitaremos seguir los siguientes pasos: 

- Primero pasaremos nuestro código en C a ensamblador con el siguiente comando

```nasm
arm-gcc ExhaustiveSearch.c -S -march=armv7-m -mtune=cortex-m3.
```

- Una vez modificado nuestro código en lenguaje ensamblador, tendremos que traducirlo a código objeto, esto con el fin de que nuestro compilador.

```nasm
arm-as ExhaustiveSearch.s -o ExhaustiveSeach.o
```

- Después enlazaremos nuestro código objeto con la biblioteca estándar; esto con el fin de que la función **`main`** pueda ejecutarse (la parte del comando s**tatic**  se encarga de que nuestro archivo no se enlace con bibliotecas estándar).

```nasm
arm-gcc ./ExhaustiveSeach.o -o ./ExhaustiveSeach.elf -static
```

- Por ultimo ejecutaremos nuestro programa, que ya se encuentra en formato .elf (Formato Ejecutable y Vinculable) con ayuda del siguiente comando:

```nasm
arm-run ./ExhaustiveSeach.elf
```
