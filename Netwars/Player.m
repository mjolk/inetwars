//
//  Player.m
//  Netwars
//
//  Created by mjolk on 17/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Player.h"

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

- (void)create:(NSString *)n email:(NSString *)e callback:(PlayerCreate)block {
	__weak Player *weakPlayer = self;
	[[AFNetClient sharedClient] postPath:@"player_create" parameters:[NSDictionary dictionaryWithObjectsAndKeys:n, @"nick", e,  @"email", nil] success: ^(AFHTTPRequestOperation *operation, id JSON) {
	    NSLog(@"json result create player %@", JSON);
	    NSLog(@"success?? %@", [JSON objectForKey:@"success"]);
	    BOOL status = [[JSON objectForKey:@"success"] boolValue];
	    if (status) {
	        weakPlayer.playerKey = [JSON objectForKey:@"result"];
	        weakPlayer.email = e;
	        weakPlayer.nick = n;
	        weakPlayer.notAuthenticated = NO;
	        block(nil);
		}
	    else {
	        NSDictionary *errors = [JSON objectForKey:@"result"];
	        block(errors);
		}
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
	}];
}

- (void)state:(PlayerState)block {
	__weak Player *weakPlayer = self;
	[[AFNetClient sharedClient] getPath:@"player_status" parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.playerKey, @"pkey", nil] success: ^(AFHTTPRequestOperation *operation, id JSON) {
	    NSLog(@"json result state player %@", JSON);
	    NSLog(@"success?? %@", [JSON objectForKey:@"success"]);
	    BOOL status = [[JSON objectForKey:@"success"] boolValue];
	    if (status) {
	        [weakPlayer update:[JSON objectForKey:@"result"]];
            NSLog(@"weakplayer: %@ \n", [[weakPlayer.programs objectAtIndex:0] programs]);
	        block(NO);
		}
	    else {
	        block(YES);
		}
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
	}];
}

- (void) allocate:(NSUInteger) dir program:(NSString *) prgKey amount:(NSUInteger) a allocBlock:(PlayerAllocate)block {
    NSString *aType = @"";
    switch (dir) {
        case 0:
            aType = @"player_allocate";
            break;
            
        case 1:
            aType = @"player_deallocate";
            break;
    }
    [[AFNetClient sharedClient] postPath:aType parameters:@{@"pkey": self.playerKey, @"prgkey":prgKey, @"amount": [NSString stringWithFormat:@"%d", a]} success: ^(AFHTTPRequestOperation *operation , id JSON) {
        if (JSON != nil){
            NSLog(@"error response : %@ \n", JSON);
            block(YES);
            NSString *error = [JSON objectForKey:@"error"];
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            block(YES);
        } else {
            block(NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
    }];
}

@end
