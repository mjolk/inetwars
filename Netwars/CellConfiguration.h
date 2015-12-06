//
//  SubTableCell.h
//  Netwars
//
//  Created by amjolk on 27/06/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Configure)(id dataItem, id cell);

@interface CellConfiguration : NSObject

@property(nonatomic, copy) Configure config;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, strong) id dataItem;
@property(nonatomic, strong) NSDictionary *properties;

-(id) initWithConfig:(Configure)creator andIdentifier:(NSString *) identifier forData:(id) dataItem;
-(UITableViewCell *) cell:(UITableView *) view atIndex:(NSIndexPath *) indexPath;
-(CellConfiguration *) instanceForItem:(id) item;

@end
