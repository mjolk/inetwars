//
//  AttackController.m
//  Netwars
//
//  Created by amjolk on 01/10/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "AttackController.h"
#import "PlayerCell.h"
#import "Player.h"
#import "Attack.h"
#import "ProgramSliderCell.h"
#import "PickerCell.h"
#import "Program.h"
#import "Event.h"
#import "UIAlertView+AFNetworking.h"
#import "TableConfiguration.h"
#import "CellConfiguration.h"
#import "EventViewCell.h"

@implementation Picker
@end

@implementation AttackButton
@end


@interface AttackController ()

- (void)filter;
- (void)refreshPrograms;
- (Attack *) currentAttack;

@end

@implementation AttackController


- (id)initWithTarget:(Player *)target andIndex:(NSIndexPath *)vIndex
{
    self = [super init];
    if (self) {
        self.virtualIndex = vIndex;
        NSLog(@"attack initialized on index: %lu", [vIndex row]);
        self.target = target;
        self.attackTypes = @[[[AttackType alloc] initWithName:@"Balanced"
                                                       typeId:BAL
                                                        types:@[@"Mutator", @"Swarm", @"d0s", @"Hunter/Killer"]],
                             [[AttackType alloc] initWithName:@"Bandwidth"
                                                       typeId:BW
                                                        types:@[@"d0s", @"Hunter/Killer"]],
                             [[AttackType alloc] initWithName:@"Memory"
                                                       typeId:MEM
                                                        types:@[@"Mutator", @"Swarm"]],
                             [[AttackType alloc] initWithName:@"Ice"
                                                       typeId:AICE
                                                        types:@[@"Ice"]],
                             [[AttackType alloc] initWithName:@"Intelligence"
                                                       typeId:AINT
                                                        types:@[@"Intelligence"]]];
        self.selectedType = [self.attackTypes objectAtIndex:0];
        //self.attacks = [[NSMutableArray alloc] initWithObjects:self.currentAttack, nil];
        self.filterPrograms = [[NSMutableArray alloc] init];
        __weak AttackController *control = self;
        TableConfiguration *config = [[TableConfiguration alloc] initWithConfig:
                                      @[[[CellConfiguration alloc] initWithConfig:
                                         ^(Picker *item, PickerCell *cell){
                                             cell.picker.delegate = control;
                                             cell.picker.dataSource = control;
                                             cell.typeField.text = control.selectedType.name;
                                         } andIdentifier:@"PickerCell" forData:[[Picker alloc] init]],
                                        [[CellConfiguration alloc] initWithConfig:
                                         ^(Program *program, ProgramSliderCell *cell){
                                             [cell setProgram:program];
                                         } andIdentifier:@"ProgramSliderCell" forData:[[Program alloc] init]],
                                        [[CellConfiguration alloc] initWithConfig:
                                         ^(AttackButton *item, UITableViewCell *cell){
                                             cell.textLabel.text = @"Attack";
                                         } andIdentifier:@"NormalCell" forData:[[AttackButton alloc] init]],
                                        [[CellConfiguration alloc] initWithConfig:
                                         ^(Event *event, EventViewCell *cell) {
                                             NSLog(@"event %@", event);
                                             [cell load:event];
                                         } andIdentifier:@"EventCell" forData:[[Event alloc] init]]
                                        ] forIndex:vIndex];
        [self setConfig:config];
        
    }
    return self;
}

- (Attack *) currentAttack
{
    return [self.attacks objectAtIndex:[self.attacks count]];
}

- (NSUInteger) endIndex
{
    return [self.virtualIndex row] + ([self.filterPrograms count] + 2) + [self.attacks count];
}


- (BOOL) indexInrange:(NSIndexPath *)idx
{
    if ([idx row] > [self.virtualIndex row] && [idx row] <= [self endIndex]) {
        return YES;
    }
    return NO;
}

- (void) trash
{
    [self removePrograms:UITableViewRowAnimationFade];
    [self.config.dataSource removeObjectAtIndex:[self endIndex]];
    [self.config.dataSource removeObjectAtIndex:([self.virtualIndex row] + 1)];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self endIndex] inSection:0],
                                             [NSIndexPath indexPathForRow:([self.virtualIndex row] + 1) inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    
}

- (NSUInteger) count
{
    return [self.attacks count] + ([self.filterPrograms count] + 2);
}



- (void)removePrograms:(UITableViewRowAnimation)animation
{
    if ([self.filterPrograms count] > 0) {
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSUInteger i = [self.virtualIndex row] + 2;
        NSUInteger count = i + [self.filterPrograms count];
        for (; i < count; i++) {
            NSLog(@"delete rows at indexpaths %lu \n", i);
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            [self.config.dataSource removeObjectAtIndex:i];
        }
        [self.filterPrograms removeAllObjects];
        if (count) {
            
            [self.tableView
             deleteRowsAtIndexPaths:indexPaths
             withRowAnimation:animation];
        }
    }
}

- (void) initViewPrograms:(NSMutableArray *)viewPrograms
{
    [self.config setDataSource:viewPrograms];
    [self.config addItem:[[Picker alloc] init] atIndex:([self.virtualIndex row] + 1)];
    [self.config addItem:[[AttackButton alloc] init] atIndex:[self endIndex]];
    NSLog(@"insert controls at: %lu \n and at %lu", ([self.virtualIndex row] + 1), [self endIndex]);
    [self.tableView insertRowsAtIndexPaths: @[[NSIndexPath indexPathForRow:([self.virtualIndex row] + 1) inSection:0],
                                              [NSIndexPath indexPathForRow:([self.virtualIndex row] + 2) inSection:0]]
                          withRowAnimation: UITableViewRowAnimationTop];
    [self refreshPrograms];
}

- (void)refreshPrograms
{
    [self removePrograms: UITableViewRowAnimationFade];
    [self filter];
    if ([self.filterPrograms count] > 0) {
        NSUInteger i = ([self.virtualIndex row] + 2);
        NSUInteger count = (i + [self.filterPrograms count]);
        for (; i < count; i++) {
            NSUInteger j = i - ([self.virtualIndex row] + 2);
            NSLog(@"program nr %lu \n from total cnt %lu \n index : %lu \n minus : %lu", j, [self.filterPrograms count], i, ([self.virtualIndex row] + 2));
            [self.config addItem:[self.filterPrograms objectAtIndex:j] atIndex:i];
            [self.tableView insertRowsAtIndexPaths:
             [NSArray arrayWithObject:[NSIndexPath indexPathForRow:i
                                                         inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}

- (void)filter
{
    NSLog(@"filterprograms");
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ptype IN $NAME_LIST and programs[SIZE] > 0"];
    NSArray *filtered = [[[Player sharedPlayer] programs]
                         filteredArrayUsingPredicate:
                         [pred predicateWithSubstitutionVariables:@{ @"NAME_LIST":[self.selectedType ptypes] }]];
    [self.filterPrograms removeAllObjects];
    for (ProgramGroup *group in filtered) {
        for (Program *program in [group programs]) {
            [self.filterPrograms addObject:[program copy]];
            
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger firstCell = ([self.virtualIndex row] + 1);
    NSUInteger lastCell = [self.virtualIndex row] + ([self.config.dataSource count] + 2);
    if (indexPath.row == firstCell) {
        return 40.f;
    } else if (indexPath.row > firstCell && indexPath.row < lastCell) {
        return 66.f;
    } else if (indexPath.row == lastCell) {
        return 44.0f;
    }
    return 0;
}
#pragma mark - picker datasource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.attackTypes count];
}

#pragma mark - picker delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //selected attack type
    NSLog(@"selcted row : %ld selected type= %@", (long)row, [self.attackTypes objectAtIndex:row]);
    self.selectedType = [self.attackTypes objectAtIndex:row];
    [self.tableView endEditing:YES];
    [self.tableView reloadData];
    [self refreshPrograms];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.attackTypes objectAtIndex:row] name];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self endIndex]) {
        Attack *attack = [[Attack alloc] initWithTargetAndType:self.target type:self.selectedType];
        NSUInteger i = ([self.virtualIndex row] + 2);
        for (; i < ([self endIndex] + [self.attacks count]); i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            ProgramSliderCell *cell = (ProgramSliderCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            if (cell.slider.value > 0) {
                Program *attackProgram = [[self.config.dataSource objectAtIndex:i] dataItem];
                attackProgram.amount = (int)cell.slider.value;
                [attack.programs addObject:attackProgram];
            }
        }
        __weak AttackController *catt = self;
        NSURLSessionDataTask *task;
        if ([[attack programs] count] > 0) {
            task = [attack execute: ^(Event *attackEvent) {
                NSLog(@"Attack Event: %@", attackEvent);
                [catt.config addItem:attackEvent atIndex:([self endIndex] - 1)];
                [self.attacks addObject:attack];
                [self.tableView insertRowsAtIndexPaths:
                 [NSArray arrayWithObject:[NSIndexPath indexPathForRow:([self endIndex] - 1)
                                                             inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
            }];
        }
        [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    }
}

@end
