//
//  InviteController.h
//  Netwars
//
//  Created by mjolk on 18/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClanController;

@protocol ClanDelegate <NSObject>
- (void)clanAvailable:(ClanController *)controller;
@end



@interface InviteController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, weak) id <ClanDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *invites;

@end
