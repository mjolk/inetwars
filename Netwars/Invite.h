//
//  Invite.h
//  Netwars
//
//  Created by mjolk on 20/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PlayerInvites)(NSMutableArray *invites);

@interface Invite : NSObject

@property (nonatomic, strong) NSString *clan;
@property (nonatomic, strong) NSString *inviteKey;
@property (nonatomic, strong) NSString *invitedBy;
@property (nonatomic, strong) NSDate *expires;
@property (nonatomic, strong) NSDate *invited;

- (id) initWithValues:(NSDictionary *) values;
+ (NSURLSessionDataTask *) invites:(PlayerInvites) block;

@end
