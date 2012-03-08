//
//  AlienTailWagger.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AlienTailWagger.h"


@implementation AlienTailWagger


- (void)dealloc {
    [spriteSheet release];
    [animation release];
    [super dealloc];
}

- (id)initWithPosition:(Vector2f)thePosition velocity:(Vector2f)theVelocity {
	self = [super init];
	if (self != nil) {
		
		// Shared resource manager
		_resourceManager = [ResourceManager sharedResourceManager];
		
		// Set the variables which have been passed in
		position = thePosition;
		velocity = theVelocity;
		
		// By default this entity is following a path
		entityState = kEntity_Following_Path;
		
		// Set up the animation to be used for this badie
		// Init animation
		spriteSheet = [[SpriteSheet alloc] initWithImageNamed:@"spritesheet16.gif" spriteWidth:16 spriteHeight:16 spacing:0 imageScale:2.0f];
		animation = [[Animation alloc] init];
		for(int index=0; index<8; index++) {
			[animation addFrameWithImage:[spriteSheet getSpriteAtX:index y:4] delay:0.1f];
		}
		[animation setRepeat:YES];
		[animation setRunning:YES];
		
		// Set up the entityPath
		entityPath[0] = Vector2fMake(100, -100);
		entityPath[1] = Vector2fMake(400, -300);
		entityPath[2] = Vector2fMake(150, 50);
		entityPath[3] = Vector2fMake(300, -400);
		entityPath[4] = Vector2fMake(50, 50);
		entityPath[5] = Vector2fMake(100, -240);
		entityPath[6] = Vector2fMake(290, -350);
		entityPath[7] = Vector2fMake(160, -240);
		entityPath[8] = Vector2fMake(50, -400);
		entityPath[9] = Vector2fMake(300, -50);
		

		wayPointCount = 10;
		currentWayPoint = 0;
		
		curvePath = [[BezierCurve alloc] initCurveFrom:Vector2fMake(0, 0) controlPoint1:Vector2fMake(100, 570) controlPoint2:Vector2fMake(250, 570) endPoint:Vector2fMake(280, 0) segments:50];
	}
	return self;
}


- (void)update:(GLfloat)theDelta {
	
	// Update the animation for this entity
	[animation update:theDelta];
	
	// Calculate the steering force needed to move from the current position to current waypoint
	// as we are seeking the target
	Vector2f steeringForce = Vector2fSub(wayPoint, position);
	
	// Subtract current velocity from the steering force
	steeringForce = Vector2fSub(steeringForce, velocity);
	
	// Multiply the steering force with delta
	steeringForce = Vector2fMultiply(steeringForce, theDelta);
	
	// Limit the steering force to be applied
	GLfloat vectorLength = Vector2fLength(steeringForce);
	GLfloat maxSteeringForce = MAX_STEERING_FORCE;
	if(vectorLength > maxSteeringForce) {
		steeringForce = Vector2fMultiply(steeringForce, maxSteeringForce / vectorLength);
	}
	
	// Add the steering force to the current velocity
	velocity = Vector2fAdd(velocity, steeringForce);		
	
	// Limit the velocity
	vectorLength = Vector2fLength(velocity);
	GLfloat maxVelocity = MAX_VELOCITY;
	if(vectorLength > maxVelocity) {
		velocity = Vector2fMultiply(velocity, maxVelocity/vectorLength);
	}
	
	// Add the velocity to the entities position
	position = Vector2fAdd(position, velocity);
	
	// If the player gets to within a defined # of pixels from waypoint move to the next waypoint
	if((position.x - wayPoint.x) > -WAYPOINT_DISTANCE && 
	   (position.x - wayPoint.x) < WAYPOINT_DISTANCE && 
	   (position.y - wayPoint.y) > -WAYPOINT_DISTANCE && 
	   (position.y - wayPoint.y) < WAYPOINT_DISTANCE) 
	{
		// Increment the current waypoint counter
		currentWayPoint++;

		// Check to see if we have reached the end of the entity path
		if(currentWayPoint > wayPointCount) {
			currentWayPoint = 0;
		}
		
		// Set the next waypoint from the entity path
		wayPoint.x = entityPath[currentWayPoint].x;
		wayPoint.y = entityPath[currentWayPoint].y;
	}
	
//	t += theDelta/2.5f;
//	if(t > 1.0f)
//		t = 0;
//	position = [curvePath getPointAt:t];
}


- (void)render {
	[animation renderAtPoint:CGPointMake(position.x, -position.y)];
}

@end
