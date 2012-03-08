//
//  Common.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>

#pragma mark -
#pragma mark Debug

#define DEBUG 0

#pragma mark -
#pragma mark Macros

// Macro which returns a random value between -1 and 1
#define RANDOM_MINUS_1_TO_1() ((random() / (GLfloat)0x3fffffff )-1.0f)

// MAcro which returns a random number between 0 and 1
#define RANDOM_0_TO_1() ((random() / (GLfloat)0x7fffffff ))

// Macro which converts degrees into radians
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

#pragma mark -
#pragma mark Enumerations

enum {
	kControlType_NewGame,
	kControlType_Settings,
	kControlType_HighScores,
	kControlType_QuitGame,
	kControlType_PauseGame,
	kControlType_LeagueEPL,
	kControlType_LeagueSPL,
	kControlType_LeagueEPLTeam1,
	kControlType_LeagueEPLTeam2,
	kControlType_LeagueEPLTeam3,
	kControlType_LeagueEPLTeam4,
	kControlType_LeagueEPLTeam5,
	kControlType_LeagueEPLTeam6,
	kControlType_LeagueEPLTeam7,
	kControlType_LeagueEPLTeam8,
	kControlType_LeagueEPLTeam9,
	kControlType_LeagueEPLTeam10,
	kControlType_LeagueEPLTeam11,
	kControlType_LeagueEPLTeam12,
	kControlType_LeagueEPLTeam13,
	kControlType_LeagueEPLTeam14,
	kControlType_LeagueEPLTeam15,
	kControlType_LeagueEPLTeam16,
	kControlType_LeagueEPLTeam17,
	kControlType_LeagueEPLTeam18,
	kControlType_LeagueEPLTeam19,
	kControlType_LeagueEPLTeam20,
	kControlType_LeagueSPLTeam1,
	kControlType_LeagueSPLTeam2,
	kControlType_LeagueSPLTeam3,
	kControlType_LeagueSPLTeam4,
	kControlType_LeagueSPLTeam5,
	kControlType_LeagueSPLTeam6,
	kControlType_LeagueSPLTeam7,
	kControlType_LeagueSPLTeam8,
	kControlType_LeagueSPLTeam9,
	kControlType_LeagueSPLTeam10,
	kControlType_LeagueSPLTeam11,
	kControlType_LeagueSPLTeam12,
	kControlType_LeagueSPLTeam13,
	kControlType_LeagueSPLTeam14,
	kControlType_LeagueSPLTeam15,
	kControlType_LeagueSPLTeam16,
	kControlType_LeagueSPLTeam17,
	kControlType_LeagueSPLTeam18,
	kControlType_LeagueSPLTeam19,
	kControlType_LeagueSPLTeam20,
	kControlType_GoBack,
	kControlType_ViewTeam,
	kControlType_SetupTeam,
	kControlType_TeamSelect,
	kControlType_SingleGame,
	kControlType_Tournament,
	kControl_Idle,
	kControl_Scaling,
	kControl_Selected,
	kGameState_Running,
	kGameState_Paused,
	kGameState_Loading,
	kSceneState_Idle,
	kSceneState_TransitionIn,
	kSceneState_TransitionOut,
	kSceneState_Running,
	kSceneState_Paused
};


#pragma mark -
#pragma mark Types

typedef struct _TileVert {
	GLfloat v[2];
	GLfloat uv[2];
} TileVert;

typedef struct _Color4f {
	GLfloat red;
	GLfloat green;
	GLfloat blue;
	GLfloat alpha;
} Color4f;

typedef struct _Vector2f {
	GLfloat x;
	GLfloat y;
} Vector2f;

typedef struct _Quad2f {
	GLfloat bl_x, bl_y;
	GLfloat br_x, br_y;
	GLfloat tl_x, tl_y;
	GLfloat tr_x, tr_y;
} Quad2f;

typedef struct _Particle {
	Vector2f position;
	Vector2f direction;
	Color4f color;
	Color4f deltaColor;
	GLfloat particleSize;
	GLfloat timeToLive;
} Particle;


typedef struct _PointSprite {
	GLfloat x;
	GLfloat y;
	GLfloat size;
} PointSprite;

#pragma mark -
#pragma mark Inline Functions

static const Color4f Color4fInit = {1.0f, 1.0f, 1.0f, 1.0f};

static const Vector2f Vector2fZero = {0.0f, 0.0f};

static inline Vector2f Vector2fMake(GLfloat x, GLfloat y)
{
	return (Vector2f) {x, y};
}

static inline Color4f Color4fMake(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha)
{
	return (Color4f) {red, green, blue, alpha};
}

static inline Vector2f Vector2fMultiply(Vector2f v, GLfloat s)
{
	return (Vector2f) {v.x * s, v.y * s};
}

static inline Vector2f Vector2fAdd(Vector2f v1, Vector2f v2)
{
	return (Vector2f) {v1.x + v2.x, v1.y + v2.y};
}

static inline Vector2f Vector2fSub(Vector2f v1, Vector2f v2)
{
	return (Vector2f) {v1.x - v2.x, v1.y - v2.y};
}

static inline GLfloat Vector2fDot(Vector2f v1, Vector2f v2)
{
	return (GLfloat) v1.x * v2.x + v1.y * v2.y;
}

static inline GLfloat Vector2fLength(Vector2f v)
{
	return (GLfloat) sqrtf(Vector2fDot(v, v));
}

static inline Vector2f Vector2fNormalize(Vector2f v)
{
	return Vector2fMultiply(v, 1.0f/Vector2fLength(v));
}
