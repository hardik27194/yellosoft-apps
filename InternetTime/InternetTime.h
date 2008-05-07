//
//  InternetTime.h
//  InternetTime
//
//  Created by Andrew Pennebaker on 19 Dec 2007.
//  Copyright 2007 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface InternetTime: NSObject {
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