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
typedef void (^PlayerList)(NSMutableArray *players, NSString *cursor);

@interface PlayerTracker : NSObject

@property (nonatomic, assign) NSUInteger eventCount;
@property (nonatomic, assign) NSUInteger messageCount;

- (id)initWithValues:(NSDictionary *)values;

@end

@interface Player : NSObject

@property (nonatomic, assign) NSUInteger cycles;
@property (nonatomic, assign) NSUInteger memory;
@property (nonatomic, assign) NSUInteger activeMemory;
@property (nonatomic, assign) NSUInteger bandwidth;
@property (nonatomic, assign) CGFloat bandwidthUsage;
@property (nonatomic, assign) NSUInteger cps;
@property (nonatomic, assign) NSUInteger aps;
@property (nonatomic, strong) NSString *playerKey;
@property (nonatomic, strong) NSMutableArray *programs;
@property (nonatomic, assign) NSUInteger newLocals;
@property (nonatomic, assign) BOOL authenticated;
@property (nonatomic, assign) BOOL clanMember;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, strong) NSString *clanTag;
@property (nonatomic, strong) NSString *clan;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *memberType;
@property (nonatomic, strong) PlayerTracker *tracker;


-(BOOL) isEqualToPlayer:(Player *) player;
+ (id)sharedPlayer;
+ (NSURLSessionDataTask *)create:(NSString *)n email:(NSString *)e password:(NSString *)pw callback:(PlayerCreate)block;
- (NSURLSessionDataTask *)state:(PlayerState)block;
- (NSURLSessionDataTask *)invite:(PlayerState)block;
+ (NSURLSessionDataTask *)list:(uint)rnge cursor:(NSString *)c callback:(PlayerList)block;
+ (NSURLSessionDataTask *)login:(NSString *)email password:(NSString *) pw callback:(PlayerState)block;
- (id)initWithDefaults;
- (void)update:(NSDictionary *)values;
- (id)initForPublic:(NSDictionary *)values;
- (id)initForPublicClan:(NSDictionary *)values;
- (id)initForPrivateClan:(NSDictionary *)values;
- (void)persistKey;

@end
