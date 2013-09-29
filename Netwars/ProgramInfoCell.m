//
//  ProgramInfoCell.m
//  Netwars
//
//  Created by amjolk on 24/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "ProgramInfoCell.h"

@interface ProgramInfoCell()

-(void) setup;

@end

@implementation ProgramInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void) setProgram:(Program *)program {
    self.adStats.text = [NSString stringWithFormat:@"%d / %d", program.attack, program.life];
    self.cycleStat.text = [NSString stringWithFormat:@"%d", program.cycles];
    self.memStat.text = [NSString stringWithFormat:@"%d", (int) (1.f/program.memory)];
    self.programDescription.text = program.pdescription;
    self.programName.text = program.name;
    
    int i;
    for(i = 0; i < 3; i++) {
        
        EffectorView *effectView = [[self.effectView subviews] objectAtIndex:i];
        NSString *tpe;
        int len = [program.effectors count];
        if (i < len) {
            tpe = [program.effectors[i] substringToIndex:2];
        } else {
            tpe = @"";
        }
        [effectView forEffect:tpe];
    }
}

- (void) updateUserValues:(NSUInteger) aType amount:(NSUInteger)a owned:(NSUInteger)o {
    self.ownedAmount.text = [NSString stringWithFormat:@"%d", o];
    switch (aType) {
        case 0:
            self.forecastValue.text = [NSString stringWithFormat:@"%d", (o + a)];
            break;
            
        case 1:
            self.forecastValue.text = [NSString stringWithFormat:@"%d", (o - a)];
            break;
    }
    self.amountValue.text = [NSString stringWithFormat:@"%d", a];
}

-(void) setup {
    UIView *pview = [UIView newAutoLayoutView];
    [self.contentView addSubview:pview];
    [pview autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
   // pview.backgroundColor = [UIColor greenColor];
    UIView *statsView = [UIView newAutoLayoutView];
    [self.contentView addSubview:statsView];
    [statsView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
   // statsView.backgroundColor = [UIColor redColor];
    
    
    UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:titleLabel];
    self.programName = titleLabel;
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.f];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.f];
    titleLabel.text = @"program name";
    
    UILabel *descriptionLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:descriptionLabel];
    self.programDescription = descriptionLabel;
    [descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.f];
    [descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:2.f];
    descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
    descriptionLabel.text = @"test";
    
    
    UILabel *adStats = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:adStats];
    UILabel *adStatsLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:adStatsLabel];
    [adStats autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:16.0f];
    [adStats autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [adStatsLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:adStats];
    [adStatsLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:adStats withOffset:0.0f];
    adStatsLabel.text = @"attack / defense";
    adStatsLabel.font = [UIFont systemFontOfSize:10.f];
    adStats.text = @"23 / 45";
    adStats.font = [UIFont systemFontOfSize:26.f];
    self.adStats = adStats;
    
    
    UILabel *ownedAmount = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:ownedAmount];
    self.ownedAmount = ownedAmount;
    UILabel *ownedLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:ownedLabel];
    [ownedAmount autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:16.0f];
    [ownedAmount autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [ownedLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:ownedAmount];
    [ownedLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:ownedAmount withOffset:0.0f];
    ownedLabel.text = @"owned";
    ownedLabel.font = [UIFont systemFontOfSize:10.f];
    ownedAmount.text = @"123";
    ownedAmount.font = [UIFont systemFontOfSize:26.f];
    
    UILabel *forecastValue = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:forecastValue];
    self.forecastValue = forecastValue;
    UILabel *forecastLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:forecastLabel];
    [forecastValue autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:18.0f];
    [forecastValue autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:ownedAmount withOffset:-28.f];
    [forecastLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:forecastValue];
    [forecastLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:forecastValue withOffset:2.0f];
    forecastLabel.text = @"forecast";
    forecastLabel.font = [UIFont systemFontOfSize:10.f];
    forecastValue.text = @"123";
    forecastValue.font = [UIFont systemFontOfSize:16.f];
    
    
    UILabel *amountValue = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:amountValue];
    self.amountValue = amountValue;
    UILabel *amountLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:amountLabel];
    [amountValue autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:18.0f];
    [amountValue autoCenterInSuperviewAlongAxis:ALAxisVertical];
    [amountLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:amountValue];
    [amountLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:amountValue withOffset:2.0f];
    amountLabel.text = @"amount";
    amountLabel.font = [UIFont systemFontOfSize:10.f];
    amountValue.text = @"123";
    amountValue.font = [UIFont systemFontOfSize:26.f];
    
    
    
    
    UIView *effectsView = [[UIView alloc]initForAutoLayout];
    [statsView addSubview:effectsView];
//    effectsView.backgroundColor = [UIColor blueColor];
    [effectsView autoSetDimension:ALDimensionHeight toSize:38.f];
    [effectsView autoSetDimension:ALDimensionWidth toSize:100.f];
    self.effectView = effectsView;
    [effectsView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.f];
    [effectsView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:ownedAmount withOffset:2.0f];
    //[effectsView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:cost withOffset:-60.f];
    UILabel *effectsLabel = [[UILabel alloc] initForAutoLayout];
    effectsLabel.text = @"targets :";
    effectsLabel.font = [UIFont systemFontOfSize:10.f];
    [statsView addSubview:effectsLabel];
    [effectsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.f];
    [effectsLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:effectsView withOffset:-5.0f];
    
    
    int i;
    EffectorView *effectView;
    for(i = 0; i < 3; i++) {
        
        if (i == 1) {
            effectView = [[EffectorView alloc] initWithFrame:CGRectMake(28.f*(float)((3 - i) -1), 0.f, 44.f, 38.f) orientation:TopDownOrientation layout:HorizontalLayout];
            [self.effectView addSubview:effectView];
        } else {
            effectView = [[EffectorView alloc] initWithFrame:CGRectMake(28.f*(float)((3 - i) -1), 0.f, 44.f, 38.f) orientation:TopUpOrientation layout:HorizontalLayout];
            [self.effectView addSubview:effectView];
        }
        [effectView forEffect:@""];
    }
    
    UILabel *cycleStats = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:cycleStats];
    self.cycleStat = cycleStats;
    UILabel *cycleStatsLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:cycleStatsLabel];
    [cycleStats autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [cycleStats autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:effectsView withOffset:-20.f];
    [cycleStatsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.f];
    [cycleStatsLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:cycleStats withOffset:-2.0f];
    UIImageView *cycleIcon = [[UIImageView alloc] initForAutoLayout];
    [statsView addSubview:cycleIcon];
    [cycleIcon setImage:[UIImage imageNamed:@"cyclesicon_22.png"]];
    [cycleIcon autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:cycleStats withOffset:-10.f];
    [cycleIcon autoAlignAxis:ALAxisBaseline toSameAxisOfView:cycleStats];
    cycleStatsLabel.text = @"cycles";
    cycleStatsLabel.font = [UIFont systemFontOfSize:10.f];
    cycleStats.text = @"123";
    cycleStats.font = [UIFont systemFontOfSize:26.f];
    
    
    UILabel *memStats = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:memStats];
    self.memStat = memStats;
    UILabel *memStatsLabel = [[UILabel alloc] initForAutoLayout];
    [statsView addSubview:memStatsLabel];
    [memStats autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [memStats autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:cycleStats withOffset:-16.f];
    [memStatsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.f];
    [memStatsLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:memStats withOffset:-5.0f];
    UIImageView *memIcon = [[UIImageView alloc] initForAutoLayout];
    [statsView addSubview:memIcon];
    [memIcon setImage:[UIImage imageNamed:@"memory_22.png"]];
    [memIcon autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:memStats withOffset:-10.f];
    [memIcon autoAlignAxis:ALAxisBaseline toSameAxisOfView:memStats];
    memStatsLabel.text = @"# / memory";
    memStatsLabel.font = [UIFont systemFontOfSize:10.f];
    memStats.text = @"5";
    memStats.font = [UIFont systemFontOfSize:26.f];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
