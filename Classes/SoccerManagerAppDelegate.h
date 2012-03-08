//
//  SoccerManagerAppDelegate.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface SoccerManagerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@end

