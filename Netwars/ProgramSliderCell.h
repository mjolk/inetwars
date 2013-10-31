//
//  ProgramSlider.h
//  Netwars
//
//  Created by amjolk on 06/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "SliderCell.h"

@class Program;

@interface ProgramSliderCell : SliderCell

@property(nonatomic, weak) UILabel *amountLabel;
@property(nonatomic, weak) UILabel *programName;
@property(nonatomic, strong) NSString *programKey;

-(void) setProgram:(Program *) prg;
@end
