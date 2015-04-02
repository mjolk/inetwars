//
//  EventCell.h
//  Netwars
//
//  Created by amjolk on 20/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuDelegate <NSObject>
- (void) showPrograms;
- (void) showLocals;
- (void) showGlobals;
- (void) showClan;
- (void) showMessages;
- (void) showPlayers;
@end

@interface NavCell : UITableViewCell
@property (weak, nonatomic) id delegate;
@property (strong, nonatomic) NSDictionary *btns;
@property (weak, nonatomic) UIScrollView *scroller;
@property (strong, nonatomic) NSArray *active;
@property (nonatomic, assign) BOOL didSetupConstraints;


- (void)messagesSelected:(id)sender;
- (void)localsSelected:(id)sender;
- (void)globalsSelected:(id)sender;
- (void)programsSelected:(id)sender;
- (void)clanSelected:(id)sender;
- (void)playersSelected:(id)sender;
- (void)initMenu:(NSArray *) enabled;
@end
