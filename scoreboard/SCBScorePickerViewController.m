//
//  SCBScorePickerViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBScorePickerViewController.h"
#import "Utility.h"

@interface SCBScorePickerViewController ()
@property NSMutableArray *elements;
@end

@implementation SCBScorePickerViewController

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
   self.collectionView.allowsMultipleSelection = YES;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void)loadElements
{
   _elements = [NSMutableArray array];
   [_elements addObject:@"小三元"];
   [_elements addObject:@"大四喜"];
   [_elements addObject:@"平糊"];
   [_elements addObject:@"對對糊"];
   [_elements addObject:@"清一色"];
   [_elements addObject:@"混一色"];
   [_elements addObject:@"正花"];
   [_elements addObject:@"正花"];
   [_elements addObject:@"一台花"];
   [_elements addObject:@"花糊"];
   [_elements addObject:@"十三么"];
   [_elements addObject:@"槓上自摸"];
   [_elements addObject:@"大三元"];
   [_elements addObject:@"小四喜"];
   [_elements addObject:@"海底撈月"];
   [_elements addObject:@"天糊"];
}

#pragma mark - Collection view data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
   return [self.elements count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"ScoreCell";
   UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
   UILabel *elementLabel = (UILabel *)[cell viewWithTag:100];
	elementLabel.text = [_elements objectAtIndex:indexPath.item];
   
   UIView *bgView = [[UIView alloc] init];
   [bgView setBackgroundColor:[Utility getColorFromString:[elementLabel text]]];
   
   [cell setSelectedBackgroundView:bgView];
   return cell;
   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   _fulfilledElements += pow(2, indexPath.row);
   NSLog(@"fulfilled: %ld", (long)_fulfilledElements);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
   _fulfilledElements -= pow(2, indexPath.row);
   NSLog(@"fulfilled: %ld", (long)_fulfilledElements);
}

#pragma mark - Navigation
- (void) prepareForSegue :(UIStoryboardSegue *)segue sender:(id)sender{
   NSLog(@"prepare segue");
}



@end
