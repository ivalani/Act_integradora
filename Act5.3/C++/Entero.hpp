#ifndef ENTERO_H
#define ENTERO_H

#include <iostream>
#include <string>

using namespace std;

class Entero {
	private:
		int state;
	
	public:
		void stateA(char);
		void stateB(char);
		void stateC(char);
		int processEntry(string);
};

void Entero :: stateA(char c) {
	if (c == '-') {
		state = STATE_B;
	}
	else if ( isdigit(c) ) {
		state = STATE_C;
	}
	else state = -1;
}

void Entero :: stateB(char c) {
	if ( isdigit(c) ) {
		state = STATE_C;
	}
	else state = -1;
}

void Entero :: stateC(char c) {
	if ( isdigit(c) ) {
		state = STATE_C;
	}
	else state = -2;
}

int Entero :: processEntry(string str) {
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
		default : return -1; break;
	}
}

#endif