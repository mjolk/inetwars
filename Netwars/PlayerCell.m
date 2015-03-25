//
//  PlayerCell.m
//  Netwars
//
//  Created by amjolk on 30/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "PlayerCell.h"
#import "UIImageView+AFNetworking.h"
#import "Player.h"

@implementation PlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.imageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.imageView autoSetDimension:ALDimensionWidth toSize:32.f];
        [self.imageView autoSetDimension:ALDimensionHeight toSize:32.f];
        [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.f];
        self.detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.detailTextLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.detailTextLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.f];
        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.textLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        
    }
    return self;
}

- (void) setPlayer:(Player *)player {
    self.textLabel.text = player.nick;
    [self.imageView setImageWithURL:[NSURL URLWithString:player.avatar] placeholderImage:[UIImage imageNamed:@"programs_32.png"]];
    self.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", player.bandwidthUsage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
