//
//  EventViewCell.h
//  Netwars
//
//  Created by amjolk on 15/06/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventViewCell : UITableViewCell

@property(nonatomic, strong) Event *event;
@property(nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, strong) UILabel *eventType;
@property(nonatomic, strong) UILabel *action;
@property(nonatomic, strong) UILabel *result;
@property(nonatomic, strong) UILabel *direction;
@property(nonatomic, strong) UILabel *subject;
@property(nonatomic, strong) UILabel *expires;
@property(nonatomic, strong) UILabel *memory;
@property(nonatomic, strong) UILabel *bwLost;
@property(nonatomic, strong) UILabel *programsLost;
@property(nonatomic, strong) UILabel *programsKilled;
@property(nonatomic, strong) UILabel *bwKilled;
@property(nonatomic, strong) UILabel *yieldLost;
@property(nonatomic, strong) UILabel *apsGained;
@property(nonatomic, strong) UILabel *cpsGained;
@property(nonatomic, strong) UILabel *cycles;


- (void)load:(Event *) event;

@end
