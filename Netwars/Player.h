//
//  Player.h
//  Netwars
//
//  Created by mjolk on 17/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;

typedef void (^PlayerCreate)(NSDictionary *errors);
typedef void (^PlayerState)(BOOL);
typedef void (^PlayerAllocate)(BOOL);

@interface Player : NSObject

@property(nonatomic, assign) NSUInteger cycles;
@property(nonatomic, assign) NSUInteger memory;
@property(nonatomic, assign) NSUInteger activeMemory;
@property(nonatomic, assign) NSUInteger bandwidth;
@property(nonatomic, assign) CGFloat bandwidthUsage;
@property(nonatomic, assign) NSUInteger cps;
@property(nonatomic, assign) NSUInteger aps;
@property(nonatomic, strong) NSString *playerKey;
@property(nonatomic, strong) NSMutableArray *programs;
@property(nonatomic, assign) NSUInteger newLocals;
@property(nonatomic, assign) BOOL authenticated;

+ (id)sharedPlayer;
- (void) update:(NSDictionary *) values;
- (void) create:(PlayerCreate) block;
- (void) state:(PlayerState) block;
- (void) allocate:(PlayerAllocate) block;
- (id) initWithDefaults;

@end
