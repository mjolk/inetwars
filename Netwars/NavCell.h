//
//  EventCell.h
//  Netwars
//
//  Created by amjolk on 20/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuDelegate <NSObject>
- (void) showLocalEvents;
- (void) showPrograms;
- (void) showLists;
- (void) showMessages;
@end

@interface NavCell : UITableViewCell
@property (weak, nonatomic) id delegate;
- (void)messageSelected:(id)sender;
- (void)listSelected:(id)sender;
- (void)programsSelected:(id)sender;
- (void)localsSelected:(id)sender;

@end
