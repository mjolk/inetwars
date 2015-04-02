//
//  PgHeader.m
//  Netwars
//
//  Created by amjolk on 28/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "PgHeader.h"
#import "DACircularProgressView.h"
#import "Program.h"

@interface PgHeader()

-(void)setup;

@end

@implementation PgHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void) setup {
    DACircularProgressView *bwUsage = [DACircularProgressView newAutoLayoutView];
    [self addSubview:bwUsage];
    self.bwUsageProgress = bwUsage;
    
    
    bwUsage.trackTintColor = [[UIColor alloc] initWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    bwUsage.progressTintColor = [[UIColor alloc] initWithRed:209.0f/255.0f green:86.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
    bwUsage.thicknessRatio = 1.0f;
    
    UILabel *typeLabel = [[UILabel alloc]initForAutoLayout];
    [self addSubview:typeLabel];
    self.programTypeLabel = typeLabel;
    
    
  //  UILabel *amountLabel = [[UILabel alloc] initForAutoLayout];
  //  [self addSubview:amountLabel]
    
    
    
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        NSLog(@"setting constraints");
        
        [self.bwUsageProgress autoSetDimension:ALDimensionWidth toSize:22.f];
        [self.bwUsageProgress autoSetDimension:ALDimensionHeight toSize:22.f];
        [self.bwUsageProgress autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.bwUsageProgress autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.f];
        
        [self.programTypeLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.programTypeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.bwUsageProgress withOffset:10.0f];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
