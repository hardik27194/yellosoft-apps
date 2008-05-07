//
//  AppDelegate.m
//  FeedAnimal
//
//  Created by Andrew Pennebaker on 10 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedMenuItem.h"

@implementation AppDelegate

-(void) dealloc {
	[manager release];
	[statusItem release];
	[super dealloc];
}

-(NSDictionary*) registrationDictionaryForGrowl {
	NSArray *notifications=[NSArray arrayWithObject:@"New Feed Item"];

	return [NSDictionary dictionaryWithObjectsAndKeys:
		notifications, GROWL_NOTIFICATIONS_ALL,
		notifications, GROWL_NOTIFICATIONS_DEFAULT,
		nil
	];
}

// clickContext is a NSString of a hyperlink.
-(void) growlNotificationWasClicked: (id) clickContext {
	[manager markAsRead:clickContext open:YES];

	[self updateMenu];
	[self saveCache];
}

-(NSDictionary*) loadCache {
	return [NSDictionary dictionaryWithContentsOfFile:
		[cachePath stringByExpandingTildeInPath]
	];
}

-(void) awakeFromNib {
	[GrowlApplicationBridge setGrowlDelegate:self];

	cachePath=@"~/Library/Caches/us.YelloSoft.FeedAnimal.Cache.plist";

	defaults=[[NSUserDefaults standardUserDefaults] retain];

	NSDictionary *dict=[
		NSDictionary dictionaryWithContentsOfFile:[
			[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"
		]
	];

	[defaults registerDefaults:dict];

	NSString *feedURL=[defaults stringForKey:@"feedURL"];
	int refreshRate=[defaults integerForKey:@"refreshRate"];
	int maxItems=[defaults integerForKey:@"maxItems"];

	manager=[[FeedManager alloc] init];
	[manager setMaxItems:maxItems];

	NSDictionary *cache=[self loadCache];
	if (cache!=NULL) {
		NSString *cacheFeedURL=[cache objectForKey:@"feedURL"];
		NSMutableArray *cacheStories=[cache objectForKey:@"stories"];

		// Only read cached stories if still using the same feed URL.
		if ([cacheFeedURL isEqualToString:feedURL]) {
			[manager setStories:cacheStories];
		}
	}

	[menu setAutoenablesItems:NO];

	statusItem=[[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];
	[statusItem setHighlightMode:YES];

	[statusItem setImage:[NSImage imageNamed:@"animal small.png"]];
	[statusItem setEnabled:YES];

	timer=[NSTimer scheduledTimerWithTimeInterval:refreshRate target:self selector:@selector(update) userInfo:nil repeats:YES];
	[timer fire];
}

-(FeedManager*) getManager {
	return manager;
}

-(NSStatusItem*) getStatusItem {
	return statusItem;
}

-(void) updateMenu {
	// remove old menu items
	int index=[menu indexOfItemWithTag:5];
	while (index!=-1) {
		[menu removeItemAtIndex:index];
		index=[menu indexOfItemWithTag:5];
	}

	int insertionPoint=4; // =[menu indexOfItemWithTag:1]-1;

	int newCount=0;

	NSMutableArray *stories=[manager getStories];
	int i;
	for (i=0; i<[stories count]; i++) {
		NSDictionary *story=[stories objectAtIndex:i];
		int read=[[story objectForKey:@"read"] intValue];
		NSString *title=[story objectForKey:@"title"];
		NSString *link=[story objectForKey:@"link"];

		FeedMenuItem *menuItem=[[FeedMenuItem alloc] initWithTitle:title action:@selector(markAsReadAndOpen) keyEquivalent:@""];
		[menuItem setRead:read];
		[menuItem setLink:link];
		[menuItem setDelegate:self];
		[menuItem setTag:5];
		[menuItem setTarget:menuItem];
		[menu insertItem:menuItem atIndex:insertionPoint+i];

		if (!read) {
			newCount++;
		}
	}

	if (newCount>0) {
		[statusItem setTitle:[NSString stringWithFormat:@"%d", newCount]];
	}
	else {
		[statusItem setTitle:@""];

		if ([stories count]==0) {
			NSMenuItem *menuItem=[[NSMenuItem alloc] initWithTitle:@"No items or could not connect." action:NULL keyEquivalent:@""];
			[menuItem setTag:5];
			[menuItem setEnabled:NO];
			[menu insertItem:menuItem atIndex:insertionPoint];
		}
	}
}

-(void) saveCache {
	NSDictionary *cache=[[NSDictionary alloc] initWithObjectsAndKeys:
		[defaults stringForKey:@"feedURL"], @"feedURL",
		[manager getStories], @"stories",
		nil
	];

	[cache writeToFile:[cachePath stringByExpandingTildeInPath] atomically:YES];
}

-(void) update {
	NSString *feedURL=[defaults stringForKey:@"feedURL"];

	// Has the feedURL changed since the last refresh?
	NSDictionary *cache=[self loadCache];
	if (cache!=NULL) {
		NSString *cacheFeedURL=[cache objectForKey:@"feedURL"];
		if (![cacheFeedURL isEqualToString:feedURL]) {
			// feedURL has changed; reset cached stories
			[manager setStories:[[NSMutableArray arrayWithCapacity:10] retain]];
		}
	}

	int maxItems=[defaults integerForKey:@"maxItems"];
	[manager setMaxItems:maxItems];

	BOOL gotRSS=YES;

	NSMutableArray *stories=[[NSMutableArray alloc] initWithCapacity:10];
	NS_DURING
		stories=[manager loadFeed:feedURL];
	NS_HANDLER
		gotRSS=NO;
	NS_ENDHANDLER

	if (gotRSS) {
		stories=[manager selectNewStories:stories];

		if ([stories count]>0) {
			[manager addStories:stories];

			// Growl notify the newest item added.

			NSDictionary *newest=[stories objectAtIndex:0];
			NSString *title=[newest objectForKey:@"title"];
			NSString *link=[newest objectForKey:@"link"];
			NSString *description=[newest objectForKey:@"description"];

			[GrowlApplicationBridge
				notifyWithTitle:title
				description:description
				notificationName:@"New Feed Item"
				iconData:nil
				priority:0
				isSticky:NO
				clickContext:link
			];

			[self saveCache];
		}
	}

	[self updateMenu];
}

-(IBAction) refresh: (id) sender {
	[self update];
}

-(IBAction) visitFeed: (id) sender {
	[FeedManager visitURL:[defaults stringForKey:@"feedURL"]];
}

-(IBAction) clearAll: (id) sender {
	int start=[menu indexOfItemWithTag:5];
	int end=[menu indexOfItemWithTag:1]-1;

	int i;
	for (i=start; i<end; i++) {
		NSMenuItem *menuItem=[menu itemAtIndex:i];

		// Some menu items are not FeedMenuItems.
		// They may just be error-displaying items.
		if ([menuItem isMemberOfClass:[FeedMenuItem class]]) {
			[menuItem markAsRead];
		}
	}
}

-(IBAction) preferences: (id) sender {
	NSApplication *app=[NSApplication sharedApplication];
	[app activateIgnoringOtherApps:YES];
	[preferencesPanel makeKeyAndOrderFront:sender];
}

-(IBAction) about: (id) sender {
	NSApplication *app=[NSApplication sharedApplication];
	[app activateIgnoringOtherApps:YES];
	[app orderFrontStandardAboutPanel:sender];
}

@end