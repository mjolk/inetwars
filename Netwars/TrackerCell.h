//
//  TrackerCell.h
//  Netwars
//
//  Created by mjolk on 23/03/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface TrackerCell : UITableViewCell


@property(nonatomic, weak) UILabel *eventLabel;
@property(nonatomic, weak) UILabel *messageLabel;
@property(nonatomic, weak) UILabel *eCount;
@property(nonatomic, weak) UILabel *mCount;

@property (nonatomic, assign) BOOL didSetupConstraints;

-(void) setMessageCount:(NSUInteger) count;
-(void) setEventCount:(NSUInteger) count;

@end
