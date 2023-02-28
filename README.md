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
![image](https://user-images.githubusercontent.com/126529855/221741104-b8050d95-04bf-4432-8d1e-160035e770de.png)

### Función de lectura

La función `read_user_input`, es una función de sistema que lee una cadena de entrada desde la consola y la devuelve como una cadena de caracteres. La función utiliza una llamada al sistema (syscall) para leer la entrada del usuario. El valor

### Función de conversión de código ASCII a números enteros

La función **`my_atoi`** convierte una cadena de caracteres en un número entero. Toma un argumento de entrada que es un puntero a la cadena de caracteres y devuelve el valor entero correspondiente. La implementación utiliza un bucle para leer los caracteres de la cadena y calcular el valor entero correspondiente.

Por último la función **`main`** es el punto de entrada de la aplicación. Llama a **`read_user_input`** para leer un número entero del usuario y luego llama a **`exhaustive_search`** para buscar ese número en la matriz. Finalmente, la función **`main`** imprime el resultado en la salida estándar.
