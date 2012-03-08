//
//  BezierCurve.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Common.h"


@interface BezierCurve : NSObject {

	// Start point
	Vector2f startPoint;
	// Control point 1
	Vector2f controlPoint1;
	// Control point 2
	Vector2f controlPoint2;
	// End point
	Vector2f endPoint;
	// Number of of segments which this curve is going to be built from
	GLuint segments;
	
}

- (id)initCurveFrom:(Vector2f)theStartPoint controlPoint1:(Vector2f)theControlPoint1 controlPoint2:(Vector2f)theControlPoint2 endPoint:(Vector2f)theEndPoint segments:(GLuint)theSegments;
- (Vector2f)getPointAt:(GLfloat)t;
@end
