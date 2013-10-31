//
//  PgHeader.h
//  Netwars
//
//  Created by amjolk on 28/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DACircularProgressView;

@interface PgHeader : UIView

@property(nonatomic, weak) DACircularProgressView *bwUsageProgress;
@property(nonatomic, weak) UILabel *programTypeLabel;
@property(nonatomic, weak) UILabel *amountLabel;

@end
