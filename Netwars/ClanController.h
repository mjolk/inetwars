//
//  ClanController.h
//  Netwars
//
//  Created by mjolk on 13/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClanController;

@protocol ClanDelegate <NSObject>
- (void)clanCreated:(ClanController *)controller;
@end

@interface ClanController : UITableViewController

@end
