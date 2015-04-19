//
//  StateController.m
//  Netwars
//
//  Created by amjolk on 18/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "PlayerStateController.h"
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
#import "InviteController.h"
#import "DetailTextCell.h"

@interface PlayerStateController ()

- (void)load;

@end

@implementation PlayerStateController

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

	[self.tableView registerClass:[NavCell class] forCellReuseIdentifier:@"NavCell"];

	[self.tableView registerClass:[DetailTextCell class] forCellReuseIdentifier:@"RegularCell"];

	[self.tableView registerClass:[TrackerCell class] forCellReuseIdentifier:@"TrackerCell"];

	[self load];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES];
	[self.tableView reloadData];
}

- (void)load {
	self.navigationItem.rightBarButtonItem.enabled = NO;
	__weak PlayerStateController *state = self;
	NSURLSessionTask *task = [[Player sharedPlayer] state: ^(BOOL failed) {
	    if (failed) {
	        [state.refreshControl endRefreshing];
	        return;
		}
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
	if (section < 3) {
		return nil;
	}
	ProgramGroup *group = [[[Player sharedPlayer] programs] objectAtIndex:section - 3];
	PgHeader *header = [[PgHeader alloc] initWithFrame:CGRectMake(0.f, 0.f, 44.f, 44.f)];
	CGFloat progress = group.usage / group.yield;
	[header.bwUsageProgress setProgress:progress animated:YES];
	header.programTypeLabel.text = group.ptype;
	[header setNeedsUpdateConstraints];
	[header updateConstraintsIfNeeded];
	return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section < 3) {
		return 0.f;
	}
	return 33.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section > 3) {
		cell.contentView.backgroundColor = [[UIColor alloc] initWithRed:164.0f / 255.0f green:246.0f / 255.0f blue:181.0f / 255.0f alpha:1.0f];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return [[[Player sharedPlayer] programs] count] + 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section < 3) {
		return 1;
	}
	return [[[[[Player sharedPlayer] programs] objectAtIndex:section - 3] programs]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *HUDCELL = @"HUDCell";
	static NSString *NAVCELL = @"NavCell";
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
		[hudCell setNeedsUpdateConstraints];
		[hudCell updateConstraintsIfNeeded];
		return hudCell;
	}
	else if (indexPath.section == 1) {
		TrackerCell *eventCell = [tableView dequeueReusableCellWithIdentifier:@"TrackerCell" forIndexPath:indexPath];
		[eventCell setEventCount:player.tracker.eventCount];
		[eventCell setMessageCount:player.tracker.messageCount];
		[eventCell setNeedsUpdateConstraints];
		[eventCell updateConstraintsIfNeeded];
		return eventCell;
	}
	else if (indexPath.section == 2) {
		NavCell *navCell = [tableView dequeueReusableCellWithIdentifier:NAVCELL forIndexPath:indexPath];
		[navCell initMenu:@[@"players", @"globals", @"locals", @"programs", @"messages", @"clan"]];
		navCell.delegate = self;
		[navCell setNeedsUpdateConstraints];
		[navCell updateConstraintsIfNeeded];
		return navCell;
	}
	else {
		UITableViewCell *regCell = [tableView dequeueReusableCellWithIdentifier:@"RegularCell" forIndexPath:indexPath];
		Program *program = [[[[player programs] objectAtIndex:indexPath.section - 3] programs] objectAtIndex:indexPath.row];
		regCell.textLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)program.amount];
		regCell.textLabel.backgroundColor = [UIColor clearColor];
		regCell.detailTextLabel.backgroundColor = [UIColor clearColor];

		regCell.detailTextLabel.text = program.name;
		NSLog(@"program name: %@", regCell.detailTextLabel.text);
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
			height = 22.0f;
			break;

		case 2:
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
	EventController *eventController = [[EventController alloc] initForEventType:@"local"];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:eventController animated:YES];
}

- (void)showGlobals {
	EventController *eventController = [[EventController alloc] initForEventType:@"global"];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:eventController animated:YES];
}

- (void)showClan {
    NSLog(@"invite controller ----\n: %@", [[Player sharedPlayer] clan]);
	if (![[Player sharedPlayer] clanMember]) {
		InviteController *invite = [[InviteController alloc] initWithStyle:UITableViewStylePlain];
        invite.delegate = self;
		[self.navigationController pushViewController:invite animated:YES];
	}
	else {
		ClanController *clanController = [[ClanController alloc] initWithStyle:UITableViewStylePlain];
		// ...
		// Pass the selected object to the new view controller.
		[self.navigationController pushViewController:clanController animated:YES];
	}
}

- (void)clanCreated:(InviteController *)controller {
    [self.navigationController popViewControllerAnimated:NO];
    ClanController *clanController = [[ClanController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:clanController animated:YES];
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
	if (indexPath.section > 2) {
		Program *program = [[[[[Player sharedPlayer] programs] objectAtIndex:indexPath.section - 3] programs] objectAtIndex:indexPath.row];
		AllocController *allocController = [[AllocController alloc] initWithProgram:program];
		// ...
		// Pass the selected object to the new view controller.
		[self.navigationController pushViewController:allocController animated:YES];
	}
}

@end
