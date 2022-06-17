#ifndef COMENTARIO_H
#define COMENTARIO_H

#include <iostream>
#include <string>

using namespace std;

class Comentario {
	private:
		int state;
	
	public:
		void stateA(char);
		void stateB(char);
		void stateC(char);
		int processEntry(string);
};

void Comentario :: stateA(char c) {
	if ( c == '/') {
		state = STATE_B;
	}
	else state = -1;
}

void Comentario :: stateB(char c) {
	if ( c == '/') {
		state = STATE_C;
	}
	else state = -1;
}

void Comentario :: stateC(char c) {
	if ( c != '\n') {
		state = STATE_C;
	}
	else state = -2;
}

int Comentario :: processEntry(string str) {
	char c;
	int i;

	i = 0;
	state = STATE_A;

	while ( i < str.length() && state != -1 && state != -2 ) {
		c = str[i];
		if (c=='\n') break;
		//cout << "state = " << state << " c = ." << c << " \n";
		switch (state) {
			case STATE_A: stateA(c); break;
			case STATE_B: stateB(c); break;
			case STATE_C: stateC(c); break;
		}
		i++;
	}

	switch(state) {
		case STATE_C  : return i-1; break;
		case -2 : return i-2; break;
		default: return -1; break;
	}
}

#endif