//
//  FirefoxCounter.m
//  FirefoxCounter
//
//  Created by Andrew Pennebaker on 9 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "FirefoxCounter.h"

@implementation FirefoxCounter

+(int) getCounter {
	NSURL *url=[NSURL URLWithString:@"http://feeds.spreadfirefox.com/downloads/firefox.xml"];

	NSURLRequest *request=[NSURLRequest requestWithURL:url];

	NSURLResponse *response;
	NSError *error;

	NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	int errorCode=[error code];

	if (errorCode!=0) {
		return -1;
	}

	NSString *rss=[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

	NSArray *lines=[rss componentsSeparatedByString:@"\n"];
	[rss release];

	int i;
	NSString *line;
	NSString *description=@"0";
	int itemFound=0;
	for (i=0; i<[lines count]; i++) {
		line=[lines objectAtIndex:i];

		if ([line rangeOfString:@"item"].length>0) {
			itemFound=1;
		}

		if (itemFound && [line rangeOfString:@"description"].length>0) {
			description=[lines objectAtIndex:i];
		}
	}

	NSRange range=[description rangeOfString:@"<description>"];

	description=[description substringFromIndex:range.location+range.length];

	range=[description rangeOfString:@"</description>"];

	NSString *counter=[description substringToIndex:range.location];

	return [counter intValue];
}

@end