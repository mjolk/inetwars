//
//  EffectorView.m
//  Netwars
//
//  Created by amjolk on 23/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "EffectorView.h"

@implementation EffectorView

- (id)initWithFrame:(CGRect)frame orientation:(Orientation)or layout:(Layout)l {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		CGFloat a = 5.0f;
		self.triPath = [UIBezierPath bezierPath];
		CGRect labelRect;
		switch (l) {
			case HorizontalLayout:
				switch (or) {
					case TopUpOrientation:
						labelRect = CGRectMake(10.0f, 20.0f, 20.f, 16.f);
						[self.triPath moveToPoint:(CGPoint) {self.frame.size.width / 2.f, a }];
						[self.triPath addLineToPoint:(CGPoint) {self.frame.size.width - a, self.frame.size.height - a }];
						[self.triPath addLineToPoint:(CGPoint) {a, self.frame.size.height - a }];
						[self.triPath closePath];
						break;

					case TopDownOrientation:
						labelRect = CGRectMake(10.0f, 4.0f, 20.f, 16.f);
						[self.triPath moveToPoint:(CGPoint) {a, a }];
						[self.triPath addLineToPoint:(CGPoint) {self.frame.size.width - a,  a }];
						[self.triPath addLineToPoint:(CGPoint) {self.frame.size.width / 2.f, self.frame.size.height - a }];
						[self.triPath closePath];
						break;
				}

				break;

			case VerticalLayout:
				switch (or) {
					case TopUpOrientation:
						labelRect = CGRectMake(5.0f, 10.0f, 20.f, 16.f);
						[self.triPath moveToPoint:(CGPoint) {a, a }];
						[self.triPath addLineToPoint:(CGPoint) {self.frame.size.width - a, self.frame.size.height / 2.f }];
						[self.triPath addLineToPoint:(CGPoint) {a,  self.frame.size.height - a }];
						[self.triPath closePath];
						break;

					case TopDownOrientation:
						labelRect = CGRectMake(14.0f, 10.0f, 20.f, 16.f);
						[self.triPath moveToPoint:(CGPoint) {a, self.frame.size.height / 2.f }];
						[self.triPath addLineToPoint:(CGPoint) {self.frame.size.width - a,  a }];
						[self.triPath addLineToPoint:(CGPoint) {self.frame.size.width - a, self.frame.size.height - a }];
						[self.triPath closePath];
						break;
				}
				break;
		}


		self.backgroundColor = [UIColor clearColor];

		UILabel *eLabel = [[UILabel alloc] initWithFrame:labelRect];
		[self addSubview:eLabel];
		self.effectLabel = eLabel;
		eLabel.font = [UIFont boldSystemFontOfSize:10.0f];
		eLabel.textColor = [UIColor whiteColor];
		eLabel.textAlignment = NSTextAlignmentCenter;
		eLabel.backgroundColor = [UIColor clearColor];
		//[eLabel set]
		// [eLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:4.f];
	}
	return self;
}

- (void)forEffect:(NSString *)effect {
	if ([effect length] > 0) {
		self.color = [UIColor redColor];
		self.effectLabel.text = effect;
	}
	else {
		self.effectLabel.text = @"";
		self.color = [UIColor greenColor];
	}
	[self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGColorRef col = self.color.CGColor;
	CGColorRef bcol = self.color.CGColor;
	CGContextSetFillColorWithColor(c, col);
	CGContextSetStrokeColorWithColor(c, bcol);
	CGContextSetLineWidth(c, 5.0f);
	CGContextSetLineJoin(c, kCGLineJoinRound);
	CGContextSetLineCap(c, kCGLineCapRound);
	CGContextAddPath(c, _triPath.CGPath);
	CGContextStrokePath(c);
	CGContextAddPath(c, _triPath.CGPath);
	CGContextFillPath(c);
}

@end
