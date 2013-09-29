//
//  ProgramInfoCell.h
//  Netwars
//
//  Created by amjolk on 24/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EffectorView.h"
#import "Program.h"

@interface ProgramInfoCell : UITableViewCell

@property(nonatomic, weak) UILabel *adStats;
@property(nonatomic, weak) UILabel *cycleStat;
@property(nonatomic, weak) UILabel *memStat;
@property(nonatomic, weak) UIView *effectView;
@property(nonatomic, weak) UILabel *cycleValue;
@property(nonatomic, weak) UILabel *memValue;
@property(nonatomic, weak) UILabel *amountValue;
@property(nonatomic, weak) UILabel *ownedAmount;
@property(nonatomic, weak) UILabel *forecastValue;
@property(nonatomic, weak) UILabel *programName;
@property(nonatomic, weak) UILabel *programDescription;

-(void) setProgram:(Program *) program;
-(void) updateUserValues:(NSUInteger) aType amount:(NSUInteger) a owned:(NSUInteger) o;

@end
