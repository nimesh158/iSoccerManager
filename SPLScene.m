//
//  SPLScene.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SPLScene.h"

#pragma mark -
#pragma mark Private Interface

@interface SPLScene (Private)
//init menu items
- (void) initMenuItems;
//init sound
- (void) initSound;
@end

#pragma mark -
#pragma mark Public implementation
@implementation SPLScene

#pragma mark -
#pragma mark init
- (id)init
{	
	if(self = [super init])
	{
		_sharedDirector = [Director sharedDirector];
		_sharedResourceManager = [ResourceManager sharedResourceManager];
		_sharedSoundManager = [SoundManager sharedSoundManager];
        
		_screenBounds = [[UIScreen mainScreen] bounds];
        _sceneFadeSpeed = 1.0f;
		[self initSound];
		
		font = [[AngelCodeFont alloc] initWithFontImageNamed:@"font1.png"
												 controlFile:@"font1"
													   scale:1.2f 
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
						case kControlType_LeagueEPL:
							nextSceneKey = @"game";
							break;
							
                        case kControlType_LeagueSPL:
                            nextSceneKey = @"epl";
                            break;
							
						case kControlType_GoBack:
							nextSceneKey = @"league";
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
	//render the enter Manager information screen
	[font drawStringAt:CGPointMake(20, 470) text:@"Select Team!!"];
	
	[menuEntities makeObjectsPerformSelector:@selector(render)];
	
	//render all particle emitters
	
}

@end

#pragma mark -

@implementation SPLScene (Private)

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
	//arsenal
	MenuControl* menuEntity = [[MenuControl alloc] initWithImageNamed:@"Almeria FC.png" location:Vector2fMake(45, 395) centerOfImage:YES type:kControlType_LeagueSPLTeam1];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//aston villa
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Athletic Bilbao.png" location:Vector2fMake(115, 395) centerOfImage:YES type:kControlType_LeagueSPLTeam2];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//birmingham city
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Atlético Madrid.png" location:Vector2fMake(195, 395) centerOfImage:YES type:kControlType_LeagueSPLTeam3];
	[menuEntities addObject:menuEntity];
	[menuEntity release];	
	
	//blackburn
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Barcelona.png" location:Vector2fMake(275, 395) centerOfImage:YES type:kControlType_LeagueSPLTeam4];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//bolton
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Deportivo La Coruña.png" location:Vector2fMake(45, 315) centerOfImage:YES type:kControlType_LeagueSPLTeam5];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//burnley
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Espanyol.png" location:Vector2fMake(115, 315) centerOfImage:YES type:kControlType_LeagueSPLTeam6];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//chelsea
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Getafe.png" location:Vector2fMake(195, 315) centerOfImage:YES type:kControlType_LeagueSPLTeam7];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//everton
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Malaga.png" location:Vector2fMake(275, 315) centerOfImage:YES type:kControlType_LeagueSPLTeam8];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//fulham
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Mallorca.png" location:Vector2fMake(45, 235) centerOfImage:YES type:kControlType_LeagueSPLTeam9];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//Hull City
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Osasuna.png" location:Vector2fMake(115, 235) centerOfImage:YES type:kControlType_LeagueSPLTeam10];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//Liverpool
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Racing Santander.png" location:Vector2fMake(195, 235) centerOfImage:YES type:kControlType_LeagueSPLTeam11];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//Manchester City
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Real Madrid.png" location:Vector2fMake(275, 235) centerOfImage:YES type:kControlType_LeagueSPLTeam12];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//Manchester United
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Real Zaragoza.png" location:Vector2fMake(45, 155) centerOfImage:YES type:kControlType_LeagueSPLTeam13];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//Portsmouth
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Sevilla FC.png" location:Vector2fMake(115, 155) centerOfImage:YES type:kControlType_LeagueSPLTeam14];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//stoke city
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Sporting Gijon.png" location:Vector2fMake(195, 155) centerOfImage:YES type:kControlType_LeagueSPLTeam15];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//SunderLand
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Tenerife.png" location:Vector2fMake(275, 155) centerOfImage:YES type:kControlType_LeagueSPLTeam16];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//Tottenham
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Valencia.png" location:Vector2fMake(45, 75) centerOfImage:YES type:kControlType_LeagueSPLTeam17];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//west ham
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Valladolid.png" location:Vector2fMake(115, 75) centerOfImage:YES type:kControlType_LeagueSPLTeam18];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//Wigan
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Villarreal.png" location:Vector2fMake(195, 75) centerOfImage:YES type:kControlType_LeagueSPLTeam19];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//wolverhampton
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"Xerez.png" location:Vector2fMake(275, 75) centerOfImage:YES type:kControlType_LeagueSPLTeam20];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	//go back
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"BackArrow.png" location:Vector2fMake(30, 20) centerOfImage:YES type:kControlType_GoBack];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
}

@end
