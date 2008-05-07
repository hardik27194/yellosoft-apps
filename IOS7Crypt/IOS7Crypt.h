#include <string>
using namespace std;

class IOS7Crypt {
	private:
		static const int xlat[54];
		static int htoi (char h);

	public:
		static std::string /*IOS7Crypt::*/encrypt (std::string &password);
		static std::string /*IOS7Crypt::*/decrypt (std::string &hash);
};