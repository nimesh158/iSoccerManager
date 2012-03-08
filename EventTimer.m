//
//  EventTimer.m
//  SoccerManager
//
//  Created by NIMESH DESAI on 11/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EventTimer.h"


@implementation EventTimer

@synthesize interval;


- (void)dealloc {
    [_invocation release];
    [super dealloc];
}


- (id)init {
    // Do not allow this class to be initialized using init
    @throw [NSException exceptionWithName:@"EventTimerInvalid" 
                                   reason:@"initWithTarget:selector should be used." userInfo:nil];
}


+ (id)timerWithTarget:(id)aTarget selector:(SEL)aSelector {
    // When returning a timer from this class method, it is marked for autorelease and it
    // is therefore the responsbility of the caller to retain it.
    return [[[self alloc] initWithTarget:aTarget selector:aSelector] autorelease];
}


- (id)initWithTarget:(id)aTarget selector:(SEL)aSelector {
    return [self initWithTarget:aTarget selector:aSelector interval:0];
}


+ (id)timerWithTarget:(id)aTarget selector:(SEL)aSelector interval:(float)aInterval {
    // When returning a timer from this class method, it is marked for autorelease and it
    // is therefore the responsbility of the caller to retain it.
    return [[[self alloc] initWithTarget:aTarget selector:aSelector interval:aInterval] autorelease];
}


- (id)initWithTarget:(id)aTarget selector:(SEL)aSelector interval:(float)aInterval {
    if(!(self==[super init]))
        return nil;
    
    // Set the interval and the elapsed time
    interval = aInterval;
    _elapsedTime = 0;
    
    // Create a method signature based on the target and selector which were provided for this 
    // timer.  This will then allow us to invoke that method within the target when this
    // timer fires.
    NSMethodSignature *methodSignature = [[aTarget class] instanceMethodSignatureForSelector:aSelector];
    _invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [_invocation setTarget:aTarget];
    [_invocation setSelector:aSelector];
    [_invocation retainArguments];
    [_invocation retain];
    return self;
}


- (void)timerUpdate:(float)aDelta {

    _elapsedTime += aDelta;

    // If the elapsed time is not greater than the interval which has been set, invoke the
    // configured selector within the configured target
    if(_elapsedTime >= interval) {

        // Argument 1 is a hidden argument which is always there, so user defined arguments start
        // from index 2.  We are passing in the |aDelta| value to the selector
        [_invocation setArgument:&_elapsedTime atIndex:2];
        [_invocation invoke];

        // We need to make sure that the elapsed time is updated correctly to maintain a consistant
        // update.  For example, if the interval = 0.5f and the delta was 0.8f the timer will fire,
        // but rather than setting the |_elapsedTime| back to 0, we need to set it to 0.3f which is 
        // the different between the delta and the interval.
        _elapsedTime = _elapsedTime - interval;
    }
}
                                                                                              
@end
