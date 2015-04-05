//
//  EventCell.m
//  Netwars
//
//  Created by amjolk on 20/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "NavCell.h"

@interface NavCell ()

@end

@implementation NavCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
		//self.contentView.backgroundColor = [[UIColor alloc] initWithRed:254.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];

		UIScrollView *scroller = [[UIScrollView alloc] initForAutoLayout];
		[self.contentView addSubview:scroller];
		[scroller setPagingEnabled:YES];
		self.scroller = scroller;

		self.btns = @{ @"players": @[[NSValue valueWithPointer:@selector(playersSelected:)], @"list_44.png"],
			           @"programs": @[[NSValue valueWithPointer:@selector(programsSelected:)], @"programs_44.png"],
			           @"locals": @[[NSValue valueWithPointer:@selector(localsSelected:)], @"events_44.png"],
			           @"globals": @[[NSValue valueWithPointer:@selector(globalsSelected:)], @"events_44.png"],
			           @"clan": @[[NSValue valueWithPointer:@selector(clanSelected:)], @"events_44.png"],
			           @"messages": @[[NSValue valueWithPointer:@selector(messagesSelected:)], @"messages_44.png"] };
	}
	return self;
}

- (void)initMenu:(NSArray *)enabled {
	int len = (int)[enabled count];
	int slen = (int)[self.active count];
	if (len != slen) {
		NSLog(@"reloading menu len: %d slen: %d\n", len, slen);
		self.active = [NSArray arrayWithArray:enabled];
		for (UIView *remove in[self.scroller subviews]) {
			[remove removeFromSuperview];
		}
		for (int i = 0; i < len; i++) {
			UIButton *btn = [[UIButton alloc] initForAutoLayout];
			NSArray *opts = [self.btns objectForKey:[enabled objectAtIndex:i]];
			[btn setImage:[UIImage imageNamed:[opts objectAtIndex:1]] forState:UIControlStateNormal];
			[btn addTarget:self action:[[opts objectAtIndex:0] pointerValue] forControlEvents:UIControlEventTouchUpInside];
			[self.scroller addSubview:btn];
		}
	}
}

- (void)updateConstraints {
	if (!self.didSetupConstraints) {
		for (UIButton *btn in[self.scroller subviews]) {
			[btn autoSetDimension:ALDimensionWidth toSize:60.0f];
			[btn autoSetDimension:ALDimensionHeight toSize:60.0f];
			[btn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.scroller];
		}
		[[self.scroller subviews] autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:44.0f insetSpacing:NO];
		[self.scroller autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
		[self.scroller autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
		[self.scroller autoSetDimension:ALDimensionHeight toSize:self.contentView.bounds.size.height];

		self.didSetupConstraints = YES;
	}

	[super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)messagesSelected:(id)sender {
	if (self.delegate != nil) {
		[self.delegate showMessages];
	}
}

- (void)playersSelected:(id)sender {
	if (self.delegate != nil) {
		[self.delegate showPlayers];
	}
}

- (void)programsSelected:(id)sender {
	if (self.delegate != nil) {
		[self.delegate showPrograms];
	}
}

- (void)localsSelected:(id)sender {
	if (self.delegate != nil) {
		[self.delegate showLocals];
	}
}

- (void)globalsSelected:(id)sender {
	if (self.delegate != nil) {
		[self.delegate showGlobals];
	}
}

- (void)clanSelected:(id)sender {
	if (self.delegate != nil) {
		[self.delegate showClan];
	}
}

@end
