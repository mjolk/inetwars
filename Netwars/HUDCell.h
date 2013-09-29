//
//  HUDCell.h
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"

@interface HUDCell : UITableViewCell

@property(nonatomic, weak) UILabel *cycleValue;
@property(nonatomic, weak) UILabel *bandwidthValue;
@property(nonatomic, weak) UILabel *memoryValue;
@property(nonatomic, weak) UILabel *activeMemoryValue;
@property(nonatomic, weak) DACircularProgressView *memoryProgress;
@property(nonatomic, weak) DACircularProgressView *bandwidthProgress;


- (void) setUsageProgress:(CGFloat) progress;
- (void) setAmemProgress:(CGFloat) progress;
- (void) setBandwidth:(CGFloat) usage bandwidth:(NSUInteger) bw;
- (void) setMemory:(NSUInteger) memory;
- (void) setActivememory:(NSUInteger) activeMemory;
- (void) setCycles:(NSUInteger) cycles;

@end
