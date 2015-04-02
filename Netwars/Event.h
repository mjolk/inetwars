//
//  Event.h
//  Netwars
//
//  Created by amjolk on 30/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayerTracker;

typedef void (^EventList)(NSMutableArray *events, NSString *cursor);

@interface Event : NSObject

@property(nonatomic, strong) NSString *clan;
@property(nonatomic, strong) NSString *clanName;
@property(nonatomic, assign) NSUInteger clanId;
@property(nonatomic, strong) NSString *playerName;
@property(nonatomic, assign) NSUInteger playerId;
@property(nonatomic, strong) NSString *targetName;
@property(nonatomic, assign) NSUInteger targetId;
@property(nonatomic, strong) NSString *expires;
@property(nonatomic, assign) CGFloat newBandwidthUsage;
@property(nonatomic, strong) NSString *eventType;
@property(nonatomic, assign) BOOL *direction; //NO = IN YES = OUT
@property(nonatomic, strong) NSString *occurred;
@property(nonatomic, assign) NSUInteger eventId;
@property(nonatomic, strong) NSMutableArray *eventPrograms;
@property(nonatomic, assign) CGFloat bandwidthLost;
@property(nonatomic, assign) NSUInteger programsLost;
@property(nonatomic, assign) CGFloat bandwidthKilled;
@property(nonatomic, assign) NSUInteger yieldLost;
@property(nonatomic, assign) NSUInteger programsKilled;
@property(nonatomic, assign) NSUInteger apsGained;
@property(nonatomic, assign) NSUInteger cpsGained;
@property(nonatomic, assign) NSUInteger cyclesGained;
@property(nonatomic, assign) NSUInteger cycles;
@property(nonatomic, assign) NSUInteger memory;
@property(nonatomic, strong) NSString *action;
@property(nonatomic, strong) NSDictionary *dict;
@property(nonatomic, assign) BOOL win;

- (id) initWithValues:(NSDictionary *) values;
+ (NSURLSessionDataTask *) list:(NSString *) tpe cursor:(NSString *) c callback:(EventList) block;

@end

@interface EventProgram : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) CGFloat amount;
@property(nonatomic, strong) NSMutableArray *children;
@property(nonatomic, strong) NSString *typeName;
@property(nonatomic, assign) NSUInteger amountUsed;
@property(nonatomic, assign) BOOL owned;

- (id) initWithValues:(NSDictionary *) values;

@end
