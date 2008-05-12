//
//  IOS7CryptAppDelegate.h
//  IOS7Crypt
//
//  Created by Andrew Pennebaker on 5/10/08.
//  Copyright YelloSoft 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOS7CryptAppDelegate: NSObject <UIApplicationDelegate, UITextFieldDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UITextField *passwordField;
	IBOutlet UITextField *hashField;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UITextField *hashField;

-(IBAction) encrypt: (id) sender;
-(IBAction) decrypt: (id) sender;

@end