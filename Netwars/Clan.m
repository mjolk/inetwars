//
//  Clan.m
//  Netwars
//
//  Created by mjolk on 20/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Clan.h"
#import "AFNetClient.h"
#import "Player.h"


@implementation ClanConnection

- (id) initWithValues:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.created = [dict objectForKey:@"created"];
        self.attackerName = [dict objectForKey:@"attacker_name"];
        self.defenderName = [dict objectForKey:@"defender_name"];
        self.attacker = [[dict objectForKey:@"attacker"]integerValue];
        self.defender = [[dict objectForKey:@"defender"]integerValue];
        self.expires = [dict objectForKey:@"expires"];
        
    }
    return self;
}

@end

@implementation Clan

+ (NSURLSessionDataTask *)create:(NSString *)n tag:(NSString *)t callback:(ClanCreate)block {
	return [[AFNetClient authPOST] PUT:@"clans/" parameters:@{ @"name":n, @"tag":t } success: ^(NSURLSessionDataTask *task, id responseObject) {
	    block(YES);
	} failure: ^(NSURLSessionDataTask *task, NSError *error) {
	    //errors
	}];
}

+ (NSURLSessionDataTask *)state:(ClanState)block {
	return [[AFNetClient authGET] GET:@"clans/status/" parameters:nil success: ^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"clan: %@", responseObject);
        Clan *cl = [[Clan alloc] initWithValues:[responseObject objectForKey:@"result"] public:NO];
	    block(cl);
	} failure: ^(NSURLSessionDataTask *task, NSError *error) {
	}];
}

- (id)initWithValues:(NSDictionary *)dict public:(BOOL) pub{
	self = [super init];
	if (self) {
		self.name = [dict objectForKey:@"clan_name"];
		self.tag = [dict objectForKey:@"clan_tag"];
		self.ID = [[dict objectForKey:@"clan_id"] integerValue];
		self.bandwidthUsage = [[dict objectForKey:@"bandwidth_usage"] floatValue];
		self.clanPoints = [[dict objectForKey:@"cps"] integerValue];
		self.amountPlayers = [[dict objectForKey:@"amount_players"] integerValue];
		self.avatar = [dict objectForKey:@"avatar"];
		self.message = [dict objectForKey:@"message"];
		self.site = [dict objectForKey:@"clan_site"];
		self.descr = [dict objectForKey:@"description"];
        NSDictionary *members = [dict objectForKey:@"clan_members"];
        if (![members isEqual:[NSNull null]]) {
            if ([members count] > 0) {
                for (NSDictionary *member in members) {
                    pub?[self.members addObject:[[Player alloc] initForPublicClan:member]]:[self.members addObject:[[Player alloc] initForPrivateClan:member]];
                }
            }
        }
        NSDictionary *wars = [dict objectForKey:@"wars"];
        if (![wars isEqual:[NSNull null]]) {
            if ([wars count] > 0 && !pub) {
                for (NSDictionary *war in wars) {
                    [self.wars addObject:[[ClanConnection alloc] initWithValues:war]];
                }
            }
        }
	}
	return self;
}

@end
