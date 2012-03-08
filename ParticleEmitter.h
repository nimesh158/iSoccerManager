//
//  ParticleEmitter.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "Image.h"
#import "Director.h"

@interface ParticleEmitter : NSObject {

	Director *sharedGameState;

	Image *texture;

	Vector2f sourcePosition;
	Vector2f sourcePositionVariance;
	GLfloat angle;
	GLfloat angleVariance;
	GLfloat speed;
	GLfloat speedVariance;
	Vector2f gravity;
	GLfloat particleLifespan;
	GLfloat particleLifespanVariance;
	Color4f startColor;
	Color4f startColorVariance;
	Color4f finishColor;
	Color4f finishColorVariance;
	GLfloat particleSize;
	GLfloat particleSizeVariance;
	GLuint maxParticles;
	GLint particleCount;
	GLfloat emissionRate;
	GLfloat emitCounter;	
	GLuint verticesID;
	GLuint colorsID;	
	Particle *particles;
	PointSprite *vertices;
	Color4f *colors;
	BOOL active;
	GLint particleIndex;
	BOOL useTexture;
	GLfloat elapsedTime;
	GLfloat duration;
	BOOL blendAdditive;
}

@property(nonatomic, retain) Image *texture;
@property(nonatomic, assign) Vector2f sourcePosition;
@property(nonatomic, assign) Vector2f sourcePositionVariance;
@property(nonatomic, assign) GLfloat angle;
@property(nonatomic, assign) GLfloat angleVariance;
@property(nonatomic, assign) GLfloat speed;
@property(nonatomic, assign) GLfloat speedVariance;
@property(nonatomic, assign) Vector2f gravity;
@property(nonatomic, assign) GLfloat particleLifespan;
@property(nonatomic, assign) GLfloat particleLifespanVariance;
@property(nonatomic, assign) Color4f startColor;
@property(nonatomic, assign) Color4f startColorVariance;
@property(nonatomic, assign) Color4f finishColor;
@property(nonatomic, assign) Color4f finishColorVariance;
@property(nonatomic, assign) GLfloat particleSize;
@property(nonatomic, assign) GLfloat particleSizeVariance;
@property(nonatomic, assign) GLuint maxParticles;
@property(nonatomic, assign) GLint particleCount;
@property(nonatomic, assign) GLfloat emissionRate;
@property(nonatomic, assign) GLfloat emitCounter;
@property(nonatomic, assign) BOOL active;
@property(nonatomic, assign) GLfloat duration;
@property(nonatomic, assign) BOOL blendAdditive;

- (id)initParticleEmitterWithImageNamed:(NSString*)inTextureName
							   position:(Vector2f)inPosition 
				 sourcePositionVariance:(Vector2f)inSourcePositionVariance
								  speed:(GLfloat)inSpeed
						  speedVariance:(GLfloat)inSpeedVariance 
					   particleLifeSpan:(GLfloat)inParticleLifeSpan
			   particleLifespanVariance:(GLfloat)inParticleLifeSpanVariance 
								  angle:(GLfloat)inAngle 
						  angleVariance:(GLfloat)inAngleVariance 
								gravity:(Vector2f)inGravity
							 startColor:(Color4f)inStartColor 
					 startColorVariance:(Color4f)inStartColorVariance
							finishColor:(Color4f)inFinishColor 
					finishColorVariance:(Color4f)inFinishColorVariance
						   maxParticles:(GLuint)inMaxParticles 
						   particleSize:(GLfloat)inParticleSize
				   particleSizeVariance:(GLfloat)inParticleSizeVariance
							   duration:(GLfloat)inDuration
						  blendAdditive:(BOOL)inBlendAdditive;

- (void)renderParticles;
- (void)update:(GLfloat)delta;
- (BOOL)addParticle;
- (void)initParticle:(Particle*)particle;
- (void)stopParticleEmitter;

@end
