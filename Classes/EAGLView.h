//
//  EAGLView.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "SoccerManagerGameController.h"

@interface EAGLView : UIView {
    
@private
    /* The pixel dimensions of the backbuffer */
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    /* OpenGL names for the renderbuffer and framebuffers used to render to this view */
    GLuint viewRenderbuffer, viewFramebuffer;
    
    /* OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist) */
    GLuint depthRenderbuffer;
	
	/* Time since the last frame was rendered */
	CFTimeInterval lastTime;
    float _FPSCounter;
	
	/* Game loop timer */
	NSTimer *gameLoopTimer;
	
	/* Game Controller */
	SoccerManagerGameController *gameController;
    
    /* Shared Director */
    Director *_sharedDirector;
}

- (void) mainGameLoop;
- (void) startGameTimer;

@end
