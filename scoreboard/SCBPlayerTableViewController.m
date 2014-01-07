//
//  SCBPlayerTableViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 15/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import "SCBPlayerTableViewController.h"
#import "SCBAddNewPlayerViewController.h"
#import "SCBAppDelegate.h"


@interface SCBPlayerTableViewController ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property NSIndexPath* lastIndexPath;
@property NSMutableArray *players;
@property NSArray *searchResults;
@end

@implementation SCBPlayerTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInitialData {
   SCBAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
   self.players = [[NSMutableArray alloc] init];
   
   // Fetching Records and saving it in "fetchedRecordsArray" object
   [self.players addObjectsFromArray:[appDelegate getAllPlayersRecords]];
   [self.tableView reloadData];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:NO];
   [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
   // Depending if it is called by searching.
   if (tableView == self.searchDisplayController.searchResultsTableView) {
      return [self.searchResults count];
      
   } else {
      return [self.players count];
      
   }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"PlayerCell";
   UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                forIndexPath:indexPath];
   Player *playerItem;
   
   // Return the player in the correponding row.
   // Depending if it is called by searching.
   if (tableView == self.searchDisplayController.searchResultsTableView) {
      playerItem = [self.searchResults objectAtIndex:indexPath.row];
   } else {
      playerItem = [self.players objectAtIndex:indexPath.row];
   }
   
   ///
   NSLog(@"id %@",[playerItem objectID]);
   ///
   UIView *frontView = (UILabel *)[cell viewWithTag:100];
   UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
   UIImageView *photoImage = (UIImageView *) [cell viewWithTag:102];
   UIButton *deleteButton = (UIButton *) [cell viewWithTag:103];
   CGRect frame = frontView.frame;
   frame.origin.x = 0;
   [frontView setFrame:frame];
   [deleteButton setTag: indexPath.row + 200];
	nameLabel.text = [playerItem name];
   [photoImage setImage:[UIImage imageWithData:[playerItem photo]]];
   
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
- (void) deletePlayerAtRow:(NSInteger) row {
   Player *playerItem = [self.players objectAtIndex:row];
   [playerItem objectID];
   
   NSLog(@"Delete %ld!!", (long)row);
   
   SCBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   NSManagedObjectContext *context = [appDelegate managedObjectContext];
   [context deleteObject:playerItem];
   
   NSError * error;
   if (![self.managedObjectContext save:&error]) {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
      return;
   }
   
   [self.players removeObjectAtIndex:row];
   [self.tableView reloadData];
}

#pragma mark - Search bar action
/*!
 \description Filter the content according to the text.
 \param searchText Text that is used to search.
 \param scope
 \return no return value.
 \version
 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
   NSPredicate *resultPredicate = [NSPredicate
                                   predicateWithFormat:@"(name contains[cd] %@) OR (name like[cd] %@)",
                                   searchText, searchText];
   
   _searchResults = [_players filteredArrayUsingPredicate:resultPredicate];
}

/*!
 \description This method is automatically called every time the search string changes.
 \param controller The controller receiving the changes.
 \param searchString Text that is used to search.
 \return always return yes.
 \version
 */
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
   [self filterContentForSearchText:searchString
                              scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                     objectAtIndex:[self.searchDisplayController.searchBar
                                                    selectedScopeButtonIndex]]];
   
   return YES;
}


#pragma mark - Navigation
- (void) prepareForSegue :(UIStoryboardSegue *)segue sender:(id)sender{
   if ([segue.identifier isEqualToString:@"PlayerTableSegue"]) {
      NSIndexPath *indexPath;

      // Set the selected player.
      // Depending if it is called by searching.
      if ([self.searchDisplayController isActive]) {
         indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
         self.selectedPlayer = [self.searchResults objectAtIndex:indexPath.row];
         
      } else {
         indexPath = [self.tableView indexPathForSelectedRow];
         self.selectedPlayer = [self.players objectAtIndex:indexPath.row];
      }
   }
}

/*!
 \description Handler of unwinding segue from adding player view.
 \param segue Segue that triiger this unwind.
 \return no return value.
 \version
 */
- (IBAction)unwindFromAddPlayer:(UIStoryboardSegue *)segue
{
   SCBAddNewPlayerViewController *source = [segue sourceViewController];
   
   if ([source.name length])
   {
      
      Player* newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Player"
                                                       inManagedObjectContext:self.managedObjectContext];
      newEntry.name = [source name];
      newEntry.photo = [source photo];
      
      NSError * error;
      if (![self.managedObjectContext save:&error]) {
         NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
         return;
      }
      [self.players addObject:newEntry];
      [self.tableView reloadData];
   }
}

#pragma mark - Interaction
/*!
 \description Handler of the delete button action.
 \param sender Button that trigger the event.
 \return no return value.
 \version
 */
- (IBAction)deleteButtonAction:(UIButton *)sender {
   NSInteger row = sender.tag - 200;
   [self deletePlayerAtRow:row];
}

/*!
 \description Handler of the pan gesture based on the state of the recogniser.
 \param sender Pan gesture recognizer that trigger this event.
 \return no return value.
 \version
 */
- (IBAction)panGestureHandler:(UIPanGestureRecognizer *)sender {
   CGPoint swipeLocation = [sender locationInView:self.tableView];
   NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
   UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:swipedIndexPath];
   UIView *frontView = (UIView *) [cell viewWithTag:100];
   if (sender.state == UIGestureRecognizerStateBegan){
      if (cell != nil)
      {
         _lastIndexPath = swipedIndexPath;
         [self touchesBegan:frontView
                 atLocation:swipeLocation];
         return;
      }
   } else if (sender.state == UIGestureRecognizerStateEnded){
      [self springBack:frontView];
      return;
   } else if (sender.state == UIGestureRecognizerStateCancelled){
      [self springBack:frontView];
      return;
   } else if (sender.state == UIGestureRecognizerStateChanged){
      [self dragsChanged:frontView
              atLocation:swipeLocation];
   }
   [swipedIndexPath row];
}

/*!
 \description Set the cell that has been started touching.
 \param frontView The view to be set.
 \param swipeLocation The CGPoint that is touched.
 \return no return value.
 \version
 */
-(void)touchesBegan: (UIView *) frontView atLocation : (CGPoint) swipeLocation{
   CGRect frame = frontView.frame;
   frame.origin = CGPointMake(swipeLocation.x, frame.origin.y);
   
   [UIView animateWithDuration:0.2
                         delay: 0.0
                       options: UIViewAnimationOptionCurveEaseOut
                    animations:^{
                       frontView.frame = frame;
                    }
                    completion:NULL];
}


/*!
 \description Change the position of the cell when the gesture is changed.
 \param frontView The view to be set.
 \param swipeLocation The CGPoint that is touched.
 \return no return value.
 \version
 */
-(void)dragsChanged: (UIView *) frontView atLocation : (CGPoint) swipeLocation {
   NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
   
   if (swipedIndexPath != _lastIndexPath){
      UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:_lastIndexPath];
      UIView *lastView = (UIView *) [lastCell viewWithTag:100];
      [self springBack:lastView];
      return;
   }
   CGRect frame = frontView.frame;
   CGFloat xLimit = frame.size.width * .5;
   CGFloat xPos = swipeLocation.x > xLimit ? xLimit : swipeLocation.x;
   
   frame.origin = CGPointMake(xPos, frame.origin.y);
   
   [UIView animateWithDuration:0.2
                         delay: 0.0
                       options: UIViewAnimationOptionCurveEaseOut
                    animations:^{
                       frontView.frame = frame;
                    }
                    completion:NULL];
}

/*!
 \description Set the position of the cell when it is relaesed.
 \param frontView The view to be set.
 \return no return value.
 \version
 */
-(void)springBack : (UIView *) frontView{
   
   CGRect frame = frontView.frame;
   CGFloat xLimit = frame.size.width * .2;
   CGFloat xPos = frame.origin.x >= xLimit ? xLimit : 0;
   frame.origin = CGPointMake(xPos, frame.origin.y);
   
   [UIView animateWithDuration:0.2
                         delay: 0.0
                       options: UIViewAnimationOptionCurveEaseOut
                    animations:^{
                       frontView.frame = frame;
                    }
                    completion:NULL];
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
    return NO;
}
*/

@end
