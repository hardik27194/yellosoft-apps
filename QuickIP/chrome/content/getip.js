/* Based on Anastasios Monachos' LiveIPAddress
   https://addons.mozilla.org/en-US/firefox/addon/1731 */

var prefs=Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService);
prefs=prefs.getBranch("extensions.quickip.");

var refreshRate=prefs.getIntPref("refreshRate"); // milliseconds

window.addEventListener("load", updateIPAddress, false);

function saveSettings(refreshRate) {
	// Tell firefox to store setting permanently ...


	self.setTimeout("updateIPAddress()", refreshRate);
}

function updateIPAddress() {
	http_request=false;
	http_request=new XMLHttpRequest();
	
	if (http_request.overrideMimeType) {
		http_request.overrideMimeType("text/xml");
	}

	if (!http_request) {
		setIPAddress("Un.kn.o.wn");
	}
	else {
		http_request.onreadystatechange=getIPAddress;
		http_request.open("GET", "http://www.showmyip.com/xml/", true);
		http_request.send(null);
	}
}

function getIPAddress() {
	if (http_request.readyState==4 && http_request.status==200) {
		var xmlobject=http_request.responseXML;
		var root=xmlobject.getElementsByTagName("ip_address")[0];
		ipAddress=root.getElementsByTagName("ip")[0].firstChild.nodeValue;

		if (!validIP(ipAddress)) {
			ipAddress="Un.kn.o.wn";
		}

		setIPAddress(ipAddress);
	}
}

function setIPAddress(ipAddress) {
	document.getElementById("quickip-statusbar").label=ipAddress;
}

function validIP(ipAddress) {
	if (ipAddress==null || ipAddress=="") {
		return false;
	}

	var sections=ipAddress.split(".");

	if (sections.length!=4) {
		return false;
	}

	for (var i=0; i<4; i++) {
		var i=parseInt(sections[i]);

		if (i<0 || i>255) {
			return false;
		}
	}

	return true;
}