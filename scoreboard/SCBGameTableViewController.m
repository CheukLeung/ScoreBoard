//
//  SCBGameTableViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 23/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBGameTableViewController.h"
#import "SCBAppDelegate.h"
#import "Constants.h"
#import "Player.h"


@interface SCBGameTableViewController ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSMutableArray *games;
@end

@implementation SCBGameTableViewController
@synthesize mainDelegate = _mainDelegate;
- (id)initWithStyle:(UITableViewStyle)style
{
   self = [super initWithStyle:style];
   if (self) {
      // Custom initialization
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   [self loadInitialData];
   // Uncomment the following line to preserve selection between presentations.
   // self.clearsSelectionOnViewWillAppear = NO;
 
   // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
   // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void)loadInitialData {
   SCBAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
   self.games = [[NSMutableArray alloc] init];
   
   // Fetching Records and saving it in "fetchedRecordsArray" object
   [self.games addObjectsFromArray:[appDelegate getAllGamesRecords]];
   [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // Return the number of sections.
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // Return the number of rows in the section.
   return [self.games count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"GameCell";
   UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                forIndexPath:indexPath];
   Game *gameItem;
   gameItem = [self.games objectAtIndex:[self.games count] - indexPath.row - 1];
   NSLog(@"%@", gameItem.objectID);
   NSLog(@"%lu", (unsigned long)[gameItem.players count]);
   
   NSMutableArray *scorelist = [[NSMutableArray alloc] init];
   [scorelist addObject:gameItem.player0];
   [scorelist addObject:gameItem.player1];
   [scorelist addObject:gameItem.player2];
   [scorelist addObject:gameItem.player3];
   [scorelist addObject:gameItem.player4];
   [scorelist addObject:gameItem.player5];
   
   NSMutableArray *playerlist = [NSMutableArray arrayWithArray:[gameItem.players array]];
   // UIView *frontView = (UILabel *)[cell viewWithTag:100];
   
   for (int i = 0; i < [playerlist count]; i++)
   {
      Player *player = [playerlist objectAtIndex:i];
      NSInteger score = [[scorelist objectAtIndex:i] integerValue];
      UILabel *nameLabel = (UILabel *)[cell viewWithTag:200 + i];
      UILabel *scoreLabel = (UILabel *)[cell viewWithTag:400 + i];
      UIImageView *photoImage = (UIImageView *) [cell viewWithTag:300 + i];
      [nameLabel setText:[NSString stringWithFormat:@"%@",player.name]];
      [scoreLabel setText:[NSString stringWithFormat:@"%ld",(long)score]];
      [photoImage setImage:[UIImage imageWithData:[player photo]]];
      if (score < 0)
      {
         scoreLabel.textColor = [UIColor redColor];
      }
      else if (score == 0)
      {
         scoreLabel.textColor = [UIColor blackColor];
      }
      else
      {
         scoreLabel.textColor = [UIColor blueColor];
      }
   }
   
   for (NSUInteger i = [playerlist count]; i < MaximumNumberOfPlayers; i++)
   {
      UILabel *nameLabel = (UILabel *)[cell viewWithTag:200 + i];
      UILabel *scoreLabel = (UILabel *)[cell viewWithTag:400 + i];
      UIImageView *photoImage = (UIImageView *) [cell viewWithTag:300 + i];
      [nameLabel setText:@""];
      [scoreLabel setText:@""];
      [photoImage setImage:nil];
   }
   
   return cell;
}

#pragma mark - Core Data access
/*!
 \description Getter of managedObjectContext.
 \return managedObjectContext.
 \version
 */
- (NSManagedObjectContext*) managedObjectContext {
   if (_managedObjectContext != nil) {
      return _managedObjectContext;
   }
   SCBAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
   _managedObjectContext = appDelegate.managedObjectContext;
   return _managedObjectContext;
}

/*!
 \description Delete player from table and core data at a row.
 \param row The row index of the player to be removed.
 \return no return value.
 \version
 */
- (void) deleteGameAtRow:(NSInteger) row {
   Game *gameItem = [self.games objectAtIndex:row];
   [gameItem objectID];
   
   NSLog(@"Delete %ld!!", (long)row);
   
   SCBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   NSManagedObjectContext *context = [appDelegate managedObjectContext];
   [context deleteObject:gameItem];
   
   NSError * error;
   if (![self.managedObjectContext save:&error]) {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
      return;
   }
   
   [self.games removeObjectAtIndex:row];
   [self.tableView reloadData];
}

- (void) reloadData
{
   [self loadInitialData];
   [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [self.mainDelegate startGame:[self.games objectAtIndex:[self.games count] - indexPath.row - 1]];
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
