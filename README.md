# T2:Programación de E/S en lenguaje ARM

*This repository contains the code corresponding to the practice T2: I/O programming in ARM language.*

---

El resultado de esta práctica es un archivo con código ensamblador ARM para Cortex-M3 que incluye 4 funciones:

1. Función que procesa los elementos de un arreglo 
2. Función de lectura 
3. Función de escritura
4. Función de conversión de código ASCII a números enteros
---
# Funcionamiento del código

### Explicación breve

La función implementada es **`exhaustive_search`** esta función toma tres argumentos y devuelve un entero. 

La función realiza una búsqueda exhaustiva en una matriz de enteros para encontrar un valor dado (en este caso el valor llave es 10). Si el valor se encuentra, se devuelve el índice de la posición en la matriz donde se encuentra el valor. Si el valor no se encuentra, se devuelve el código 9999.

### Explicación detallada (main y exhaustive search)

La función **`main`** empieza almacenando 5 elementos del arreglo para después entrar a un ciclo for donde dentro de este for lee cada uno de los valores. Una vez hecho esto entra a la función **`read_user_input`** y guardar el valor en el arreglo (siguiendo las convenciones del arreglo en ensamblador)
Posterior al salir del ciclo for se inicializan los valores **`key`** y **`res`**.
Seguidamente, llama a la función **`exhaustive_search`** que guardan los argumentos que necesarios (key, 10 y a). Donde key es el número que a buscar.

Al final se guarda el resultado de la función en **`index`** para que sea comparado con el if, si entra al if este cambia el valor de **`res`** para ver si se encontró el número o no. 
Una vez salga del if entra a la función **`int_to_string **` para transformar los números enteros a un String al salir de dicha función se hace uso de  **`display`** que imprime el resultado. Cuando termine de imprimir comienza con el epílogo para terminar el programa.

La función **`exhaustive_search`** primero inicia el prólogo, una vez hecho empieza con guardando cada argumento que llamo (**`*a,size y key`**) para después inicializar y guardar el índex (con valor 9999 para evitar utilizar números negativos). 

Posteriormente, entra a un bucle for, dentro del bucle for hay un if donde se hace una comparativa con el key y el arreglo. En donde, siguiendo las convenciones correspondiente (convenciones del arreglo y el if) buscar que **`key**` y el valor del arreglo no sean iguales. En caso de que sean iguales no entra al if y vuelve a iniciar el ciclo for hasta que se cumpla la condición.
En caso contrario, carga el valor de i (es decir la posición del arreglo) en **`índex**` y saldrá inmediatamente de la estructura if y for, debido a que hay un break.
Siendo este el caso inmediatamente hará un return con *`índex**` como el valor que regresa la función. Después de guardar el *`índex**` se realiza el epílogo para darle fin a la función.

### Función de lectura

La función `read_user_input`, es una función de sistema que lee una cadena de entrada desde la consola y la devuelve como una cadena de caracteres. La función utiliza una llamada al sistema (syscall) para leer la entrada del usuario. El valor

### Función de conversión de código ASCII a números enteros

La función **`my_atoi`** convierte una cadena de caracteres en un número entero. Toma un argumento de entrada que es un puntero a la cadena de caracteres y devuelve el valor entero correspondiente. La implementación utiliza un bucle para leer los caracteres de la cadena y calcular el valor entero correspondiente.



# Compilación

Para poder compilar el código es necesario seguir los siguientes pasos: 

- Primero pasar el código en C que contiene la función ExhaustiveSearch a ensamblador con el siguiente comando

```nasm
arm-gcc ExhaustiveSearch.c -S -march=armv7-m -mtune=cortex-m3.
```

- Una vez modificado el código en lenguaje ensamblador, es necesario traducirlo a código objeto, esto con el fin de que nuestro compilador.

```nasm
arm-as ExhaustiveSearch.s -o ExhaustiveSeach.o
```

- Después se enlaza el código objeto con la biblioteca estándar. Esto con el fin de que la función **`main`** pueda ejecutarse (la parte del comando **`static`**  se encarga de que el archivo no se enlace con bibliotecas estándar).

```nasm
arm-gcc ./ExhaustiveSeach.o -o ./ExhaustiveSeach.elf -static
```

- Por último, se ejecuta programa, que ya se encuentra en formato .elf (Formato Ejecutable y Vinculable) con ayuda del siguiente comando:

```nasm
arm-run ./ExhaustiveSeach.elf
```
# Marcos de función

Para crear los marcos de función se han tenido las siguientes consideraciones:

- El marco se crea en múltiplos de 8
- La pila crece hacia arriba
- Se sigue el orden del esquema:
![image](https://user-images.githubusercontent.com/89500688/222765755-37732b08-ef45-4505-9fa4-a2eb330792d9.png)

### display
![image](https://user-images.githubusercontent.com/89500688/222765835-6a1028ff-b5c9-4d11-8a46-edb47a7273ed.png)

### int_to_string
![image](https://user-images.githubusercontent.com/89500688/222765967-a6e268a9-151d-4d45-adfe-5d3368c42d8b.png)

### my_atoy
![image](https://user-images.githubusercontent.com/89500688/222766035-ff4db5c9-7df0-4291-8d8b-047cd0c46470.png)

### read_user_Imput
