//
//  AFNetClient.m
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "AFNetClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kAFAppNetwarsAPIBaseURLTestString = @"http://localhost:8080/";
static NSString * const kAFAppNetwarsAPIBaseURLString = @"http://n3twars.appspot.com/";

@implementation AFNetClient

+ (AFNetClient *)sharedClient {
    static AFNetClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFNetClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppNetwarsAPIBaseURLTestString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    // By default, the example ships with SSL pinning enabled for the app.net API pinned against the public key of adn.cer file included with the example. In order to make it easier for developers who are new to AFNetworking, SSL pinning is automatically disabled if the base URL has been changed. This will allow developers to hack around with the example, without getting tripped up by SSL pinning.
    if ([[url scheme] isEqualToString:@"https"] && [[url host] isEqualToString:@"n3twars.appspot.com"]) {
        self.defaultSSLPinningMode = AFSSLPinningModePublicKey;
    } else {
        self.defaultSSLPinningMode = AFSSLPinningModeNone;
    }
    
    return self;
}
@end
