//
//  AppDelegate.h
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerController.h"

@class PageController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, PlayerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;

- (void)playerCreated:(PlayerController *)controller;

@end
