//
//  LoginViewController.h
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UITableViewController <UITextFieldDelegate>

@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *nick;

@end
