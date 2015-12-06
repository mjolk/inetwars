//
//  SubTable.h
//  Netwars
//
//  Created by amjolk on 27/06/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VirtualTable <NSObject>

-(NSUInteger) endIndex;
-(NSUInteger) count;

@end

@interface SubTable : NSObject

@property(nonatomic, strong) NSIndexPath *virtualIndex;


@end
