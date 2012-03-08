//
//  Player.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "Player.h"
#import "GameScene.h"

@implementation Player

@synthesize tileX;
@synthesize tileY;

- (void)dealloc {
    [image release];
    [_leftSpriteSheet release];
    [_rightSpriteSheet release];
    [_upSpriteSheet release];
    [_downSpriteSheet release];
    [_leftAnimation release];
    [_rightAnimation release];
    [_downAnimation release];
    [_upAnimation release];
    [super dealloc];
}

#pragma mark -
#pragma mark Init

- (id)initWithTileLocation:(Vector2f)aLocation {
    self = [super init];
	if (self != nil) {
        _sharedDirector = [Director sharedDirector];
        position.x = aLocation.x;
        position.y = aLocation.y;
        
        // Set up the spritesheets that will give us out player animation
        _leftSpriteSheet = [[SpriteSheet alloc] initWithImageNamed:@"knight.gif" spriteWidth:14 spriteHeight:18 spacing:0 imageScale:2.0f];
        _rightSpriteSheet = [[SpriteSheet alloc] initWithImageNamed:@"knight.gif" spriteWidth:14 spriteHeight:18 spacing:0 imageScale:2.0f];
        _upSpriteSheet = [[SpriteSheet alloc] initWithImageNamed:@"knightup.gif" spriteWidth:15 spriteHeight:18 spacing:0 imageScale:2.0f];
        _downSpriteSheet = [[SpriteSheet alloc] initWithImageNamed:@"knightdown.gif" spriteWidth:15 spriteHeight:18 spacing:0 imageScale:2.0f];

        // Set up the animations for our player for different directions
        _leftAnimation = [[Animation alloc] init];
        _rightAnimation = [[Animation alloc] init];
        _downAnimation = [[Animation alloc] init];
        _upAnimation = [[Animation alloc] init];
        _currentAnimation = [[Animation alloc] init];
        
        uint _frameIndex;
        float _animationDelay = 0.05f;
        
        // Right animation
        for(_frameIndex=0; _frameIndex < 3; _frameIndex++) {
            [_rightAnimation addFrameWithImage:[_rightSpriteSheet getSpriteAtX:_frameIndex y:0] delay:_animationDelay];
        }
        [_rightAnimation setRunning:YES];
        [_rightAnimation setPingPong:YES];
        
        // Left animation
        // Flip the image we are using for left horizontally.  This means we can use the same image for
        // both left and right.  Then add the frames to the animation
        [[_leftSpriteSheet image] setFlipVertically:YES];
        for(_frameIndex=0; _frameIndex < 3; _frameIndex++) {
            [_leftAnimation addFrameWithImage:[_leftSpriteSheet getSpriteAtX:_frameIndex y:0] delay:_animationDelay];
        }
        [_leftAnimation setRunning:YES];
        [_leftAnimation setPingPong:YES];
        
        // Down animation
        for(_frameIndex=0; _frameIndex < 3; _frameIndex++) {
            [_downAnimation addFrameWithImage:[_downSpriteSheet getSpriteAtX:_frameIndex y:0] delay:_animationDelay];
        }
        [_downAnimation setRunning:YES];
        [_downAnimation setPingPong:YES];
        
        // Up animation
        for(_frameIndex=0; _frameIndex < 3; _frameIndex++) {
            [_upAnimation addFrameWithImage:[_upSpriteSheet getSpriteAtX:_frameIndex y:0] delay:_animationDelay];
        }
        [_upAnimation setRunning:YES];
        [_upAnimation setPingPong:YES];
        
        // Set the default animation to be facing the right with the selected frame
        // showing the player standing
        _currentAnimation = _rightAnimation;
        [_currentAnimation setCurrentFrame:1];
        
        // Speed at which the player moves
        _playerSpeed = 0.04f;
        
        // Set the players state to alive
        entityState = kEntity_Alive;
        
    }
    return self;
}

#pragma mark -
#pragma mark Update

- (void)update:(GLfloat)aDelta {

    // If we do not have access to the currentscene then grab it
    if(!_gotScene) {
        _scene = (GameScene*)[_sharedDirector currentScene];
		
		_gotScene = YES;
    }
    
    // Grab the latest values from the accelerometer
    float x = [(GameScene*)[_sharedDirector currentScene] accelerometerValueForAxis:0];
    float y = [(GameScene*)[_sharedDirector currentScene] accelerometerValueForAxis:1];


    
    // Track if the player is moving
    BOOL _moving = NO;
    
    switch (entityState) {
        case kEntity_Alive:
            // Up
            if(y >= -0.72) {
                tileY -= _playerSpeed;
                float xx = ((tileX * _tileWidth) + 28) / _tileWidth;
                float yy = ((tileY * _tileHeight) - 36) / _tileHeight;
                if([_scene isBlocked:xx y:yy] ||
                   [_scene isBlocked:tileX y:yy]) {
                    tileY += _playerSpeed;
                }
                _currentAnimation = _upAnimation;
                _moving = YES;
            }
            
            // Down
            if(y <= -0.85) {
                tileY += _playerSpeed;
                float xx = ((tileX * _tileWidth) + 28) / _tileWidth;
                if([_scene isBlocked:xx y:tileY] ||
                   [_scene isBlocked:tileX y:tileY]) {
                    tileY -= _playerSpeed;
                }
                _currentAnimation = _downAnimation;
                _moving = YES;
            }
            
            // Left
            if(x <= -0.08) {
                tileX -= _playerSpeed;
                float yy = ((tileY * _tileHeight) - 36) / _tileHeight;
                if([_scene isBlocked:tileX y:yy] || 
                   [_scene isBlocked:tileX y:tileY]) {
                    tileX += _playerSpeed;
                }
                _currentAnimation = _leftAnimation;
                _moving = YES;
            }
            
            // Right
            if(x >= 0.12) {
                tileX += _playerSpeed;
                float xx = ((tileX * _tileWidth) + 28) / _tileWidth;
                float yy = ((tileY * _tileHeight) - 36) / _tileHeight;
                if([_scene isBlocked:xx y:yy] || 
                   [_scene isBlocked:xx y:tileY]) {
                    tileX -= _playerSpeed;
                }
                _currentAnimation = _rightAnimation;
                _moving = YES;
            }
            
            // Update the current animation
            if(_moving) {
                [_currentAnimation setRunning:YES];
                [_currentAnimation update:aDelta];
            } else {
                [_currentAnimation setRunning:NO];
                [_currentAnimation setCurrentFrame:1];
            }
            break;
        default:
            break;
    }

}

#pragma mark -
#pragma mark Render

- (void)render {
    [_currentAnimation renderAtPoint:CGPointMake((int)(tileX*50), -(int)(tileY*50))];
}

@end
