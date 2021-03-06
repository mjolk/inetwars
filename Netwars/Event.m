//
//  Event.m
//  Netwars
//
//  Created by amjolk on 30/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Event.h"
#import "AFNetClient.h"
#import "Clan.h"
#import "Player.h"

@implementation Event

- (id)initWithValues:(NSDictionary *)values
{
    self = [super init];
    if (self) {
        self.dict = values;
        self.targetPlayer = [[Player alloc] init];
        self.targetClan = [[Clan alloc] init];
        self.eventType = [values objectForKey:@"event_type"];
        self.action = [values objectForKey:@"action"];
        if ([self.eventType isEqualToString:@"Clan"]) {
            [self.targetClan setName:[self.dict objectForKey:@"target_name"]];
            [self.targetClan setID:[[self.dict objectForKey:@"target_id"] integerValue]];
        } else {
        }
        [self.targetClan setName:[values objectForKey:@"clan_name"]];
        [self.targetClan setID:[[values objectForKey:@"clan_id"] integerValue]];
        [self.targetPlayer setID:[[values objectForKey:@"target_id"] integerValue]];
        [self.targetPlayer setNick:[values objectForKey:@"target_name"]];
        self.expires = [values objectForKey:@"expires"];
        self.occurred = [values objectForKey:@"created"];
        
        self.ID = [[values objectForKey:@"event_id"] integerValue];
        
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
        self.result = [[values objectForKey:@"result"] boolValue];
        for (NSDictionary *ep in[values objectForKey:@"event_programs"]) {
            if ([[ep objectForKey:@"type_name"] length] == 0) {
                EventProgram *eprog = [[EventProgram alloc] initWithValues:ep];
                for (NSDictionary *ep_ in[values objectForKey:@"event_programs"]) {
                    NSString *typeName = [ep_ objectForKey:@"type_name"];
                    if ([typeName length] > 0) {
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

+ (NSURLSessionDataTask *)list:(NSString *)tpe cursor:(NSString *)c callback:(EventList)block
{
    NSString *path = [NSString stringWithFormat:@"players/%@events/", tpe];
    if ([c length] > 0) {
        path = [NSString stringWithFormat:@"%@/%@/", path, c];
    }
    return [[AFNetClient authGET] GET:path parameters:nil success: ^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"events response %@", responseObject);
        NSDictionary *listObj = [responseObject objectForKey:@"result"];
        NSString *cursor = [listObj objectForKey:@"c"];
        NSArray *eventDicts = [listObj objectForKey:@"events"];
        NSMutableArray *events = [[NSMutableArray alloc] init];
        if (eventDicts != (id)[NSNull null]) {
            events = [[NSMutableArray alloc] initWithCapacity:[eventDicts count]];
            for (NSDictionary *eDict in eventDicts) {
                [events addObject:[[Event alloc] initWithValues:eDict]];
            }
        }
        block(events, cursor);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}

@end

@implementation EventProgram

- (id)initWithValues:(NSDictionary *)values
{
    self = [super init];
    if (self) {
        self.name = [values objectForKey:@"name"];
        self.amount = [[values objectForKey:@"amount"] floatValue];
        self.amountUsed = [[values objectForKey:@"amount_used"] integerValue];
        self.owned = [[values objectForKey:@"owned"] boolValue];
        self.typeName = [values objectForKey:@"type_name"];
    }
    return self;
}

@end
