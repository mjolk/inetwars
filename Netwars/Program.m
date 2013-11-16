//
//  Program.m
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "Program.h"
#import "AFNetClient.h"

@interface Program()



@end

@implementation Program

- (void) update:(NSDictionary *) values {
    
    self.dict = values;
    self.attack = [[values objectForKey:@"attack"] integerValue];
    self.life = [[values objectForKey:@"life"] integerValue];
    self.name = [values objectForKey:@"name"];
    self.programKey = [values objectForKey:@"program_key"];
    self.type = [values objectForKey:@"type"];
    self.cycles = [[values objectForKey:@"cycle_cost"] integerValue];
    self.memory = [[values objectForKey:@"mem_cost"] floatValue];
    self.bandwidth = [[values objectForKey:@"bandwidth"] integerValue];
    self.bandwidthUsage = [[values objectForKey:@"bandwidth_usage"] floatValue];
    self.pdescription = [values objectForKey:@"description"];
    self.effectors = [values objectForKey:@"effector"];
    self.amount = [[values objectForKey:@"amount"] integerValue];
   // NSLog(@"EFFECTORS %@ \n", self.effectors);
    
}

- (id) copyWithZone:(NSZone *)zone {
    return [[Program alloc] initWithValues:self.dict];
}

- (id) initWithValues:(NSDictionary *) values {
    self = [super init];
    if (self) {
        // Initialization code
        [self update:values];
    }
    return self;
    
}

+ (NSURLSessionDataTask *) list:(ProgramList) block {
    return [[AFNetClient sharedClient] GET:@"programs/" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSMutableArray *programs = [[NSMutableArray alloc] init];
            NSDictionary *dictProgs = [responseObject objectForKey:@"result"];
            for(NSString *tpe in dictProgs) {
                NSDictionary *progsForType = [dictProgs objectForKey:tpe];
                ProgramGroup *pGroup = [[ProgramGroup alloc] initForType:tpe];
                NSLog(@"ptype loaded : %@ \n", pGroup.ptype);
                for(NSDictionary *dictProg in progsForType) {
                    [pGroup.programs addObject:[[Program alloc] initWithValues:dictProg]];
                }
                [programs addObject:pGroup];
            }
            block(programs);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //error
    }];
}


@end

@implementation ProgramGroup
            
- (id) initForType:(NSString *)tpe {
    self = [super init];
    if (self != nil) {
        self.ptype = tpe;
        self.programs = [[NSMutableArray alloc] init];
    }
    return self;
}


- (id) copyWithZone:(NSZone *)zone {
    ProgramGroup *pg = [[ProgramGroup alloc] initWithValues:self.dict];
    return pg;
}

- (id) initWithValues:(NSDictionary *) values {
    self = [super init];
    if (self) {
        [self update:values];
    }
    return self;
}

- (void) update:(NSDictionary *) values {
    self.dict = values;
    self.ptype = [values objectForKey:@"type"];
    self.usage = [[values objectForKey:@"usage"] floatValue];
    self.yield = [[values objectForKey:@"yield"] integerValue];
    NSArray *pDict =  [values objectForKey:@"programs"];
    self.programs = [[NSMutableArray alloc] initWithCapacity:[pDict count]];
    for (NSDictionary *pd in pDict) {
        [self.programs addObject:[[Program alloc] initWithValues:pd]];
    }
}

@end
