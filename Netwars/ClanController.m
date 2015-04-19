//
//  ClanController.m
//  Netwars
//
//  Created by mjolk on 13/11/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "ClanController.h"
#import "Player.h"
#import "InviteController.h"
#import "ClanCell.h"

@interface ClanController ()
-(void) load;
@end

@implementation ClanController

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
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(load) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor magentaColor];
    self.refreshControl = refreshControl;
    [self.navigationController setNavigationBarHidden:NO];
    [self.tableView registerClass:[ClanCell class] forCellReuseIdentifier:@"ClanCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RegCell"];
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self load];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 1;
    } else if(section == 3) {
        return [self.clan.wars count];
    } else if (section == 4) {
        return [self.clan.members count];
    }
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CCell = @"ClanCell";
    static NSString *RCell = @"RegCell";
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        ClanCell *clanCell = [tableView dequeueReusableCellWithIdentifier:CCell forIndexPath:indexPath];
        [clanCell setClan:self.clan];
        [clanCell setNeedsUpdateConstraints];
        [clanCell updateConstraintsIfNeeded];
        return clanCell;
    } else if(indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RCell forIndexPath:indexPath];
        cell.textLabel.text = self.clan.message;
        return cell;
    } else if(indexPath.section == 2) {
        UITableViewCell *wcell = [tableView dequeueReusableCellWithIdentifier:RCell forIndexPath:indexPath];
        wcell.textLabel.text = self.clan.wars[indexPath.row];
        return wcell;
    } else if (indexPath.section == 3) {
        UITableViewCell *mcell = [tableView dequeueReusableCellWithIdentifier:RCell forIndexPath:indexPath];
        mcell.textLabel.text = self.clan.members[indexPath.row];
    }
	// Configure the cell...

	return cell;
}

- (void) load {
    __weak ClanController *ccon = self;
    [Clan state:^(Clan *cl){
        ccon.clan = cl;
        [ccon.tableView reloadData];
        [ccon.refreshControl endRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    switch (indexPath.section) {
        case 0:
            height = 220.0f;
            break;
        case 1:
            height = 44.0f;
            break;
        default:
            height = 44.0f;
            break;
    }
    return height;
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
