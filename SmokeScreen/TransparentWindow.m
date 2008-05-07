/*
# Created by Matteo Rattotti on 13/03/06.
# Copyright (c) 2006 - 2007 Shiny Frog. All rights reserved.
# Contact matteo.rattotti@shinyfrog.net for any problem

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

#import "TransparentWindow.h"

@implementation TransparentWindow

-(id) initWithContentRect:(NSRect) contentRect
                styleMask:(unsigned int) aStyle
                  backing:(NSBackingStoreType) bufferingType
                    defer:(BOOL) flag {

	self=[super initWithContentRect:[[NSScreen mainScreen] frame]
	                          styleMask:NSBorderlessWindowMask
	                            backing:NSBackingStoreBuffered
	                              defer:NO];

	//[self setLevel: NSStatusWindowLevel];
	[self setLevel: NSNormalWindowLevel];
	//[self setLevel: kCGDesktopWindowLevel];// + 1];
//	[self setBackgroundColor: [NSColor clearColor]];
	[self setAlphaValue:1.0];
	[self setOpaque:NO];
	[self setHasShadow:NO];
	[self setMovableByWindowBackground:NO];
	//[self setIgnoresMouseEvents:YES];

	// sets full screen
	NSRect screenFrame=[[NSScreen mainScreen] frame];
	[self setFrame:screenFrame display:YES];

	return self;
}

-(BOOL) canBecomeKeyWindow {
	return YES;
}

-(void) mouseDragged:(NSEvent *) theEvent {
	NSPoint currentLocation;
	NSPoint newOrigin;
	NSRect  screenFrame = [[NSScreen mainScreen] frame];
	NSRect  windowFrame = [self frame];

	currentLocation = [self convertBaseToScreen:[self mouseLocationOutsideOfEventStream]];
	newOrigin.x = currentLocation.x - initialLocation.x;
	newOrigin.y = currentLocation.y - initialLocation.y;

	// Prevent dragging into the menu bar area
	if ( (newOrigin.y+windowFrame.size.height) > (NSMaxY(screenFrame)-[NSMenuView menuBarHeight]) ) {
		newOrigin.y = NSMaxY(screenFrame) - windowFrame.size.height - [NSMenuView menuBarHeight];
	}

	[self setFrameOrigin:newOrigin];
}

-(void) mouseDown:(NSEvent *) theEvent {
	//NSLog(@"click!");
	NSRect windowFrame = [self frame];

	// Get mouse location in global coordinates
	initialLocation = [self convertBaseToScreen:[theEvent locationInWindow]];
	initialLocation.x -= windowFrame.origin.x;
	initialLocation.y -= windowFrame.origin.y;
}

@end