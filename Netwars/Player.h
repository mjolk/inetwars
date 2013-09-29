//
//  Player.h
//  Netwars
//
//  Created by mjolk on 17/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetClient.h"
#import "Player.h"
#import "Program.h"

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
@property(nonatomic, assign) BOOL notAuthenticated;
@property(nonatomic, strong) NSString *nick;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSDate *updated;

+ (id)sharedPlayer;
- (void) create:(NSString *)n email:(NSString *)e callback:(PlayerCreate) block;
- (void) state:(PlayerState) block;
- (void) allocate:(NSUInteger) dir program:(NSString *) prgKey amount:(NSUInteger) a allocBlock:(PlayerAllocate)block;
- (id) initWithDefaults;
- (void) update:(NSDictionary *) values;
- (void) persistKey;

@end
