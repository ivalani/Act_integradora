# Resaltador de sintaxis paralelo en python 

## Intrucciones para correr: 
1. Dentro de python, asegurarse de tener pip con: <span style="color:orange">pip -h</span> 
2. Ejecutar el comando <span style="color:orange">pip install virtualenv</span> 
3. Seguir con el comando <span style="color:orange">virtualenv venv</span> 
4. Y finalmente el comando <span style="color:orange">pip install -r requirements.txt</span> 
5. Correr el main para ver los resultados con <span style="color:orange">python main.py</span> 
6. Los resultados se reflejaran en la carpeta "test" 

* NOTA: Para cambiar el numero de Threads es necesario cambiarlo desde main.py en <span style="color:magenta">N = [numero de threads]</span> 
![imagen de variables](var.png)

## Comparación entre threads

* Un solo thread
![1thread](prueba1.png)
* 6 threads
![6threads](prueba2.png)

#### <span style="color:magenta">Speedup obtenido = 1.18 </span> 

## Complejidad: 
Por las iteraciones sobre cada linea del archivo y además de la función while que analiza las lineas, es de complejidad O(n´2)

## Reflexiones: 
La implementación de lectura por hilos, mejora la lectura de varios archivos en menor tiempo, aprovechado los procesadores actuales, resultando en una ejecución mas rapida. 

Como tal, en el proyecto no podemos notar implicaciones eticas, pero quizas si existan problemas con la ejecucion de tareas paralelas, por ejemplo, si alguien esta intentando ingresar a un sistema de forma ilegal, el uso de ejecuciones paralelas le podria facilitar el ingreso en menos tiempo y hasta salir del sistema antes de ser detectado. 