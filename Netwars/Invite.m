//
//  Invite.m
//  Netwars
//
//  Created by mjolk on 20/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Invite.h"

@implementation Invite

- (id) initWithValues:(NSDictionary *) values {
    self = [super init];
    if(self) {
        self.invitedBy = [values objectForKey:@"invited_by"];
        self.invited = [values objectForKey:@"invited_date"];
        self.expires = [values objectForKey:@"valid_date"];
        self.clan = [values objectForKey:@"clan"];
        self.inviteKey = [values objectForKey:@"invite_key"];
        
    }
    return self;
}

@end
