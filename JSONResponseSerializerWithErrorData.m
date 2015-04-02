//
//  JSONResponseSerializerWithErrorData.m
//  Netwars
//
//  Created by mjolk on 14/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "JSONResponseSerializerWithErrorData.h"

@implementation JSONResponseSerializerWithErrorData

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id JSONObject = [super responseObjectForResponse:response data:data error:error]; // may mutate `error`
    if (*error) {
        NSMutableDictionary *mutableUserInfo = [(*error).userInfo mutableCopy];
        [mutableUserInfo setObject:[JSONObject objectForKey:@"error"] forKey:@"NSLocalizedDescription"];
        NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:[mutableUserInfo copy]];
        (*error) = newError;
    }
    
    return JSONObject;
}

@end
