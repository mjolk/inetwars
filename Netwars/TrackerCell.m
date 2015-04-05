//
//  TrackerCell.m
//  Netwars
//
//  Created by mjolk on 23/03/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "TrackerCell.h"

@implementation TrackerCell

- (void)awakeFromNib {
	// Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		UIView *labelContainter = [[UIView alloc] initForAutoLayout];
		[self.contentView addSubview:labelContainter];
		self.messageLabel = [Common createLabel:labelContainter text:@"new messages" fontSize:8.0f];
		self.eventLabel = [Common createLabel:labelContainter text:@"new events" fontSize:8.0f];
		self.eCount = [Common createLabel:labelContainter text:@"0" fontSize:12.f];
		self.mCount = [Common createLabel:labelContainter text:@"0" fontSize:12.f];
	}
	return self;
}

- (void)updateConstraints {
	if (!self.didSetupConstraints) {
		CGFloat middle = self.contentView.bounds.size.width / 2;

		[self.eCount autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
		[self.eCount autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.eventLabel withOffset:-5.0];
		//[self.eCount autoCenterInSuperview];

		[self.eventLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
		[self.eventLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-(middle + 40.0f)];

		[self.mCount autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
		[self.mCount autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:middle + 5.0f];

		[self.messageLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
		[self.messageLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.mCount withOffset:5.0];



		//[self.labelContainer autoSetDimension:ALDimensionWidth toSize:totalwidth];

		//[self.labelContainer autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView];

		self.didSetupConstraints = YES;
	}

	[super updateConstraints];
}

- (void)setMessageCount:(NSUInteger)count {
	[self.mCount setText:[NSString stringWithFormat:@"%lu", (unsigned long)count]];
}

- (void)setEventCount:(NSUInteger)count {
	[self.eCount setText:[NSString stringWithFormat:@"%lu", (unsigned long)count]];
}

@end
