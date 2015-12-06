//
//  HUDCell.m
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "HUDCell.h"
#import "DACircularProgressView.h"

@interface HUDCell ()

- (void)setup;
- (void)setupProgress;

@end

@implementation HUDCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setupProgress
{
    UIView *progressContainer = [UIView newAutoLayoutView];
    [self.contentView addSubview:progressContainer];
    self.progressContainer = progressContainer;
    self.progressContainer.backgroundColor = [UIColor lightGrayColor];
    DACircularProgressView *memProgress = [[DACircularProgressView alloc] initForAutoLayout];
    DACircularProgressView *bwProgress = [[DACircularProgressView alloc] initForAutoLayout];
    [progressContainer addSubview:bwProgress];
    [progressContainer addSubview:memProgress];
    self.bandwidthProgress = bwProgress;
    self.memoryProgress = memProgress;
    memProgress.trackTintColor = [[UIColor alloc] initWithRed:244.0f / 255.0f green:244.0f / 255.0f blue:244.0f / 255.0f alpha:1.0f];
    memProgress.progressTintColor = [[UIColor alloc] initWithRed:209.0f / 255.0f green:86.0f / 255.0f blue:62.0f / 255.0f alpha:1.0f];
    memProgress.thicknessRatio = 1.0f;
    bwProgress.roundedCorners = YES;
    bwProgress.trackTintColor = [[UIColor alloc] initWithRed:241.0f / 255.0f green:196.0f / 255.0f blue:15.0f / 255.0f alpha:1.0f];
    bwProgress.progressTintColor = [[UIColor alloc] initWithRed:164.0f / 255.0f green:246.0f / 255.0f blue:181.0f / 255.0f alpha:1.0f];
    bwProgress.thicknessRatio = 0.2f;
}

- (void)setup
{
    [self setupProgress];
    
    self.contentView.backgroundColor = [[UIColor alloc] initWithRed:254.0f / 255.0f green:255.0f / 255.0f blue:254.0f / 255.0f alpha:1.0f];
    
    UIView *memoryContainer = [[UIView alloc] initForAutoLayout];
    UIView *activeMemoryContainer = [[UIView alloc] initForAutoLayout];
    UIView *cycleContainer = [[UIView alloc] initForAutoLayout];
    UIView *bandwidthContainer = [[UIView alloc] initForAutoLayout];
    
    [self.contentView addSubview:memoryContainer];
    [self.contentView addSubview:activeMemoryContainer];
    [self.contentView addSubview:cycleContainer];
    [self.contentView addSubview:bandwidthContainer];
    
    self.memoryContainer = memoryContainer;
    self.activeMemoryContainer = activeMemoryContainer;
    self.cycleContainer = cycleContainer;
    self.bandwidthContainer = bandwidthContainer;
    
    UIImageView *memoryIcon = [Common createIcon:@"memory_22.png"];
    UIImageView *cyclesIcon = [Common createIcon:@"cyclesicon_22.png"];
    UIImageView *activeMemoryIcon = [Common createIcon:@"activememory_22.png"];
    UIImageView *bandwidthIcon = [Common createIcon:@"bandwidth_22.png"];
    
    [memoryContainer addSubview:memoryIcon];
    [cycleContainer addSubview:cyclesIcon];
    [activeMemoryContainer addSubview:activeMemoryIcon];
    [bandwidthContainer addSubview:bandwidthIcon];
    
    self.memoryIcon = memoryIcon;
    self.cyclesIcon = cyclesIcon;
    self.activeMemoryIcon = activeMemoryIcon;
    self.bandwidthIcon = bandwidthIcon;
    
    self.memoryLabel = [Common createLabel:memoryContainer text:@"memory :" fontSize:10.0f];
    self.memoryValue = [Common createLabel:memoryContainer text:@"0" fontSize:26.0f];
    self.memoryMetric = [Common createLabel:memoryContainer text:@"gb" fontSize:8.0f];
    
    self.cycleLabel = [Common createLabel:cycleContainer text:@"cycles :" fontSize:10.0f];
    self.cycleValue = [Common createLabel:cycleContainer text:@"122345" fontSize:26.0f];
    self.cycleMetric = [Common createLabel:cycleContainer text:@"sec" fontSize:8.0f];
    
    self.activeMemoryLabel = [Common createLabel:activeMemoryContainer text:@"active memory :" fontSize:10.0f];
    self.activeMemoryValue = [Common createLabel:activeMemoryContainer text:@"0 / 10" fontSize:16.0f];
    self.activeMemoryMetric = [Common createLabel:activeMemoryContainer text:@"gb" fontSize:8.0f];
    
    self.bandwidthLabel = [Common createLabel:bandwidthContainer text:@"usage / bandwidth :" fontSize:10.0f];
    self.bandwidthValue = [Common createLabel:bandwidthContainer text:@"0 / 0" fontSize:16.0f];
    self.bandwidthMetric = [Common createLabel:bandwidthContainer text:@"gbit" fontSize:8.0f];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        NSLog(@"setting constraints");
        
        
        
        [self.progressContainer autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-66.0f];
        [self.progressContainer autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
        [self.memoryProgress autoSetDimension:ALDimensionHeight toSize:66.0f];
        [self.memoryProgress autoSetDimension:ALDimensionWidth toSize:66.0f];
        [self.bandwidthProgress autoSetDimension:ALDimensionHeight toSize:86.0f];
        [self.bandwidthProgress autoSetDimension:ALDimensionWidth toSize:86.0f];
        [self.bandwidthProgress autoCenterInSuperview];
        [self.memoryProgress autoCenterInSuperview];
        
        [self.memoryIcon autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10.0f];
        [self.activeMemoryIcon autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10.0f];
        [self.cyclesIcon autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10.0f];
        [self.bandwidthIcon autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:10.0f];
        
        [self.memoryIcon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.memoryContainer];
        [self.cyclesIcon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.cycleContainer];
        [self.activeMemoryIcon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.activeMemoryContainer];
        [self.bandwidthIcon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bandwidthContainer];
        
        [self.memoryLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.memoryIcon withOffset:5.0f];
        [self.memoryLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.memoryContainer];
        
        [self.memoryValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.memoryLabel withOffset:5.0f];
        [self.memoryValue autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.memoryContainer];
        
        [self.memoryMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.memoryValue withOffset:5.0f];
        [self.memoryMetric autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.memoryContainer];
        
        [self.cycleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cyclesIcon withOffset:5.0f];
        [self.cycleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.cycleContainer];
        
        [self.cycleValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cycleLabel withOffset:5.0f];
        [self.cycleValue autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.cycleContainer];
        
        [self.cycleMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cycleValue withOffset:5.0f];
        [self.cycleMetric autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.cycleContainer];
        
        [self.activeMemoryLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.activeMemoryIcon withOffset:5.0f];
        [self.activeMemoryLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.activeMemoryContainer];
        
        [self.activeMemoryValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.activeMemoryLabel withOffset:5.0f];
        [self.activeMemoryValue autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.activeMemoryContainer];
        
        [self.activeMemoryMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.activeMemoryValue withOffset:5.0f];
        [self.activeMemoryMetric autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.activeMemoryContainer];
        
        [self.bandwidthLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.bandwidthIcon withOffset:5.0f];
        [self.bandwidthLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bandwidthContainer];
        
        [self.bandwidthValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.bandwidthLabel withOffset:5.0f];
        [self.bandwidthValue autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bandwidthContainer];
        
        [self.bandwidthMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.bandwidthValue withOffset:5.0f];
        [self.bandwidthMetric autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bandwidthContainer];
        
        NSArray *left = @[self.memoryContainer, self.cycleContainer, self.activeMemoryContainer, self.bandwidthContainer];
        [left autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeVertical withFixedSpacing:5.0f];
        
        
        
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)setAmemProgress:(CGFloat)progress
{
    [self.memoryProgress setProgress:progress animated:YES];
}

- (void)setUsageProgress:(CGFloat)progress
{
    NSLog(@"PROGRESS %f", progress);
    [self.bandwidthProgress setProgress:progress animated:YES];
}

- (void)setActivememory:(NSUInteger)activeMemory
{
    self.activeMemoryValue.text = [NSString stringWithFormat:@"%lu / 10", (unsigned long)activeMemory];
}

- (void)setBandwidth:(CGFloat)usage bandwidth:(NSUInteger)bw
{
    self.bandwidthValue.text = [NSString stringWithFormat:@"%.2f / %lu", usage, (unsigned long)bw];
}

- (void)setMemory:(NSUInteger)memory
{
    self.memoryValue.text = [NSString stringWithFormat:@"%lu", (unsigned long)memory];
}

- (void)setCycles:(NSUInteger)cycles
{
    self.cycleValue.text = [NSString stringWithFormat:@"%lu", (unsigned long)cycles];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
