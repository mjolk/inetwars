//
//  HUDCell.m
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "HUDCell.h"
#import "DACircularProgressView.h"

@interface HUDCell()

- (void) setup;
- (void) setupProgress;
- (UIImageView *) createIcon:(NSString *) path;
- (UILabel *) createLabel:(UIView *) container text:(NSString *) label fontSize:(CGFloat) size;

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

- (void) setupProgress {
    UIView *progressContainer = [UIView newAutoLayoutView];
    [self.contentView addSubview:progressContainer];
    DACircularProgressView *memProgress = [[DACircularProgressView alloc] initForAutoLayout];
    [memProgress setFrame:CGRectMake(-33.f, -33.f, 66.f, 66.f)];
    [memProgress autoSetDimension:ALDimensionWidth toSize:66.0f];
    [memProgress autoSetDimension:ALDimensionHeight toSize:66.0f];
    DACircularProgressView *bwProgress = [[DACircularProgressView alloc] initForAutoLayout];
    [progressContainer addSubview:bwProgress];
    [progressContainer addSubview:memProgress];
    self.bandwidthProgress = bwProgress;
    self.memoryProgress = memProgress;
    [bwProgress setFrame:CGRectMake(-47, -47, 94.f, 94.f)];
    [bwProgress autoSetDimension:ALDimensionWidth toSize:94.0f];
    [bwProgress autoSetDimension:ALDimensionHeight toSize:94.0f];
   [progressContainer autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:88.f];
    [progressContainer autoCenterInSuperviewAlongAxis:ALAxisHorizontal];
    
    memProgress.trackTintColor = [[UIColor alloc] initWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    memProgress.progressTintColor = [[UIColor alloc] initWithRed:209.0f/255.0f green:86.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
    memProgress.thicknessRatio = 1.0f;
    
    bwProgress.roundedCorners = YES;
    bwProgress.trackTintColor = [[UIColor alloc] initWithRed:241.0f/255.0f green:196.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
    bwProgress.progressTintColor = [[UIColor alloc] initWithRed:164.0f/255.0f green:246.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
    bwProgress.thicknessRatio = 0.2f;
}

- (void) setup {
    
    [self setupProgress];
    
    self.contentView.backgroundColor = [[UIColor alloc] initWithRed:254.0f/255.0f green:255.0f/255.0f blue:254.0f/255.0f alpha:1.0f];
    
    UIView *hudContainer = [UIView newAutoLayoutView];
    
    [self.contentView addSubview:hudContainer];
    
    [hudContainer autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.f];
    [hudContainer autoSetDimension:ALDimensionHeight toSize:200.f];
    [hudContainer autoCenterInSuperviewAlongAxis:ALAxisHorizontal];
           
    UIView *memoryContainer = [[UIView alloc] initForAutoLayout];
    UIView *activeMemoryContainer = [[UIView alloc] initForAutoLayout];
    UIView *cycleContainer = [[UIView alloc] initForAutoLayout];
    UIView *bandwidthContainer = [[UIView alloc] initForAutoLayout];
    
    [hudContainer addSubview:memoryContainer];
    [hudContainer addSubview:activeMemoryContainer];
    [hudContainer addSubview:cycleContainer];
    [hudContainer addSubview:bandwidthContainer];
    
    [cycleContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:memoryContainer withOffset:50.0f];
    [activeMemoryContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cycleContainer withOffset:60.f];
    [bandwidthContainer autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:activeMemoryContainer withOffset:50.f];
    
    UILabel *memoryLabel = [self createLabel:memoryContainer text:@"memory :" fontSize:10.0f];
    [memoryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:32.f];
    self.memoryValue = [self createLabel:memoryContainer text:@"0" fontSize:26.0f];
    [self.memoryValue autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:memoryLabel withOffset:2.f];
    [self.memoryValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:memoryLabel withOffset:0.f];
    UILabel *memoryMetric = [self createLabel:memoryContainer text:@"gb" fontSize:10.0f];
    [memoryMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.memoryValue withOffset:2.f];
    [memoryMetric autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.memoryValue withOffset:-4.f];
    
    UILabel *cycleLabel = [self createLabel:cycleContainer text:@"cycles :" fontSize:10.0f];
    [cycleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:32.f];
    self.cycleValue = [self createLabel:cycleContainer text:@"122345" fontSize:26.0f];
    [self.cycleValue autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cycleLabel withOffset:2.f];
    [self.cycleValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:cycleLabel withOffset:0.f];
    UILabel *cycleMetric = [self createLabel:cycleContainer text:@"cycles" fontSize:10.0f];
    [cycleMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.cycleValue withOffset:2.f];
    [cycleMetric autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.cycleValue withOffset:-4.f];
    
    UILabel *activeMemoryLabel = [self createLabel:activeMemoryContainer text:@"active memory :" fontSize:10.0f];
    [activeMemoryLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:32.f];
    self.activeMemoryValue = [self createLabel:activeMemoryContainer text:@"0 / 10" fontSize:16.0f];
    [self.activeMemoryValue autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:activeMemoryLabel withOffset:2.f];
    [self.activeMemoryValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:activeMemoryLabel withOffset:0.f];
    UILabel *activeMemoryMetric = [self createLabel:activeMemoryContainer text:@"gb" fontSize:10.0f];
    [activeMemoryMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.activeMemoryValue withOffset:4.f];
    [activeMemoryMetric autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.activeMemoryValue withOffset:-2.f];
    
    UILabel *bandwidthLabel = [self createLabel:bandwidthContainer text:@"usage / bandwidth :" fontSize:10.0f];
    [bandwidthLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:32.f];
    self.bandwidthValue = [self createLabel:bandwidthContainer text:@"0 / 0" fontSize:16.0f];
    [self.bandwidthValue autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:bandwidthLabel withOffset:2.f];
    [self.bandwidthValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:bandwidthLabel withOffset:0.f];
    UILabel *bandwidthMetric = [self createLabel:bandwidthContainer text:@"ghz" fontSize:10.0f];
    [bandwidthMetric autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.bandwidthValue withOffset:4.f];
    [bandwidthMetric autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.bandwidthValue withOffset:-2.f];
    
    
    UIImageView *memoryIcon = [self createIcon:@"memory_22.png"];
    UIImageView *cyclesIcon = [self createIcon:@"cyclesicon_22.png"];
    UIImageView *activeMemoryIcon = [self createIcon:@"activememory_22.png"];
    UIImageView *bandwidthIcon = [self createIcon:@"bandwidth_22.png"];
    [bandwidthIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
    [memoryIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
    [cyclesIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
    [activeMemoryIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [memoryContainer addSubview:memoryIcon];
    [cycleContainer addSubview:cyclesIcon];
    [activeMemoryContainer addSubview:activeMemoryIcon];
    [bandwidthContainer addSubview:bandwidthIcon];
    
    [memoryIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.f];
    [cyclesIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.f];
    [activeMemoryIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
    [bandwidthIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
    
}

- (void) setAmemProgress:(CGFloat)progress {
    [self.memoryProgress setProgress:progress animated:YES];
}

- (void) setUsageProgress:(CGFloat)progress {
    [self.bandwidthProgress setProgress:progress animated:YES];
}

- (void) setActivememory:(NSUInteger)activeMemory {
    self.activeMemoryValue.text = [NSString stringWithFormat:@"%d / 10", activeMemory];
}

- (void) setBandwidth:(CGFloat) usage bandwidth:(NSUInteger)bw {
    self.bandwidthValue.text = [NSString stringWithFormat:@"%.2f / %d", usage, bw];
}

- (void) setMemory:(NSUInteger)memory {
    self.memoryValue.text = [NSString stringWithFormat:@"%d", memory];
}

- (void) setCycles:(NSUInteger)cycles {
    self.cycleValue.text = [NSString stringWithFormat:@"%d", cycles];
}



- (UILabel *) createLabel:(UIView *) container text:(NSString *)content fontSize:(CGFloat) size {
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    label.font = [UIFont systemFontOfSize:size];
    label.text = content;
    label.backgroundColor = [UIColor whiteColor];
    [container addSubview:label];
    return label;
}

- (UIImageView *) createIcon:(NSString *) path {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:path]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
