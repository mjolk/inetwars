//
//  LookupController.h
//  Netwars
//
//  Created by amjolk on 29/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LookupController : UITableViewController

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSString *cursor;
@property (nonatomic, assign) BOOL range;

@end
