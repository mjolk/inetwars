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
        //[self setup];
        self.contentView.backgroundColor = [[UIColor alloc] initWithRed:254.0f/255.0f green:255.0f/255.0f blue:254.0f/255.0f alpha:1.0f];
        
        UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 70.0)];
        [self.contentView addSubview:scroller];
        [scroller setPagingEnabled:YES];
        self.scroller = scroller;
        
        self.btns = @{@"players": @[[NSValue valueWithPointer:@selector(playersSelected:)], @"list_44.png"],
                      @"programs": @[[NSValue valueWithPointer:@selector(programsSelected:)], @"programs_44.png"],
                      @"locals": @[[NSValue valueWithPointer:@selector(localsSelected:)], @"events_44.png"],
                      @"globals": @[[NSValue valueWithPointer:@selector(globalsSelected:)], @"events_44.png"],
                      @"clan": @[[NSValue valueWithPointer:@selector(clanSelected:)], @"events_44.png"],
                      @"messages": @[[NSValue valueWithPointer:@selector(messagesSelected:)], @"messages_44.png"]};
                      
        
    }
    return self;
}

- (void) initMenu:(NSArray *) enabled {
    CGFloat cellWidth = self.contentView.bounds.size.width;
    CGFloat btnWidth = cellWidth/ 4;
    int len = [enabled count];
    int slen = [self.active count];
    if (len != slen) {
        NSLog(@"reloading menu len: %d slen: %d\n", len, slen);
        self.active = [NSArray arrayWithArray:enabled];
        for(UIView *remove in [self.scroller subviews]) {
            [remove removeFromSuperview];
        }
        [self.scroller setContentSize:CGSizeMake(len*btnWidth, [self.scroller bounds].size.height)];
        for(int i = 0; i < len; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnWidth, 0.0, btnWidth, 70.0)];
            NSArray *opts = [self.btns objectForKey:[self.active objectAtIndex:i]];
            [btn setImage:[UIImage imageNamed:[opts objectAtIndex:1]] forState:UIControlStateNormal];
            [btn addTarget:self action:[[opts objectAtIndex:0] pointerValue] forControlEvents:UIControlEventTouchUpInside];
            [self.scroller addSubview:btn];
        }

    }
    
}

- (void) setup {
    self.contentView.backgroundColor = [[UIColor alloc] initWithRed:254.0f/255.0f green:255.0f/255.0f blue:254.0f/255.0f alpha:1.0f];
    
    UIView *container = [UIView newAutoLayoutView];//[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self.contentView addSubview:container];
    
    [container autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView];
    [container autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [container autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView];
    
    [container autoSetDimension:ALDimensionHeight toSize:70.0f];
    
    UIButton *localEventsBtn = [[UIButton alloc] initForAutoLayout];
    [localEventsBtn setImage:[UIImage imageNamed:@"events_44.png" ] forState:UIControlStateNormal];
    [localEventsBtn addTarget:self action:@selector(localsSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *programsBtn = [[UIButton alloc] initForAutoLayout];
    [programsBtn setImage:[UIImage imageNamed:@"programs_44.png"] forState:UIControlStateNormal];
    [programsBtn addTarget:self action:@selector(programsSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *listBtn = [[UIButton alloc] initForAutoLayout];
    [listBtn setImage:[UIImage imageNamed:@"list_44.png"] forState:UIControlStateNormal];
    [listBtn addTarget:self action:@selector(listSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *messageBtn = [[UIButton alloc]initForAutoLayout];
    [messageBtn setImage:[UIImage imageNamed:@"messages_44.png"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messagesSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [container addSubview:localEventsBtn];
    [container addSubview:programsBtn];
    [container addSubview:listBtn];
    [container addSubview:messageBtn];
    
    [localEventsBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    [programsBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    [listBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    [messageBtn autoSetDimension:ALDimensionHeight toSize:70.0f];
    
    NSArray *subViews = @[localEventsBtn, programsBtn, listBtn, messageBtn];
    
    [subViews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0.0f];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
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
    if (self.delegate != nil ) {
        [self.delegate showLocals];
    }
}

- (void)globalsSelected:(id)sender {
    if (self.delegate != nil ) {
        [self.delegate showGlobals];
    }
}

- (void)clanSelected:(id)sender {
    if (self.delegate != nil ) {
        [self.delegate showClan];
    }
}
@end
