//
//  Program.h
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ProgramList)(NSMutableArray *programs);

@interface Program : NSObject <NSCopying>

@property (nonatomic, assign) NSUInteger attack;
@property (nonatomic, assign) NSUInteger life;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *programKey;//key for the program
@property (nonatomic, assign) NSUInteger cycles;
@property (nonatomic, assign) CGFloat memory;
@property (nonatomic, assign) CGFloat bandwidthUsage;
@property (nonatomic, assign) NSUInteger bandwidth;
@property (nonatomic, strong) NSArray *effectors;
@property (nonatomic, assign) NSUInteger *ettl;
@property (nonatomic, strong) NSString *infect;
@property (nonatomic, strong) NSString *infectName;
@property (nonatomic, assign) NSUInteger amount;
@property (nonatomic, assign) CGFloat usage;
@property (nonatomic, assign) NSUInteger yield;
@property (nonatomic, strong) NSDate *expires;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) NSString *pdescription;
@property(nonatomic, strong) NSDictionary *dict;

+(NSURLSessionDataTask *) list:(ProgramList) block;
-(void) update:(NSDictionary *) values;
- (id) initWithValues:(NSDictionary *) values;


@end

@interface ProgramGroup : NSObject <NSCopying>

@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, assign) CGFloat usage;
@property (nonatomic, assign) NSUInteger yield;
@property (nonatomic, assign) BOOL power;
@property (nonatomic, strong) NSMutableArray *programs;
@property (nonatomic, strong) NSDictionary *dict;

-(id) initForType:(NSString *) type;
-(id) initWithValues:(NSDictionary *) values;
-(void) update:(NSDictionary *) values;

@end
