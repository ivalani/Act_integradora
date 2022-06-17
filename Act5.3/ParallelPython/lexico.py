import pandas as pd

def output(word: str, result: str, salida: str):
    """Se escribe dentro de un archivo el resultado de cada una de las palabras
    Args:
        word (str): La palabra que se leyó
        result (str): El tipo de palabra que es
    """
    # Quita los espacios de las palabras
    word = word.strip()

    states = [
        "Estado inicial",
        "Identificador",
        "Numero",
        "Numero",
        "Error",
        "Error",
        "Numero",
        "Operador",
        "Operador",
        "Operador",
        "Comentario",
        "Operador",
        "Operador",
        "Operador",
        "Especiales",
        "Especiales",
        "Error",
        "Simbolo",
        "Logico",
        "BR",
        "Error",
        "Error",
        "Simbolo"
    ]
    
    colores = {
        "Numero": "#ffe119",
        "Logico":"#4363d8",
        "Simbolo": "#469990",
        "Operador": "#911eb4",
        "Identificador" :"#3cb44b",
        "Especiales": "#9A6324",
        "Comentario": "#808000",
        "Palabras Reservadas": "#f032e6",
        "Error": "#e6194B",
        "BR": "<br>"
        }
    
    with open(salida, "a+") as file:
        if word not in ["\t ", ""] and len(word) > 0:
            #print(word)
            if result <= 0:
                file.write("<span style=color:#e6194B;>"+ word + " " + "</span>")
            elif result == 19:
                file.write("<br>")    
            else:
                if word in ["define", "cdr" ,"car" ,"append" ,"else", "cond"]:
                    file.write("<span style=color:#e6194B;>"+ word + " " + "</span>")
                else:
                    file.write("<span style=color:"+colores[states[result]]+";>"+ word + " " + "</span>")


def analyze(line: str, data: pd.DataFrame, salida: str):
    """Analiza cada una de las lineas del archivo
    Args:
        line (str): La línea a analizar
    """
    # Inicializar las variables
    
    line = line.replace("\n", "?").replace("\t", "")
    state = 0
    length = len(line)
    start = 0
    index = 0
    
    while index < length :
        letter = line[index]
        
        if letter == 'E':
            pass
        elif letter == 't':
            pass
        elif letter == 'f':
            pass
        elif letter == "?":
            pass
        elif letter == ' ':
            letter = "SPACE"
        elif letter == ',':
            letter = "SPACE"
        elif letter.isalpha() and letter.islower():
            letter = "alpha-minus"
        elif letter.isnumeric():
            letter = "number"
        elif letter.isalpha() and letter.isupper():
            letter = "alpha-mayus"
        else:
            pass
        
        # La letra no está dentro del vocabulario
        if letter not in data.columns or state == -1:
            if state == -1:
                if letter in "+-/^*=();'" or letter == "SPACE" :
                    output(line[start:index], state, salida)
                    state = 0
                    start = index
                else:
                    index += 1
            else:
                if line[start:index] in "+-/^*=();'" and line[start:index] != "" :
                    output(line[start:index], state, salida)
                    start += 1
                state = -1
                index += 1
            continue
            
        if state == 0:
            # Estado inicial
            state = data[letter][0]
            index += 1
            
            if state == 0:
                start += 1
                    
        else:
            if state == data[letter][state]:
                index += 1
            else:
                if data[letter][state] == 0:
                    output(line[start:index], state, salida)
                    start = index
                    index -= 1
                state = data[letter][state]
                index += 1
    
    output(line[start:index], state, salida)
    
        
def resaltadorLexico(archivo: str, salida: str):
    """
    Función principal donde se lee el archivo y se mandan a llamar las demás funciones para realizar el procesamiento
    Args:
        archivo (str): Nombre del archivo que se tiene que leer
    """
    # Leer la tabla de transición
    try:
        tabla = pd.read_csv("tabla.csv")
    except FileNotFoundError:
        print(f'ERROR: El archivo "{archivo}" no se ha encontrado.')
        return
    
    # Crear un archivo de resultados limpio
    with open(salida, "w") as file:
        pass
        
    # Leer el archivo a analizar
    try:
        with open(archivo, 'r') as file:
            lines = file.readlines()
        for line in lines:
            analyze(line, tabla, salida)
            
    except FileNotFoundError:
        print(f'ERROR: El archivo "{archivo}" no se ha encontrado.')
        return