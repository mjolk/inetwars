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

@interface Player ()

@end

@implementation Player

+ (id)sharedPlayer {
	static id _sharedPlayer = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedPlayer = [[self alloc] initWithDefaults];
	});
    
	return _sharedPlayer;
}

- (id)initWithDefaults {
	self = [super init];
    
	if (self) {
		NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
		NSString *playerKey = [data objectForKey:@"playerKey"];
        //playerKey = @"agtkZXZ-bjN0d2Fyc3IsCxIGUGxheWVyIiA1NTE5NTIwNjQwNDFlODI4ODA2ZjNjZTcwOTBlODIwZQw";
		if (playerKey == nil) {
			self.notAuthenticated = YES;
		}
		else {
			self.notAuthenticated = NO;
			self.playerKey = playerKey;
		}
	}
    
	return self;
}

- (id) initForPublic:(NSDictionary *)values {
    self = [super init];
    if (self) {
        self.nick = [values objectForKey:@"nick"];
        self.bandwidthUsage = [[values objectForKey:@"bandwidth_usage"] floatValue];
        self.clanTag = [values objectForKey:@"clan_tag"];
        self.avatar = [values objectForKey:@"avatar_thumb"];
        self.playerID = [[values objectForKey:@"player_id"] integerValue];
        self.status = [values objectForKey:@"status"];
        self.publicKey = [values objectForKey:@"key"];
    }
    return self;
}

- (void)persistKey {
	NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
	[data setObject:self.playerKey forKey:@"playerKey"];
	[data synchronize];
}

- (void)update:(NSDictionary *)values {
	NSDictionary *player = [values objectForKey:@"player"];
	self.cps = [[player objectForKey:@"cps"] integerValue];
	self.aps = [[player objectForKey:@"aps"] integerValue];
	self.bandwidth = [[player objectForKey:@"bandwidth"] integerValue];
	self.bandwidthUsage = [[player objectForKey:@"bandwidth_usage"] floatValue];
	self.memory = [[player objectForKey:@"mem"] integerValue];
	self.cycles = [[player objectForKey:@"cycles"]integerValue];
	self.activeMemory = [[player objectForKey:@"active_mem"] integerValue];
	self.newLocals = [[player objectForKey:@"new_locals"] integerValue];
    NSArray *pGroups = [values objectForKey:@"programs"];
    self.programs = [[NSMutableArray alloc] initWithCapacity:[pGroups count]];
    for (NSDictionary *pGroup in pGroups) {
        [self.programs addObject:[[ProgramGroup alloc] initWithValues:pGroup]];
    }
    
	NSLog(@" updated : %d", self.memory);
}

- (NSURLSessionDataTask *) create:(NSString *)n email:(NSString *)e callback:(PlayerCreate)block {
    __weak Player *weakPlayer = self;
    return [[AFNetClient sharedClient] POST:@"player_create" parameters:@{@"nick":n, @"email":e} success:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL status = [[responseObject objectForKey:@"success"]boolValue];
        if(status) {
            weakPlayer.playerKey = [responseObject objectForKey:@"result"];
            weakPlayer.email = e;
            weakPlayer.nick = n;
            weakPlayer.notAuthenticated = NO;
            block(nil);
        } else {
            NSDictionary *errors = [responseObject objectForKey:@"result"];
            block(errors);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //errors
    }];
}

- (NSURLSessionDataTask *) state:(PlayerState)block {
    __weak Player *wPlayer = self;
    return [[AFNetClient sharedClient] GET:@"player_status" parameters:@{@"pkey": self.playerKey} success:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL status = [[responseObject objectForKey:@"success"] boolValue];
        if(status){
            [wPlayer update:[responseObject objectForKey:@"result"]];
            block(NO);
        } else {
            block(YES);
        }
    }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           //send error message
       }];
}

+ (NSURLSessionDataTask *) list:(NSString *)playerKey range:(BOOL) rnge cursor:(NSString *) c callback:(PlayerList) block {
    return [[AFNetClient sharedClient] GET:@"player_list" parameters:@{@"pkey":playerKey, @"range":[NSNumber numberWithBool:rnge], @"c": c} success:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL status = [[responseObject objectForKey:@"success"] boolValue];
        if (status) {
            NSLog(@"result players: %@", responseObject);
            NSDictionary *listObj = [responseObject objectForKey:@"result"];
            NSString *cur = [listObj objectForKey:@"cursor"];
            NSArray *dictPls = [listObj objectForKey:@"players"];
            NSMutableArray *pls = [[NSMutableArray alloc] initWithCapacity:[listObj count]];
            for(NSDictionary *pDict in dictPls) {
                [pls addObject:[[Player alloc] initForPublic:pDict]];
            }
            block(pls, cur);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}



- (NSURLSessionDataTask *) allocate:(NSUInteger) dir program:(NSString *) prgKey amount:(NSUInteger) a allocBlock:(PlayerAllocate)block {
    NSString *aType = @"";
    switch (dir) {
        case 0:
            aType = @"player_allocate";
            break;
            
        case 1:
            aType = @"player_deallocate";
            break;
    }
    return [[AFNetClient sharedClient] POST:aType parameters:@{@"pkey": self.playerKey, @"prgkey": prgKey, @"amount": [NSString stringWithFormat:@"%d", a]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject != nil){
            NSLog(@"error response : %@ \n", responseObject);
            block(YES);
            NSString *error = [responseObject objectForKey:@"error"];
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            block(NO);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}

@end
