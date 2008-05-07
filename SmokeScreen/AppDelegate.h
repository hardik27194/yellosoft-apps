//
//  AppDelegate.h
//  SmokeScreen
//
//  Created by Andrew Pennebaker on 14 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate: NSObject {
	NSUserDefaults *defaults;

	IBOutlet NSWindow *wallpaperWindow;
	IBOutlet NSImageView *wallpaperView;

	IBOutlet NSPanel *preferencesPanel;
	IBOutlet NSImageView *wallpaperPreview;
	IBOutlet NSButton *browseButton;

	IBOutlet NSMenu *menu;
	NSStatusItem *statusItem;
	IBOutlet NSMenuItem *preferencesMenuItem;
	IBOutlet NSMenuItem *aboutMenuItem;
	IBOutlet NSMenuItem *quitMenuItem;
}

-(void) update;
-(void) awakeFromNib;

-(IBAction) browseAndSetImage: (id) sender;

-(IBAction) preferences: (id) sender;
-(IBAction) about: (id) sender;

@end