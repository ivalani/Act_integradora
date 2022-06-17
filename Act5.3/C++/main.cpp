/*
Andrea Serrano Diego - A01028728
Iwalani Amador Piaga - A01732251
Daniel Sanchez Sanchez - A0178575
*/

#include <iostream>
#include <string>
#include <fstream>
#include <pthread.h>
#include <iostream>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include <sys/types.h>


const int STATE_A = 0;
const int STATE_B = 1;
const int STATE_C = 2;
const int STATE_D = 3;
const int STATE_E = 4;
const int STATE_F = 5;
const int STATE_G = 6;
const int STATE_H = 7;
const int STATE_I = 8;

#include "Comentario.hpp"
#include "Entero.hpp"
#include "Reales.hpp"
#include "Variable.hpp"
#include "String.hpp"
#include "PalabraReservada.hpp"
#include "utils.h"
/* Cambiar los threads si es necesario*/
#define THREADS 3  

using namespace std;

string writeTag(string type, string text) {
	return "<span class='" + type + "'>" +text+ "</span>";
}

void* lexer(string archivo, int start, int limit, char type) {
	string c, str, substring, textoHTML;
	Comentario comentario;
	String tipoString;
	Entero entero;
	Reales real;
	Variable variable;
	PalabraReservada palabraReservada;

	ofstream writeFile;

	if (type == 's')
		writeFile.open("secuencial.html");
	else 
		writeFile.open("paralelo.html",ios_base::app);

	writeFile << "<!DOCTYPE html> <html lang='en'> <head> <meta charset='UTF-8'> <meta http-equiv='X-UA-Compatible' content='IE=edge'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Actividad 5.3 </title> <link rel='stylesheet' href='styles.css'> </head> <body>";

	ifstream readFile;

	readFile.open(archivo);
	int cont = 0;
	while (getline(readFile, str))
	{
		if(cont >= start and cont <= limit){
			writeFile <<  "<br>";
			for (int i = 0; i < str.length(); i++)
			{
				c = str[i];
				substring = str.substr(i);
				if (c == " ") {
					writeFile<< " ";
				}
				else if (c == "\t") {
					writeFile<< "&nbsp;&nbsp;&nbsp;&nbsp";
				}
				else if (tipoString.processEntry(substring) != -1) {
					writeFile<< writeTag("string", substring.substr(0, tipoString.processEntry(substring) + 1));
					i += tipoString.processEntry(substring);
				}
				else if (comentario.processEntry(substring) != -1) {
					writeFile<< writeTag("comentario",substring);
					i += comentario.processEntry(substring);
				}
				else if (palabraReservada.processEntry(substring) != -1) {
					writeFile<< writeTag("palabra-reservada", substring.substr(0, palabraReservada.processEntry(substring) + 1));
					i += palabraReservada.processEntry(substring);
				}
				else if (variable.processEntry(substring) != -1) {
					writeFile<< writeTag("variable", substring.substr(0, variable.processEntry(substring)+1));
					i += variable.processEntry(substring);
				}
				else if (real.processEntry(substring) != -1) {
					writeFile<< writeTag("real", substring.substr(0, real.processEntry(substring)+1));
					i += real.processEntry(substring);
				}
				else if (entero.processEntry(substring) != -1) {
					writeFile<< writeTag("numero", substring.substr(0, entero.processEntry(substring) + 1));
				}
				else if (c == "=") {
					writeFile<< writeTag("operadores",c);
				}
				else if (c == "+"){
					writeFile<< writeTag("operadores",c);
				}
				else if (c == "*") {
					writeFile<< writeTag("operadores",c);
				}
				else if (c == "/"){
					writeFile<< writeTag("operadores",c);
				}
				else if (c == "^") {
					writeFile<< writeTag("operadores",c);
				}
				else if ( c == "-" && str[i+1]==' ' ){
					writeFile<< writeTag("operadores", c);
				}
				else if ( c == "(" ){
					writeFile<< writeTag("operadores",c);
				}
				else if ( c == ")" ){
					writeFile<< writeTag("operadores",c);
				}
				else if (c == "'")
				{
					writeFile<< writeTag("operadores", c);
				}
				else if ( c == "," ){
					writeFile<< writeTag("operadores",c);
				}
				else if ( c == "#" ){
					writeFile<< writeTag("operadores",c);
				}
				else if ( c == ";" ){
					writeFile<< writeTag("operadores",c);
				}
				else if (c == "{"){
					writeFile<< writeTag("operadores", c);
				}
				else if ( c == "}" ){
					writeFile<< writeTag("operadores",c);
				}
				else if (c == "["){
					writeFile<< writeTag("operadores", c);
				}
				else if ( c == "]" ){
					writeFile<< writeTag("operadores",c);
				}
				else if ( c == "<" ){
					writeFile<< writeTag("operadores",c);
				}
				else if (c == ">"){
					writeFile<< writeTag("operadores", c);
				}
				else continue;
			}
		}
		cont++;
	}
	return (void*) 0;
}

/*Concurrent implementation*/
typedef struct{
  int start, limit;
  string file;
} Block;


void* task(void* param){
    Block *block;
    block = (Block *) param;
    return ((void*)lexer(block->file, block->start, block->limit,'p'));
}


int main(int argc, char* argv[]) {
	string input, line, result = "<!DOCTYPE html> <html lang='en'> <head> <meta charset='UTF-8'> <meta http-equiv='X-UA-Compatible' content='IE=edge'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Actividad 5.3 C++</title> <link rel='stylesheet' href='styles.css'> </head> <body>", text = "";
	int numberLines;
	long int results[THREADS];
	double seq, parallel;
	ofstream writeFilePar;

	writeFilePar.open("paralelo.html");
	writeFilePar << "";

	cout << "ingresar nombre de prueba (ej. example_0.json): ";
	cin >> input;

	ifstream file;
	file.open(input);
	while (getline(file, line)){
		++numberLines;
	}

	/*Implementacion Secuencial*/
	cout << "Running sequential code..." << endl;
	start_timer();
	lexer(input,0,numberLines-1,'s');
	seq = stop_timer();
	printf("\tTiempo en secuencial = %lf \n",seq);

	
	/*Implementacion en Paralelo*/
	cout << "Running parallel code..." << endl;
	
	Block blocks[THREADS];
	pthread_t threads[THREADS];
	long jump = numberLines / THREADS;

	for (int i = 0; i < THREADS; i++)
	{
		blocks[i].start = i * jump;
		blocks[i].limit = (i + 1) * jump;
		blocks[i].file = input;
	}
	
	start_timer();
	for (int i = 0; i < THREADS; i++)
	{
		pthread_create(&threads[i],NULL, task,(void*) &blocks[i]);
	}

	for (int i = 0; i < THREADS; i++){
		pthread_join(threads[i], (void**) &results[i]);
		result += results[i];
	}
	
	parallel = stop_timer();
	cout << "\tTiempo paralelo = " << parallel<<endl;
    
	cout << "Speed up = "<< (float) seq / (float) parallel *100<< "%"<<endl;
}