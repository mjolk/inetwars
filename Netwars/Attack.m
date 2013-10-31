//
//  Attack.m
//  Netwars
//
//  Created by amjolk on 01/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Attack.h"
#import "Event.h"
#import "Player.h"
#import "Program.h"
#import "AFNetClient.h"
@interface Attack()

@end

@implementation Attack

-(id) initWithTargetAndType:(Player *) target type:(AttackType *) atpe; {
    self = [super init];
    if (self) {
            self.target = target;
        self.type = atpe;
        self.programs = [[NSMutableArray alloc] init];
        self.playerKey = [[Player sharedPlayer] playerKey];
    }
    return self;
}

-(NSDictionary *) toDict {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.playerKey forKey:@"pkey"];
    [dict setValue:self.type.name forKey:@"attack_type"];
    [dict setValue:self.target.publicKey forKey:@"target"];
    NSMutableArray *attackPrograms = [[NSMutableArray alloc] init];
    for(Program *aProg in self.programs) {
        [attackPrograms addObject:[[NSDictionary alloc] initWithObjects:@[aProg.programKey, [[NSNumber alloc] initWithUnsignedInteger:aProg.amount]] forKeys:@[@"key", @"amount"]]];
    }
    [dict setValue:attackPrograms forKey:@"attack_programs"];
    return dict;
}

-(NSURLSessionDataTask *) execute:(AttackBlock) block {
    if (self.result == nil) {
        AFNetClient *client = [AFNetClient sharedClient];
        AFHTTPRequestSerializer *serializer = client.requestSerializer;
        [client setRequestSerializer:[[AFJSONRequestSerializer alloc] init]];
        NSURLSessionDataTask *task = [[AFNetClient sharedClient] POST:@"attack" parameters:[self toDict] success:^(NSURLSessionDataTask *task, id responseObject) {
            BOOL result = [[responseObject objectForKey:@"success"] boolValue];
            if (result) {
                block([[Event alloc] initWithValues:[responseObject objectForKey:@"result"]]);
            } else {
                block(nil);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //error
        }];
        [client setRequestSerializer:serializer];
        return task;
    }
    return nil;
}



@end

@implementation AttackType

-(id) initWithNameAndTypes:(NSString *) name types:(NSArray *) ptypes {
    self = [super init];
    if (self) {
        self.name = name;
        self.ptypes = ptypes;
    }
    return self;
}

@end
