//
//  SCBStartNewGameViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 07/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBStartNewGameViewController.h"
#import "SCBSelectPlayersViewController.h"
#import "SCBGamePanelViewController.h"
@interface SCBStartNewGameViewController ()

@end

@implementation SCBStartNewGameViewController

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
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (IBAction)startGameBtnAction:(id)sender {
   if ([_players count] < 2)
   {
      NSString *message = @"At least two players are needed.";
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not enough player"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
      return;
   }
   SCBGamePanelViewController *gameStoryBoardViewController = [[UIStoryboard storyboardWithName:@"Game_iPad" bundle:nil] instantiateInitialViewController];
   
   [self.navigationController pushViewController:gameStoryBoardViewController animated:YES];
   gameStoryBoardViewController.players = _players;
}


#pragma mark - Navigation
- (void) prepareForSegue :(UIStoryboardSegue *)segue sender:(id)sender{
   if([[segue identifier] isEqualToString:@"startGameSegue"])
   {
      gamePanelViewController = (SCBGamePanelViewController *) segue.destinationViewController;
      gamePanelViewController.players = _players;
   }
}

- (IBAction)unwindFromSelectPlayers:(UIStoryboardSegue *)segue
{
   SCBSelectPlayersViewController *source = [segue sourceViewController];
   if (source.selectedPlayers)
   {
      _players = source.selectedPlayers;
   }
}



@end
