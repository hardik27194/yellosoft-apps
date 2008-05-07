//
//  InternetTime.m
//  InternetTime
//
//  Created by Andrew Pennebaker on 19 Dec 2007.
//  Copyright 2007 YelloSoft. All rights reserved.
//

#import "InternetTime.h"
#import "Swatch.h"

@implementation InternetTime

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
	[statusItem setTitle:@"@000"];
	[statusItem setEnabled:YES];

	timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update) userInfo:nil repeats:YES];
	[timer fire];
}

-(void) update {
	[statusItem setTitle:[Swatch swatch]];
	[localTimeMenuItem setTitle:[Swatch localTime]];
}

-(IBAction) about: (id) sender {
	NSApplication *app=[NSApplication sharedApplication];
	[app activateIgnoringOtherApps:YES];
	[app orderFrontStandardAboutPanel:NULL];
}

@end