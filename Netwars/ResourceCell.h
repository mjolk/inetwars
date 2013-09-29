//
//  ResourceCell.h
//  Netwars
//
//  Created by amjolk on 23/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"

@interface ResourceCell : UITableViewCell

@property(nonatomic, weak) DACircularProgressView *memProgress;
@property(nonatomic, weak) DACircularProgressView *cycleProgress;
@property(nonatomic, weak) DACircularProgressView *bandwidthProgress;
@property(nonatomic, weak) UILabel *memUsedLabel;
@property(nonatomic, weak) UILabel *memAvailableLabel;
@property(nonatomic, weak) UILabel *cycleUsedLabel;
@property(nonatomic, weak) UILabel *cycleAvailableLabel;
@property(nonatomic, weak) UILabel *bandwidthUsedLabel;
@property(nonatomic, weak) UILabel *bandwidthAvailableLabel;

@end
