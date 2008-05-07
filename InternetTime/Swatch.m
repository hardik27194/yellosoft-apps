#import <stdio.h>
#import <time.h>

#import "Swatch.h"

@implementation Swatch

+(int) beats {
	time_t timer=time(NULL);

	struct tm *g;
	g=gmtime(&timer);

	int hour=g->tm_hour, min=g->tm_min, sec=g->tm_sec;

	int utc=hour*3600+min*60+sec; // Greenwich, England

	int bmt=utc+3600; // Biel, Switzerland

	float beat=bmt/86.4;

	if (beat>=1000)
		beat-=1000;

	return (int) beat;
}

+(NSString *) swatch {
	return [NSString stringWithFormat:@"@%03d", [self beats]];
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