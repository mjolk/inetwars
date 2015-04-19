//
//  InviteController.m
//  Netwars
//
//  Created by mjolk on 18/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "InviteController.h"
#import "Player.h"
#import "Invite.h"
#import "ClanCreateCell.h"
#import "Clan.h"
#import "UIAlertView+AFNetworking.h"

@interface InviteController ()

- (void)loadInvites;
- (void)createClan;

@end

@implementation InviteController

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
    [self.navigationController setNavigationBarHidden:NO];

	[self.tableView registerClass:[ClanCreateCell class] forCellReuseIdentifier:@"ClanInputCell"];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RegularCell"];

	[self loadInvites];
}

- (void)loadInvites {
	__weak InviteController *weakCtrl = self;
	[Invite invites: ^(NSMutableArray *invites) {
	    weakCtrl.invites = invites;
	    [weakCtrl.tableView reloadData];
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return 3 + [self.invites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *btnCell = @"RegularCell";
	static NSString *inputCell = @"ClanInputCell";
	if (indexPath.row == 0) {
		ClanCreateCell *input = [tableView dequeueReusableCellWithIdentifier:inputCell forIndexPath:indexPath];
		input.name.delegate = self;
		input.name.tag = 0;
		input.clanTag.delegate = self;
		input.clanTag.tag = 1;
		[input setNeedsUpdateConstraints];
		[input updateConstraintsIfNeeded];
		return input;
	}
	else if (indexPath.row == 1) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
		cell.textLabel.text = @"Create clan";
		return cell;
	}
	else if (indexPath.row == 2) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
		cell.textLabel.text = @"Invites";
		return cell;
	}
	else if (indexPath.row > 2) {
		if ([self.invites count] > 0) {
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
			cell.textLabel.text = [[self.invites objectAtIndex:indexPath.row - 2] clan];
			// cell.detailTextLabel.text = [[[self.invites objectAtIndex:indexPath.row - 2] expires];
			return cell;
		}
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height;
	switch (indexPath.row) {
		case 0:
			height = 200.0f;
			break;

		default:
			height = 44.0f;
			break;
	}
	return height;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	switch (textField.tag) {
		case 0:
			self.name = textField.text;
			break;

		case 1:
			self.tag = textField.text;
			break;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic may go here. Create and push another view controller.
	/*
	   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
	   // ...
	   // Pass the selected object to the new view controller.
	   [self.navigationController pushViewController:detailViewController animated:YES];
	 */
    NSLog(@"selected row %ld", indexPath.row);
	if (indexPath.row == 1) {
		NSLog(@"name: %@ tag: %@", self.name, self.tag);
		if ([self.name length] == 0 || [self.tag length] == 0) {
			//error
		}
		else {
			[self createClan];
		}
	}
}

- (void)createClan {
	  NSURLSessionDataTask *task = [Clan create:self.name tag:self.tag callback:^(BOOL fail) {
          [self.delegate clanCreated:self];
    }];
	   [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
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
   }

 */

@end
