//
//  Clan.h
//  Netwars
//
//  Created by mjolk on 20/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClanConnection : NSObject

@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *expires;
@property (nonatomic, assign) NSUInteger attacker;
@property (nonatomic, assign) NSUInteger defender;
@property (nonatomic, strong) NSString *attackerName;
@property (nonatomic, strong) NSString *defenderName;
@property (nonatomic, assign) NSUInteger declaredBy;
- (id)initWithValues:(NSDictionary *)dict;


@end


@class Clan;

typedef void (^ClanCreate)(BOOL);
typedef void (^ClanState) (Clan *);

@interface Clan : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, assign) CGFloat bandwidthUsage;
@property (nonatomic, assign) NSUInteger clanPoints;
@property (nonatomic, assign) NSUInteger amountPlayers;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, strong) NSMutableArray *wars;
@property (nonatomic, strong) NSMutableArray *members;

+ (NSURLSessionDataTask *)create:(NSString *)n tag:(NSString *)t callback:(ClanCreate)block;
+ (NSURLSessionDataTask *)state:(ClanState)block;
- (id)initWithValues:(NSDictionary *)dict public:
    (BOOL)pub;

@end
