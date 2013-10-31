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


@interface AttackController ()

@property (nonatomic, strong) Attack *currentAttack;
- (void)filterPrograms;
- (void) refreshPrograms;

@end

@implementation AttackController


- (id)initWithTarget:(Player *)target {
	self = [super initWithStyle:UITableViewStylePlain];
	if (self) {
		// Custom initialization
		self.target = target;
		AttackType *atpe = [[AttackType alloc] initWithNameAndTypes:@"Balanced" types:@[@"Mutator", @"Swarm", @"d0s", @"Hunter/Killer"]];
		AttackType *btpe = [[AttackType alloc] initWithNameAndTypes:@"Bandwidth" types:@[@"d0s", @"Hunter/Killer"]];
		AttackType *ctpe = [[AttackType alloc] initWithNameAndTypes:@"Memory" types:@[@"Mutator", @"Swarm"]];
		AttackType *dtpe = [[AttackType alloc] initWithNameAndTypes:@"Ice" types:@[@"Ice"]];
		AttackType *etpe = [[AttackType alloc] initWithNameAndTypes:@"Intelligence" types:@[@"Intelligence"]];
		self.attackTypes = @[atpe, btpe, ctpe, dtpe, etpe];
		self.selectedType = atpe;
		//self.attacks = [[NSMutableArray alloc] initWithObjects:self.currentAttack, nil];
		[self filterPrograms];
	}
	return self;
}

- (void)emptySectionAtIndex:(NSInteger)aSectionIndex
              withAnimation:(UITableViewRowAnimation)animation
{
	if (aSectionIndex >= [self.viewPrograms count] + 1)
	{
        return;
	}
	
	NSMutableArray *indexPaths = [NSMutableArray array];
	int i;
	int count = [[[self.viewPrograms objectAtIndex:aSectionIndex - 1] programs] count];
	for (i = 0; i < count; i++)
	{
		[indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:aSectionIndex]];
	}
    
	[[[self.viewPrograms objectAtIndex:aSectionIndex - 1] programs] removeAllObjects];
    
	if (count)
	{
        NSLog(@"delete rows");
		[self.tableView
         deleteRowsAtIndexPaths:indexPaths
         withRowAnimation:animation];
	}
}

- (void) refreshPrograms {
    [self.tableView reloadData];
    int len = [self.viewPrograms count];
    for (int r = 0; r < len; r++) {
        NSLog(@"empty section: %d", r);
        [self emptySectionAtIndex:r+1 withAnimation:UITableViewRowAnimationNone];
    }
    for(int i = 0; i<len;i++) {
        NSLog(@"insert program");
        int plen = [[[self.filteredPrograms objectAtIndex:i] programs] count];
        NSLog(@"insert program plen %d", plen);
        for (int j = 0; j<plen; j++) {
            [[[self.viewPrograms objectAtIndex:i] programs] addObject:[[[[self.filteredPrograms objectAtIndex:i] programs] objectAtIndex:j] copy]];
            [self.tableView insertRowsAtIndexPaths:
             [NSArray arrayWithObject:
              [NSIndexPath
               indexPathForRow:j
               inSection:i+1]]
             withRowAnimation:UITableViewRowAnimationTop];
        }
        
    }
    
    
    //self.filteredPrograms = [[Player sharedPlayer] programs] filter
    
}

- (void)filterPrograms {
    NSLog(@"filterprograms");
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"ptype IN $NAME_LIST and programs[SIZE] > 0"];
    NSArray *filtered = [[[Player sharedPlayer] programs] filteredArrayUsingPredicate:[pred predicateWithSubstitutionVariables:@{ @"NAME_LIST":self.selectedType.ptypes }]];
    self.filteredPrograms = [NSMutableArray arrayWithArray:filtered];
    self.viewPrograms = [[NSMutableArray alloc] init];
    for (ProgramGroup *pg in self.filteredPrograms){
        NSLog(@"filtered group type : %@ , count: %d \n", pg.ptype, [pg.programs count]);
        [self.viewPrograms addObject:[pg copy]];
    }
    for (ProgramGroup *pg in self.viewPrograms){
        NSLog(@"group type : %@ , count: %d \n", pg.ptype, [pg.programs count]);
    }
    
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
    
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
	[self.tableView registerClass:[PlayerCell class] forCellReuseIdentifier:@"PlayerCell"];
	[self.tableView registerClass:[ProgramSliderCell class] forCellReuseIdentifier:@"ProgramSliderCell"];
	[self.tableView registerClass:[PickerCell class] forCellReuseIdentifier:@"PickerCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NormalCell"];
    self.currentAttack = [[Attack alloc] initWithTargetAndType:self.target type:self.selectedType];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 2 + [self.viewPrograms count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	if (section == 0) {
		return 2;
	}
    if (section == [self.viewPrograms count] +1) {
        return 1;
    }
    NSLog(@"indexpath section : %d rowcount: %d", section, [[[self.viewPrograms objectAtIndex:section -1] programs ]count]);
	return [[[self.viewPrograms objectAtIndex:section -1] programs ]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *sliderCell = @"ProgramSliderCell";
	static NSString *playerCell = @"PlayerCell";
	static NSString *pickerCell = @"PickerCell";
    static NSString *normalCell = @"NormalCell";
	UITableViewCell *cell;
	if (indexPath.section < 1) {
		if (indexPath.row == 0) {
			PlayerCell *pcell = [tableView dequeueReusableCellWithIdentifier:playerCell forIndexPath:indexPath];
			[pcell setPlayer:self.target];
			return pcell;
		}
		else if (indexPath.row == 1) {
			PickerCell *picell = [tableView dequeueReusableCellWithIdentifier:pickerCell forIndexPath:indexPath];
			picell.picker.delegate = self;
            picell.picker.dataSource = self;
            picell.typeField.text = self.currentAttack.type.name;
			[picell.picker selectedRowInComponent:0];
			return picell;
		}
	}
	else if (indexPath.section < [self.viewPrograms count] +1){
        NSLog(@"row: %d \n", indexPath.row);
        if ([[[self.viewPrograms objectAtIndex:(indexPath.section -1)] programs] count] > 0 ) {
            ProgramSliderCell *pscell = [tableView dequeueReusableCellWithIdentifier:sliderCell forIndexPath:indexPath];
            //  NSLog(@"pgroup : %@", [[[self.filteredPrograms objectAtIndex:(indexPath.section -1)] programs] objectAtIndex:indexPath.row]);
            [pscell setProgram:[[[self.viewPrograms objectAtIndex:(indexPath.section -1)] programs] objectAtIndex:indexPath.row]];
            return pscell;
        }
	}
    
	// Configure the cell...
    cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
    cell.textLabel.text = @"Attack";
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if( indexPath.section == 0) {
        switch(indexPath.row) {
            case 0:
                return 100.f;
            case 1:
                return 32.f;
        }
    } else if(indexPath.section < [self.viewPrograms count] +1){
        return 66.f;
    }
    return 44.0f;
}


#pragma mark - picker datasource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.attackTypes count];
}

#pragma mark - picker delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	//selected attack type
    NSLog(@"selcted row : %d selected type= %@", row, [self.attackTypes objectAtIndex:row]);
	self.selectedType = [self.attackTypes objectAtIndex:row];
	[self.currentAttack setType:self.selectedType];
    [self.tableView endEditing:YES];
    [self filterPrograms];
    [self refreshPrograms];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[self.attackTypes objectAtIndex:row] name];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [self.viewPrograms count] +1) {
        [self.currentAttack.programs removeAllObjects];
        for (int i = 0; i < indexPath.section - 1; i++) {
            int progCount = [[[self.viewPrograms objectAtIndex:i] programs] count];
            for (int j = 0; j < progCount; j++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow: j inSection: i + 1];
                ProgramSliderCell *cell = (ProgramSliderCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                if (cell.slider.value > 0) {
                    Program *attackProgram = [[[self.viewPrograms objectAtIndex:i] programs] objectAtIndex:j];
                    attackProgram.amount = (int)cell.slider.value;
                    [self.currentAttack.programs addObject:attackProgram];
                }
            }
        }
        __weak Attack *catt = self.currentAttack;
        NSURLSessionDataTask *task;
        if([[self.currentAttack programs] count] > 0) {
            task = [self.currentAttack execute:^(Event *attackEvent) {
                catt.result = attackEvent;
                NSLog(@"attack event: %@", attackEvent.dict);
                NSString *win = @"lost";
                if (attackEvent.win) {
                    win = @"win";
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"attack event : %@", win] message:[NSString stringWithFormat:@"%@", attackEvent.dict] delegate:Nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                [alert show];
            }];
        }
        [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    }
}
@end
