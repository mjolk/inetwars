//
//  Clan.h
//  Netwars
//
//  Created by mjolk on 20/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ClanCreate)(BOOL);

@interface Clan : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *tag;
@property(nonatomic, assign) NSUInteger ID;
@property(nonatomic, assign) CGFloat bandwidthUsage;
@property(nonatomic, assign) NSUInteger clanPoints;
@property(nonatomic, assign) NSUInteger amountPlayers;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSString *site;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSArray *players;

@end
