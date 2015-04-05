//
//  ProgramListController.h
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgramController : UITableViewController

@property (nonatomic, strong) NSArray *programs;
@property (nonatomic, strong) NSMutableArray *filteredPrograms;
@property (nonatomic, strong) NSDictionary *imgMap;

- (void)updateSource;

@end
