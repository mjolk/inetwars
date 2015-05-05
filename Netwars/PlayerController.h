//
//  LoginViewController.h
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerController;

@protocol PlayerDelegate <NSObject>
- (void)playerCreated:(PlayerController *)controller;
@end

@interface PlayerController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) BOOL create;
@property (nonatomic, weak) id <PlayerDelegate> delegate;

-(id) initForCreate:(BOOL) tpe;

@end
