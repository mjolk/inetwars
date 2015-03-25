//
//  Player.m
//  Netwars
//
//  Created by mjolk on 17/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Player.h"
#import "AFNetClient.h"
#import "Program.h"
#import "Invite.h"

@interface Player ()
-(void) updatePublic:(NSDictionary *) values;
@end

@implementation Player

+ (id)sharedPlayer {
	static id _sharedPlayer = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedPlayer = [[Player alloc] initWithDefaults];
	});
    
	return _sharedPlayer;
}

- (id)initWithDefaults {
	self = [super init];
    
	if (self) {
		NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
		NSString *playerKey = [data objectForKey:@"playerKey"];
		if (playerKey == nil || [playerKey length] < 5) {
			self.authenticated = NO;
		}
		else {
			self.authenticated = YES;
			self.playerKey = playerKey;
		}
	}
    
	return self;
}

- (id) initForPublic:(NSDictionary *)values {
    self = [super init];
    if (self) {
        [self updatePublic:values];
        self.bandwidthUsage = [[values objectForKey:@"bandwidth_usage"] floatValue];
        self.publicKey = [values objectForKey:@"key"];
    }
    return self;
}

- (void) updatePublic:(NSDictionary *) values {
    self.nick = [values objectForKey:@"nick"];
    self.clanTag = [values objectForKey:@"clan_tag"];
    self.avatar = [values objectForKey:@"avatar_thumb"];
    self.playerID = [[values objectForKey:@"player_id"] integerValue];
    self.status = [values objectForKey:@"status"];
    self.email = [values objectForKey:@"email"];
    
}

- (void)persistKey {
	NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
	[data setObject:self.playerKey forKey:@"playerKey"];
	[data synchronize];
}

- (void)update:(NSDictionary *)player {
	self.cps = [[player objectForKey:@"cps"] integerValue];
	self.aps = [[player objectForKey:@"aps"] integerValue];
	self.bandwidth = [[player objectForKey:@"bandwidth"] integerValue];
	self.bandwidthUsage = [[player objectForKey:@"bandwidth_usage"] floatValue];
	self.memory = [[player objectForKey:@"mem"] integerValue];
	self.cycles = [[player objectForKey:@"cycles"]integerValue];
	self.activeMemory = [[player objectForKey:@"active_mem"] integerValue];
	self.newLocals = [[player objectForKey:@"new_locals"] integerValue];
    self.publicKey = [player objectForKey:@"public_key"];
    self.tracker = [[PlayerTracker alloc] initWithValues:[player objectForKey:@"tracker"]];
    NSArray *pGroups = [player objectForKey:@"programs"];
    self.programs = [[NSMutableArray alloc] initWithCapacity:[pGroups count]];
    for (NSDictionary *pGroup in pGroups) {
        [self.programs addObject:[[ProgramGroup alloc] initWithValues:pGroup]];
    }
}

+ (NSURLSessionDataTask *) create:(NSString *)n email:(NSString *)e callback:(PlayerCreate)block {
    __weak Player *weakPlayer = [Player sharedPlayer];
    return [[AFNetClient sharedClient] POST:@"players/" parameters:@{@"nick":n, @"email":e} success:^(NSURLSessionDataTask *task, id responseObject) {
            weakPlayer.playerKey = [responseObject objectForKey:@"result"];
            weakPlayer.authenticated = YES;
            block(nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //errors
    }];
}

- (NSURLSessionDataTask *) state:(PlayerState)block {
    __weak Player *wPlayer = self;
    return [[AFNetClient sharedClient] GET:@"players/status" parameters:@{@"pkey": self.playerKey} success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"response: %@", responseObject);
            [wPlayer update:[responseObject objectForKey:@"result"]];
            block(NO);
    }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           //send error message
       }];
}

- (NSURLSessionDataTask *) profile:(PlayerProfile) block {
    __weak Player *wPlayer = self;
    return [[AFNetClient sharedClient] GET:@"players/profile" parameters:@{@"pkey": self.playerKey} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"profile %@ \n", responseObject);
            [wPlayer updatePublic:[responseObject objectForKey:@"result"]];
            block(NO);
        }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           //send error message
       }];
}

+ (NSURLSessionDataTask *) list:(NSString *)playerKey range:(BOOL) rnge cursor:(NSString *) c callback:(PlayerList) block {
    return [[AFNetClient sharedClient] GET:@"players/" parameters:@{@"pkey":playerKey, @"range":[NSNumber numberWithBool:rnge], @"c": c} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"result players: %@", responseObject);
            NSDictionary *listObj = [responseObject objectForKey:@"result"];
            NSString *cur = [listObj objectForKey:@"cursor"];
            NSArray *dictPls = [listObj objectForKey:@"players"];
            NSMutableArray *pls = [[NSMutableArray alloc] initWithCapacity:[listObj count]];
            for(NSDictionary *pDict in dictPls) {
                [pls addObject:[[Player alloc] initForPublic:pDict]];
            }
            block(pls, cur);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}



- (NSURLSessionDataTask *) allocate:(NSUInteger) dir program:(NSString *) prgKey amount:(NSUInteger) a allocBlock:(PlayerAllocate)block {
    NSString *aType = @"";
    switch (dir) {
        case 0:
            aType = @"players/allocation";
            break;
            
        case 1:
            aType = @"players/deallocation";
            break;
    }
    return [[AFNetClient sharedClient] POST:aType parameters:@{@"pkey": self.playerKey, @"prgkey": prgKey, @"amount": [NSString stringWithFormat:@"%lu", (unsigned long)a]} success:^(NSURLSessionDataTask *task, id responseObject) {
            block(NO);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}

- (NSURLSessionDataTask *) invites:(PlayerInvites)block {
    return [[AFNetClient sharedClient] GET:@"clans/invitations" parameters:@{@"pkey": self.playerKey} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dictInvites = [responseObject objectForKey:@"result"];
        NSMutableArray *invites = [[NSMutableArray alloc] initWithCapacity:[dictInvites count]];
        for( NSDictionary *inv in dictInvites) {
            [invites addObject:[[Invite alloc] initWithValues:inv]];
        }
        block(invites);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}

@end
