//
//  SliderCell.m
//  Netwars
//
//  Created by amjolk on 26/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "SliderCell.h"

@interface SliderCell ()

- (void)setup;

@end

@implementation SliderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		[self setup];
	}
	return self;
}

- (void)setup {
	UISlider *slider = [UISlider newAutoLayoutView];
	[self.contentView addSubview:slider];
	//[slider autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.f, 46.f, 0.f, 0.f)];
	self.slider = slider;
	[slider setMaximumTrackImage:[[UIImage imageNamed:@"trackright_46.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)] forState:UIControlStateNormal];
	[slider setMinimumTrackImage:[[UIImage imageNamed:@"track_46.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)] forState:UIControlStateNormal];
	[slider setThumbImage:[UIImage imageNamed:@"thumb_46.png"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        self.didSetupConstraints = YES;
        [self.slider autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.f, 46.f, 0.f, 10.f)];
    }
    
    [super updateConstraints];
}


@end
