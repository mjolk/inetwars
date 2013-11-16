//
//  StateController.m
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "StateController.h"
#import "LoginController.h"
#import "NavCell.h"
#import "ProgramController.h"
#import "Player.h"
#import "HUDCell.h"
#import "PgHeader.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"
#import "LookupController.h"
#import "EventController.h"
#import "DACircularProgressView.h"
#import "Program.h"
#import "AllocController.h"
#import "ClanController.h"

@interface StateController ()

- (void)load;

@end

@implementation StateController

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)loadView {
	[super loadView];
    
	self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	self.activityIndicator.hidesWhenStopped = YES;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
    
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
	                                    init];
    
	[refreshControl addTarget:self action:@selector(load) forControlEvents:UIControlEventValueChanged];
	refreshControl.tintColor = [UIColor magentaColor];
	self.refreshControl = refreshControl;
    
	[self.tableView registerClass:[HUDCell class] forCellReuseIdentifier:@"HUDCell"];
    
	[self.tableView registerClass:[NavCell class] forCellReuseIdentifier:@"EventCell"];
    
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RegularCell"];
    
    
	if ([[Player sharedPlayer] notAuthenticated]) {
		LoginController *login = [[LoginController alloc] initWithStyle:UITableViewStylePlain];
		login.modalPresentationStyle = UIModalPresentationFullScreen;
		login.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		[login setDelegate:self];
		[self presentViewController:login animated:NO completion:nil];
	}
	else {
		[self load];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	[self.tableView reloadData];
}

- (void)userCreated:(LoginController *)controller {
	NSLog(@"user created");
	[self dismissViewControllerAnimated:YES completion: ^(void) {
	    [self load];
	}];
}

- (void)load {
	self.navigationItem.rightBarButtonItem.enabled = NO;
	__weak StateController *state = self;
	NSURLSessionTask *task = [[Player sharedPlayer] state: ^(BOOL failed) {
	    if (failed) {
	        [state.refreshControl endRefreshing];
	        return;
		}
	    NSLog(@"tableView reload");
	    [state.tableView reloadData];
	    [state.refreshControl endRefreshing];
        //        [self refreshPrograms];
	}];
	[UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
	[self.activityIndicator setAnimatingWithStateOfTask:task];
    
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section {
	if (section < 2) {
		return nil;
	}
	ProgramGroup *group = [[[Player sharedPlayer] programs] objectAtIndex:section - 2];
	PgHeader *header = [[PgHeader alloc] initWithFrame:CGRectMake(0.f, 0.f, 44.f, 44.f)];
	CGFloat progress = group.usage / group.yield;
	[header.bwUsageProgress setProgress:progress animated:YES];
	header.programTypeLabel.text = group.ptype;
	return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section < 2) {
		return 0.f;
	}
	return 33.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section > 1) {
		cell.contentView.backgroundColor = [[UIColor alloc] initWithRed:164.0f / 255.0f green:246.0f / 255.0f blue:181.0f / 255.0f alpha:1.0f];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return [[[Player sharedPlayer] programs] count] + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section < 2) {
		return 1;
	}
	return [[[[[Player sharedPlayer] programs] objectAtIndex:section - 2] programs]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *HUDCELL = @"HUDCell";
	static NSString *EVENTCELL = @"EventCell";
	Player *player = [Player sharedPlayer];
	UITableViewCell *cell;
    
	if (indexPath.section == 0) {
		HUDCell *hudCell = [tableView dequeueReusableCellWithIdentifier:HUDCELL forIndexPath:indexPath];
		[hudCell setUsageProgress:(player.bandwidthUsage / player.bandwidth)];
		[hudCell setAmemProgress:((float)player.activeMemory / 10.0)];
		[hudCell setMemory:player.memory];
		[hudCell setBandwidth:player.bandwidthUsage bandwidth:player.bandwidth];
		[hudCell setActivememory:player.activeMemory];
		[hudCell setCycles:player.cycles];
		return hudCell;
	}
	else if (indexPath.section == 1) {
		NavCell *eventCell = [tableView dequeueReusableCellWithIdentifier:EVENTCELL forIndexPath:indexPath];
        [eventCell initMenu:@[@"players", @"globals", @"locals", @"programs", @"messages", @"clan"]];
		eventCell.delegate = self;
		return eventCell;
	}
	else {
		UITableViewCell *regCell = [tableView dequeueReusableCellWithIdentifier:@"RegularCell" forIndexPath:indexPath];
		Program *program = [[[[[Player sharedPlayer] programs] objectAtIndex:indexPath.section - 2] programs] objectAtIndex:indexPath.row];
		regCell.textLabel.text = [NSString stringWithFormat:@"%d", program.amount];
		regCell.textLabel.backgroundColor = [UIColor clearColor];
		regCell.detailTextLabel.backgroundColor = [UIColor clearColor];
		regCell.detailTextLabel.text = program.name;
		return regCell;
	}
    
    
    
    
	// Configure the cell...
    
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height;
	switch (indexPath.section) {
		case 0:
			height = 220.0f;
			break;
            
		case 1:
			height = 70.0f;
			break;
            
		default:
			height = 44.0f;
			break;
	}
	return height;
}

#pragma mark - Menu delegate

- (void)showPrograms {
	ProgramController *programController = [[ProgramController alloc] initWithStyle:UITableViewStylePlain];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:programController animated:YES];
}

- (void)showPlayers {
	LookupController *lookupController = [[LookupController alloc] initWithStyle:UITableViewStylePlain];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:lookupController animated:YES];
}

- (void)showMessages {
}

- (void)showLocals {
	EventController *eventController = [[EventController alloc] initWithStyle:UITableViewStylePlain];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:eventController animated:YES];
}

- (void)showGlobals {
	EventController *eventController = [[EventController alloc] initWithStyle:UITableViewStylePlain];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:eventController animated:YES];
}

- (void)showClan {
	ClanController *eventController = [[ClanController alloc] initWithStyle:UITableViewStylePlain];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:eventController animated:YES];
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
    if (indexPath.section > 1) {
        Program *program = [[[[[Player sharedPlayer] programs] objectAtIndex:indexPath.section - 2] programs] objectAtIndex:indexPath.row];
        AllocController *allocController = [[AllocController alloc] initWithProgram:program];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:allocController animated:YES];
    }
}

@end
