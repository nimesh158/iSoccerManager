//
//  SoccerManagerAppDelegate.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SoccerManagerAppDelegate.h"
#import "EAGLView.h"

@implementation SoccerManagerAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window setUserInteractionEnabled:YES];
	[window setMultipleTouchEnabled:YES];
	
	glView = [[[EAGLView alloc] initWithFrame:[UIScreen mainScreen].bounds] retain];
	
	//add the glview to the window that is defined
	[window addSubview:glView];
	[window makeKeyAndVisible];
	
	[glView performSelectorOnMainThread:@selector(mainGameLoop) withObject:nil waitUntilDone:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	
}

- (void)dealloc
{
	[window release];
	[glView release];
	[super dealloc];
}

@end