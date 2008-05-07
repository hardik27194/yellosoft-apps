//
//  HexTime.h
//  HexTime
//
//  Created by Andrew Pennebaker on 9 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HexTime: NSObject {}

+(int) hexSeconds;
+(NSString *) hexTime;
+(NSString *) localTime;

@end