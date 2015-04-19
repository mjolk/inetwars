//
//  ClanCell.m
//  Netwars
//
//  Created by mjolk on 13/04/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "ClanCell.h"
#import "Clan.h"
#import "Common.h"
#import "UIImageView+AFNetworking.h"

@implementation ClanCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *logo = [[UIImageView alloc] initForAutoLayout];
        [self.contentView addSubview:logo];
        self.logo = logo;
        self.bandwidthUsage = [Common createLabel:self.contentView text:@"bandwidth usage :" fontSize:12.0f];
        self.clanName = [Common createLabel:self.contentView text:@"name :" fontSize:12.0f];
        self.clanID = [Common createLabel:self.contentView text:@"id :" fontSize:12.0f];
        self.clanTag = [Common createLabel:self.contentView text:@"tag :" fontSize:12.0f];
        self.amount = [Common createLabel:self.contentView text:@"# players :" fontSize:12.0f];
        self.site = [Common createLabel:self.contentView text:@"site :" fontSize:12.0f];
        self.descript = [Common createLabel:self.contentView text:@"history :" fontSize:12.0f];
    }
    return self;
}

-(void) setClan:(Clan *) clan {
    [self.logo setImageWithURL:[NSURL URLWithString:clan.avatar] placeholderImage:[UIImage imageNamed:@"programs_32.png"]];
    [self.bandwidthUsage setText:[NSString stringWithFormat:@"bandwidth usage :%lu", (unsigned long)clan.bandwidthUsage]];
    [self.clanName setText:[NSString stringWithFormat:@"name :%@", clan.name]];
    [self.clanID setText:[NSString stringWithFormat:@"id : %d", (uint)clan.ID]];
    [self.clanTag setText:[NSString stringWithFormat:@"tag : %@", clan.tag]];
    [self.amount setText:[NSString stringWithFormat:@"# players : %d", (uint)clan.amountPlayers]];
    [self.site setText:[NSString stringWithFormat:@"site: %@", clan.site]];
    [self.descript setText:[NSString stringWithFormat:@"description : %@", clan.descr]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self.logo autoSetDimension:ALDimensionHeight toSize:120.0f];
        [self.logo autoSetDimension:ALDimensionWidth toSize:200.0f];
       [self.logo autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:5.0f];
       [self.logo autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView];
        [self.clanName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.logo withOffset:5.0f];
        [self.clanID autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.clanName withOffset:5.0f];
        [self.clanTag autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.clanID withOffset:5.0f];
        [self.amount autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.clanTag withOffset:5.0f];
        [self.bandwidthUsage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.logo withOffset:5.0f];
        [self.bandwidthUsage autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.clanName withOffset:5.0f];
        [self.descript autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bandwidthUsage withOffset:5.0f];
        [self.descript autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.bandwidthUsage withOffset:5.0f];
        [self.site autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.descript];
        [self.site autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.descript withOffset:5.0f];
    }
    [super updateConstraints];
}

@end
