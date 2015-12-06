//
//  TabelConfiguration.h
//  Netwars
//
//  Created by amjolk on 28/06/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellConfiguration.h"

@interface TableConfiguration : NSObject <UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) NSArray *cellConfig;
@property(nonatomic, strong) NSIndexPath *virtualIndex;

- (id) initWithConfig:(NSArray *) configs forIndex:(NSIndexPath *) indexPath;
-(CellConfiguration *) itemAtIndex:(NSUInteger) index;
-(void) addItem:(id) item atIndex:(NSUInteger) index;
-(void) addItem:(id) item;

@end
