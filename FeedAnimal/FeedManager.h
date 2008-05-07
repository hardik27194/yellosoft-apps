//
//  FeedManager.h
//  FeedAnimal
//
//  Created by Andrew Pennebaker on 10 Mar 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FeedManager: NSObject {
	NSMutableArray *stories;
	int maxItems;
}

+(NSString*) decodeCharacterEntities: (NSString *) source;
+(NSString*) flattenHTML: (NSString*) text;
+(NSString*) clean: (NSString*) text;
+(BOOL) isRSS: (NSXMLDocument*) xmlDoc;
+(BOOL) isAtom: (NSXMLDocument*) xmlDoc;

-(void) setStories: (NSMutableArray*) a;
-(FeedManager*) init;
-(void) setMaxItems: (int) max;
-(int) getMaxItems;
-(NSMutableArray*) loadFeed: (NSString*) url;

-(int) getStoryIndexForLink: (NSString*) link;
-(NSMutableArray*) selectNewStories: (NSMutableArray*) feed;
-(void) addStories: (NSMutableArray*) newStories;
-(NSMutableArray*) getStories;

+(void) visitURL: (NSString*) url;
-(void) markAsRead: (NSString*) link open: (BOOL) shouldOpen;

@end