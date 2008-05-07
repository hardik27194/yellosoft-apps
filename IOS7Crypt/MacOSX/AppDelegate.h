//
//  AppDelegate.h
//  IOS7Crypt
//
//  Created by Andrew Pennebaker on 23 Dec 2007.
//  Copyright 2007 - 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate: NSObject {
	IBOutlet NSTextField *passwordField;
	IBOutlet NSTextField *hashField;
}

-(IBAction) passwordModified: (id) sender;
-(IBAction) hashModified: (id) sender;

@end