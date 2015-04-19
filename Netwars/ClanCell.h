//
//  ClanCell.h
//  Netwars
//
//  Created by mjolk on 13/04/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clan.h"

@interface ClanCell : UITableViewCell

@property(nonatomic, weak) UIImageView *logo;
@property(nonatomic, weak) UILabel *clanName;
@property(nonatomic, weak) UILabel *clanID;
@property(nonatomic, weak) UILabel *clanTag;
@property(nonatomic, weak) UILabel *amount;
@property(nonatomic, weak) UILabel *site;
@property(nonatomic, weak) UILabel *message;
@property(nonatomic, weak) UILabel *descript;
@property(nonatomic, weak) UILabel *bandwidthUsage;
@property (nonatomic, assign) BOOL didSetupConstraints;

-(void) setClan:(Clan *) clan;

@end
