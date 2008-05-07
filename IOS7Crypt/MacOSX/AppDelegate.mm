//
//  AppDelegate.m
//  IOS7Crypt
//
//  Created by Andrew Pennebaker on 23 Dec 2007.
//  Copyright 2007 - 2008 YelloSoft. All rights reserved.
//

#include <string>
using namespace std;

#import "AppDelegate.h"

#include "IOS7Crypt.h"

@implementation AppDelegate

-(void) dealloc {
	[passwordField release];
	[hashField release];
	[super dealloc];
}

-(IBAction) passwordModified: (id) sender {
	std::string passwordStdString=[[passwordField stringValue] UTF8String];

	std::string resultStdString=IOS7Crypt::encrypt(passwordStdString);

	NSString *resultNSString=[NSString stringWithUTF8String:resultStdString.c_str()];

	[hashField setStringValue:resultNSString];
}

-(IBAction) hashModified: (id) sender {
	std::string hashStdString=[[hashField stringValue] UTF8String];

	std::string resultStdString=IOS7Crypt::decrypt(hashStdString);

	NSString *resultNSString=[NSString stringWithUTF8String:resultStdString.c_str()];

	[passwordField setStringValue:resultNSString];
}

@end