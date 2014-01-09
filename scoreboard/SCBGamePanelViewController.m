//
//  SCBGamePanelViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBGamePanelViewController.h"
#import "SCBSelectPlayersViewController.h"
#import "SCBPlayersPickerViewController.h"
#import "SCBScorePickerViewController.h"
#import "Player.h"
#import "Constants.h"

@interface SCBGamePanelViewController ()

@end

@implementation SCBGamePanelViewController

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
   NSLog(@"Number of players = %lu", (unsigned long)[_players count]);
   for (NSUInteger i = 0; i < [_players count]; i++)
   {
      Player *playerItem = [_players objectAtIndex:i];
      UILabel *playerLable = (UILabel *)[self.view viewWithTag:100+i];
      UIImageView *playerImage = (UIImageView *)[self.view viewWithTag:200+i];
      UILabel *playerScore = (UILabel *)[self.view viewWithTag:300+i];
      [playerLable setText:[playerItem name]];
      [playerImage setImage:[UIImage imageWithData:[playerItem photo]]];
      [playerScore setText:@"0"];
      NSLog(@"id %@",[playerItem objectID]);
   }
   
   for (NSUInteger i = [_players count]; i < MaximumNumberOfPlayers; i++)
   {
      UILabel *playerLable = (UILabel *)[self.view viewWithTag:100+i];
      UIImageView *playerImage = (UIImageView *)[self.view viewWithTag:200+i];
      UILabel *playerScore = (UILabel *)[self.view viewWithTag:300+i];
      [playerLable setText:@""];
      [playerImage setImage:nil];
      [playerScore setText:@""];
   }
   
   SCBPlayersPickerViewController *child = [self.childViewControllers objectAtIndex:2];
   child.players=self.players;
   child = [self.childViewControllers objectAtIndex:3];
   child.players=_players;
      
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (IBAction)unwindFromUpdatedPicking:(UIStoryboardSegue *)segue
{
   SCBScorePickerViewController *source = [segue sourceViewController];
   if (source.fulfilledElements)
   {
      NSLog(@"fulfilled --- %ld", (long)source.fulfilledElements);
   }
}

@end
