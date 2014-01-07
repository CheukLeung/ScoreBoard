//
//  SCBSelectPlayersViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 07/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBSelectPlayersViewController.h"
#import "SCBAppDelegate.h"

@interface SCBSelectPlayersViewController ()
@property NSMutableArray *players;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation SCBSelectPlayersViewController
@synthesize  selectedPlayers = _selectedPlayers;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   [self loadInitialData];
   self.collectionView.allowsMultipleSelection = YES;
   _selectedPlayers = [NSMutableArray array];
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
   [self.collectionView reloadData];
}

#pragma mark - Collection view data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
   return [self.players count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"PlayerCell";
   UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
   Player *playerItem;
   
   // Return the player in the correponding row.
   playerItem = [self.players objectAtIndex:indexPath.item];
   
   UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
   UIImageView *photoImage = (UIImageView *) [cell viewWithTag:102];

	nameLabel.text = [playerItem name];
   [photoImage setImage:[UIImage imageWithData:[playerItem photo]]];
   
   cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedBackground"]];
   return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   if ([_selectedPlayers count] >= 4)
   {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exceeding Players Limit"
                                                      message:@"A game should always starts with at most 4 players"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
      [self.collectionView deselectItemAtIndexPath: indexPath animated:YES];
   }
   else
   {
      // Determine the selected items by using the indexPath
      Player *selectedPlayer = [_players objectAtIndex:indexPath.row];
      // Add the selected item into the array
      [_selectedPlayers addObject:selectedPlayer];
   }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // Determine the selected items by using the indexPath
   Player *selectedPlayer = [_players objectAtIndex:indexPath.row];
   // Add the selected item into the array
   [_selectedPlayers removeObject:selectedPlayer];
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


@end
