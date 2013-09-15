//
//  AFNetClient.h
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "AFHTTPClient.h"

@interface AFNetClient : AFHTTPClient

+ (AFNetClient *)sharedClient;

@end
