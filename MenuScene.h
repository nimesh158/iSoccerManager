//
//  MenuScene.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"

@interface MenuScene : AbstractScene
{	
	NSMutableArray *menuEntities;
	Image *menuBackground;
    CGPoint _origin;
	AngelCodeFont *font;
}
@end
