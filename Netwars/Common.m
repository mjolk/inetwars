//
//  Common.m
//  Netwars
//
//  Created by mjolk on 24/03/15.
//  Copyright (c) 2015 mjolk. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (UILabel *)createLabel:(UIView *)container text:(NSString *)content fontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    label.font = [UIFont systemFontOfSize:size];
    label.text = content;
    label.backgroundColor = [UIColor whiteColor];
    [container addSubview:label];
    return label;
}

+ (UILabel *)createLabel:(UIView *)container fontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    label.font = [UIFont systemFontOfSize:size];
    label.backgroundColor = [UIColor whiteColor];
    [container addSubview:label];
    return label;
}

+ (UIImageView *)createIcon:(NSString *)path
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:path]];
}

@end
