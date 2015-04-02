//
//  AllocController.m
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "AllocController.h"
#import "ResourceCell.h"
#import "ProgramInfoCell.h"
#import "SliderCell.h"
#import "Player.h"
#import "UIAlertView+AFNetworking.h"
#import "DACircularProgressView.h"

@interface AllocController ()

@property (nonatomic, strong) Program *program;
@property (nonatomic, weak) ProgramInfoCell *programInfo;
@property (nonatomic, weak) ResourceCell *resourceInfo;
@property (nonatomic, weak) UISlider *slider;
@property (nonatomic, weak) UILabel *btnLabel;
@property (nonatomic, assign) NSUInteger amount;
@property (nonatomic, assign) AllocType at;

- (void)updateResource:(NSUInteger)a;

@end

@implementation AllocController

- (id)initWithProgram:(Program *)prog {
	self = [super initWithStyle:UITableViewStylePlain];
	if (self) {
		_program = prog;
	}
	return self;
}

- (void)allocSelect:(id)sender {
	UISegmentedControl *control = (UISegmentedControl *)sender;
	NSInteger selectedSegment = control.selectedSegmentIndex;
	switch (selectedSegment) {
		case 0:
			self.at = Allocate;
			self.btnLabel.text = @"Allocate";
			break;
            
		case 1:
			self.at = Deallocate;
			self.btnLabel.text = @"Deallocate";
			break;
	}
	[self.slider setValue:0.f animated:YES];
	[self updateResource:0.f];
}

- (void)updateResource:(NSUInteger)a {
	Player *player = [Player sharedPlayer];
	NSUInteger yield = 0;
	CGFloat usage = 0;
	NSUInteger ow = 0;
	for (ProgramGroup *pg in player.programs) {
		if ([pg.ptype isEqualToString:self.program.type]) {
			yield = pg.yield;
			usage = pg.usage;
			for (Program *p in pg.programs) {
				if ([p.programKey isEqualToString:self.program.programKey]) {
					ow = p.amount;
				}
			}
		}
	}
	[self.programInfo updateUserValues:self.at amount:a owned:ow];
	self.amount = a;
	CGFloat memp = 0.f;
	CGFloat cycp = 0.f;
	CGFloat usagep = 0.f;
	if (a > 0) {
		switch (self.at) {
			case Allocate:
				memp = (self.program.memory * a) / (float)player.memory;
				cycp = ((float)self.program.cycles * a) / (float)player.cycles;
				// if (yield > 0) {
				usagep = (usage + ((self.program.cycles * self.program.memory / 10) * a)) / (float)yield;
				// }
				break;
                
			case Deallocate:
				memp = (self.program.memory * a) / (self.program.memory * (float)ow);
				cycp = ((float)self.program.cycles * a) / (float)(self.program.cycles * ow);
				if (yield > 0) {
					usagep = (usage + ((self.program.cycles * self.program.memory * 10) * a)) / (float)yield;
				}
				break;
		}
	}
	[self.resourceInfo.memProgress setProgress:memp animated:NO];
	[self.resourceInfo.cycleProgress setProgress:cycp animated:NO];
	[self.resourceInfo.bandwidthProgress setProgress:usagep animated:NO];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
    
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationController setNavigationBarHidden:NO];
	UISegmentedControl *cntrl = [[UISegmentedControl alloc] initWithItems:@[@"Allocate", @"Deallocate"]];
	[cntrl setSelectedSegmentIndex:0];
	self.btnLabel.text = @"Allocate";
	self.navigationItem.titleView = cntrl;
	[cntrl addTarget:self action:@selector(allocSelect:) forControlEvents:UIControlEventValueChanged];
	[self.tableView registerClass:[ResourceCell class] forCellReuseIdentifier:@"ResourceCell"];
	[self.tableView registerClass:[ProgramInfoCell class] forCellReuseIdentifier:@"InfoCell"];
	[self.tableView registerClass:[SliderCell class] forCellReuseIdentifier:@"SliderCell"];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RegularCell"];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height = 44.f;
	switch (indexPath.row) {
		case 0:
			height = 60.f;
			break;
            
		case 1:
			height = 320.f;
			break;
            
		case 2:
			height = 60.f;
			break;
            
		case 3:
			height = 65.f;
			break;
            
		default:
			height = 44.f;
			break;
	}
	return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *resource = @"ResourceCell";
	static NSString *info = @"InfoCell";
	static NSString *btn = @"RegularCell";
	static NSString *slider = @"SliderCell";
	ResourceCell *rcell;
	UITableViewCell *cell;
	SliderCell *scell;
	ProgramInfoCell *pcell;
	Player *player = [Player sharedPlayer];
	switch (indexPath.row) {
		case 0:
			rcell = [tableView dequeueReusableCellWithIdentifier:resource forIndexPath:indexPath];
			self.resourceInfo = rcell;
			return rcell;
            
		case 1:
			pcell = [tableView dequeueReusableCellWithIdentifier:info forIndexPath:indexPath];
			self.programInfo = pcell;
			[self.programInfo setProgram:self.program];
			return pcell;
            
		case 2:
			scell = [tableView dequeueReusableCellWithIdentifier:slider];
			[scell positionSlider:nil];
			[scell.slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
			self.slider = scell.slider;
			CGFloat amountForCycles = 0.f;
			CGFloat amountForMem = 0.f;
			CGFloat pAmount = 0.f;
			switch (self.at) {
				case Allocate:
					amountForCycles = floorf(player.cycles / (self.program.cycles));
					amountForMem = floorf((float)player.memory / (self.program.memory));
					if (amountForCycles < 1 || amountForMem < 1) {
						[self.slider setEnabled:NO];
						break;
					}
					uint maxam = MIN(amountForMem, amountForCycles);
					[self.slider setMaximumValue:maxam];
					[self.slider setMinimumValue:0];
					break;
                    
				case Deallocate:
					for (ProgramGroup *pg in player.programs) {
						if ([pg.ptype isEqualToString:self.program.type]) {
							for (Program *p in pg.programs) {
								if ([p.programKey isEqualToString:self.program.programKey]) {
									pAmount = p.amount;
								}
							}
						}
					}
					if (pAmount <= 0) {
						[self.slider setEnabled:NO];
						break;
					}
					[self.slider setMinimumValue:0.f];
					[self.slider setMaximumValue:pAmount];
					break;
			}
            
			return scell;
            
		default:
			cell = [tableView dequeueReusableCellWithIdentifier:btn forIndexPath:indexPath];
			cell.textLabel.text = @"Allocate";
			self.btnLabel = cell.textLabel;
			cell.textLabel.textAlignment = NSTextAlignmentCenter;
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			break;
	}
	[self updateResource:0.f];
	// Configure the cell...
	return cell;
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

- (void)sliderChange:(id)sender {
	UISlider *slider = (UISlider *)sender;
	int increment = (int)1.f / self.program.memory;
	//[slider setValue: animated:NO];
	[self updateResource:((int)slider.value - (int)slider.value % increment)];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic may go here. Create and push another view controller.
	//__weak AllocController *this = self;
	__weak Player *player = [Player sharedPlayer];
    __weak AllocController *alloc = self;
	if (indexPath.row > 2) {
        NSLog(@"program selected : %@", self.program.programKey);
		NSURLSessionDataTask *allocTask = [Program allocate:self.at program:self.program.programKey amount:self.amount allocBlock: ^(BOOL failed) {
            BOOL notExists = YES;
		    if (failed) {
		        NSLog(@"error!!!!");
		        return;
			}
            if ([self.program.type isEqualToString:@"Connection"]) {
                
                for (ProgramGroup *pg in player.programs) {
                    if([pg.ptype isEqualToString:alloc.program.effectors[0]]) {
                        notExists = NO;
                    }
                }
                NSLog(@"notextists %d", notExists);
                if (notExists) {
                    NSLog(@"effector-- : %@ \n", self.program.effectors[0]);
                    ProgramGroup *newGroup = [[ProgramGroup alloc] initForType:@"Connection"];
                    alloc.program.amount = alloc.amount;
                    alloc.program.effectors = [[NSArray alloc] initWithObjects:self.program.effectors[0], nil];
                    [newGroup.programs addObject:alloc.program];
                    [player.programs addObject:newGroup];
                }
            }
            [alloc.navigationController popViewControllerAnimated:YES];
            
		    //state.navigationItem.rightBarButtonItem.enabled = YES;
		   // NSLog(@"tableView reload");
		    //[.tableView reloadData];
		    //        [self refreshPrograms];
		}];
		[UIAlertView showAlertViewForTaskWithErrorOnCompletion:allocTask delegate:nil];
	}
	/*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
	 */
}

@end
