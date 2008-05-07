#include <string>
using namespace std;

#include <iostream>

#if defined(UNIX)
	#include <getopt.h>
#elif defined(WIN32)
	#include "XGetopt.h"
#endif

#include "IOS7Crypt.h"

void usage(char* program) {
	cout << "IOS7Crypt 1.0 (http://yellosoft.us)" << endl;
	cout << "Usage: " << program << " [OPTIONS]" << endl;
	cout << "Options:" << endl;
	cout << " -e <password>\tEncrypt" << endl;
	cout << " -d <hash>\tDecrypt" << endl;
	cout << " -h\t\tHelp" << endl;

	exit(0);
}

int main(int argc, char* argv[]) {
	std::string password;
	std::string hash;

	if (argc<3) {
		usage(argv[0]);
	}

	int option;
	while ((option=getopt(argc, argv, "e:d:"))!=-1) {
		switch (option) {
			case 'e':
				password=strdup(optarg);
				cout << IOS7Crypt::encrypt(password) << endl;
				break;
			case 'd':
				hash=strdup(optarg);
				cout << IOS7Crypt::decrypt(hash) << endl;
				break;
			default:
			case 'h':
				usage(argv[0]);
		}
	}
}