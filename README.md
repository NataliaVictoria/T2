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
Una vez salga del if entra a la función **`int_to_string`** para transformar los números enteros a un String al salir de dicha función se hace uso de  **`display`** que imprime el resultado. Cuando termine de imprimir comienza con el epílogo para terminar el programa.

La función **`exhaustive_search`** primero inicia el prólogo, una vez hecho empieza con guardando cada argumento que llamo (**`*a,size y key`**) para después inicializar y guardar el índex (con valor 9999 para evitar utilizar números negativos). 

Posteriormente, entra a un bucle for, dentro del bucle for hay un if donde se hace una comparativa con el key y el arreglo. En donde, siguiendo las convenciones correspondiente (convenciones del arreglo y el if) buscar que **`key`** y el valor del arreglo no sean iguales. En caso de que sean iguales no entra al if y vuelve a iniciar el ciclo for hasta que se cumpla la condición.
En caso contrario, carga el valor de i (es decir, la posición del arreglo) en **`índex`** y saldrá inmediatamente de la estructura if y for, debido a que hay un break.
Siendo este el caso, inmediatamente hará un return con **`índex`** como el valor que regresa la función. Después de guardar el **`índex`** se realiza el epílogo para darle fin a la función.

### Función de lectura

La función `read_user_input`, es una función de sistema que lee una cadena de entrada desde la consola y la devuelve como una cadena de caracteres. La función utiliza una llamada al sistema (syscall) para leer la entrada del usuario. El valor

### Función de conversión de código ASCII a números enteros (**`my_atoi`**)

#Argumentos en la función:#         Un apuntador con la dirección del arreglo
#Variables dentro de la función:#   Contador-> Encargado de obtener el tamaño del string
                                    Estado-> Guarda la posición en la que estamos dentro del string (1 = unidad, 2 = decena, 3 = centena, etc).
                                    Valor actual-> Cadeana de caracteres que contiene los datos en ASCII
                                    Digito-> Encargado de almacenar el valor en decimal obtenido por iteración.
#Descripción de su funcionamiento:# Se inicia con un ciclo **`while`**, encargado, apoyandonos con la variable `contador` la cual alamcena el tamaño del string recibido; su condición de paro es un salto a la línea 0x10.
Una vez hecho esto, retornamos a la posición inicial de nuestro string para procesar cada dígito.
El siguiente paso viene establecido por un segundo ciclo **`while`**

La función **`my_atoi`** convierte una cadena de caracteres en un número entero. Toma un argumento de entrada que es un puntero a la cadena de caracteres y devuelve el valor entero correspondiente. La implementación utiliza un bucle para leer los caracteres de la cadena y calcular el valor entero correspondiente. Inicialmente se obtiene el caracter en ASCII en la posición `n`, dicho caracter pasa a transformarse en un decimal al restarle un 48 (dandonos su valor como entero). Por consiguiente se multiplica por el estado (encargado de decirnos su valor en unidad, decena o centena dependiendo la posición). Y se almacenará en la variable Digito; la cual con cada iteración recibirá un decimal de menor valor hasta llegar a 0.
Ejemplo: 934 -> ASCII   Iteraciones a realizar =  Estado = 3
  Iteración 1:  Digito = Digito + 900   ->    900
  Iteración 2:  Digito = Digito + 30    ->    930
  Iteración 3:  Digito = Digito + 4     ->    934.
 
 La condición de paro vendrá cuando nuestra variable Estado sea igual a 0.
 



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
- Se sigue el orden del esquema:

![image](https://user-images.githubusercontent.com/89500688/222771235-a71effa1-a210-4bfd-854a-fd212945bd5c.png)

### exhaustive_search
![image](https://user-images.githubusercontent.com/89500688/222769863-0697afae-e5db-45fa-973a-5110f99a1a6f.png)

### read_user_input
![image](https://user-images.githubusercontent.com/89500688/222770124-7f6d58c5-35b4-41a2-937a-b97c3055b964.png)

### my_atoy
![image](https://user-images.githubusercontent.com/89500688/222770334-f57f8836-a5e6-4f1a-9f0f-260a5a908a6f.png)

### int_to_string
![image](https://user-images.githubusercontent.com/89500688/222770937-836ca49a-3f2c-4be6-96f1-0338cf2c5ca9.png)

### display
![image](https://user-images.githubusercontent.com/89500688/222771714-abf785a4-66fb-430d-a180-5fe7615f90a2.png)

### main
![image](https://user-images.githubusercontent.com/89500688/222772004-6d0a6e80-7e6a-4236-aae2-47f0487dccd7.png)






