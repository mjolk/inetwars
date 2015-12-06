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

@implementation PlayerTracker

- (id)initWithValues:(NSDictionary *)values
{
    self = [super init];
    if (self) {
        self.eventCount = [[values objectForKey:@"event_count"] integerValue];
        self.messageCount = [[values objectForKey:@"message_count"] integerValue];
    }
    return self;
}

@end

@interface Player ()
- (void)updatePublic:(NSDictionary *)values;
- (void)updateClan:(NSDictionary *)values;
@end

@implementation Player

+ (id)sharedPlayer
{
    static id _sharedPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPlayer = [[Player alloc] initWithDefaults];
    });
    
    return _sharedPlayer;
}

- (id)initWithDefaults
{
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
            self.clanMember = NO;
        }
    }
    
    return self;
}

- (BOOL)isEqualToPlayer:(Player *)player
{
    if(!player) {
        return NO;
    }
    
    BOOL equalNicks = (!self.nick && !player.nick) || [self.nick isEqualToString:player.nick];
    BOOL equalIds = (!self.ID && !player.ID) || self.ID == player.ID;
    
    return equalIds && equalNicks;
}

- (id)initForPublic:(NSDictionary *)values
{
    self = [super init];
    if (self) {
        [self updatePublic:values];
    }
    return self;
}

- (id)initForPublicClan:(NSDictionary *)values
{
    self = [super init];
    if (self) {
        [self updateClanPublic:values];
    }
    return self;
}

- (id)initForPrivateClan:(NSDictionary *)values
{
    self = [super init];
    if (self) {
        [self updateClan:values];
    }
    return self;
}

- (void)updatePublic:(NSDictionary *)values
{
    self.nick = [values objectForKey:@"nick"];
    self.clanTag = [values objectForKey:@"clan_tag"];
    self.avatar = [values objectForKey:@"avatar_thumb"];
    self.ID = [[values objectForKey:@"player_id"] integerValue];
    self.status = [values objectForKey:@"status"];
    self.bandwidthUsage = [[values objectForKey:@"bandwidth_usage"] floatValue];
}

- (void)updateClan:(NSDictionary *)values
{
    self.nick = [values objectForKey:@"nick"];
    self.clanTag = [values objectForKey:@"clan_tag"];
    self.avatar = [values objectForKey:@"avatar_thumb"];
    self.ID = [[values objectForKey:@"player_id"] integerValue];
    self.status = [values objectForKey:@"status"];
    self.bandwidthUsage = [[values objectForKey:@"bandwidth_usage"] floatValue];
    self.cps = [[values objectForKey:@"cps"] integerValue];
    self.bandwidth = [[values objectForKey:@"bandwidth"] integerValue];
    self.activeMemory = [[values objectForKey:@"active_mem"] integerValue];
    self.memberType = [values objectForKey:@"member"];
}

- (void)updateClanPublic:(NSDictionary *)values
{
    self.nick = [values objectForKey:@"nick"];
    self.clanTag = [values objectForKey:@"clan_tag"];
    self.avatar = [values objectForKey:@"avatar_thumb"];
    self.ID = [[values objectForKey:@"player_id"] integerValue];
    self.status = [values objectForKey:@"status"];
    self.bandwidthUsage = [[values objectForKey:@"bandwidth_usage"] floatValue];
    self.memberType = [values objectForKey:@"member"];
}

- (void)persistKey
{
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    [data setObject:self.playerKey forKey:@"playerKey"];
    [data synchronize];
}

- (void)update:(NSDictionary *)player
{
    self.cps = [[player objectForKey:@"cps"] integerValue];
    self.aps = [[player objectForKey:@"aps"] integerValue];
    self.bandwidth = [[player objectForKey:@"bandwidth"] integerValue];
    self.bandwidthUsage = [[player objectForKey:@"bandwidth_usage"] floatValue];
    self.memory = [[player objectForKey:@"mem"] integerValue];
    self.cycles = [[player objectForKey:@"cycles"]integerValue];
    self.activeMemory = [[player objectForKey:@"active_mem"] integerValue];
    self.clan = [player objectForKey:@"clan_member"];
    if (self.clan.length > 0) {
        self.clanMember = YES;
    }
    NSLog(@"clan member : %@", self.clan);
    [self updateClan:player];
    self.tracker = [[PlayerTracker alloc] initWithValues:[player objectForKey:@"tracker"]];
    NSArray *pGroups = [player objectForKey:@"programs"];
    self.programs = [[NSMutableArray alloc] initWithCapacity:[pGroups count]];
    for (NSDictionary *pGroup in pGroups) {
        [self.programs addObject:[[ProgramGroup alloc] initWithValues:pGroup]];
    }
}

+ (NSURLSessionDataTask *)create:(NSString *)n email:(NSString *)e password:(NSString *)pw callback:(PlayerCreate)block
{
    __weak Player *weakPlayer = [Player sharedPlayer];
    AFNetClient *client = [AFNetClient authPOST];
    return [client PUT:@"players/" parameters:@{ @"nick":n, @"email":e, @"pwd":pw } success: ^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"create player response: %@", responseObject);
        weakPlayer.playerKey = [responseObject objectForKey:@"result"];
        weakPlayer.authenticated = YES;
        block(nil);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        //errors
        NSLog(@"create player error %@", error);
    }];
}

+ (NSURLSessionDataTask *)login:(NSString *)email password:(NSString *)pw callback:(PlayerState)block
{
    __weak Player *weakPlayer = [Player sharedPlayer];
    AFNetClient *client = [AFNetClient authPOST];
    return [client POST:@"players/login/" parameters:@{ @"email":email, @"pwd":pw } success: ^(NSURLSessionDataTask *task, id responseObject) {
        weakPlayer.playerKey = [responseObject objectForKey:@"result"];
        weakPlayer.authenticated = YES;
        block(nil);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        //errors
        NSLog(@"login error %@", error);
    }];
}

- (NSURLSessionDataTask *)state:(PlayerState)block
{
    __weak Player *wPlayer = self;
    return [[AFNetClient authGET] GET:@"players/status/" parameters:nil success: ^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response: %@", responseObject);
        [wPlayer update:[responseObject objectForKey:@"result"]];
        block(NO);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        //send error message
        block(YES);
    }];
}

+ (NSURLSessionDataTask *)list:(uint)rnge cursor:(NSString *)c callback:(PlayerList)block
{
    NSString *path = [NSString stringWithFormat:@"players/lists/%d/", rnge];
    if (c.length > 0) {
        path = [NSString stringWithFormat:@"%@/%@/", path, c];
    }
    return [[AFNetClient authGET] GET:path parameters:nil success: ^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *listObj = [responseObject objectForKey:@"result"];
        NSString *cur = [listObj objectForKey:@"cursor"];
        NSArray *dictPls = [listObj objectForKey:@"players"];
        NSLog(@"players %@", responseObject);
        NSMutableArray *pls = [[NSMutableArray alloc] initWithCapacity:[listObj count]];
        for (NSDictionary *pDict in dictPls) {
            [pls addObject:[[Player alloc] initForPublic:pDict]];
        }
        block(pls, cur);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}

- (NSURLSessionDataTask *)invite:(PlayerState)block
{
    return [[AFNetClient authPOST] PUT:@"clans/invitations/" parameters:@{ @"id": [[NSNumber alloc] initWithUnsignedInteger:self.ID] } success: ^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response: %@", responseObject);
        block(NO);
    } failure: ^(NSURLSessionDataTask *task, NSError *error) {
        //send error message
        block(YES);
    }];
}


#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Player class]]) {
        return NO;
    }
    
    return [self isEqualToPlayer:(Player *)object];
}

- (NSUInteger)hash
{
    return [self.nick hash] ^ self.ID;
}

@end
