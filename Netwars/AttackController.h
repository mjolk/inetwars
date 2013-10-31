//
//  AttackController.h
//  Netwars
//
//  Created by amjolk on 01/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;
@class AttackType;

@interface AttackController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, strong) Player *target;
@property(nonatomic, strong) NSMutableArray *attacks;
@property(nonatomic, strong) NSArray *attackTypes;
@property(nonatomic, strong) NSMutableArray *filteredPrograms;
@property(nonatomic, strong) NSMutableArray *viewPrograms;
@property(nonatomic, strong) AttackType *selectedType;
@property(nonatomic, strong) NSMutableArray *remove;
@property(nonatomic, strong) NSMutableArray *add;
-(id) initWithTarget:(Player *) target;

@end
