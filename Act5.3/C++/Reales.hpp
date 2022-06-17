#ifndef REALES_H
#define REALES_H

#include <iostream>
#include <string>

using namespace std;

class Reales {
	private:
		int state;
	
	public:
		void stateA(char);
		void stateB(char);
		void stateC(char);
		void stateD(char);
		void stateE(char);
		void stateF(char);
		void stateG(char);
		void stateH(char);
		void stateI(char);
		int processEntry(string);
};

void Reales :: stateA(char c) {
	if (c == '-') {
		state = STATE_C;
	} 
	else if (isdigit(c)) {
		state = STATE_B;
	}
	else if (c == '.') {
		state = STATE_D;
	}
	else state = -1;
}

void Reales :: stateB(char c) {
	if ( isdigit(c) ) {
		state = STATE_B;
	}
	else if (c == '.') {
		state = STATE_E;
	}
	else state = -1;
}

void Reales :: stateC(char c) {
	if ( isdigit(c) ) {
		state = STATE_B;
	}
	else if (c == '.') {
		state = STATE_D;
	}
	else state = -1;
}

void Reales :: stateD(char c) {
	if ( isdigit(c) ) {
		state = STATE_F;
	}
	else state = -1;
}

void Reales :: stateE(char c) {
	if ( isdigit(c) ) {
		state = STATE_F;
	}
	else state = -2;
}

void Reales :: stateF(char c) {
	if ( isdigit(c) ) {
		state = STATE_F;
	}
	else if (c == 'E') {
		state = STATE_G;
	}
	else if (c == 'e') {
		state = STATE_G;
	}
	else state = -2;
}

void Reales :: stateG(char c) {
	if (c == '-') {
		state = STATE_I;
	}
	else if ( isdigit(c) ) {
		state = STATE_H;
	} 
	else state = -1;
}

void Reales :: stateH(char c) {
	if ( isdigit(c) ) {
		state = STATE_H;
	}
	else state = -2;
}

void Reales :: stateI(char c) {
	if ( isdigit(c) ) {
		state = STATE_H;
	}
	else state = -1;
}

int Reales :: processEntry(string str) {
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
			case STATE_D: stateD(c); break;
			case STATE_E: stateE(c); break;
			case STATE_F: stateF(c); break;
			case STATE_G: stateG(c); break;
			case STATE_H: stateH(c); break;
			case STATE_I: stateI(c); break;
		}
		i++;
	}

	switch(state) {
		//case -1 : 
		case STATE_E : return i-1; break;
		case STATE_F : return i-1; break;
		case STATE_H : return i-1; break;
		case -2 : return i-2; break;
		default: return -1; break;
	}
}

#endif