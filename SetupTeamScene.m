//
//  SetupTeamScene.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SetupTeamScene.h"

#pragma mark -
#pragma mark Private Interface

@interface SetupTeamScene (Private)
#pragma mark -
#pragma mark Methods
//init menu items
- (void) initMenuItems;
//init sound
- (void) initSound;
@end

#pragma mark -
#pragma mark Public Implementation
@implementation SetupTeamScene

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
        _sceneFadeSpeed = 1.5f;
		[self initSound];
		
		font = [[AngelCodeFont alloc] initWithFontImageNamed:@"font1.png"
												 controlFile:@"font1"
													   scale:0.7f 
													  filter:GL_LINEAR];
		
		background = [[Image alloc] initWithImage:@"SoccerField.png" scale:1.0f filter:GL_LINEAR];
		
		//setup players
		reina = [[Image alloc] initWithImage:@"Reina-1.png" scale:1.0f filter:GL_NEAREST];
		johnson = [[Image alloc] initWithImage:@"Johnson-1.png" scale:1.0f filter:GL_NEAREST];
		agger = [[Image alloc] initWithImage:@"Agger-1.png" scale:1.0f filter:GL_NEAREST];
		carragher = [[Image alloc] initWithImage:@"Carragher-1.png" scale:1.0f filter:GL_NEAREST];
		insua = [[Image alloc] initWithImage:@"Insua-1.png" scale:1.0f filter:GL_NEAREST];
		mascherano = [[Image alloc] initWithImage:@"Mascherano-1.png" scale:1.0f filter:GL_NEAREST];
		aquilani = [[Image alloc] initWithImage:@"Aquilani-1.png" scale:1.0f filter:GL_NEAREST];
		benayoun = [[Image alloc] initWithImage:@"Benayoun.png" scale:1.0f filter:GL_NEAREST];
		kuyt = [[Image alloc] initWithImage:@"Kuyt-1.png" scale:1.0f filter:GL_NEAREST];
		gerrard = [[Image alloc] initWithImage:@"Gerrard.png" scale:1.0f filter:GL_NEAREST];
		torres = [[Image alloc] initWithImage:@"Torres.png" scale:1.0f filter:GL_NEAREST];
		
		//setup player positions
		_reinaPosition[1] = 160.0f;
		_reinaPosition[2] = 40.0f;
		
		_johnsonPosition[1] = 270.0f;
		_johnsonPosition[2] = 100.0f;
		
		_aggerPosition[1] = 205.0f;
		_aggerPosition[2] = 100.0f;
		
		_carraPosition[1] = 120.0f;
		_carraPosition[2] = 100.0f;
		
		_insuaPosition[1] = 50.0f;
		_insuaPosition[2] = 100.0f;
		
		_maschPosition[1] = 120.0f;
		_maschPosition[2] = 200.0f;
		
		_aquilaniPosition[1] = 205.0f;
		_aquilaniPosition[2] = 230.0f;
		
		_kuytPosition[1] = 270.0f;
		_kuytPosition[2] = 280.0f;
		
		_gerrardPosition[1] = 160.0f;
		_gerrardPosition[2] = 290.0f;
		
		_benaPosition[1] = 50.0f;
		_benaPosition[2] = 280.0f;
		
		_torresPosition[1]= 160.0f;
		_torresPosition[2] = 350.0f;
		
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
	NSLog(@"updateWithTouchLocationBegan");
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
	NSLog(@"Location x: %f, Location y: %f", _location.x, _location.y);
	
	if( _location.x < 120.0f )
		// setup 4-4-2 formation
		[self check442:_location];
	else
		//setup the 4-5-1 formation
		[self check451:_location];
	
	[menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) 
								withObject:NSStringFromCGPoint(_location)];
}

- (void)updateWithTouchLocationMoved:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView
{
	NSLog(@"updateWithTouchLocationMoved");
    UITouch *touch = [[event touchesForView:aView] anyObject];
	CGPoint _location;
	_location = [touch locationInView:aView];
    
	// Flip the y location ready to check it against OpenGL coordinates
	_location.y = 480 - _location.y;
	
	[menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) 
							withObject:NSStringFromCGPoint(_location)];
	
	//update the players position
	if( [self checkReinaCollision:_location] )
	   {
		   _reinaPosition[1] = _location.x;
		   _reinaPosition[2] = _location.y;
	   }
	else
		if( [self checkJohnsonCollision:_location] )
		{
			_johnsonPosition[1] = _location.x;
			_johnsonPosition[2] = _location.y;
		}
		else
			if( [self checkAggerCollision:_location] )
			{
				_aggerPosition[1] = _location.x;
				_aggerPosition[2] = _location.y;
			}
			else
				if( [self checkCarraCollision:_location] )
				{
					_carraPosition[1] = _location.x;
					_carraPosition[2] = _location.y;
				}
				else
					if( [self checkInsuaCollision:_location] )
					{
						_insuaPosition[1] = _location.x;
						_insuaPosition[2] = _location.y;
					}
					else
						if( [self checkMaschCollision:_location] )
						{
							_maschPosition[1] = _location.x;
							_maschPosition[2] = _location.y;
						}
						else
							if( [self checkAquilaniCollision:_location] )
							{
								_aquilaniPosition[1] = _location.x;
								_aquilaniPosition[2] = _location.y;
							}
							else
								if( [self checkKuytCollision:_location] )
								{
									_kuytPosition[1] = _location.x;
									_kuytPosition[2] = _location.y;
								}
								else
									if( [self checkGerrardCollision:_location] )
									{
										_gerrardPosition[1] = _location.x;
										_gerrardPosition[2] = _location.y;
									}
									else
										if( [self checkBenaCollision:_location] )
										{
											_benaPosition[1] = _location.x;
											_benaPosition[2] = _location.y;
										}
										else
											if( [self checkTorresCollision:_location] )
											{
												_torresPosition[1] = _location.x;
												_torresPosition[2] = _location.y;
											}
}

#pragma mark -
#pragma mark Check 4-4-2
- (void) check442:(CGPoint)_location
{
	if( _location.x < 120.0f && _location.x > 19.0f )
		if( _location.y > 420.0f && _location.y < 445.0f )
		{
			//reina
			_reinaPosition[1] = 160.0f;
			_reinaPosition[2] = 30.0f;
			
			//johnson
			_johnsonPosition[1] = 275.0f;
			_johnsonPosition[2] = 120.0f;
			
			//agger
			_aggerPosition[1] = 210.0f;
			_aggerPosition[2] = 100.0f;
			
			//carra
			_carraPosition[1] = 120.0f;
			_carraPosition[2] = 100.0f;
			
			//insua
			_insuaPosition[1] = 45.0f;
			_insuaPosition[2] = 120.0f;
			
			//mascherano
			_maschPosition[1] =	115.0f;
			_maschPosition[2] = 220.0f;
			
			//aquilani
			_aquilaniPosition[1] = 210.0f;
			_aquilaniPosition[2] = 220.0f;
			
			//kuyt
			_kuytPosition[1] = 275.0f;
			_kuytPosition[2] = 280.0f;
			
			//benayoun
			_benaPosition[1] = 45.0f;
			_benaPosition[2] = 280.0f;
			
			//gerrard
			_gerrardPosition[1] = 200.0f;
			_gerrardPosition[2] = 330.0f;
			
			//torres
			_torresPosition[1] = 125.0f;
			_torresPosition[2] = 345.0f;			
		}
}

#pragma mark -
#pragma mark heck 4-5-1
- (void) check451:(CGPoint) _location
{
	if( _location.x < 300.0f && _location.x > 200.0f )
		if( _location.y > 420.0f && _location.y < 445.0f )
		{
			//reina
			_reinaPosition[1] = 160.0f;
			_reinaPosition[2] = 30.0f;
			
			//johnson
			_johnsonPosition[1] = 260.0f;
			_johnsonPosition[2] = 110.0f;
			
			//agger
			_aggerPosition[1] = 205.0f;
			_aggerPosition[2] = 110.0f;
			
			//carra
			_carraPosition[1] = 120.0f;
			_carraPosition[2] = 110.0f;
			
			//insua
			_insuaPosition[1] = 60.0f;
			_insuaPosition[2] = 110.0f;
			
			//mascherano
			_maschPosition[1] =	115.0f;
			_maschPosition[2] = 220.0f;
			
			//aquilani
			_aquilaniPosition[1] = 210.0f;
			_aquilaniPosition[2] = 220.0f;
			
			//kuyt
			_kuytPosition[1] = 270.0f;
			_kuytPosition[2] = 285.0f;
			
			//gerrard
			_gerrardPosition[1] = 160.0f;
			_gerrardPosition[2] = 300.0f;
			
			//benayoun
			_benaPosition[1] = 50.0f;
			_benaPosition[2] = 285.0f;
			
			//torres
			_torresPosition[1]= 160.0f;
			_torresPosition[2] = 350.0f;			
		}
}

#pragma mark -
#pragma mark CheckCollision

- (BOOL) checkReinaCollision:(CGPoint)_location
{
	if( _location.x <  _reinaPosition[1] + 17.0f )
		if( _location.x > _reinaPosition[1] - 17.0f )
		   if( _location.y < _reinaPosition[2] + 17.0f )
			   if( _location.y > _reinaPosition[2] - 17.0f )
			   {
				   return YES;
			   }
	return NO;
}

- (BOOL) checkJohnsonCollision:(CGPoint)_location
{
	if( _location.x <  _johnsonPosition[1] + 17.0f )
		if( _location.x > _johnsonPosition[1] - 17.0f )
			if( _location.y < _johnsonPosition[2] + 17.0f )
				if( _location.y > _johnsonPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkAggerCollision:(CGPoint)_location
{
	if( _location.x <  _aggerPosition[1] + 17.0f )
		if( _location.x > _aggerPosition[1] - 17.0f )
			if( _location.y < _aggerPosition[2] + 17.0f )
				if( _location.y > _aggerPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkCarraCollision:(CGPoint)_location
{
	if( _location.x <  _carraPosition[1] + 17.0f )
		if( _location.x > _carraPosition[1] - 17.0f )
			if( _location.y < _carraPosition[2] + 17.0f )
				if( _location.y > _carraPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkInsuaCollision:(CGPoint)_location
{
	if( _location.x <  _insuaPosition[1] + 17.0f )
		if( _location.x > _insuaPosition[1] - 17.0f )
			if( _location.y < _insuaPosition[2] + 17.0f )
				if( _location.y > _insuaPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkMaschCollision:(CGPoint)_location
{
	if( _location.x <  _maschPosition[1] + 17.0f )
		if( _location.x > _maschPosition[1] - 17.0f )
			if( _location.y < _maschPosition[2] + 17.0f )
				if( _location.y > _maschPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkAquilaniCollision:(CGPoint)_location
{
	if( _location.x <  _aquilaniPosition[1] + 17.0f )
		if( _location.x > _aquilaniPosition[1] - 17.0f )
			if( _location.y < _aquilaniPosition[2] + 17.0f )
				if( _location.y > _aquilaniPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkKuytCollision:(CGPoint)_location
{
	if( _location.x <  _kuytPosition[1] + 17.0f )
		if( _location.x > _kuytPosition[1] - 17.0f )
			if( _location.y < _kuytPosition[2] + 17.0f )
				if( _location.y > _kuytPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkGerrardCollision:(CGPoint)_location
{
	if( _location.x <  _gerrardPosition[1] + 17.0f )
		if( _location.x > _gerrardPosition[1] - 17.0f )
			if( _location.y < _gerrardPosition[2] + 17.0f )
				if( _location.y > _gerrardPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkBenaCollision:(CGPoint)_location
{
	if( _location.x <  _benaPosition[1] + 17.0f )
		if( _location.x > _benaPosition[1] - 17.0f )
			if( _location.y < _benaPosition[2] + 17.0f )
				if( _location.y > _benaPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
}

- (BOOL) checkTorresCollision:(CGPoint)_location
{
	if( _location.x <  _torresPosition[1] + 17.0f )
		if( _location.x > _torresPosition[1] - 17.0f )
			if( _location.y < _torresPosition[2] + 17.0f )
				if( _location.y > _torresPosition[2] - 17.0f )
				{
					return YES;
				}
	return NO;
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
	//render all particle emitters
	
	//render font
	[font drawStringAt:CGPointMake(20, 470) text:@"Set Team Formation!"];
	[font drawStringAt:CGPointMake(20, 440) text:@"1. 4-4-2"];
	[font drawStringAt:CGPointMake(200, 440) text:@"2. 4-5-1"];
	
	//render menu entities
	[menuEntities makeObjectsPerformSelector:@selector(render)];
	
	//render the image
	[background renderAtPoint:CGPointMake(160, 200) centerOfImage:YES];
	
	//render players
	[reina renderAtPoint:CGPointMake(_reinaPosition[1], _reinaPosition[2]) centerOfImage:YES];
	[johnson renderAtPoint:CGPointMake(_johnsonPosition[1], _johnsonPosition[2]) centerOfImage:YES];
	[agger renderAtPoint:CGPointMake(_aggerPosition[1], _aggerPosition[2]) centerOfImage:YES];
	[carragher renderAtPoint:CGPointMake(_carraPosition[1], _carraPosition[2]) centerOfImage:YES];
	[insua renderAtPoint:CGPointMake(_insuaPosition[1], _insuaPosition[2]) centerOfImage:YES];
	[mascherano renderAtPoint:CGPointMake(_maschPosition[1], _maschPosition[2]) centerOfImage:YES];
	[aquilani renderAtPoint:CGPointMake(_aquilaniPosition[1], _aquilaniPosition[2]) centerOfImage:YES];
	[kuyt renderAtPoint:CGPointMake(_kuytPosition[1], _kuytPosition[2]) centerOfImage:YES];
	[gerrard renderAtPoint:CGPointMake(_gerrardPosition[1], _gerrardPosition[2]) centerOfImage:YES];
	[benayoun renderAtPoint:CGPointMake(_benaPosition[1], _benaPosition[2]) centerOfImage:YES];
	[torres renderAtPoint:CGPointMake(_torresPosition[1], _torresPosition[2]) centerOfImage:YES];	
}

@end

#pragma mark -
@implementation SetupTeamScene (Private)

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
	MenuControl* menuEntity = [[MenuControl alloc] initWithImageNamed:@"BackArrow.png" location:Vector2fMake(300, 460) centerOfImage:YES type:kControlType_GoBack];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
}

@end
