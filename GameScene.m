//
//  GameScene.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

#define FPS 0

#pragma mark -
#pragma mark Private interface

@interface GameScene (Private)
#pragma mark -
#pragma mark Methods
// Initialize the sound needed for this scene
- (void)initSound;
//init the menu items
- (void)initMenuItems;

@end

#pragma mark -
#pragma mark Public implementation

@implementation GameScene

#pragma mark -
#pragma mark Init
- (id)init
{	
	if(self == [super init])
	{
		
        // Grab an instance of our singleton classes
		_sharedDirector = [Director sharedDirector];
		_sharedResourceManager = [ResourceManager sharedResourceManager];
		_sharedSoundManager = [SoundManager sharedSoundManager];
		
		// Grab the bounds of the screen
		_screenBounds = [[UIScreen mainScreen] bounds];
		
        _sceneFadeSpeed = 1.0f;
        
		// Init Sound
		[self initSound];
		
		// Init font
        font = [[AngelCodeFont alloc] initWithFontImageNamed:@"test.png" controlFile:@"test" scale:0.6f filter:GL_LINEAR];
		
		// Init particle emitter for Name
		_explosionEmitterEPL = [[ParticleEmitter alloc] initParticleEmitterWithImageNamed:@"texture.png"
															   position:Vector2fMake(50, 325)
												 sourcePositionVariance:Vector2fMake(2, 2)
																  speed:0.25f
														  speedVariance:0.125f
													   particleLifeSpan:0.5f	
											   particleLifespanVariance:0.85f
																  angle:0.0f
														  angleVariance:180
																gravity:Vector2fMake(0.0f, 0.0f)
															 startColor:Color4fMake(1.0f, 0.5f, 0.0f, 1.0f)
													 startColorVariance:Color4fMake(0.0f, 0.0f, 0.0f, 0.5f)
															finishColor:Color4fMake(0.2f, 0.5f, 0.0f, 0.0f)  
													finishColorVariance:Color4fMake(0.2f, 0.0f, 0.0f, 0.0f)
														   maxParticles:100
														   particleSize:20
												   particleSizeVariance:5
															   duration:-1
														  blendAdditive:YES];
		//Init particle emitter for age
		_explosionEmitterSPL = [[ParticleEmitter alloc] initParticleEmitterWithImageNamed:@"texture.png"
																				  position:Vector2fMake(50, 120)
																	sourcePositionVariance:Vector2fMake(2, 2)
																					 speed:0.25f
																			 speedVariance:0.125f
																		  particleLifeSpan:0.5f	
																  particleLifespanVariance:0.85f
																					 angle:0.0f
																			 angleVariance:360
																				   gravity:Vector2fMake(0.0f, 0.0f)
																				startColor:Color4fMake(1.0f, 0.5f, 0.0f, 1.0f)
																		startColorVariance:Color4fMake(0.0f, 0.0f, 0.0f, 0.5f)
																			   finishColor:Color4fMake(0.2f, 0.5f, 0.0f, 0.0f)  
																	   finishColorVariance:Color4fMake(0.2f, 0.0f, 0.0f, 0.0f)
																			  maxParticles:100
																			  particleSize:20
																	  particleSizeVariance:5
																				 duration:-1
																			blendAdditive:YES];
		
		//init the menu items
		menuEntities = [[NSMutableArray alloc] init];
		[self setSceneState:kSceneState_TransitionIn];
		nextSceneKey = nil;
		[self initMenuItems];
    }
	
	return self;
}

#pragma mark -
#pragma mark Update scene logic

- (void)updateWithDelta:(GLfloat)theDelta
{
	switch (sceneState)
	{
		case kSceneState_Running:
			
			[menuEntities makeObjectsPerformSelector:@selector(updateWithDelta:) withObject:[NSNumber numberWithFloat:theDelta]];
			
			for (MenuControl *control in menuEntities)
			{
				if([control state] == kControl_Selected)
				{
					[control setState:kControl_Idle];
					sceneState = kSceneState_TransitionOut;
					switch ([control type])
					{
						case kControlType_LeagueEPL:
							nextSceneKey = @"epl";
							break;
							
                        case kControlType_LeagueSPL:
                            nextSceneKey = @"epl";
                            break;
							
						case kControlType_GoBack:
							nextSceneKey = @"menu";
							break;
							
						default:
							break;
					}
				}
			}
            
			// Update all the particle emitters
			[_explosionEmitterEPL update:theDelta];
			[_explosionEmitterSPL update:theDelta];
			
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

//	if( _location.y > 220 )
//	{
//		[_explosionEmitterEPL stopParticleEmitter];
//		[_explosionEmitterEPL renderParticles];
//	}
//	else
//	{
//		[_explosionEmitterSPL stopParticleEmitter];
//		[_explosionEmitterSPL renderParticles];
//	}
		
	[menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) withObject:NSStringFromCGPoint(_location)];
}

- (void)updateWithTouchLocationMoved:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView
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

   [menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) withObject:NSStringFromCGPoint(_location)];
}

#pragma mark -
#pragma mark Accelerometer

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
	//render FPS
    if(FPS)
        [font drawStringAt:CGPointMake(5, 450) text:[NSString stringWithFormat:@"FPS: %1.0f", [_sharedDirector framesPerSecond]]];
	
	//render the enter Manager information screen
	[font drawStringAt:CGPointMake(12, 460) text:@"Select League!!"];
	
	[menuEntities makeObjectsPerformSelector:@selector(render)];
	
	//render all particle emitters
	[_explosionEmitterEPL renderParticles];
	[_explosionEmitterSPL renderParticles];
}

@end
#pragma mark -

@implementation GameScene (Private)

#pragma mark -
#pragma mark Initialize sound

- (void)initSound
{	
    [_sharedSoundManager setListenerPosition:Vector2fMake(160, 0)];
	
    // Initialize the sound effects
	[_sharedSoundManager loadSoundWithKey:@"photon" fileName:@"photon" fileExt:@"caf"];
	[_sharedSoundManager loadSoundWithKey:@"explosion" fileName:@"explosion" fileExt:@"caf"];
	
	// Initialize the background music
	//[_sharedSoundManager loadBackgroundMusicWithKey:@"music" fileName:@"music" fileExt:@"mp3"];
	[_sharedSoundManager setMusicVolume:0.25f];
	//[_sharedSoundManager playMusicWithKey:@"music" timesToRepeat:-1];
	
	// Set the master sound FX volume
	[_sharedSoundManager setFXVolume:1.0f];
}

#pragma mark -
#pragma mark Initialize Menu
- (void) initMenuItems
{
	MenuControl *menuEntity = [[MenuControl alloc] initWithImageNamed:@"epl.png" location:Vector2fMake(160, 325) centerOfImage:YES type:kControlType_LeagueEPL];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"spl.png" location:Vector2fMake(160, 120) centerOfImage:YES type:kControlType_LeagueSPL];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"BackArrow.png" location:Vector2fMake(30, 20) centerOfImage:YES type:kControlType_GoBack];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
}

@end

