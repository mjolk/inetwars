//
//  LoginViewController.m
//  Netwars
//
//  Created by mjolk on 15/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "PlayerController.h"
#import "CreatePlayerCell.h"
#import "Player.h"
#import "UIAlertView+AFNetworking.h"
#import "LoginCell.h"

@interface PlayerController ()

- (void)createPlayer;
-(void) setupInput:(UITableViewCell *) cell;

@end

@implementation PlayerController

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (id)initForCreate:(BOOL) type {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.create = type;
    }
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
        [self.tableView registerClass:[CreatePlayerCell class] forCellReuseIdentifier:@"CreateCell"];
        [self.tableView registerClass:[LoginCell class] forCellReuseIdentifier:@"LoginCell"];
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RegularCell"];
}

- (void) setupInput:(UITableViewCell *) cell {
    if (self.create) {
        CreatePlayerCell *input = (CreatePlayerCell *)cell;
        input.nick.delegate = self;
        input.email.delegate = self;
        input.password.delegate = self;
    } else {
        LoginCell *input = (LoginCell *)cell;
        input.email.delegate = self;
        input.password.delegate = self;
    }
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *btnCell = @"RegularCell";
	static NSString *createCell = @"CreateCell";
    static NSString *loginCell = @"LoginCell";
	UITableViewCell *cell;
	switch (indexPath.row) {
		case 0:
			cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
            if (self.create) {
                cell.textLabel.text = @"Login";
            } else {
                cell.textLabel.text = @"New player";
            }
			break;

		case 1:
			cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
			break;

		case 2: {
            if (self.create) {
                cell = [tableView dequeueReusableCellWithIdentifier:createCell forIndexPath:indexPath];
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:loginCell forIndexPath:indexPath];
            }
			
            [self setupInput:cell];
			break;
		}

		case 3:
			cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
            if(self.create) {
                cell.textLabel.text = @"Create new account";
            } else {
                cell.textLabel.text = @"Login";
            }
			break;
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height;
	CGFloat tableHeight = [self.tableView bounds].size.height;
	CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
	switch (indexPath.row) {
		case 1:
			height = tableHeight - (276.0f + statusBarHeight);
			break;

		case 2:
			height = 168.0f;
			break;

		default:
			height = 54.0f;
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
			self.nick = textField.text;
			break;

		case 1:
			self.email = textField.text;
			break;

		case 2:
			self.password = textField.text;
			break;
	}
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
    if (indexPath.row == 0) {
        self.create = self.create?NO:YES;
        [self.tableView reloadData];
    }
	if (indexPath.row == 3 && self.create) {
		NSLog(@"email: %@ \n nickname: %@ \n password: %@", self.email, self.nick, self.password);
		if ([self.email length] == 0 || [self.nick length] == 0 || [self.password length] == 0) {
			//error
		}
		else {
			[self createPlayer];
		}
    } else if(indexPath.row == 3){
        if ([self.email length] == 0 || [self.password length] == 0) {
            //error
        }
        else {
            [self login];
        }
    }
}

#pragma mark - create player

- (void)createPlayer {
	//__weak LoginViewController *sself = self;
	NSURLSessionDataTask *task = [Player create:self.nick email:self.email password:self.password callback: ^(NSDictionary *errors) {
	    if (errors) {
	        //errors
	        NSLog(@"errors %@", errors);
		}
	    else {
	        [self.delegate playerCreated:self];
		}
	}];
	[UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

-(void)login {
    NSURLSessionDataTask *task = [Player login:self.email password:self.password callback: ^(BOOL result) {
            [self.delegate playerCreated:self];
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

@end
