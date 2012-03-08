//
//  SettingsScene.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SettingsScene.h"

@implementation SettingsScene

- (id)init {
	
	if(self = [super init]) {
		_sharedDirector = [Director sharedDirector];
		_sharedResourceManager = [ResourceManager sharedResourceManager];
		_sharedSoundManager = [SoundManager sharedSoundManager];
        _sceneFadeSpeed = 0.2f;

        // Init anglecode font and message
		font = [[AngelCodeFont alloc] initWithFontImageNamed:@"test.png" controlFile:@"test" scale:1.0f filter:GL_LINEAR];
	}
	
	return self;
}


- (void)updateWithDelta:(GLfloat)aDelta {
    switch (sceneState) {
		case kSceneState_Running:

			break;
			
		case kSceneState_TransitionOut:
			sceneAlpha-= _sceneFadeSpeed * aDelta;
            [_sharedDirector setGlobalAlpha:sceneAlpha];
			if(sceneAlpha <= 0.0f)
                // If the scene being transitioned to does not exist then transition
                // this scene back in
				if(![_sharedDirector setCurrentSceneToSceneWithKey:nextSceneKey])
                    sceneState = kSceneState_TransitionIn;
			break;
			
		case kSceneState_TransitionIn:
			sceneAlpha += _sceneFadeSpeed * aDelta;
            [_sharedDirector setGlobalAlpha:sceneAlpha];
			if(sceneAlpha >= 1.0f)
			{
				sceneState = kSceneState_Running;
			}
			break;
		default:
			break;
	}
    
}


- (void)updateWithTouchLoctionBegan:(NSString*)aTouchLocation {
}


- (void)updateWithMovedLocation:(NSString*)aTouchLocation {
}


- (void)transitionToSceneWithKey:(NSString*)aKey {
}

- (void)render {
    [font drawStringAt:CGPointMake(20, 450) text:@"Settings"];
}

@end
