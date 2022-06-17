#ifndef PALABRA_RESERVADA_H
#define PALABRA_RESERVADA_H

#include <iostream>
#include <string>
#include <vector>

using namespace std;

class PalabraReservada {
	private:
		int state;
        vector<string> palabrasCPP {"asm", "auto", "bool", "break", "case", "catch", "char", "class", "const", "const_cast", "continue", "default", "delete", "do", "double", "dynamic_cast", "else", "enum", "explicit", "extern", "false", "float", "for", "friend", "goto", "if", "inline", "int", "long", "mutable", "namespace", "new", "operator", "private", "protected", "public", "register", "reinterpret_cast", "return", "short", "signed", "sizeof", "static", "static_cast", "struct", "switch", "template", "this", "throw", "true", "try", "typedef", "typeid", "typename", "union", "unsigned", "using", "virtual", "void", "volatile", "while"};
        // Palbras reservadas "asm", "auto", "bool" "break" "case" "catch" "char" "class" "const" "const_cast" "continue" "default" "delete" "do" "double" "dynamic_cast" "else" "enum" "explicit" "extern" "false" "float" "for" "friend" "goto" "if" "inline" "int" "long" "mutable" "namespace" "new" "operator" "private" "protected" "public" "register" "reinterpret_cast" "return" "short" "signed" "sizeof" "static" "static_cast" "struct" "switch" "template" "this" "throw" "true" "try" "typedef" "typeid" "typename" "union" "unsigned" "using" "virtual" "void" "volatile" "while"
	
	public:
		int processEntry(string);
};

/** (define (cppPR palabra lst index)
 * (cond
    [(empty? lst) index]
    [(char-alphabetic? (car lst))(cppPR (string-append palabra (string (car lst))) (cdr lst) (+ 1 index))]
    [(set-member? cplusplusPR palabra) index]
    [else 0])) 
*/

int PalabraReservada :: processEntry(string str) {
	char c;
	int i;
    string palabra;

	i = 0;

	while ( i < str.length() ) {
		c = str[i];
		if (c=='\n') break;
		//cout << "state = " << state << " c = ." << c << " \n";
        else if (isalpha(c)) {
            palabra += c;
        }
        else break;
		i++;
	}
    for(int j = 0; j < palabrasCPP.size(); j++){
        if(palabrasCPP[j] == palabra){
            return i;
        }
    }
    return -1;
}

#endif