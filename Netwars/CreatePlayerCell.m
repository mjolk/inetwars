//
//  LoginInputCell.m
//  Netwars
//
//  Created by mjolk on 17/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "CreatePlayerCell.h"

@interface CreatePlayerCell ()

- (UITextField *)createInput;
@end

@implementation CreatePlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
        UITextField *n = [self createInput];
        [self.contentView addSubview:n];
        self.nick = n;
        self.nick.placeholder = @"Nick";
        self.nick.tag = 0;
        UITextField *em = [self createInput];
        [self.contentView addSubview:em];
        self.email = em;
        self.email.tag = 1;
        self.email.placeholder = @"E-mail";
        UITextField *pw = [self createInput];
        [self.contentView addSubview:pw];
        self.password = pw;
        self.password.tag = 2;
        self.password.placeholder = @"Password";
		
	}
	return self;
}

- (UITextField *)createInput {
	UITextField *n = [[UITextField alloc] initForAutoLayout];
	n.textAlignment = NSTextAlignmentCenter;
	n.clearButtonMode = UITextFieldViewModeWhileEditing;
	n.borderStyle = UITextBorderStyleNone;
	n.font = [UIFont systemFontOfSize:16.0f];
    //[n sizeToFit];
	return n;
}

- (void)updateConstraints {
	if (!self.didSetupConstraints) {
		// [self.email autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:20.0f];
		[self.email autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
		[self.email autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
		[self.nick autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
		[self.nick autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
		[self.password autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
		[self.password autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
		[self.contentView.subviews autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeVertical withFixedSize:24];
	}
	[super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

@end
