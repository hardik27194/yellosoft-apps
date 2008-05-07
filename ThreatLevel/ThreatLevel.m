//
//  ThreatLevel.m
//  ThreatLevel
//
//  Created by Andrew Pennebaker on 10 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "ThreatLevel.h"

@implementation ThreatLevel

+(NSString *) threatLevel {
	NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dhs.gov/dhspublic/getAdvisoryCondition"]];

	NSURLResponse *response;
	NSError *error;
	NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	if ([error code]!=0) {
		return @"NOTAVAILABLE";
	}

	NSString *xml=[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

	NSArray *lines=[xml componentsSeparatedByString:@"\n"];

	int i;
	NSString *result=@"";
	NSString *line;
	for (i=0; i<[lines count]; i++) {
		line=[lines objectAtIndex:i];

		if ([line rangeOfString:@"THREAT_ADVISORY"].length>0) {
			result=[lines objectAtIndex:i];
		}
	}

	NSRange range=[result rangeOfString:@"<THREAT_ADVISORY CONDITION=\""];

	result=[result substringFromIndex:range.location+range.length];

	range=[result rangeOfString:@"\" />"];

	return [result substringToIndex:range.location];
}

@end