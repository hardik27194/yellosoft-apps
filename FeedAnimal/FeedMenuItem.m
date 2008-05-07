//
//  FeedMenuItem.m
//  FeedAnimal
//
//  Created by Andrew Pennebaker on 10 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "FeedMenuItem.h"

@implementation FeedMenuItem

-(void) setRead: (int) isRead {
	read=isRead;

	if (read) {
		[self setImage:[NSImage imageNamed:@"read"]];
	}
	else {
		[self setImage:[NSImage imageNamed:@"new"]];
	}
}

-(int) getRead {
	return read;
}

-(void) setLink: (NSString*) url {
	link=url;
}

-(NSString*) getLink {
	return link;
}

-(void) setDelegate: (AppDelegate*) o {
	delegate=o;
}

-(AppDelegate*) getDelegate {
	return delegate;
}

-(void) markAsRead: (BOOL) open {
	[[delegate getManager] markAsRead:link open:open];

	[delegate updateMenu];

	[delegate saveCache];
}

-(void) markAsRead {
	[self markAsRead:NO];
}

-(void) markAsReadAndOpen {
	[self markAsRead:YES];
}

@end