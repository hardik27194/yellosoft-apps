//
//  AppDelegate.m
//  HexTime
//
//  Created by Andrew Pennebaker on 9 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "HexTime.h"

@implementation AppDelegate

-(void) dealloc {
	[timer release];
	[localTimeMenuItem release];
	[aboutMenuItem release];
	[quitMenuItem release];

	[statusItem release];
	[menu release];
	[super dealloc];
}

-(void) awakeFromNib {
	statusItem=[[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];
	[statusItem setHighlightMode:YES];
	[statusItem setTitle:@"0_00"];
	[statusItem setEnabled:YES];

	timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update) userInfo:nil repeats:YES];
	[timer fire];
}

-(void) update {
	[statusItem setTitle:[HexTime hexTime]];
	[localTimeMenuItem setTitle:[HexTime localTime]];
}

-(IBAction) about: (id) sender {
	NSApplication *app=[NSApplication sharedApplication];
	[app activateIgnoringOtherApps:YES];
	[app orderFrontStandardAboutPanel:NULL];
}

@end