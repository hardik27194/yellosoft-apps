//
//  AppDelegate.m
//  SiteStatus
//
//  Created by Andrew Pennebaker on 20 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "SiteStatus.h"

@implementation AppDelegate

-(void) dealloc {
	[statusItem release];
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

	statusItem=[[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];

	[statusItem setHighlightMode:YES];
	[statusItem setEnabled:YES];

	[preferencesMenuItem setImage:[NSImage imageNamed:@"preferences"]];

	timer=[NSTimer scheduledTimerWithTimeInterval:refreshRate target:self selector:@selector(update) userInfo:nil repeats:YES];
	[timer fire];
}

-(void) update {
	NSString *siteName=[defaults stringForKey:@"siteName"];
	NSString *siteURL=[defaults stringForKey:@"siteURL"];
	BOOL displaySiteName=[defaults boolForKey:@"displaySiteName"];

	NSImage *upIcon=[NSImage imageNamed:@"up"];
	NSImage *downIcon=[NSImage imageNamed:@"down"];
	NSImage *unknownIcon=[NSImage imageNamed:@"unknown"];

	[statusItem setImage:unknownIcon];

	if (displaySiteName) {
		[statusItem setTitle:siteName];
	}
	else {
		[statusItem setTitle:@""];
	}

	[upMenuItem setImage:upIcon];
	[downMenuItem setImage:downIcon];
	[unknownMenuItem setImage:unknownIcon];

	int status=[SiteStatus getStatus:siteURL];

	if (status != -1) {
		if (status == 1) {
			[statusItem setImage:upIcon];
		}
		else {
			[statusItem setImage:downIcon];
		}
	}
}

-(IBAction) refresh: (id) sender {
	[self update];
}

-(IBAction) visitSite: (id) sender {
	NSString *siteURL=[defaults stringForKey:@"siteURL"];
	NSString *command=[@"open " stringByAppendingString:siteURL];
	system([command UTF8String]);
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