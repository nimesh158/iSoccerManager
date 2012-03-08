//
//  EventTimer.h
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// This class provides timer functionality for events.  A timer can be created which has
// an interval at which is fires the supplied selector within the supplied target.  It 
// can also just file each game cycle without the use of an interval.
// Timers are used within the EventScheduling class which is where all event timers are 
// both scheduled and unscheduled.
//
@interface EventTimer : NSObject {
 @private
    NSInvocation *_invocation;
    float _elapsedTime;
 @protected
    float interval;
}

@property (nonatomic, assign) float interval;

// Returns a timer instance which has been configured with the supplied target and selector.
// The returned timer does not have an interval and will be fired on each game logic cycle.
// The selector which is fired will be passed the |delta| allowing the called selector to 
// use the elapsed time as necessary.  The returned timer will continue to file until it is 
// manually unscheduled through the EventScheduler.  The timer returned is marked for autorelease
// and it is therefore the responsibility of the caller to retain it.
+ (id)timerWithTarget:(id)aTarget selector:(SEL)aSelector;

// Initializes a timer configured with the supplied target and selector.  The returned 
// timer does not have an interval and will be fired on each game logic cycle.
// The selector which is fired will be passed the |delta| allowing the called selector to 
// use the elapsed time as necessary.  The returned timer will continue to file until it is 
// manually unscheduled through the EventScheduler.
- (id)initWithTarget:(id)aTarget selector:(SEL)aSelector;

// Returns a timer instance which has been configured with the supplied target, selector and interval.
// The returned timer will only fire when the elapsed time supplied has been exceeded.  The
// returned timer will continue to file until it is manually unscheduled through the EventScheduler.
// The timer returned is marked for autorelease and it is therefore the responsibility of the caller to 
// retain it.
+ (id)timerWithTarget:(id)aTarget selector:(SEL)aSelector interval:(float)aInterval;

// Desginated selector
// Initializes a timer instance which has been configured with the supplied target, selector and interval.
// The returned timer will only fire with the elapsed time defined for the timer has been exceeded.  The
// returned timer will continue to file until it is manually unscheduled through the EventScheduler.
- (id)initWithTarget:(id)aTarget selector:(SEL)aSelector interval:(float)aInterval;

// This method is used to update this timer.  When called it will check to see if the timer should
// fire based on the interval which has been defined.  If it should fire then the configured selector
// is called within the configured target.
- (void)timerUpdate:(float)aDelta;

@end