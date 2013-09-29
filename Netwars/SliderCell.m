//
//  SliderCell.m
//  Netwars
//
//  Created by amjolk on 26/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "SliderCell.h"

@interface SliderCell()

-(void) setup;

@end

@implementation SliderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void) setup {
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10.f, 10.f, 300.f, 46.f)];
    [self.contentView addSubview:slider];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [slider autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(2.f, 46.f, 2.f, 2.f)];
    self.slider = slider;
       UIImage *trackImg = [[UIImage imageNamed:@"track_46.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [slider setMaximumTrackImage:trackImg forState:UIControlStateNormal];
    [slider setMinimumTrackImage:trackImg forState:UIControlStateNormal];
    UIImage *thumbImg = [[UIImage imageNamed:@"thumb_46.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)];
    [slider setThumbImage:thumbImg forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
