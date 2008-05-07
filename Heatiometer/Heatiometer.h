//
//  Heatiometer.h
//  Heatiometer
//
//  Created by Andrew Pennebaker on 6 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <Cocoa/Cocoa.h>

@interface Heatiometer: NSObject {
	IBOutlet NSTextField *celsiusField;
	IBOutlet NSTextField *fahrenheitField;
	IBOutlet NSTextField *kelvinField;
	IBOutlet NSTextField *rankineField;
	IBOutlet NSTextField *reaumurField;
	IBOutlet NSTextField *romerField;
	IBOutlet NSTextField *newtonField;
	IBOutlet NSTextField *delisleField;
	IBOutlet NSTextField *leydenField;
	IBOutlet NSTextField *frostField;

	IBOutlet NSSlider *slider;
}

-(float) celsiusToFahrenheit: (float) c;
-(float) celsiusToKelvin: (float) c;
-(float) celsiusToRankine: (float) c;
-(float) celsiusToReaumur: (float) c;
-(float) celsiusToRomer: (float) c;
-(float) celsiusToNewton: (float) c;
-(float) celsiusToDelisle: (float) c;
-(float) celsiusToLeyden: (float) c;
-(float) celsiusToFrost: (float) c;

-(IBAction) sliderSlid: (id) sender;

@end