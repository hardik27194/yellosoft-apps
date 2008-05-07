//
//  AppDelegate.h
//  ThreatLevel
//
//  Created by Andrew Pennebaker on 10 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate: NSObject {
	NSArray *levels;
	NSStatusItem *statusItem;
	IBOutlet NSMenu *menu;

	IBOutlet NSMenuItem *severeMenuItem;
	IBOutlet NSMenuItem *highMenuItem;
	IBOutlet NSMenuItem *elevatedMenuItem;
	IBOutlet NSMenuItem *guardedMenuItem;
	IBOutlet NSMenuItem *lowMenuItem;
	IBOutlet NSMenuItem *notAvailableMenuItem;

	IBOutlet NSMenuItem *refreshMenuItem;
	IBOutlet NSMenuItem *aboutMenuItem;
	IBOutlet NSMenuItem *quitMenuItem;
	NSTimer *timer;
}

-(void) update;
-(IBAction) refresh: (id) sender;
-(IBAction) about: (id) sender;

@end