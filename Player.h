//
//  Player.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractEntity.h"

@class GameScene;

@interface Player : AbstractEntity {
    Director *_sharedDirector;
    float tileX;
    float tileY;
    SpriteSheet *_leftSpriteSheet;
    SpriteSheet *_rightSpriteSheet;
    SpriteSheet *_downSpriteSheet;
    SpriteSheet *_upSpriteSheet;
    Animation *_leftAnimation;
    Animation *_rightAnimation;
    Animation *_downAnimation;
    Animation *_upAnimation;
    Animation *_currentAnimation;
    float _playerSpeed;
    GameScene *_scene;
    uint _tileWidth;
    uint _tileHeight;
}

@property (nonatomic, assign) float tileX;
@property (nonatomic, assign) float tileY;

- (id)initWithTileLocation:(Vector2f)aLocation;

@end
