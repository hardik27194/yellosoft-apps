//
//  AppDelegate.h
//  FeedAnimal
//
//  Created by Andrew Pennebaker on 10 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Growl/Growl.h>

#import "FeedManager.h"

@interface AppDelegate: NSObject <GrowlApplicationBridgeDelegate> {
	NSUserDefaults *defaults;
	IBOutlet NSPanel *preferencesPanel;
	IBOutlet NSMenu *menu;
	NSStatusItem *statusItem;

	IBOutlet NSMenuItem *appMenu;
	IBOutlet NSMenuItem *visitFeedMenuItem;
	IBOutlet NSMenuItem *clearAllMenuItem;
	IBOutlet NSMenuItem *refreshMenuItem;
	IBOutlet NSMenuItem *preferencesMenuItem;
	IBOutlet NSMenuItem *aboutMenuItem;
	IBOutlet NSMenuItem *quitMenuItem;

	FeedManager *manager;
	NSString *cachePath;
	NSTimer *timer;
}

-(NSDictionary*) registrationDictionaryForGrowl;
-(void) growlNotificationWasClicked: (id) clickContext;

-(FeedManager*) getManager;
-(NSStatusItem*) getStatusItem;

-(NSDictionary*) loadCache;
-(void) updateMenu;
-(void) saveCache;
-(void) update;
-(IBAction) visitFeed: (id) sender;
-(IBAction) clearAll: (id) sender;
-(IBAction) refresh: (id) sender;
-(IBAction) preferences: (id) sender;
-(IBAction) about: (id) sender;

@end