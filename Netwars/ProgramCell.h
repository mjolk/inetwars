//
//  ProgramCell.h
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Program;


@interface ProgramCell : UITableViewCell

@property(nonatomic, weak) UILabel *alLabel;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *descriptionLabel;
@property(nonatomic, weak) UILabel *costLabel;
@property(nonatomic, weak) UIImageView *cycleIcon;
@property(nonatomic, weak) UIView *effectsView;
-(void) setProgram:(Program *) program;

@end
