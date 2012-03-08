//
//  AlienTailWagger.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BezierCurve.h"
#import "AbstractEntity.h"

#define MAX_VELOCITY 2.5f
#define MAX_STEERING_FORCE 0.05f
#define WAYPOINT_DISTANCE 50
#define MAX_WAYPOINTS 20

@interface AlienTailWagger : AbstractEntity {
	
	// Shared resource manager
	ResourceManager *_resourceManager;
	// Animation to be used for this entity
	Animation *animation;
	// SpriteSheet to be used for this entities animation
	SpriteSheet *spriteSheet;
	// Array of waypoints this entity is to follow
	Vector2f entityPath[MAX_WAYPOINTS];
	// Waypoint object
	Vector2f wayPoint;
	// Current target waypoint within the entity path array
	GLuint currentWayPoint;
	// Total number of waypoints being used
	GLuint wayPointCount;
	// Bezier curve which the entity will follow
	BezierCurve *curvePath;
	// Location between curve path start and end points
	GLfloat t;
	
}

- (id)initWithPosition:(Vector2f)thePosition velocity:(Vector2f)theVelocity;
- (void)update:(GLfloat)theDelta;
- (void)render;

@end
