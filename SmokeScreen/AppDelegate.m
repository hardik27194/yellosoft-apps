//
//  AppDelegate.m
//  SmokeScreen
//
//  Created by Andrew Pennebaker on 14 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

-(void) dealloc {
	[wallpaperView dealloc];
	[wallpaperWindow dealloc];
	[wallpaperPreview dealloc];
	[browseButton dealloc];
	[preferencesPanel dealloc];

	[super dealloc];
}

-(void) update {
	NSString *imageName=[defaults stringForKey:@"image"];

	NSImage *image=[[NSImage alloc] initByReferencingFile:imageName];
	if (image!=NULL) {
		[wallpaperPreview setImage:image];
		[wallpaperView setImage:image];
	}
}

-(void) awakeFromNib {
	NSRect frame=[wallpaperWindow frame];
	[wallpaperView setFrame:frame];

	defaults=[[NSUserDefaults standardUserDefaults] retain];

	NSDictionary *dict=[
		NSDictionary dictionaryWithContentsOfFile:[
			[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"
		]
	];

	[defaults registerDefaults:dict];

	statusItem=[[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:menu];
	[statusItem setHighlightMode:YES];

	[statusItem setImage:[NSImage imageNamed:@"smokescreen small.png"]];
	[statusItem setEnabled:YES];

	[self update];
}

-(IBAction) browseAndSetImage: (id) sender {
	NSOpenPanel *dialog=[NSOpenPanel openPanel];
	[dialog setCanChooseFiles:YES];

	if ([dialog runModalForDirectory:nil file:nil]==NSOKButton) {
		NSString *filename=[dialog filename];
		[defaults setObject:filename forKey:@"image"];

		[self update];	
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
	[app orderFrontStandardAboutPanel:NULL];
}

@end