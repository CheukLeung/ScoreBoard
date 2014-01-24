//
//  SCBMainViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 19/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import "SCBMainViewController.h"
#import "SCBPlayerTableViewController.h"
#import "SCBGameTableViewController.h"
#import "SCBGamePanelViewController.h"

@interface SCBMainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *currentUserImage;
@property (weak, nonatomic) IBOutlet UILabel *currentUserLabel;
@property (weak, nonatomic) IBOutlet UIView *playerTableContainer;
@property SCBGameTableViewController *gametableViewController;

@end

@implementation SCBMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
   }
   return self;
}

- (IBAction)startGameBtn:(id)sender {
   UIViewController *gameStoryBoardViewController = [[UIStoryboard storyboardWithName:@"NewGame_iPad" bundle:nil] instantiateInitialViewController];
   [self.navigationController pushViewController:gameStoryBoardViewController animated:YES];
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   _gametableViewController = [self.childViewControllers objectAtIndex:1];
   _gametableViewController.mainDelegate = self;
	// Do any additional setup after loading the view.
}

- (void) reloadData
{
   [_gametableViewController reloadData];
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
   [self.navigationController setNavigationBarHidden:YES animated:animated];
   [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
   [self.navigationController setNavigationBarHidden:NO animated:animated];
   [super viewWillDisappear:animated];
}

- (void) selectPlayer : (Player*) player
{
   self.currentPlayer = player;
   [self.currentUserLabel setText:[player name]];
   [self.currentUserImage setImage:[UIImage imageWithData:[player photo]]];
}

- (IBAction)unwindFromPlayerTable:(UIStoryboardSegue *)segue
{
   SCBPlayerTableViewController *source = [segue sourceViewController];
   if (source.selectedPlayer)
   {
      [self selectPlayer:source.selectedPlayer];
   }
}

-(void) startGame : (Game*) game
{
   SCBGamePanelViewController *gamePanelViewController = [[UIStoryboard storyboardWithName:@"Game_iPad" bundle:nil] instantiateInitialViewController];
   
   [self.navigationController pushViewController:gamePanelViewController animated:YES];
   gamePanelViewController.players = [NSMutableArray arrayWithArray:[game.players array]];
   gamePanelViewController.thisGame = game;
}

@end
