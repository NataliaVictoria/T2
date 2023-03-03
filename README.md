# T2:Programación de E/S en lenguaje ARM

*This repository contains the code corresponding to the practice T2: I/O programming in ARM language.*

---

El resultado de esta práctica es un archivo con código ensamblador ARM para Cortex-M3 que incluye 4 funciones:

1. Función que procesa los elementos de un arreglo 
2. Función de lectura 
3. Función de escritura
4. Función de conversión de código ASCII a números enteros
---

### Función que procesa los elementos de un arreglo

La función `exhaustive_search` toma tres argumentos y devuelve un entero. 

La función realiza una búsqueda exhaustiva en una matriz de enteros para encontrar un valor dado. Si el valor se encuentra, se devuelve el índice de la posición en la matriz donde se encuentra el valor. Si el valor no se encuentra, se devuelve -1.

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
