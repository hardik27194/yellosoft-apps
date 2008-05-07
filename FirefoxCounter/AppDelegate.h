//
//  AppDelegate.h
//  FirefoxCounter
//
//  Created by Andrew Pennebaker on 9 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate: NSObject {
	NSNumberFormatter *formatter;

	NSStatusItem *statusItem;
	IBOutlet NSMenu *menu;
	IBOutlet NSMenuItem *refreshMenuItem;
	IBOutlet NSMenuItem *aboutMenuItem;
	IBOutlet NSMenuItem *quitMenuItem;
	NSTimer *timer;
}

-(void) update;
-(IBAction) refresh: (id) sender;
-(IBAction) about: (id) sender;

@end