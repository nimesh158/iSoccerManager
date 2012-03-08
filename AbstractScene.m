//
//  AbstractScene.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AbstractScene.h"


@implementation AbstractScene

@synthesize sceneState;
@synthesize sceneAlpha;

- (void)updateWithDelta:(GLfloat)aDelta
{
}

- (void)updateWithTouchLocationBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView
{
}

- (void)updateWithTouchLocationMoved:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView
{
}

- (void)updateWithTouchLocationEnded:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView
{
}

- (void)updateWithAccelerometer:(UIAcceleration*)aAcceleration
{
}

- (void)transitionToSceneWithKey:(NSString*)aKey
{
}

- (void)render
{
}
@end