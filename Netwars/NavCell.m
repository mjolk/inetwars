//
//  EventCell.m
//  Netwars
//
//  Created by amjolk on 20/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "NavCell.h"

@interface NavCell()

-(void) setup;

@end

@implementation NavCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void) setup {
    self.contentView.backgroundColor = [[UIColor alloc] initWithRed:254.0f/255.0f green:255.0f/255.0f blue:254.0f/255.0f alpha:1.0f];
    
    UIView *container = [UIView newAutoLayoutView];
    
    [self.contentView addSubview:container];
    
    [container autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
    [container autoCenterInSuperviewAlongAxis:ALAxisHorizontal];
    [container autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
    
    [container autoSetDimension:ALDimensionHeight toSize:70.0f];
    
    UIButton *localEventsBtn = [[UIButton alloc] initForAutoLayout];
    [localEventsBtn setImage:[UIImage imageNamed:@"events_44.png" ] forState:UIControlStateNormal];
    [localEventsBtn addTarget:localEventsBtn action:@selector(localsSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *programsBtn = [[UIButton alloc] initForAutoLayout];
    [programsBtn setImage:[UIImage imageNamed:@"programs_44.png"] forState:UIControlStateNormal];
    [programsBtn addTarget:self action:@selector(programsSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *listBtn = [[UIButton alloc] initForAutoLayout];
    [listBtn setImage:[UIImage imageNamed:@"list_44.png"] forState:UIControlStateNormal];
    [listBtn addTarget:listBtn action:@selector(listSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *messageBtn = [[UIButton alloc]initForAutoLayout];
    [messageBtn setImage:[UIImage imageNamed:@"messages_44.png"] forState:UIControlStateNormal];
    [messageBtn addTarget:messageBtn action:@selector(messageSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [container addSubview:localEventsBtn];
    [container addSubview:programsBtn];
    [container addSubview:listBtn];
    [container addSubview:messageBtn];
    
    [localEventsBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    [programsBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    [listBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    [messageBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    
    NSArray *subViews = @[localEventsBtn, programsBtn, listBtn, messageBtn];
    
    [container autoDistributeSubviews:subViews alongAxis:ALAxisHorizontal withFixedSpacing:0.0f alignment:NSLayoutFormatAlignAllCenterY];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)messageSelected:(id)sender {
    if (self.delegate != nil) {
        [self.delegate showMessages];
    }
}

- (void)listSelected:(id)sender {
    if (self.delegate != nil) {
        [self.delegate showLists];
    }
}

- (void)programsSelected:(id)sender {
    if (self.delegate != nil) {
        [self.delegate showPrograms];
    }
}

- (void)localsSelected:(id)sender {
    if (self.delegate != nil ) {
        [self.delegate showLocalEvents];
    }
}
@end
