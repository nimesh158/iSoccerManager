//
//  Ghost.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Ghost.h"
#import "GameScene.h"

@implementation Ghost

- (void)dealloc {
    [_spriteSheet release];
    [_animation release];
    [super dealloc];
}

- (id)initWithTileLocation:(Vector2f)aLocation {
    self = [super init];
	if (self != nil) {
        _sharedDirector = [Director sharedDirector];
        
        _spriteSheet = [[SpriteSheet alloc] initWithImageNamed:@"ghost.gif" spriteWidth:17 spriteHeight:17 spacing:0 imageScale:2.0f];
        [[_spriteSheet image] setAlpha:0.5f];
        _animation = [[Animation alloc] init];
        [_animation addFrameWithImage:[_spriteSheet getSpriteAtX:0 y:0] delay:0.1f];
        [_animation addFrameWithImage:[_spriteSheet getSpriteAtX:1 y:0] delay:0.1f];
        [_animation setRunning:YES];
        [_animation setPingPong:YES];

        // Set the actors location to the vector location which was passed in
        position.x = aLocation.x;
        position.y = aLocation.y;
        _angle = (int)(360 * RANDOM_0_TO_1()) % 360;
        _speed = (float)(RANDOM_0_TO_1() * 0.04f);
    }
    return self;
}

- (void)update:(GLfloat)aDelta {
    
    // If we do not have access to the currentscene then grab it
    if(!_gotScene) {
        _scene = (GameScene*)[_sharedDirector currentScene];
        _gotScene = YES;
    }
    
    // Pick a new angle at
    int _changeAngle = (int)(100 * RANDOM_0_TO_1());
    if(_changeAngle == 1) {
        _angle = (int)(360 * RANDOM_0_TO_1()) % 360;
        _speed = (float)(RANDOM_0_TO_1() * 0.04f);
    }
    
    position.x += _speed * cos(DEGREES_TO_RADIANS(_angle));
    position.y += _speed * sin(DEGREES_TO_RADIANS(_angle));
    
    // Check to see if the ghost ran into a blocked tile
    float xx = ((position.x * 50) + 34) / 50;
    float yy = ((position.y * 50) - 34) / 50;
    if([_scene isBlocked:position.x y:position.y] ||
       [_scene isBlocked:xx y:position.y] ||
       [_scene isBlocked:position.x y:yy] || 
       [_scene isBlocked:xx y:yy]) {
        position.x -= _speed * cos(DEGREES_TO_RADIANS(_angle));
        position.y -= _speed * sin(DEGREES_TO_RADIANS(_angle));
        _angle = (int)(_angle + 160) % 360;
    }

    
    [_animation update:aDelta];
}

- (void)render {
	[_animation renderAtPoint:CGPointMake((int)(position.x*50), -(int)(position.y*50))];
}

@end

