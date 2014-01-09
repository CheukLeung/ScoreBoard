//
//  SCBPlayersPickerViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBPlayersPickerViewController.h"
#import "Player.h"
#import "Utility.h"
@interface SCBPlayersPickerViewController ()
@end

@implementation SCBPlayersPickerViewController
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
	[self.collectionView reloadData];
   self.collectionView.allowsMultipleSelection = YES;
   _selectedPlayers = [NSMutableArray array];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

   UIView *bgView = [[UIView alloc] init];
   [bgView setBackgroundColor:[Utility getColorFromString:[playerItem name]]];

   [cell setSelectedBackgroundView:bgView];
   return cell;
   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // Determine the selected items by using the indexPath
   Player *selectedPlayer = [_players objectAtIndex:indexPath.row];
   // Add the selected item into the array
   [_selectedPlayers addObject:selectedPlayer];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // Determine the selected items by using the indexPath
   Player *selectedPlayer = [_players objectAtIndex:indexPath.row];
   // Add the selected item into the array
   [_selectedPlayers removeObject:selectedPlayer];
}

@end
