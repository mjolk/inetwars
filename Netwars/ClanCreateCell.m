//
//  ClanCreateCell.m
//  Netwars
//
//  Created by amjolk on 12/04/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "ClanCreateCell.h"

@implementation ClanCreateCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UITextField *n = [self createInput];
        [self.contentView addSubview:n];
        self.name = n;
        self.name.placeholder = @"Clan Name";
        self.name.tag = 0;
        UITextField *em = [self createInput];
        [self.contentView addSubview:em];
        self.clanTag = em;
        self.clanTag.tag = 1;
        self.clanTag.placeholder = @"Clan Tag ";
    }
    return self;
}

- (UITextField *)createInput {
    UITextField *n = [[UITextField alloc] initForAutoLayout];
    n.textAlignment = NSTextAlignmentCenter;
    n.clearButtonMode = UITextFieldViewModeWhileEditing;
    n.borderStyle = UITextBorderStyleNone;
    n.font = [UIFont systemFontOfSize:12.0f];
    return n;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        // [self.email autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:20.0f];
        [self.name autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
        [self.name autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
        [self.clanTag autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
        [self.clanTag autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
        [self.contentView.subviews autoDistributeViewsAlongAxis:ALAxisVertical alignedTo:ALAttributeVertical withFixedSpacing:32.0f];
    }
    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
