//
//  Clan.m
//  Netwars
//
//  Created by mjolk on 20/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Clan.h"
#import "AFNetClient.h"

@implementation Clan



+ (NSURLSessionDataTask *) create:(NSString *) pkey name:(NSString *)n tag:(NSString *)t callback:(ClanCreate)block {
    return [[AFNetClient sharedClient] POST:@"clans/" parameters:@{@"name":n, @"tag":t, @"pkey":pkey} success:^(NSURLSessionDataTask *task, id responseObject) {
        block(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //errors
    }];
}



@end
