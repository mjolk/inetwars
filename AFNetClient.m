//
//  AFNetClient.m
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "AFNetClient.h"
#import "JSONResponseSerializerWithErrorData.h"
#import "Player.h"

static NSString *const kAFAppNetwarsAPIBaseURLTestString = @"http://localhost:8080/";
static NSString *const kAFAppNetwarsAPIBaseURLString = @"http://n3twars.appspot.com/";

@implementation AFNetClient

+ (AFNetClient *)shared {
	static AFNetClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedClient = [[AFNetClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppNetwarsAPIBaseURLTestString]];
        _sharedClient.postSerializer = [[AFJSONRequestSerializer alloc] init];
        _sharedClient.getSerializer = [[AFHTTPRequestSerializer alloc] init];
	});

	return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
	self = [super initWithBaseURL:url];
	if (!self) {
		return nil;
	}

	// Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Accept"];

	[self setResponseSerializer:[JSONResponseSerializerWithErrorData serializer]];

	/*if ([[url scheme] isEqualToString:@"https"] && [[url host] isEqualToString:@"n3twars.appspot.com"]) {
	    self.defaultSSLPinningMode = AFSSLPinningModePublicKey;
	   } else {
	    self.defaultSSLPinningMode = AFSSLPinningModeNone;
	   }
	 */
	return self;
}

+ (AFNetClient *)authGET {
	AFNetClient *client = [AFNetClient shared];
	[client setRequestSerializer:client.getSerializer];
	[client.requestSerializer setValue:[NSString stringWithFormat:@"n3twars%@", [[Player sharedPlayer] playerKey]] forHTTPHeaderField:@"Authorization"];
	return client;
}

+ (AFNetClient *)authPOST {
	AFNetClient *client = [AFNetClient shared];
	[client setRequestSerializer:client.postSerializer];
	[client.requestSerializer setValue:[NSString stringWithFormat:@"n3twars%@", [[Player sharedPlayer] playerKey]] forHTTPHeaderField:@"Authorization"];
	return client;
}

@end
