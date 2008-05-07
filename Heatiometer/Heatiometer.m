//
//  Heatiometer.m
//  Heatiometer
//
//  Created by Andrew Pennebaker on 6 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import "Heatiometer.h"

@implementation Heatiometer

-(void) dealloc {
	[celsiusField release];
	[fahrenheitField release];
	[kelvinField release];
	[rankineField release];
	[reaumurField release];
	[romerField release];
	[newtonField release];
	[delisleField release];
	[leydenField release];
	[frostField release];
	[slider release];

	[super dealloc];
}

-(float) celsiusToFahrenheit: (float) c {
	return c*1.8+32.0;
}

-(float) celsiusToKelvin: (float) c {
	return c+273.15;
}

-(float) celsiusToRankine: (float) c {
	return (c+273.15)*1.8;
}

-(float) celsiusToReaumur: (float) c {
	return c*0.8;
}

-(float) celsiusToRomer: (float) c {
	return c*0.525+7.5;
}

-(float) celsiusToNewton: (float) c {
	return c*33.0/100.0;
}

-(float) celsiusToDelisle: (float) c {
	return (100.0-c)*1.5;
}

-(float) celsiusToLeyden: (float) c {
	return c+253.0;
}

-(float) celsiusToFrost: (float) c {
	return (float) (32-((int) (c*1.8+32.0)));
}

-(IBAction) sliderSlid: (id) sender {
	float celsius=[slider floatValue];
	float fahrenheit=[self celsiusToFahrenheit:celsius];
	float kelvin=[self celsiusToKelvin:celsius];
	float rankine=[self celsiusToRankine:celsius];
	float reaumur=[self celsiusToReaumur:celsius];
	float romer=[self celsiusToRomer:celsius];
	float newton=[self celsiusToNewton:celsius];
	float delisle=[self celsiusToDelisle:celsius];
	float leyden=[self celsiusToLeyden:celsius];
	float frost=[self celsiusToFrost:celsius];

	[celsiusField setIntValue:(int) celsius];
	[fahrenheitField setIntValue:(int) fahrenheit];
	[kelvinField setIntValue:(int) kelvin];
	[rankineField setIntValue:(int) rankine];
	[reaumurField setIntValue:(int) reaumur];
	[romerField setIntValue:(int) romer];
	[newtonField setIntValue:(int) newton];
	[delisleField setIntValue:(int) delisle];
	[leydenField setIntValue:(int) leyden];
	[frostField setIntValue:(int) frost];
}

@end