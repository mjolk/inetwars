//
//  EventController.m
//  Netwars
//
//  Created by amjolk on 30/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "EventController.h"
#import "Player.h"
#import "Event.h"
#import "EventCell.h"
#import "UIAlertView+AFNetworking.h"

@interface EventController ()

- (void)load;
@end

@implementation EventController

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (id)initForEventType:(NSString *)tpe {
	self = [super initWithStyle:UITableViewStylePlain];
	if (self) {
		self.eventType = tpe;
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
	self.cursor = @"";
	[self.tableView registerClass:[EventCell class] forCellReuseIdentifier:@"EventCell"];
	NSString *imageMapPath = [[NSBundle mainBundle] pathForResource:@"programgroupimg" ofType:@"plist"];
	self.imgMap = [[NSDictionary alloc] initWithContentsOfFile:imageMapPath];
	[self load];
}

- (void)load {
	NSURLSessionDataTask *task = [Event list:self.eventType cursor:self.cursor callback: ^(NSMutableArray *events, NSString *cursor) {
	    if ([self.cursor length] == 0) {
	        self.events = events;
		}
	    self.cursor = cursor;
	    [self.tableView reloadData];
	}];
	[UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
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
	return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"EventCell";
	EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

	// Configure the cell...
	[cell setEvent:[self.events objectAtIndex:indexPath.row]];

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
