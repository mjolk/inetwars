//
//  ResourceCell.m
//  Netwars
//
//  Created by amjolk on 23/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "ResourceCell.h"
#import "DACircularProgressView.h"

@interface ResourceCell()

-(void) setup;

@end

@implementation ResourceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void) setup{
    UIView *container = [UIView newAutoLayoutView];
    [self.contentView addSubview:container];
    [container setCenter:CGPointMake(0.f, 0.f)];
    [container autoSetDimension:ALDimensionHeight toSize:36.f];
    [container autoSetDimension:ALDimensionWidth toSize:self.contentView.frame.size.width];
    [container autoCenterInSuperview];
    UIView *memoryResource = [[UIView alloc]initForAutoLayout];
    [container addSubview:memoryResource];
    [memoryResource autoSetDimension:ALDimensionHeight toSize:36.0f];
    UIView *cycleResource = [[UIView alloc] initForAutoLayout];
    [container addSubview:cycleResource];
    [cycleResource autoSetDimension:ALDimensionHeight toSize:36.0f];
    UIView *bandwidthResource = [[UIView alloc] initForAutoLayout];
    [container addSubview:bandwidthResource];
    [bandwidthResource autoSetDimension:ALDimensionHeight toSize:36.0f];
    UIImageView *memoryImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"memory_22.png"]];
    [memoryImg setTranslatesAutoresizingMaskIntoConstraints:NO];
    [memoryResource addSubview:memoryImg];
    UIImageView *cyclesImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cyclesicon_22.png"]];
    [cyclesImg setTranslatesAutoresizingMaskIntoConstraints:NO];
    [cycleResource addSubview:cyclesImg];
    UIImageView *bandwidthImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandwidth_22.png"]];
    [bandwidthImg setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bandwidthResource addSubview:bandwidthImg];
    DACircularProgressView *memProgress = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0.f, 0.f, 36.f, 36.f)];
    DACircularProgressView *bandwidthProgress = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0.f, 0.f, 36.f, 36.f)];
    DACircularProgressView *cyclesProgress = [[DACircularProgressView alloc] initWithFrame:CGRectMake(0.f, 0.f, 36.f, 36.f)];
    [memoryResource addSubview:memProgress];
    [bandwidthResource addSubview:bandwidthProgress];
    [cycleResource addSubview:cyclesProgress];
    self.memProgress = memProgress;
    self.bandwidthProgress = bandwidthProgress;
    self.cycleProgress = cyclesProgress;
    [bandwidthImg autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [bandwidthImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:7.0f];
    [memoryImg autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [memoryImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:7.f];
    [cyclesImg autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [cyclesImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:7.f];
    NSArray *subViews = @[memoryResource, cycleResource, bandwidthResource ];
    [subViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSize:44.0f ];
    memProgress.roundedCorners = YES;
    memProgress.trackTintColor = [[UIColor alloc] initWithRed:241.0f/255.0f green:196.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
    memProgress.progressTintColor = [[UIColor alloc] initWithRed:164.0f/255.0f green:246.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
    memProgress.thicknessRatio = 0.4f;
   // [memProgress setProgress:1.0f animated:NO];
    bandwidthProgress.roundedCorners = YES;
    bandwidthProgress.trackTintColor = [[UIColor alloc] initWithRed:241.0f/255.0f green:196.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
    bandwidthProgress.progressTintColor = [[UIColor alloc] initWithRed:164.0f/255.0f green:246.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
    bandwidthProgress.thicknessRatio = 0.4f;
   // [bandwidthProgress setProgress:1.0f animated:NO];
    cyclesProgress.roundedCorners = YES;
    cyclesProgress.trackTintColor = [[UIColor alloc] initWithRed:241.0f/255.0f green:196.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
    cyclesProgress.progressTintColor = [[UIColor alloc] initWithRed:164.0f/255.0f green:246.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
    cyclesProgress.thicknessRatio = 0.4f;
   // [cyclesProgress setProgress:1.0f animated:NO];

   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
