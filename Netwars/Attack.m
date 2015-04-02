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
    }
    return self;
}

-(NSDictionary *) toDict {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjects:@[[NSNumber numberWithUnsignedInteger:self.type.intId], [NSNumber numberWithUnsignedInteger:self.target.playerID]] forKeys:@[@"attack_type", @"target"]];
    NSMutableArray *attackPrograms = [[NSMutableArray alloc] init];
    for(Program *aProg in self.programs) {
        [attackPrograms addObject:[[NSDictionary alloc] initWithObjects:@[aProg.programKey, [NSNumber numberWithUnsignedInteger:aProg.amount]] forKeys:@[@"key", @"amount"]]];
    }
    [dict setValue:attackPrograms forKey:@"attack_programs"];
    return dict;
}

-(NSURLSessionDataTask *) execute:(AttackBlock) block {
    if (self.result == nil) {
        NSURLSessionDataTask *task = [[AFNetClient authPOST] POST:@"attack" parameters:[self toDict] success:^(NSURLSessionDataTask *task, id responseObject) {
            //BOOL result = [[responseObject objectForKey:@"success"] boolValue];
                block([[Event alloc] initWithValues:[responseObject objectForKey:@"result"]]);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
        return task;
    }
    return nil;
}



@end

@implementation AttackType

-(id) initWithNameAndTypes:(NSString *) name intid:(AttackTpe) tpe types:(NSArray *) ptypes {
    self = [super init];
    if (self) {
        self.name = name;
        self.ptypes = ptypes;
        self.intId = tpe;
    }
    return self;
}

@end
