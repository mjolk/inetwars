//
//  TabelConfiguration.m
//  Netwars
//
//  Created by amjolk on 28/06/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "TableConfiguration.h"

@interface TableConfiguration ()

-(CellConfiguration *) configure:(id) data;

@end

@implementation TableConfiguration

-(id) initWithConfig:(NSArray *)configs forIndex:(NSIndexPath *) indexPath
{
    self = [super init];
    if (self) {
        self.cellConfig = configs;
        self.virtualIndex = indexPath;
    }
    return self;
}

-(void) addItem:(id) item atIndex:(NSUInteger) index
{
    CellConfiguration *cfg = [self configure:item];
    NSLog(@"------item configured %@", [cfg.dataItem class]);
    [self.dataSource insertObject:cfg atIndex:index];
    
}

-(CellConfiguration *) itemAtIndex:(NSUInteger) index
{
    return [self.dataSource objectAtIndex:index];
}

-(void) addItem:(id) item
{
    CellConfiguration *cfg = [self configure:item];
    [self.dataSource addObject:cfg];
}

-(CellConfiguration *) configure:(id) data
{
    for (CellConfiguration *cfg in [self cellConfig]) {
        if ([cfg.dataItem isKindOfClass:[data class]]) {
            return [cfg instanceForItem:data];
        }
    }
    return nil;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellConfiguration *item = [self itemAtIndex:indexPath.row];
    NSLog(@"item class %@", [item.dataItem class]);
    return [item cell:tableView atIndex:indexPath];
}


@end
