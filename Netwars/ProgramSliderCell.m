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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		UILabel *amountLabel = [[UILabel alloc] initForAutoLayout];
		[self.contentView addSubview:amountLabel];
		self.amountLabel = amountLabel;
		amountLabel.font = [UIFont systemFontOfSize:26.f];
		UILabel *progLabel = [[UILabel alloc] initForAutoLayout];
		[self.contentView addSubview:progLabel];
		self.programName = progLabel;
		[self.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
	}
	return self;
}

- (void)sliderChange:(id)source {
	UISlider *slider = source;
	self.amountLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
}

- (void)setProgram:(Program *)prog {
	self.programName.text = prog.name;
	NSLog(@"set program amount %lu", (unsigned long)prog.amount);
	self.programKey = prog.programKey;
	self.amountLabel.text = @"0";
	[self.slider setMaximumValue:(float)prog.amount];
	[self.slider setMinimumValue:0.f];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        self.didSetupConstraints = YES;
        [self.amountLabel autoSetDimension:ALDimensionWidth toSize:44.f];
        [self.amountLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.amountLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:20.f];
        [self.slider autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.amountLabel withOffset:10.f];
        [self.slider autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.amountLabel withOffset:10.f];
        [self.slider autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10.f];
        [self.programName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:5.f];
        [self.programName autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.slider withOffset:-10.f];
    }
    
    [super updateConstraints];
}
@end
