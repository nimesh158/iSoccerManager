//
//  SoccerManagerGameController.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "AccelerometerSimulation.h"
#import "Director.h"
#import "ResourceManager.h"
#import "SoundManager.h"
#import "Image.h"
#import "SpriteSheet.h"
#import "AbstractScene.h"
#import "MenuScene.h"
#import "GameScene.h"
#import "SettingsScene.h"
#import "EPLScene.h"
#import "SPLScene.h"
#import "TeamScene.h"
#import "SetupTeamScene.h"
#import "ViewTeam.h"
#import "ToBeImplemented.h"

@class EAGLView;

@interface SoccerManagerGameController : UIView <UIAccelerometerDelegate>
{
	/* State to define if OGL has been initialised or not */
	BOOL glInitialised;
	
	// Grab the bounds of the screen
	CGRect screenBounds;
	
	// Accelerometer fata
	UIAccelerationValue _accelerometer[3];
	
	// Shared game state
	Director *_director;
	
	// Shared resource manager
	ResourceManager *_resourceManager;
	
	// Shared sound manager
	SoundManager *_soundManager;
}

- (id)init;
- (void)initOpenGL;
- (void)renderScene;
- (void)updateScene:(GLfloat)aDelta;
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView;
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView;
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView;

@end
