//
//  SubTableCell.m
//  Netwars
//
//  Created by amjolk on 27/06/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "CellConfiguration.h"

@implementation CellConfiguration

-(id) initWithConfig:(Configure)config andIdentifier:(NSString *) identifier forData:(id)dataItem
{
    self = [super init];
    if(self) {
        self.config = config;
        NSLog(@"dataItem %@", dataItem);
        self.dataItem = dataItem;
        self.properties = [[NSDictionary alloc] init];
        self.identifier = identifier;
    }
    return self;
}

-(UITableViewCell *) cell:(UITableView *)view atIndex:(NSIndexPath *)indexPath
{
    NSLog(@"view at index %ld", (long)indexPath.row);
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier:[self identifier] forIndexPath:indexPath];
    self.config(self.dataItem, cell);
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

-(CellConfiguration *) instanceForItem:(id)item
{
    return [[CellConfiguration alloc] initWithConfig:[self config] andIdentifier:[self identifier] forData:item];
}

@end
