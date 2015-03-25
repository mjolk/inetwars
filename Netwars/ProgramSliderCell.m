//
//  ProgramSlider.m
//  Netwars
//
//  Created by amjolk on 06/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "ProgramSliderCell.h"
#import "Program.h"

@implementation ProgramSliderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UILabel *amountLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:amountLabel];
        self.amountLabel = amountLabel;
        amountLabel.font = [UIFont systemFontOfSize:26.f];
        [amountLabel autoSetDimension:ALDimensionWidth toSize:44.f];
         [amountLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
         [amountLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:20.f];
        [self positionSlider:amountLabel];
        UILabel *progLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentView addSubview:progLabel];
        self.programName = progLabel;
            [progLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:5.f];
           [progLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.slider withOffset:-10.f];
        [self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

-(void) sliderChange:(id) source {
    UISlider *slider = source;
    self.amountLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
}

-(void) setProgram:(Program *) prog{
     self.programName.text = prog.name;
    NSLog(@"set program amount %d", prog.amount);
    self.programKey = prog.programKey;
    self.amountLabel.text = @"0";
    [self.slider setMaximumValue:(float)prog.amount];
    [self.slider setMinimumValue:0.f];
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
