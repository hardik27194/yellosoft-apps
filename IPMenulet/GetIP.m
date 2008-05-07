//
//  GetIP.m
//  IPMenulet
//
//  Created by Andrew Pennebaker on 23 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "GetIP.h"

@implementation GetIP

+(NSString *) getIP {
	NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://highearthorbit.com/service/myip.php"]];

	NSURLResponse *response;
	NSError *error;
	NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	int errorCode=[error code];

	if (errorCode!=0) {
		return @"0.0.0.0";
	}
	else {
		return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	}
}

@end