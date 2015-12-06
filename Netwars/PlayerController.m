//
//  LookupController.m
//  Netwars
//
//  Created by amjolk on 29/09/13.
//  Copyright (c) 2013 mjolk. All rights reserved.
//

#import "PlayerController.h"
#import "Player.h"
#import "PlayerCell.h"
#import "AttackController.h"
#import "UIAlertView+AFNetworking.h"
#import "PickerCell.h"
#import "ProgramSliderCell.h"
#import "EventViewCell.h"

@interface PlayerController ()

- (void)load;

@end

@implementation PlayerController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.range = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[ProgramSliderCell class] forCellReuseIdentifier:@"ProgramSliderCell"];
    [self.tableView registerClass:[PickerCell class] forCellReuseIdentifier:@"PickerCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NormalCell"];
    [self.tableView registerClass:[PlayerCell class] forCellReuseIdentifier:@"PlayerCell"];
    [self.tableView registerClass:[EventViewCell class] forCellReuseIdentifier:@"EventCell"];
    self.players = [[NSMutableArray alloc] init];
    self.range = 0;
    self.cursor = @"";
    [self load];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)load
{
    __weak PlayerController *lookup = self;
    NSURLSessionDataTask *task = [Player list:self.range cursor:self.cursor
                                  callback   : ^(NSMutableArray *players, NSString *cursor) {
                                      [lookup.players addObjectsFromArray:players];
                                      lookup.cursor = cursor;
                                      [lookup.tableView reloadData];
                                  }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index::::::::: %lu \n\n", indexPath.row);
    static NSString *CellIdentifier = @"PlayerCell";
    if ([self attack]) {
        if ([self.attack indexInrange:indexPath]) {
            NSLog(@">>>>>attack edit %lu", indexPath.row);
            return [self.attack.config tableView:tableView cellForRowAtIndexPath:indexPath];
        }
    }
    Player *player = [self.players objectAtIndex:indexPath.row];
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setPlayer:player];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self attack]) {
        if ([self.attack indexInrange:indexPath]) {
            return [self.attack tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *profileAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Profile" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [self.tableView setEditing:NO];
    }];
    profileAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *messageAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Message"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [self.tableView setEditing:NO];
    }];
    
    //TODO if player not in clan and clan open spot -> invite action
    
    return @[profileAction, messageAction];
    
}

/*- (void)    tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath {
 }*/


// Override to support conditional editing of the table view.
// - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
// Return NO if you do not want the specified item to be editable.
// return YES;
// }


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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self attack]) {
        NSLog(@"requested row: %lu \n row after removal: %lu \n attack count: %lu", indexPath.row, (indexPath.row - [self.attack count]), [self.attack count]);
        if ([self.attack indexInrange:indexPath]) {
            [self.attack tableView:tableView didSelectRowAtIndexPath:indexPath];
            return;
        }
        if ([[self.attack virtualIndex] row] < indexPath.row) {
            indexPath = [NSIndexPath indexPathForRow:(indexPath.row - [self.attack count]) inSection:0];
        }
        [self.attack trash];
    }
    [self setAttack:[[AttackController alloc] initWithTarget:[self.players objectAtIndex:indexPath.row] andIndex:indexPath]];
    NSLog(@"players array %@", self.players);
    [self.attack setTableView:self.tableView];
    [self.attack initViewPrograms:self.players];
    
}

@end
