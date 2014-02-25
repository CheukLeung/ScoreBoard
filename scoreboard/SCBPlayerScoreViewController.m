//
//  SCBPlayerScoreViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 03/02/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBPlayerScoreViewController.h"
#import "Constants.h"
#import "Utility.h"
#import "Game.h"
#import "Round.h"

@interface SCBPlayerScoreViewController ()
@property NSMutableArray *elements;
@property NSMutableArray *scores;
@end

@implementation SCBPlayerScoreViewController

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
   [self loadElements];
   [self loadScores];
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void)loadElements
{
   _elements = [NSMutableArray array];;
   for (int i = 0; i < [[Constants ElementNames] count]; i++){
      [_elements addObject:[[Constants ElementNames] objectAtIndex:i]];
   }
}

- (void)loadScores
{
   _elements = [NSMutableArray array];;
   for (int i = 0; i < [[Constants ElementNames] count]; i++){
      [_elements addObject:[[Constants ElementNames] objectAtIndex:i]];
   }
}


#pragma mark - Collection view data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
   return [self.scores count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"ScoreCell";
   UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
   NSNumber *scoreItem;
   
   // Return the player in the correponding row.
   scoreItem = [self.scores objectAtIndex:indexPath.item];
   
   NSInteger score = [scoreItem integerValue];
   
   UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
   UILabel *scoreLabel = (UILabel *)[cell viewWithTag:101];
   
   nameLabel.text = [_elements objectAtIndex:indexPath.item];
   scoreLabel.text = [NSString stringWithFormat:@"%d", score];
   [nameLabel setBackgroundColor:[Utility getColorFromString:[_elements objectAtIndex:indexPath.item]]];
   
   return cell;
   
}

@end
