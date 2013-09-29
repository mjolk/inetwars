//
//  EffectorView.h
//  Netwars
//
//  Created by amjolk on 23/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum Orientation {
    TopDownOrientation = 0,
    TopUpOrientation,
} Orientation;

typedef enum Layout {
    HorizontalLayout = 0,
    VerticalLayout,
} Layout;

@interface EffectorView : UIView

@property (nonatomic, strong) UIBezierPath *triPath;
@property(nonatomic, weak) UILabel *effectLabel;
@property(nonatomic, strong) UIColor *color;

-(void) forEffect:(NSString *) effect;
- (id)initWithFrame:(CGRect)frame orientation:(Orientation) or layout:(Layout) l;

@end
