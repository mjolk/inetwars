//
//  DetailTextCell.m
//  Netwars
//
//  Created by mjolk on 26/03/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "DetailTextCell.h"

@implementation DetailTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
