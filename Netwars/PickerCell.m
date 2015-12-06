//
//  PickerCell.m
//  Netwars
//
//  Created by amjolk on 06/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "PickerCell.h"

@implementation PickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		UIPickerView *picker = [UIPickerView newAutoLayoutView];
        //[self.contentView addSubview:picker];
		self.picker = picker;
		UITextField *typeField = [[UITextField alloc] initForAutoLayout];
		[self.contentView addSubview:typeField];
		self.typeField = typeField;
		typeField.font = [UIFont systemFontOfSize:14.f];
		self.typeField.inputView = picker;
		// picker.backgroundColor = [UIColor greenColor];
		// [picker autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
		//[picker autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f)];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.typeField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:6.f];
        [self.typeField autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
    [super updateConstraints];
}

@end
