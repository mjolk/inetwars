//
//  LoginInputCell.h
//  Netwars
//
//  Created by mjolk on 17/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputCell : UITableViewCell

@property(nonatomic, weak) UITextField *nick;
@property(nonatomic, weak) UITextField *email;
@property(nonatomic, weak) UITextField *password;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end
