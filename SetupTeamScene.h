//
//  SetupTeamScene.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"

@interface SetupTeamScene : AbstractScene
{	
	@private
	//menu entities
	NSMutableArray* menuEntities;
	
	//Background Image
	Image* background;
	
	//Player Images;
	Image* reina;
	Image* johnson;
	Image* agger;
	Image* carragher;
	Image* insua;
	Image* mascherano;
	Image* aquilani;
	Image* benayoun;
	Image* kuyt;
	Image* gerrard;
	Image* torres;
	
	//font
	AngelCodeFont* font;
	
	//Accelerometer
	UIAccelerationValue _accelerometer[3];
	
	//player positions
	GLfloat _reinaPosition[2];
	GLfloat _johnsonPosition[2];
	GLfloat _aggerPosition[2];
	GLfloat _carraPosition[2];
	GLfloat _insuaPosition[2];
	GLfloat _maschPosition[2];
	GLfloat _aquilaniPosition[2];
	GLfloat _kuytPosition[2];
	GLfloat _gerrardPosition[2];
	GLfloat _benaPosition[2];
	GLfloat _torresPosition[2];	
}

// Returns the current accelerometer value for the given axis.  The axis is the location
// within an array in which the value is stored.  0 = x, 1 = y, 2 = z
- (float)accelerometerValueForAxis:(uint)aAxis;

//checl player collisions
- (BOOL) checkReinaCollision:(CGPoint)_location;
- (BOOL) checkJohnsonCollision:(CGPoint)_location;
- (BOOL) checkAggerCollision:(CGPoint)_location;
- (BOOL) checkCarraCollision:(CGPoint)_location;
- (BOOL) checkInsuaCollision:(CGPoint)_location;
- (BOOL) checkMaschCollision:(CGPoint)_location;
- (BOOL) checkAquilaniCollision:(CGPoint)_location;
- (BOOL) checkKuytCollision:(CGPoint)_location;
- (BOOL) checkGerrardCollision:(CGPoint)_location;
- (BOOL) checkBenaCollision:(CGPoint)_location;
- (BOOL) checkTorresCollision:(CGPoint)_location;

// check 4-4-2 formation requested
- (void) check442:(CGPoint) _location;
// check 4-5-1 formation requested
- (void) check451:(CGPoint) _location;

@end
