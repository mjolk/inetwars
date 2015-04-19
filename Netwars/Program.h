//
//  Program.h
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ProgramList)(NSMutableArray *programs);
typedef void (^PlayerAllocate)(BOOL);

typedef enum ProgramType : NSUInteger {
	SW = 1,
	MUT = 1 << 1,
	    HUK = 1 << 2,
	    DOS = 1 << 3,
	    FW = 1 << 4,
	    CONN = 1 << 5,
	    INT = 1 << 6,
	    ICE = 1 << 7,
	    INF = 1 << 8
} ProgramType;

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
@property (nonatomic, strong) NSDictionary *dict;

+ (NSURLSessionDataTask *)list:(ProgramList)block;
+ (NSURLSessionDataTask *)allocate:(NSUInteger)dir program:(NSString *)prgKey amount:(NSUInteger)a allocBlock:(PlayerAllocate)block;
- (void)update:(NSDictionary *)values;
- (id)initWithValues:(NSDictionary *)values;


@end

@interface ProgramGroup : NSObject <NSCopying>

@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, assign) CGFloat usage;
@property (nonatomic, assign) NSUInteger yield;
@property (nonatomic, assign) BOOL power;
@property (nonatomic, strong) NSMutableArray *programs;
@property (nonatomic, strong) NSDictionary *dict;

- (id)initForType:(NSString *)type;
- (id)initWithValues:(NSDictionary *)values;
- (void)update:(NSDictionary *)values;

@end
