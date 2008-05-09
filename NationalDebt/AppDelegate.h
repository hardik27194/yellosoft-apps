//
//  AppDelegate.h
//  NationalDebt
//
//  Created by Andrew Pennebaker on 10 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate: NSObject {
	NSUserDefaults *defaults;
	IBOutlet NSPanel *preferencesPanel;
	NSStatusItem *statusItem;
	IBOutlet NSMenu *menu;

	IBOutlet NSMenuItem *refreshMenuItem;
	IBOutlet NSMenuItem *aboutMenuItem;
	IBOutlet NSMenuItem *quitMenuItem;
	NSTimer *timer;
}

-(void) update;
-(IBAction) refresh: (id) sender;
-(IBAction) preferences: (id) sender;
-(IBAction) about: (id) sender;

@end