//
//  LookupController.h
//  Netwars
//
//  Created by amjolk on 29/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttackController.h"


@interface PlayerController : UITableViewController

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSString *cursor;
@property (nonatomic, assign) uint range;
@property (nonatomic, strong) AttackController *attack;

@end
