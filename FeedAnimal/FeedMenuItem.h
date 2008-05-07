//
//  FeedMenuItem.h
//  FeedAnimal
//
//  Created by Andrew Pennebaker on 10 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@interface FeedMenuItem: NSMenuItem {
	int read;
	NSString *link;
	AppDelegate *delegate;
}

-(void) setRead: (int) isRead;
-(int) getRead;
-(void) setLink: (NSString*) url;
-(NSString*) getLink;
-(void) setDelegate: (AppDelegate*) o;
-(AppDelegate*) getDelegate;

-(void) markAsRead: (BOOL) open;
-(void) markAsRead;
-(void) markAsReadAndOpen;

@end