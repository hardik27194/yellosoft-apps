#include <cstdio>
#include <ctime>
#include <string>
using namespace std;
#include <sstream>
#include <iomanip>

#include "IOS7Crypt.h"

const int IOS7Crypt::xlat[]={
	0x64, 0x73, 0x66, 0x64, 0x3b, 0x6b, 0x66, 0x6f,
	0x41, 0x2c, 0x2e, 0x69, 0x79, 0x65, 0x77, 0x72,
	0x6b, 0x6c, 0x64, 0x4a, 0x4b, 0x44, 0x48, 0x53,
	0x55, 0x42, 0x73, 0x67, 0x76, 0x63, 0x61, 0x36,
	0x39, 0x38, 0x33, 0x34, 0x6e, 0x63, 0x78, 0x76,
	0x39, 0x38, 0x37, 0x33, 0x32, 0x35, 0x34, 0x6b,
	0x3b, 0x66, 0x67, 0x38, 0x37
};

int IOS7Crypt::htoi (char h) {
	if (isdigit(h)) {
		return h-48;
	}
	else if (isxdigit(h)) {
		return toupper(h)-55;
	}

	return -1;
}

std::string IOS7Crypt::encrypt (std::string &password) {
	if (password.length()<1) {
		return "";
	}

	password=password.substr(0, 11);

	srand((unsigned) time(NULL));
	int seed=rand()%16;

	stringstream ss;
	ss << setfill('0') << setw(2) << seed;
	std::string result=ss.str();
	ss.str("");

	int i;
	int length=password.length();
	ss << hex;
	for (i=0; i<length; i++) {
		int c=xlat[(seed++)%sizeof(xlat)]^password.at(i);

		ss << setfill('0') << setw(2) << c;
		result.append(ss.str());
		ss.str("");
	}

	return result;
}

std::string IOS7Crypt::decrypt (std::string &hash) {
	if (hash.length()<4) {
		return "";
	}

	if (!isdigit(hash.at(0)) || !isdigit(hash.at(1))) {
		return "";
	}

	int seed=atoi(hash.substr(0, 2).c_str());
	hash=hash.substr(2);

	std::string result;
	int i;
	int length=hash.length();
	for (i=0; i+1<length; i+=2) {
		char a=htoi(hash.at(i)), b=htoi(hash.at(i+1));

		if (a==-1 || b==-1) {
			break;
		}

		char c=(char) a*16+b;
		c=c^xlat[(seed++)%sizeof(xlat)];
		result += c;
	}

	return result;
}