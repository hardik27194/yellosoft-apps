//
//  AppDelegate.m
//  ThreatLevel
//
//  Created by Andrew Pennebaker on 10 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "ThreatLevel.h"

@implementation AppDelegate

-(void) dealloc {
	[statusItem release];
	[super dealloc];
}

-(void) awakeFromNib {
	levels=[@"low guarded elevated high severe notavailable" componentsSeparatedByString:@" "];
	[levels retain];

	statusItem=[[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];
	[statusItem setHighlightMode:YES];

	[statusItem setTitle:@""];
	[statusItem setEnabled:YES];

	timer=[NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(update) userInfo:nil repeats:YES];
	[timer fire];
}

-(void) update {
	NSImage *menuIcon=[NSImage imageNamed:@"notavailable"];
	[statusItem setImage:menuIcon];

	[notAvailableMenuItem setImage:menuIcon];

	NSArray *icons=[[NSArray alloc] init];
	int i;
	for (i=0; i<[levels count]; i++) {
		menuIcon=[NSImage imageNamed:[levels objectAtIndex:i]];
		icons=[icons arrayByAddingObject:menuIcon];
	}

	[lowMenuItem setImage:[icons objectAtIndex:0]];
	[guardedMenuItem setImage:[icons objectAtIndex:1]];
	[elevatedMenuItem setImage:[icons objectAtIndex:2]];
	[highMenuItem setImage:[icons objectAtIndex:3]];
	[severeMenuItem setImage:[icons objectAtIndex:4]];

	NSString *advisory=[ThreatLevel threatLevel];
	advisory=[advisory lowercaseString];

	if ([levels containsObject:advisory]) {
		menuIcon=[NSImage imageNamed:advisory];
		[statusItem setImage:menuIcon];
	}
}

-(IBAction) refresh: (id) sender {
	[self update];
}

-(IBAction) about: (id) sender {
	NSApplication *app=[NSApplication sharedApplication];
	[app activateIgnoringOtherApps:YES];
	[app orderFrontStandardAboutPanel:NULL];
}

@end