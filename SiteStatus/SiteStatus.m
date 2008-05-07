//
//  SiteStatus.m
//  SiteStatus
//
//  Created by Andrew Pennebaker on 20 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "SiteStatus.h"

@implementation SiteStatus

+(int) getStatus: (NSString *) url {
	// Check for general Internet connectivity
	NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com/"]];
	NSURLResponse *response;
	NSError *error;
	NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	if ([error code] != 0) {
		return -1;
	}

	// Check for specified URL
	request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	if ([error code] == 0) {
		return 1;
	}
	else {
		return 0;
	}
}

@end