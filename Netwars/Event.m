//
//  Event.m
//  Netwars
//
//  Created by amjolk on 30/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Event.h"
#import "AFNetClient.h"

@implementation Event

- (id) initWithValues:(NSDictionary *)values {
    self = [super init];
    if (self) {
        self.dict = values;
        self.clan = [values objectForKey:@"clan"];
        self.clanId = [[values objectForKey:@"clan_id"] integerValue];
        self.clanName = [values objectForKey:@"clan_name"];
        self.playerId = [[values objectForKey:@"player_id"] integerValue];
        self.playerName = [values objectForKey:@"player_name"];
        self.targetId = [[values objectForKey:@"target_id"] integerValue];
        self.targetName = [values objectForKey:@"target_name"];
        self.expires = [values objectForKey:@"expires"];
        self.occurred = [values objectForKey:@"created"];
        self.action = [values objectForKey:@"action"];
        self.eventId = [[values objectForKey:@"event_id"] integerValue];
        self.eventType = [values objectForKey:@"event_type"];
        self.newBandwidthUsage = [[values objectForKey:@"new_bandwidth_usage"] floatValue];
        self.eventPrograms = [[NSMutableArray alloc] init];
        self.cpsGained = [[values objectForKey:@"cps_gained"] integerValue];
        self.apsGained = [[values objectForKey:@"aps_gained"] integerValue];
        self.bandwidthLost = [[values objectForKey:@"bw_lost"] floatValue];
        self.bandwidthKilled = [[values objectForKey:@"bw_killed"] floatValue];
        self.programsKilled = [[values objectForKey:@"programs_killed"] integerValue];
        self.programsLost = [[values objectForKey:@"programs_lost"] integerValue];
        self.cyclesGained = [[values objectForKey:@"cycles_gained"] integerValue];
        self.cycles = [[values objectForKey:@"cycles_cost"] integerValue];
        self.yieldLost = [[values objectForKey:@"yield_lost"] integerValue];
        self.win = [[values objectForKey:@"result"] boolValue];
        for(NSDictionary *ep in [values objectForKey:@"event_programs"]) {
            if ([[ep objectForKey:@"type_name"] length] == 0) {
                EventProgram *eprog = [[EventProgram alloc] initWithValues:ep];
                for(NSDictionary *ep_ in [values objectForKey:@"event_programs"]) {
                    NSString *typeName = [ep_ objectForKey:@"type_name"];
                    if([typeName length] > 0) {
                        if ([eprog.name isEqualToString:typeName]) {
                            [eprog.children addObject:[[EventProgram alloc] initWithValues:ep_]];
                        }
                    }
                }
                [self.eventPrograms addObject:eprog];
            }
        }
        
        
    }
    return self;
}

+ (NSURLSessionDataTask *) list:(NSString *)playerKey eventType:(NSString *) tpe cursor:(NSString *) c callback:(EventList) block {
    return [[AFNetClient sharedClient] GET:@"players/events" parameters:@{@"pkey":playerKey, @"c":c, @"loc":tpe} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *listObj = [responseObject objectForKey:@"result"];
            NSString *cursor = [listObj objectForKey:@"c"];
            NSArray *eventDicts = [listObj objectForKey:@"events"];
            NSMutableArray *events = [[NSMutableArray alloc] initWithCapacity:[eventDicts count]];
            for(NSDictionary *eDict in eventDicts) {
                [events addObject:[[Event alloc] initWithValues:eDict]];
            }
            block(events, cursor);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}

+ (NSURLSessionDataTask *) tracker:(NSString *)playerKey clan:(NSString *) clanKey callback:(Tracker)block {
    return [[AFNetClient sharedClient] GET:@"players/trackers" parameters:@{@"pkey":playerKey, @"ckey":clanKey} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *tr = [responseObject objectForKey:@"result"];
        PlayerTracker *tracker = [[PlayerTracker alloc] initWithValues:tr];
        block(tracker);
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        //error
    }];
}

@end

@implementation EventProgram
            
- (id) initWithValues:(NSDictionary *) values {
    self = [super init];
    if(self) {
        self.name = [values objectForKey:@"name"];
        self.amount = [[values objectForKey:@"amount"] floatValue];
        self.amountUsed = [[values objectForKey:@"amount_used"] integerValue];
        self.owned = [[values objectForKey:@"owned"] boolValue];
        self.typeName = [values objectForKey:@"type_name"];
        self.children = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

@implementation PlayerTracker

- (id) initWithValues:(NSDictionary *)values {
    self = [super init];
    if (self) {
        self.eventCount = [[values objectForKey:@"event_count"] integerValue];
        self.messageCount = [[values objectForKey:@"message_count"] integerValue];
    }
    return self;
}

@end
