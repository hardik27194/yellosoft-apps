//
//  HexTime.m
//  HexTime
//
//  Created by Andrew Pennebaker on 9 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "HexTime.h"

@implementation HexTime

+(int) hexSeconds {
	time_t timer=time(NULL);

	struct tm *local;
	local=localtime(&timer);

	float seconds=local->tm_hour*3600+local->tm_min*60+local->tm_sec;

	return (int) (seconds*65536.0/86400.0);
}

+(NSString *) hexTime {
	int seconds=[self hexSeconds];

	int hhour=seconds/4096;

	int hmin=(seconds%4096)/16;

	// int hsec=seconds%16;

	return [NSString stringWithFormat:@"%x_%02x", hhour, hmin];
}

+(NSString *) localTime {
	time_t timer=time(NULL);
	struct tm *t;
	t=localtime(&timer);

	int hour, minute;
	hour=t->tm_hour;
	minute=t->tm_min;

	char period='A';

	if (hour>11) {
		period='P';
	}

	if (hour==0) {
		hour=12;
	}
	else if (hour>12) {
		hour-=12;
	}

	return [NSString stringWithFormat:@"%d:%02d %cM", hour, minute, period];
}

@end