//
//	GameScene.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"

// This class is the core game scene.  It is responsible for game rendering, logic, user
// input etc.
//
@interface GameScene : AbstractScene
{
	/* Game specific items */
  @private    
    AngelCodeFont *font;
	
	ParticleEmitter *_explosionEmitterEPL;
	ParticleEmitter *_explosionEmitterSPL;
	
	//Menu for selecting leagues
	NSMutableArray *menuEntities;
    
	//create an _accelerometer object 
    UIAccelerationValue _accelerometer[3];
}

// Returns the current accelerometer value for the given axis.  The axis is the location
// within an array in which the value is stored.  0 = x, 1 = y, 2 = z
- (float)accelerometerValueForAxis:(uint)aAxis;

@end
