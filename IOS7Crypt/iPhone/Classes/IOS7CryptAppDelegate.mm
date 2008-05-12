//
//  IOS7CryptAppDelegate.m
//  IOS7Crypt
//
//  Created by Andrew Pennebaker on 5/10/08.
//  Copyright YelloSoft 2008. All rights reserved.
//

#import "IOS7CryptAppDelegate.h"
#include "IOS7Crypt.h"

@implementation IOS7CryptAppDelegate

@synthesize window;
@synthesize passwordField;
@synthesize hashField;

-(void) applicationDidFinishLaunching:(UIApplication *) application {	
	// Override point for customization after app launch
}

-(BOOL) textFieldShouldReturn:(UITextField *) theTextField {
	if (theTextField==passwordField || theTextField==hashField) {
		[theTextField resignFirstResponder];
	}

	return YES;
}

-(IBAction) encrypt: (id) sender {
	std::string passwordStdString=[passwordField.text UTF8String];
	
	std::string resultStdString=IOS7Crypt::encrypt(passwordStdString);
	
	NSString *resultNSString=[NSString stringWithUTF8String:resultStdString.c_str()];
	
	hashField.text=resultNSString;
}

-(IBAction) decrypt: (id) sender {
	std::string hashStdString=[hashField.text UTF8String];
	
	std::string resultStdString=IOS7Crypt::decrypt(hashStdString);
	
	NSString *resultNSString=[NSString stringWithUTF8String:resultStdString.c_str()];
	
	passwordField.text=resultNSString;
}

-(void) dealloc {
	[passwordField release];
	[hashField release];
	[window release];
	[super dealloc];
}

@end