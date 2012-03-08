//
//  ToBeImplemented.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ToBeImplemented.h"

#pragma mark -
#pragma mark Private Interface
@interface ToBeImplemented (Private)
#pragma mark -
#pragma mark Methods
//init menu items
- (void) initMenuItems;
//init sound
- (void) initSound;
@end

#pragma mark -
#pragma mark Public Implementation

@implementation ToBeImplemented

#pragma mark -
#pragma mark init

- (id)init
{
	if( self = [super init] )
	{
		_sharedDirector = [Director sharedDirector];
		_sharedResourceManager = [ResourceManager sharedResourceManager];
		_sharedSoundManager = [SoundManager sharedSoundManager];
        
		_screenBounds = [[UIScreen mainScreen] bounds];
        _sceneFadeSpeed = 1.5f;
		[self initSound];
		
		font = [[AngelCodeFont alloc] initWithFontImageNamed:@"font1.png"
												 controlFile:@"font1"
													   scale:0.7f 
													  filter:GL_LINEAR];
		
		menuEntities = [[NSMutableArray alloc] init];
		[self setSceneState:kSceneState_TransitionIn];
		nextSceneKey = nil;
		[self initMenuItems];
	}
	return self;
}

#pragma mark -
#pragma mark Update Scene Logic
- (void) updateWithDelta:(GLfloat)theDelta
{
	switch(sceneState)
	{
		case kSceneState_Running:
			
			[menuEntities makeObjectsPerformSelector:@selector(updateWithDelta:)
										  withObject:[NSNumber numberWithFloat:theDelta]];
			
			for (MenuControl *control in menuEntities)
			{
				if([control state] == kControl_Selected)
				{
					[control setState:kControl_Idle];
					sceneState = kSceneState_TransitionOut;
					switch ([control type])
					{
							
						case kControlType_GoBack:
							nextSceneKey = @"teamscene";
							break;
						default:
							break;
					}
				}
			}
            
			// Update all the particle emitters
			
			// Update ingame controls
			break;
			
		case kSceneState_TransitionOut:
			sceneAlpha -= _sceneFadeSpeed * theDelta;
            [_sharedDirector setGlobalAlpha:sceneAlpha];
			if(sceneAlpha < 0)
                // If the scene being transitioned to does not exist then transition
                // this scene back in
				if(![_sharedDirector setCurrentSceneToSceneWithKey:nextSceneKey])
                    sceneState = kSceneState_TransitionIn;
			break;
			
		case kSceneState_TransitionIn:
			sceneAlpha += _sceneFadeSpeed * theDelta;
			[_sharedDirector setGlobalAlpha:sceneAlpha];
			if(sceneAlpha >= 1.0f)
			{
				sceneAlpha = 1.0f;
				sceneState = kSceneState_Running;
			}
		default:
			break;
	}
}

#pragma mark -
#pragma mark setSceneState
- (void)setSceneState:(uint)theState
{
	sceneState = theState;
	if(sceneState == kSceneState_TransitionOut)
		sceneAlpha = 1.0f;
	if(sceneState == kSceneState_TransitionIn)
		sceneAlpha = 0.0f;
}

#pragma mark -
#pragma mark Touch events

- (void)updateWithTouchLocationBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView
{	
    UITouch *touch = [[event touchesForView:aView] anyObject];
    
	CGPoint _location;
	_location = [touch locationInView:aView];
    
	// Flip the y location ready to check it against OpenGL coordinates
	_location.y = 480 - _location.y;
	[_sharedSoundManager playSoundWithKey:@"laser" 
									 gain:0.25f pitch:1.0f 
								 location:Vector2fZero 
							   shouldLoop:NO 
								 sourceID:-1];
	
	[menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) 
								  withObject:NSStringFromCGPoint(_location)];
}

- (void)updateWithTouchLocationMoved:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView
{
    UITouch *touch = [[event touchesForView:aView] anyObject];
	CGPoint _location;
	_location = [touch locationInView:aView];
    
	// Flip the y location ready to check it against OpenGL coordinates
	_location.y = 480 - _location.y;
	
	[menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) 
								  withObject:NSStringFromCGPoint(_location)];
}

#pragma mark -
#pragma mark Accelerometer Methods

- (void)updateWithAccelerometer:(UIAcceleration*)aAcceleration
{
    // Populate the accelerometer array with the filtered accelerometer info
	_accelerometer[0] = aAcceleration.x * 0.1f + _accelerometer[0] * (1.0 - 0.1f);
	_accelerometer[1] = aAcceleration.y * 0.1f + _accelerometer[1] * (1.0 - 0.1f);
	_accelerometer[2] = aAcceleration.z * 0.1f + _accelerometer[2] * (1.0 - 0.1f);
}

- (float)accelerometerValueForAxis:(uint)aAxis
{
    return _accelerometer[aAxis];
}

#pragma mark -
#pragma mark Transition

- (void)transitionToSceneWithKey:(NSString*)theKey
{
	sceneState = kSceneState_TransitionOut;
	sceneAlpha = 1.0f;
}

#pragma mark -
#pragma mark Render scene

- (void)render
{	
	//render the enter Manager information screen
	[font drawStringAt:CGPointMake(40, 240) text:@"To Be Implemented!!"];
	
	[menuEntities makeObjectsPerformSelector:@selector(render)];
	
	//render all particle emitters
	
	//render the particle emitter
}

@end

#pragma mark -
@implementation ToBeImplemented (Private)

- (void)initSound
{	
    [_sharedSoundManager setListenerPosition:Vector2fMake(160, 0)];
	
    // Initialize the sound effects
	[_sharedSoundManager loadSoundWithKey:@"photon" fileName:@"photon" fileExt:@"caf"];
	[_sharedSoundManager loadSoundWithKey:@"explosion" fileName:@"explosion" fileExt:@"caf"];
	
	// Initialize the background music
	//[_sharedSoundManager stopMusic];
//	[_sharedSoundManager loadBackgroundMusicWithKey:@"music" fileName:@"What Gods Are These" fileExt:@"mp3"];
//	[_sharedSoundManager setMusicVolume:0.05f];
//	[_sharedSoundManager playMusicWithKey:@"music" timesToRepeat:-1];
	
	// Set the master sound FX volume
	[_sharedSoundManager setFXVolume:1.0f];
}

#pragma mark -
#pragma mark Initialize Menu
- (void) initMenuItems
{
	MenuControl* menuEntity = [[MenuControl alloc] initWithImageNamed:@"BackArrow.png" location:Vector2fMake(30, 20) centerOfImage:YES type:kControlType_GoBack];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
}

@end
