//
//  Common.h
//  Netwars
//
//  Created by mjolk on 24/03/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Common : NSObject

+ (UILabel *)createLabel:(UIView *)container text:(NSString *)content fontSize:(CGFloat)size;
+ (UILabel *)createLabel:(UIView *)container fontSize:(CGFloat)size;
+ (UIImageView *)createIcon:(NSString *)path;

@end
