//
//  AppDelegate.m
//  NationalDebt
//
//  Created by Andrew Pennebaker on 10 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "NationalDebt.h"

@implementation AppDelegate

-(void) dealloc {
	[timer release];
	[refreshMenuItem release];
	[aboutMenuItem release];
	[quitMenuItem release];
	[statusItem release];
	[menu release];

	[super dealloc];
}

-(void) awakeFromNib {
	defaults=[[NSUserDefaults standardUserDefaults] retain];

	NSDictionary *dict=[
		NSDictionary dictionaryWithContentsOfFile:[
			[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"
		]
	];

	[defaults registerDefaults:dict];

	int refreshRate=[defaults integerForKey:@"refreshRate"];

	printf("Detected refreshRate: %d\n", refreshRate);

	statusItem=[[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];
	[statusItem setHighlightMode:YES];

	[statusItem setTitle:@"$"];
	[statusItem setEnabled:YES];

	timer=[NSTimer scheduledTimerWithTimeInterval:refreshRate target:self selector:@selector(update) userInfo:nil repeats:YES];
	[timer fire];
}

-(void) update {
	NSString *debt=[NationalDebt getDebt];

	if ([debt length]>0) {
		NSString *result=@"";
		NSArray *parts=[debt componentsSeparatedByString:@" "];
		int i;
		for (i=0; i<[parts count]; i++) {
			result=[result stringByAppendingString:[parts objectAtIndex:i]];
		}

		[statusItem setTitle:result];
	}
}

-(IBAction) refresh: (id) sender {
	[self update];
}

-(IBAction) preferences: (id) sender {
	NSApplication *app=[NSApplication sharedApplication];
	[app activateIgnoringOtherApps:YES];
	[preferencesPanel makeKeyAndOrderFront:sender];
}

-(IBAction) about: (id) sender {
	NSApplication *app=[NSApplication sharedApplication];
	[app activateIgnoringOtherApps:YES];
	[app orderFrontStandardAboutPanel:NULL];
}

@end