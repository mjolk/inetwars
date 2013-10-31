//
//  ProgramListController.m
//  Netwars
//
//  Created by amjolk on 21/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "ProgramController.h"
#import "Program.h"
#import "ProgramCell.h"
#import "EffectorView.h"
#import "AllocController.h"
#import "UIAlertView+AFNetworking.h"
#import "Player.h"

@interface ProgramController ()

- (void)load;
- (UIView *)createHeader:(NSString *)programType;

@end

@implementation ProgramController

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
    
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
	NSString *imageMapPath = [[NSBundle mainBundle] pathForResource:@"programgroupimg" ofType:@"plist"];
	self.imgMap = [[NSDictionary alloc] initWithContentsOfFile:imageMapPath];
    
	[self.tableView registerClass:[ProgramCell class] forCellReuseIdentifier:@"ProgramCell"];
    
	[self load];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [self updateSource];
}

- (void)updateSource {
	NSMutableArray *supportedProgramTypes = [[NSMutableArray alloc] init];
	Player *player = [Player sharedPlayer];
	for (ProgramGroup *pGroup in player.programs) {
		//only programs for which you can have power.
		if ([pGroup.ptype isEqualToString:@"Connection"]) {
			for (Program *energy in pGroup.programs) {
				NSLog(@"supported types : %@\n", [energy.effectors objectAtIndex:0]);
				[supportedProgramTypes addObject:[energy.effectors objectAtIndex:0]];
			}
		}
	}
	//always show connections/ power units
	[supportedProgramTypes addObject:@"Connection"];
	NSPredicate *prgPred = [NSPredicate predicateWithFormat:@"ptype IN $NAME_LIST"];
	NSArray *filtered = [self.programs filteredArrayUsingPredicate:[prgPred predicateWithSubstitutionVariables:@{ @"NAME_LIST":supportedProgramTypes }]];
    for (ProgramGroup *_prog in filtered) {
        NSLog(@"filtered program A--- %@", _prog.ptype);
    }
    self.filteredPrograms = [NSMutableArray arrayWithArray:filtered];
    for (ProgramGroup *prog in self.filteredPrograms) {
        NSLog(@"filtered program B--- %@", prog.ptype);
    }
    NSLog(@"filter ----");
    [self.tableView reloadData];
}

- (void)load {
	__weak ProgramController *pself = self;
	NSURLSessionDataTask *task = [Program list: ^(NSMutableArray *progs) {
        NSLog(@"loaded programs %@", progs);
	    if (progs != nil) {
	        pself.programs = [NSArray arrayWithArray:progs];
	        [pself updateSource];
		}
	}];
	[UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (UIView *)createHeader:(NSString *)programType {
	UIView *header = [[UIView alloc] init];
    
	UILabel *ptype = [[UILabel alloc] initForAutoLayout];
	// ptype.translatesAutoresizingMaskIntoConstraints = NO;
	[header addSubview:ptype];
	ptype.font = [UIFont systemFontOfSize:32.0f];
	ptype.textColor = [UIColor whiteColor];
	ptype.backgroundColor = [UIColor clearColor];
	ptype.text = [programType substringToIndex:2];
	[ptype autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0f];
	[ptype autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3.0f];
    
	UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.imgMap[programType][@"group"]]]];
	imgv.translatesAutoresizingMaskIntoConstraints = NO;
	[header addSubview:imgv];
	[imgv autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
	[imgv autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0f];
	header.backgroundColor = [UIColor colorWithRed:(22.0f / 255.0f) green:160.0f / 255.0f blue:133.0f / 255.0f alpha:0.6f];
    
    
	UILabel *alLabel = [[UILabel alloc] initForAutoLayout];
	alLabel.font = [UIFont systemFontOfSize:10.0f];
	alLabel.text = @"attack/life";
	alLabel.backgroundColor = [UIColor clearColor];
	alLabel.textColor = [UIColor whiteColor];
	[header addSubview:alLabel];
	[alLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:2.0f];
	[alLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:4.0f];
	return header;
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section {
	NSString *programType = [[self.filteredPrograms objectAtIndex:section] ptype];
	UIView *hdr = [self createHeader:programType];
	return hdr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 56.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[self.filteredPrograms objectAtIndex:section] ptype];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return [self.filteredPrograms count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return [[[self.filteredPrograms objectAtIndex:section] programs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ProgramCell";
	ProgramCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	ProgramGroup *programGroup = [self.filteredPrograms objectAtIndex:indexPath.section];
	Program *prog = [[programGroup programs] objectAtIndex:indexPath.row];
	// [cell.imageView setImage:[UIImage imageNamed:self.imgMap[programGroup.ptype][@"program"]]];
	[cell setProgram:prog];
    
    
	// Configure the cell...
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100.0f;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic may go here. Create and push another view controller.
	/*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
	 */
	Program *program = [[[self.filteredPrograms objectAtIndex:indexPath.section] programs] objectAtIndex:indexPath.row];
	AllocController *allocController = [[AllocController alloc] initWithProgram:program];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:allocController animated:YES];
}

@end
