//
//  StateController.h
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "NavCell.h"
#import "ProgramController.h"
#import "Player.h"
#import "HUDCell.h"
#import "PgHeader.h"

@interface StateController : UITableViewController <LoginDelegate, MenuDelegate>

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

- (void) showGlobalEvents;
- (void) showLists;
- (void) showLocalEvents;
- (void) showMessages;

@end
