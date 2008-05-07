//
//  NationalDebt.m
//  NationalDebt
//
//  Created by Andrew Pennebaker on 10 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "NationalDebt.h"

@implementation NationalDebt

+(NSString *) getDebt {
	NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.brillig.com/debt_clock/"]];

	NSURLResponse *response;
	NSError *error;

	NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	int errorCode=[error code];

	if (errorCode!=0) {
		return @"";
	}

	NSString *page=[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

	NSArray *lines=[page componentsSeparatedByString:@"\n"];

	int i;
	NSString *line;
	for (i=0; i<[lines count]; i++) {
		line=[lines objectAtIndex:i];

		if ([line rangeOfString:@"<IMG SRC=\"debtiv.gif\""].length>0) {
			break;
		}
	}

	NSRange range=[line rangeOfString:@"ALT=\""];
	NSString *result=[line substringFromIndex:range.location+range.length];
	range=[result rangeOfString:@"\"></TD></TR>"];

	return [result substringToIndex:range.location];
}

@end