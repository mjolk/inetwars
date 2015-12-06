//
//  AttackController.h
//  Netwars
//
//  Created by amjolk on 01/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableConfiguration.h"

@class Player;
@class AttackType;

@interface Picker : NSObject
@end

@interface AttackButton : NSObject
@end

@interface AttackController : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) Player *target;
@property (nonatomic, strong) NSMutableArray *attacks;
@property (nonatomic, strong) NSArray *attackTypes;
@property (nonatomic, strong) AttackType *selectedType;
@property (nonatomic, strong) NSIndexPath *virtualIndex;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *filterPrograms;
@property (nonatomic, strong) TableConfiguration *config;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (id)initWithTarget:(Player *)target andIndex:(NSIndexPath *) vIndex;
- (BOOL) indexInrange:(NSIndexPath *) index;
- (NSUInteger) endIndex;
- (void) trash;
- (NSUInteger) count;
- (void) initViewPrograms:(NSMutableArray *)viewPrograms;

@end
