//
//  AppDelegate.h
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"

@class PageController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, LoginDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;

- (void)userCreated:(LoginController *)controller;

@end
