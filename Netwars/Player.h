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
typedef void (^PlayerList)(NSMutableArray *players, NSString *cursor);

@interface Player : NSObject

@property(nonatomic, assign) NSUInteger cycles;
@property(nonatomic, assign) NSUInteger memory;
@property(nonatomic, assign) NSUInteger activeMemory;
@property(nonatomic, assign) NSUInteger bandwidth;
@property(nonatomic, assign) CGFloat bandwidthUsage;
@property(nonatomic, assign) NSUInteger cps;
@property(nonatomic, assign) NSUInteger aps;
@property(nonatomic, strong) NSString *playerKey;
@property(nonatomic, strong) NSString *publicKey;
@property(nonatomic, strong) NSMutableArray *programs;
@property(nonatomic, assign) NSUInteger newLocals;
@property(nonatomic, assign) BOOL notAuthenticated;
@property(nonatomic, strong) NSString *nick;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSDate *updated;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, assign) NSUInteger playerID;
@property(nonatomic, strong) NSString *clanTag;
@property(nonatomic, strong) NSString *clan;
@property(nonatomic, strong) NSString *status;

+ (id)sharedPlayer;
- (NSURLSessionDataTask *) create:(NSString *)n email:(NSString *)e callback:(PlayerCreate) block;
//- (void) state:(PlayerState) block;
- (NSURLSessionDataTask *) state:(PlayerState) block;
- (NSURLSessionDataTask *) allocate:(NSUInteger) dir program:(NSString *) prgKey amount:(NSUInteger) a allocBlock:(PlayerAllocate)block;
+ (NSURLSessionDataTask *) list:(NSString *)playerKey range:(BOOL) rnge cursor:(NSString *) c callback:(PlayerList) block;
- (id) initWithDefaults;
- (void) update:(NSDictionary *) values;
- (id) initForPublic:(NSDictionary *) values;
- (void) persistKey;

@end
