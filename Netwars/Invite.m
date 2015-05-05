//
//  Invite.m
//  Netwars
//
//  Created by mjolk on 20/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Invite.h"
#import "AFNetClient.h"

@implementation Invite

- (id)initWithValues:(NSDictionary *)values {
	self = [super init];
	if (self) {
		self.invitedBy = [values objectForKey:@"invited_by"];
		self.invited = [values objectForKey:@"invited_date"];
		self.expires = [values objectForKey:@"valid_date"];
		self.clan = [values objectForKey:@"clan"];
		self.inviteKey = [values objectForKey:@"invite_key"];
	}
	return self;
}

+ (NSURLSessionDataTask *)invites:(PlayerInvites)block {
	return [[AFNetClient authGET] GET:@"clans/invitations/" parameters:nil success: ^(NSURLSessionDataTask *task, id responseObject) {
	    NSDictionary *dictInvites = [responseObject objectForKey:@"result"];
	    NSMutableArray *invites = [[NSMutableArray alloc] initWithCapacity:[dictInvites count]];
	    for (NSDictionary *inv in dictInvites) {
	        [invites addObject:[[Invite alloc] initWithValues:inv]];
		}
	    block(invites);
	} failure: ^(NSURLSessionDataTask *task, NSError *error) {
	    //error
	}];
}

- (NSURLSessionDataTask *)join:(PlayerJoin)block {
    return [[AFNetClient authPOST] POST:@"clans/links/" parameters:@{@"key": self.inviteKey} success:^(NSURLSessionDataTask *task, id responseObject) {
        block(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(NO);
    }];
}

@end
