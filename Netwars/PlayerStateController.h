//
//  StateController.h
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AuthController.h"
#import "NavCell.h"
#import "Event.h"
#import "TrackerCell.h"
#import "InviteController.h"
#import "ProgramController.h"
#import "EventController.h"
#import "PlayerController.h"
#import "ClanController.h"


@interface PlayerStateController : UITableViewController <MenuDelegate, ClanDelegate>

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) ProgramController *programController;
@property (nonatomic, strong) ClanController *clanController;
@property (nonatomic, strong) PlayerController *playerController;
@property (nonatomic, strong) EventController *localEventController;
@property (nonatomic, strong) EventController *globalEventController;
- (void)showPrograms;
- (void)showLocals;
- (void)showGlobals;
- (void)showClan;
- (void)showMessages;
- (void)showPlayers;
- (void)clanCreated:(InviteController *)controller;

@end
