//
//  ProgramListController.h
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"
#import "ProgramCell.h"
#import "EffectorView.h"
#import "AllocController.h"

@interface ProgramController : UITableViewController

@property(nonatomic, strong) NSMutableArray *programs;
@property(nonatomic, strong) NSDictionary *imgMap;

@end
