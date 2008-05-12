//
//  iYubAppDelegate.h
//  iYub
//
//  Created by Andrew Pennebaker on 5/11/08.
//  Copyright YelloSoft 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iYubAppDelegate: NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
    BOOL showUsageAlert;
}

@property (nonatomic, retain) UIWindow *window;

-(IBAction) tryItOut: (id) sender;

@end