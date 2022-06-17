#ifndef STRING_H
#define STRING_H

#include <iostream>
#include <string>

using namespace std;

class String {
	private:
		int state;
	
	public:
		void stateA(char);
		void stateB(char);
		int processEntry(string);
};

void String :: stateA(char c) {
	if (c == '"' || c == '\'') {
		//cout << c<<endl;
		state = STATE_B;
	}
	else state = -1;
}

void String :: stateB(char c) {
	if (c != '"' || c != '\'') {
		//cout << c<<endl;
		state = STATE_B;
	} 
	else state = -2;
}

int String :: processEntry(string str) {
	char c;
	int i;

	i = 0;
	state = STATE_A;

	while ( i < str.length() && state != -1 && state != -2 ) {
		c = str[i];
		if (c=='\n') break;
		// cout << "state = " << state << " c = ." << c << " \n";
		switch (state) {
			case STATE_A: stateA(c); break;
			case STATE_B: stateB(c); break;
		}
		i++;
	}

	switch(state) {
		case STATE_B : return i-2; break;
		default : return -1; break;
	}
}

#endif