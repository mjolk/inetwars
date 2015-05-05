//
//  ProgramCell.m
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "ProgramCell.h"
#import "Program.h"
#import "EffectorView.h"

@interface ProgramCell ()

- (void)setup;

@end

@implementation ProgramCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		[self setup];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)setProgram:(Program *)program {
	self.titleLabel.text = program.name;
	self.descriptionLabel.text = program.pdescription;
	//self.detailTextLabel.text = program.description;
	self.costLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)program.cycles];
	self.alLabel.text = [NSString stringWithFormat:@"%lu / %lu", (unsigned long)program.attack, (unsigned long)program.life];

	int i;
	for (i = 0; i < 3; i++) {
		EffectorView *effectView = [[self.effectsView subviews] objectAtIndex:i];
		NSString *tpe;
        NSLog(@"effectors---- %@", program.effectors);
		int len = (int)[program.effectors count];
		if (i < len) {
			tpe = [program.effectors[i] substringToIndex:2];
		}
		else {
			tpe = @"";
		}
		[effectView forEffect:tpe];
	}
}

- (void)setup {
	[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	[self.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
	self.detailTextLabel.font = [UIFont systemFontOfSize:10.0f];
	self.textLabel.textAlignment = NSTextAlignmentCenter;
	UILabel *alLabel = [[UILabel alloc] initForAutoLayout];
	[self.contentView addSubview:alLabel];
	alLabel.font = [UIFont systemFontOfSize:12.0f];
	self.alLabel = alLabel;
	[alLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
	[alLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];

	UILabel *title = [[UILabel alloc] initForAutoLayout];
	[self.contentView addSubview:title];
	title.font = [UIFont systemFontOfSize:12.0f];
	self.titleLabel = title;
	[title autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:alLabel withOffset:14.0f];
	[title autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];

	UILabel *description = [[UILabel alloc] initForAutoLayout];
	[self.contentView addSubview:description];
	description.font = [UIFont systemFontOfSize:12.0f];
	description.textColor = [UIColor lightGrayColor];
	self.descriptionLabel = description;
	[description autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:alLabel withOffset:14.0f];
	[description autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:title withOffset:2.0f];


	UIImageView *costIcon = [[UIImageView alloc] initForAutoLayout];
	[self.contentView addSubview:costIcon];
	[costIcon setImage:[UIImage imageNamed:@"cyclesicon_22.png"]];
	self.cycleIcon = costIcon;
	[costIcon autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:4.0f];
	[costIcon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

	UILabel *cost = [[UILabel alloc] initForAutoLayout];
	[self.contentView addSubview:cost];
	cost.font = [UIFont systemFontOfSize:12.0f];
	self.costLabel = cost;
	[cost autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
	[cost autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:costIcon withOffset:-4.0f];

	UIView *effectsView = [[UIView alloc]initForAutoLayout];
	[self.contentView addSubview:effectsView];
	self.effectsView = effectsView;
	[effectsView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.f];
	[effectsView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:cost withOffset:-60.f];

	int i;
	EffectorView *effectView;
	for (i = 0; i < 3; i++) {
		if (i == 1) {
			effectView = [[EffectorView alloc] initWithFrame:CGRectMake(0.f, 24.f * (float)((3 - i) - 1), 38.f, 36.f) orientation:TopDownOrientation layout:VerticalLayout];
			[self.effectsView addSubview:effectView];
		}
		else {
			effectView = [[EffectorView alloc] initWithFrame:CGRectMake(0.f, 24.f * (float)((3 - i) - 1), 38.f, 36.f) orientation:TopUpOrientation layout:VerticalLayout];
			[self.effectsView addSubview:effectView];
		}
		[effectView forEffect:@""];
	}
}

@end
