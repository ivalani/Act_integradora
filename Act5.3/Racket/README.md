# Syntax H. racket implementation 
### Team

- Andrea Serrano Diego  - A01028728
- Iwalani Amador Piaga  - A01732251
- Daniel Sanchez Sanchez  - A0178575

##

## Instrucciones: 

* Ejecución secuencial: 

La funcion "write-files" recibe la carpeta con los archivos a resaltar
```elixir
> (enter! "syntax.rkt")
> (write-files "Test_HW")
```
* Ejecución paralela: 

La funcion "write-files-parallel" recibe la carpeta con los archivos a resaltar y la cantidad de threads 
```elixir
> (enter! "syntax.rkt")
> (write-files-parallel "Test_HW" 6)
```

## Complejidad

La solución planteada lee cada línea del archivo de manera recursiva: O(n)
* Para cada línea, realiza 7 reemplazos usando sustituciones de expresiones regulares: O(1)
* Posteriormente la nueva línea es añadida a una nueva lista: O(1)
* La lista es devuelta en el caso base de la función recursiva: O(1)

Al leerse el archivo solamente una vez, podemos obtener una complejidad de O(n) (n = cantidad de líneas en el archivo).

## Tiempos y speedup
Con 5 archivos tenemos de forma secuencial un tiempo de 553775 (ms), y de forma paralela un tiempo de 501989(ms), resultando en un speedup de 1.10

## Conclusiones
El trabajo nos permitio comprender mejor las expresiones regulares, ademas Racket ayudo a el uso de la programación funcional y entender los beneficios que tiene. 

El uso de paralelismo hace que la lectura de varios archivos de gran tamaño sea mucho mas rapida que de forma secuencial, gracias a que las tareas se dividen entre los threads, sin embargo, tambien hay que utilizarlos de acuerdo a las especificaciones del procesador donde se ejecta el programa, ya que si la cantidad de threads excede a la cantidad de cores del procesador, el programa se volvera más lento. 

