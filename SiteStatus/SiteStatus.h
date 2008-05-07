//
//  SiteStatus.h
//  SiteStatus
//
//  Created by Andrew Pennebaker on 20 Jan 2008.
//  Copyright 2008 YelloSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SiteStatus: NSObject {}

+(int) getStatus: (NSString *) url;

@end