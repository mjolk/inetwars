//
//  HUDCell.h
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@class DACircularProgressView;

@interface HUDCell : UITableViewCell

@property(nonatomic, weak) UILabel *cycleValue;
@property(nonatomic, weak) UILabel *bandwidthValue;
@property(nonatomic, weak) UILabel *memoryValue;
@property(nonatomic, weak) UILabel *activeMemoryValue;
@property(nonatomic, weak) DACircularProgressView *memoryProgress;
@property(nonatomic, weak) DACircularProgressView *bandwidthProgress;
@property(nonatomic, weak) UIView *progressContainer;
@property(nonatomic, weak) UIView *memoryContainer;
@property(nonatomic, weak) UIView *activeMemoryContainer;
@property(nonatomic, weak) UIView *cycleContainer;
@property(nonatomic, weak) UIView *bandwidthContainer;
@property(nonatomic, weak) UILabel *memoryLabel;
@property(nonatomic, weak) UILabel *memoryMetric;
@property(nonatomic, weak) UILabel *cycleLabel;
@property(nonatomic, weak) UILabel *cycleMetric;
@property(nonatomic, weak) UILabel *activeMemoryLabel;
@property(nonatomic, weak) UILabel *activeMemoryMetric;
@property(nonatomic, weak) UILabel *bandwidthLabel;
@property(nonatomic, weak) UILabel *bandwidthMetric;
@property(nonatomic, weak) UIImageView *memoryIcon;
@property(nonatomic, weak) UIImageView *cyclesIcon;
@property(nonatomic, weak) UIImageView *activeMemoryIcon;
@property(nonatomic, weak) UIImageView *bandwidthIcon;


@property (nonatomic, assign) BOOL didSetupConstraints;


- (void) setUsageProgress:(CGFloat) progress;
- (void) setAmemProgress:(CGFloat) progress;
- (void) setBandwidth:(CGFloat) usage bandwidth:(NSUInteger) bw;
- (void) setMemory:(NSUInteger) memory;
- (void) setActivememory:(NSUInteger) activeMemory;
- (void) setCycles:(NSUInteger) cycles;

@end
