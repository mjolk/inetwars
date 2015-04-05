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

- (void)positionSlider:(UIView *)view {
	if (view == nil) {
		[self.slider autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.f, 46.f, 0.f, 10.f)];
	}
	else {
		[self.slider autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:view withOffset:10.f];
		[self.slider autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view withOffset:10.f];
		[self.slider autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-10.f];
	}
}

- (void)setup {
	UISlider *slider = [UISlider newAutoLayoutView];
	[self.contentView addSubview:slider];
	slider.translatesAutoresizingMaskIntoConstraints = NO;
	//[slider autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.f, 46.f, 0.f, 0.f)];
	self.slider = slider;
	UIImage *trackImg = [[UIImage imageNamed:@"track_46.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
	UIImage *trackRightImg = [[UIImage imageNamed:@"trackright_46.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
	[slider setMaximumTrackImage:trackRightImg forState:UIControlStateNormal];
	[slider setMinimumTrackImage:trackImg forState:UIControlStateNormal];
	UIImage *thumbImg = [UIImage imageNamed:@"thumb_46.png"];
	[slider setThumbImage:thumbImg forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end
