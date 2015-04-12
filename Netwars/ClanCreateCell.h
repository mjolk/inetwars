//
//  ClanCreateCell.h
//  Netwars
//
//  Created by amjolk on 12/04/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClanCreateCell : UITableViewCell

@property (nonatomic, weak) UITextField *name;
@property (nonatomic, weak) UITextField *clanTag;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end
