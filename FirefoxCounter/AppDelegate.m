//
//  AppDelegate.m
//  FirefoxCounter
//
//  Created by Andrew Pennebaker on 9 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "FirefoxCounter.h"

@implementation AppDelegate

-(void) dealloc {
	[formatter release];
	[timer release];
	[refreshMenuItem release];
	[aboutMenuItem release];
	[quitMenuItem release];
	[statusItem release];
	[menu release];
	[super dealloc];
}

-(void) awakeFromNib {
	formatter=[[NSNumberFormatter alloc] init];
	[formatter setFormat:@"#,###"];

	statusItem=[[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];
	[statusItem setHighlightMode:YES];

	[statusItem setImage:[NSImage imageNamed:@"FirefoxSmall.png"]];
	[statusItem setEnabled:YES];

	timer=[NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(update) userInfo:nil repeats:YES];
	[timer fire];
}

-(void) update {
	int counter=[FirefoxCounter getCounter];

	if (counter != -1) {
		NSString *result=[formatter stringFromNumber:[NSNumber numberWithInt: counter]];
		[statusItem setTitle:result];
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