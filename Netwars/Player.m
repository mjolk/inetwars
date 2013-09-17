//
//  Player.m
//  Netwars
//
//  Created by mjolk on 17/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Player.h"

@implementation Player

+ (Player *)sharedPlayer {
    static Player *_sharedPlayer = nil;
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
        NSLog(@"saved playerkey %@", playerKey);
        if (playerKey == nil) {
            self.authenticated = NO;
        }
        else
        {
            self.authenticated = YES;
            self.playerKey = playerKey;
        }
        
    }
    
    return self;
}


@end
