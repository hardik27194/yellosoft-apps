//
//  AppDelegate.h
//  SiteStatus
//
//  Created by Andrew Pennebaker on 20 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate: NSObject {
	NSUserDefaults *defaults;
	IBOutlet NSPanel *preferencesPanel;
	IBOutlet NSMenu *menu;
	NSStatusItem *statusItem;
	IBOutlet NSMenuItem *upMenuItem;
	IBOutlet NSMenuItem *downMenuItem;
	IBOutlet NSMenuItem *unknownMenuItem;
	IBOutlet NSMenuItem *refreshMenuItem;
	IBOutlet NSMenuItem *preferencesMenuItem;
	IBOutlet NSMenuItem *aboutMenuItem;
	IBOutlet NSMenuItem *quitMenuItem;
	NSTimer *timer;
}

-(void) update;
-(IBAction) visitSite: (id) sender;
-(IBAction) refresh: (id) sender;
-(IBAction) preferences: (id) sender;
-(IBAction) about: (id) sender;

@end