//
//  AFNetClient.h
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFNetClient : AFHTTPSessionManager

@property(nonatomic, strong) AFHTTPRequestSerializer *getSerializer;
@property(nonatomic, strong) AFJSONRequestSerializer *postSerializer;

+ (AFNetClient *)shared;
+ (AFNetClient *)authGET;
+ (AFNetClient *)authPOST;

@end
