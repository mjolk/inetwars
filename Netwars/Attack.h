//
//  Attack.h
//  Netwars
//
//  Created by amjolk on 01/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Event;
@class Player;
@class Attack;

typedef void (^AttackBlock)(Event *attackEvent);

@interface AttackType : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSArray *ptypes;

-(id) initWithNameAndTypes:(NSString *) name types:(NSArray *) ptypes;

@end

@interface Attack : NSObject

@property(nonatomic, strong) NSString *playerKey;
@property(nonatomic, strong) Event *result;
@property(nonatomic, strong) AttackType *type;
@property(nonatomic, strong) NSMutableArray *programs;
@property(nonatomic, strong) Player *target;

-(id) initWithTargetAndType:(Player *) target type:(AttackType *) atpe;
-(NSDictionary *) toDict;
-(NSURLSessionDataTask *) execute:(AttackBlock) block;

@end


