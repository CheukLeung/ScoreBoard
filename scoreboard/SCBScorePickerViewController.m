//
//  SCBScorePickerViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBScorePickerViewController.h"
#import "Utility.h"
#import "Constants.h"

@interface SCBScorePickerViewController ()
@property NSMutableArray *elements;
@end

@implementation SCBScorePickerViewController
@synthesize delegate = _delegate;

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
   _elements = [NSMutableArray array];;
   for (int i = 0; i < [[Constants ElementNames] count]; i++){
      [_elements addObject:[[Constants ElementNames] objectAtIndex:i]];
   }
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
   [self.delegate updateScorePicking:_fulfilledElements];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
   _fulfilledElements -= pow(2, indexPath.row);
   NSLog(@"fulfilled: %ld", (long)_fulfilledElements);
   [self.delegate updateScorePicking:_fulfilledElements];
}

#pragma mark - Navigation
- (void) prepareForSegue :(UIStoryboardSegue *)segue sender:(id)sender{
   NSLog(@"prepare segue");
}



@end
