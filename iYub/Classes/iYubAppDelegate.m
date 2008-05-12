//
//  iYubAppDelegate.m
//  iYub
//
//  Created by Andrew Pennebaker on 5/11/08.
//  Copyright YelloSoft 2008. All rights reserved.
//

#import "iYubAppDelegate.h"

@implementation iYubAppDelegate

@synthesize window;

-(void) applicationDidFinishLaunching:(UIApplication *) application {}

-(BOOL) application:(UIApplication *) application handleOpenURL:(NSURL *) url {
	if (!url) {
		return NO;
	}

	NSString *urlString=[url absoluteString];
	if (!urlString) {
		return NO;
	}

	// Remove "yn://" from urlString.
	if ([urlString length]>5) {
		urlString=[urlString substringFromIndex:5];
	}

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yubnub.org/parser/parse?command=%@", urlString]]];

	return YES;
}

-(IBAction) tryItOut: (id) sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://yubnub.org"]];
}

-(void) dealloc {
	[window release];
	[super dealloc];
}

@end