#include <gtkmm.h>
#include <libglademm.h>

#include <string>
using namespace std;

#include "../IOS7Crypt.h"

Gtk::Window *mainWindow;
Gtk::Entry *passwordEntry;
Gtk::Entry *hashEntry;

Gtk::MenuItem *aboutMenuItem;
Gtk::MenuItem *quitMenuItem;

Gtk::Dialog *aboutDialog;

void on_aboutMenuItem_activate() {
	aboutDialog->run();
}

void on_aboutDialog_response(int i) {
	aboutDialog->hide();
}

void on_quitMenuItem_activate() {
	exit(0);
}

void on_passwordEntry_activate() {
	Glib::ustring passwordGlib=passwordEntry->get_text();

	std::string passwordStd=passwordGlib.raw();

	std::string hashStd=IOS7Crypt::encrypt(passwordStd);

	Glib::ustring hashGlib=Glib::ustring::ustring(hashStd);

	hashEntry->set_text(hashGlib);
}

void on_hashEntry_activate() {
	Glib::ustring hashGlib=hashEntry->get_text();

	std::string hashStd=hashGlib.raw();

	std::string passwordStd=IOS7Crypt::decrypt(hashStd);

	Glib::ustring passwordGlib=Glib::ustring::ustring(passwordStd);

	passwordEntry->set_text(passwordGlib);
}

int main(int argc, char *argv[]) {
	Gtk::Main kit(argc, argv);

	Glib::RefPtr<Gnome::Glade::Xml> refXmlMain=Gnome::Glade::Xml::create("/usr/share/yellosoft/ios7crypt/mainWindow.glade");
	refXmlMain->get_widget("mainWindow", mainWindow);
	refXmlMain->get_widget("passwordEntry", passwordEntry);
	refXmlMain->get_widget("hashEntry", hashEntry);
	refXmlMain->get_widget("aboutMenuItem", aboutMenuItem);
	refXmlMain->get_widget("quitMenuItem", quitMenuItem);

	Glib::RefPtr<Gnome::Glade::Xml> refXmlAbout=Gnome::Glade::Xml::create("/usr/share/yellosoft/ios7crypt/aboutDialog.glade");
	refXmlAbout->get_widget("aboutDialog", aboutDialog);

	aboutDialog->set_transient_for(*mainWindow);
	aboutDialog->signal_response().connect(sigc::ptr_fun(&on_aboutDialog_response));

	passwordEntry->signal_activate().connect(sigc::ptr_fun(&on_passwordEntry_activate));
	hashEntry->signal_activate().connect(sigc::ptr_fun(&on_hashEntry_activate));
	aboutMenuItem->signal_activate().connect(sigc::ptr_fun(&on_aboutMenuItem_activate));
	quitMenuItem->signal_activate().connect(sigc::ptr_fun(&on_quitMenuItem_activate));

	kit.run(*mainWindow);

	return 0;
}
