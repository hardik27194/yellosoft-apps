//
//  AppDelegate.h
//  HexTime
//
//  Created by Andrew Pennebaker on 9 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate: NSObject {
	NSStatusItem *statusItem;
	IBOutlet NSMenu *menu;
	IBOutlet NSMenuItem *localTimeMenuItem;
	IBOutlet NSMenuItem *aboutMenuItem;
	IBOutlet NSMenuItem *quitMenuItem;
	NSTimer *timer;
}

-(void) update;
-(IBAction) about: (id) sender;

@end