//
//  AbstractEntity.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AbstractEntity.h"


@implementation AbstractEntity

@synthesize position;
@synthesize velocity;
@synthesize entityState;
@synthesize image;

- (id)init {
	self = [super init];
	if (self != nil) {
		position = Vector2fMake(0, 0);
		velocity = Vector2fMake(0, 0);
		entityState = kEntity_Idle;
        _gotScene = NO;
	}
	return self;
}


- (void)update:(GLfloat)delta {
	
}


- (void)render {
	
}


@end
