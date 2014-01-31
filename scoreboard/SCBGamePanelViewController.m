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
#import "SCBRoundTableViewController.h"
#import "SCBTrendGraphViewController.h"
#import "SCBMainViewController.h"
#import "Player.h"
#import "Round.h"

#import "Utility.h"
#import "Constants.h"
#import "SCBAppDelegate.h"

@interface SCBGamePanelViewController ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSInteger nextElements;
@property (nonatomic) NSInteger nextScore;
@property (nonatomic) NSInteger nextGain;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gainLabel;
@property NSMutableArray *nextWinners;
@property NSMutableArray *nextLosers;
@property BOOL oldGame;

@property SCBPlayersPickerViewController *winnersViewController;
@property SCBPlayersPickerViewController *losersViewController;
@property SCBScorePickerViewController *scorePickerViewController;
@property SCBRoundTableViewController *roundTableViewController;
@property SCBTrendGraphViewController *trendGraphViewController;
@end

@implementation SCBGamePanelViewController
- (IBAction)swipeGestureAction:(UISwipeGestureRecognizer *)sender {
   [self endGameButtonAction:self];
}
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
   [self setDefaultView];
   if (!_thisGame)
   {
      [self addGameEntry];
      _oldGame = NO;
   }
   else
   {
      _oldGame = YES;
      [self setScore];
   }
   _scorePickerViewController = [self.childViewControllers objectAtIndex:0];
   _roundTableViewController = [self.childViewControllers objectAtIndex:1];
   _winnersViewController = [self.childViewControllers objectAtIndex:2];
   _losersViewController = [self.childViewControllers objectAtIndex:3];
   _trendGraphViewController = [self.childViewControllers objectAtIndex:4];
   _scorePickerViewController.delegate = self;
   _winnersViewController.delegate = self;
   _losersViewController.delegate = self;
   
   _winnersViewController.players=_players;
   _losersViewController.players=_players;
   _roundTableViewController.thisGame = _thisGame;
   _trendGraphViewController.thisGame = _thisGame;
}


- (void) setDefaultView
{
   for (NSUInteger i = 0; i < [_players count]; i++)
   {
      Player *playerItem = [_players objectAtIndex:i];
      UILabel *playerLabal = (UILabel *)[self.view viewWithTag:100+i];
      UIImageView *playerImage = (UIImageView *)[self.view viewWithTag:200+i];
      UILabel *playerScore = (UILabel *)[self.view viewWithTag:300+i];
      [playerLabal setText:[playerItem name]];
      [playerLabal setBackgroundColor:[Utility getColorFromString:[playerItem name]]];
      [playerImage setImage:[UIImage imageWithData:[playerItem photo]]];
      [playerScore setText:@"0"];
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
}

- (void) setScore
{
   NSMutableArray* scoreList = [[NSMutableArray alloc] init];
   [scoreList addObject:_thisGame.player0];
   [scoreList addObject:_thisGame.player1];
   [scoreList addObject:_thisGame.player2];
   [scoreList addObject:_thisGame.player3];
   [scoreList addObject:_thisGame.player4];
   [scoreList addObject:_thisGame.player5];
   
   for (NSUInteger i = 0; i < [_players count]; i++)
   {
      UILabel *playerScore = (UILabel *)[self.view viewWithTag:300+i];
      NSInteger score = [[scoreList objectAtIndex:i] integerValue];
      [playerScore setText:[NSString stringWithFormat:@"%ld", (long)score]];
      if (score < 0)
      {
         playerScore.textColor = [UIColor redColor];
      }
      else if (score == 0)
      {
         playerScore.textColor = [UIColor blackColor];
      }
      else
      {
         playerScore.textColor = [UIColor blueColor];
      }
   }
   
   for (NSUInteger i = [_players count]; i < MaximumNumberOfPlayers; i++)
   {
      UILabel *playerScore = (UILabel *)[self.view viewWithTag:300+i];
      [playerScore setText:@""];
   }
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (NSInteger) resolveScoreFromFulfilledElements: (NSInteger) fulfilled
{
   NSInteger tempScore = 0;
   for (int i = 0; i < [[Constants ElementNames] count]; i++ )
   {
      int scoreIndex = 0x01 & (fulfilled >> i);
      if (scoreIndex){
         tempScore += [[[Constants ElementScores] objectAtIndex:i] integerValue];
      }
   }
   return tempScore;
}

- (NSInteger) resolveGainFromScore: (NSInteger) score
{
   if (score >= [[Constants ScoreGain] count]){
      return [[[Constants ScoreGain] lastObject] integerValue];
   }
   return [[[Constants ScoreGain] objectAtIndex:score] integerValue];
}

- (NSInteger) getGainAt: (NSInteger) index
                winners: (NSMutableArray *) winners
                 losers: (NSMutableArray *) losers
                   gain: (NSInteger) gain
{
   if (index >= [_players count])
   {
      return 0;
   }
   
   NSInteger netGain = 0;
   if ([winners indexOfObject:[_players objectAtIndex:index]] != NSNotFound)
   {
      netGain += gain/[winners count];
   }
   if ([losers indexOfObject:[_players objectAtIndex:index]] != NSNotFound)
   {
      netGain -= gain/[losers count];
   }
   NSLog(@"%ld get: %ld", (long)index, (long)netGain);
   return netGain;
}


- (void) viewWillAppear:(BOOL)animated {
   [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:YES animated:animated];
}


#pragma mark - Interaction
- (IBAction)clearButtonAction:(id)sender {
   [_winnersViewController clearSelection];
   [_losersViewController clearSelection];
   [_scorePickerViewController clearSelection];
   [self updateScorePicking:0];
   [self.nextWinners removeAllObjects];
   [self.nextLosers removeAllObjects];
}

- (IBAction)confirmButtonAction:(id)sender {
   [self addRoundWithGain:_nextGain
                  winners:_nextWinners
                   losers:_nextLosers
                    score:_nextScore
                 elements:_nextElements];
}

- (IBAction)endGameButtonAction:(id)sender {
   [_trendGraphViewController.graph removeAllPlots];
   
   NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
   SCBMainViewController *mainViewController = [navigationArray objectAtIndex:0];
   [mainViewController reloadData];
   [self.navigationController popToViewController:mainViewController animated:YES];
   
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

- (void) duplicateGameEntry
{
   Game *newGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game"
                                                 inManagedObjectContext:self.managedObjectContext];;
   newGame.date = _thisGame.date;
   newGame.players = _thisGame.players;
   newGame.player0 = _thisGame.player0;
   newGame.player1 = _thisGame.player1;
   newGame.player2 = _thisGame.player2;
   newGame.player3 = _thisGame.player3;
   newGame.player4 = _thisGame.player4;
   newGame.player5 = _thisGame.player5;
   newGame.rounds = _thisGame.rounds;
   
   SCBAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   NSManagedObjectContext *context = [appDelegate managedObjectContext];
   [context deleteObject:_thisGame];
   
   _thisGame = newGame;
   
   NSError * error;
   if (![self.managedObjectContext save:&error])
   {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
      return;
   }
   
   
   _roundTableViewController.thisGame = _thisGame;
   _trendGraphViewController.thisGame = _thisGame;

}

- (void) addGameEntry
{
   _thisGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game"
                                             inManagedObjectContext:self.managedObjectContext];
   _thisGame.date = [NSDate date];
   _thisGame.player0 = [NSNumber numberWithInt:0];
   _thisGame.player1 = [NSNumber numberWithInt:0];
   _thisGame.player2 = [NSNumber numberWithInt:0];
   _thisGame.player3 = [NSNumber numberWithInt:0];
   _thisGame.player4 = [NSNumber numberWithInt:0];
   _thisGame.player5 = [NSNumber numberWithInt:0];
   _thisGame.rounds = [[NSOrderedSet alloc] init];
   _thisGame.players = [NSOrderedSet orderedSetWithArray:_players];
   
   
   NSError * error;
   if (![self.managedObjectContext save:&error])
   {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
      return;
   }
}

- (void) addRoundWithGain: (NSInteger) nextGain
                  winners: (NSMutableArray *) nextWinners
                   losers: (NSMutableArray *) nextLosers
                    score: (NSInteger) nextScore
                 elements: (NSInteger) nextElements
{
   if ([nextWinners count] == 0 || [nextLosers count] == 0 || nextGain == 0)
   {
      NSString *message = @"At least one winner and one loser are needed.";
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No player win or lose"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
      return;
   }
   
   if (_oldGame)
   {
      [self duplicateGameEntry];
      _oldGame = NO;
   }
   Round* newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Round"
                                                    inManagedObjectContext:self.managedObjectContext];
   
   // Refactoring needed!!
   newEntry.player0 = [NSNumber numberWithInteger:[self getGainAt: 0 winners:nextWinners losers:nextLosers gain:nextGain]];
   newEntry.player1 = [NSNumber numberWithInteger:[self getGainAt: 1 winners:nextWinners losers:nextLosers gain:nextGain]];
   newEntry.player2 = [NSNumber numberWithInteger:[self getGainAt: 2 winners:nextWinners losers:nextLosers gain:nextGain]];
   newEntry.player3 = [NSNumber numberWithInteger:[self getGainAt: 3 winners:nextWinners losers:nextLosers gain:nextGain]];
   newEntry.player4 = [NSNumber numberWithInteger:[self getGainAt: 4 winners:nextWinners losers:nextLosers gain:nextGain]];
   newEntry.player5 = [NSNumber numberWithInteger:[self getGainAt: 5 winners:nextWinners losers:nextLosers gain:nextGain]];
   newEntry.roundData = [NSNumber numberWithInteger:nextElements];
   
   newEntry.game = _thisGame;
   _thisGame.player0 = [NSNumber numberWithInt:[_thisGame.player0 integerValue] + [newEntry.player0 integerValue]];
   _thisGame.player1 = [NSNumber numberWithInt:[_thisGame.player1 integerValue] + [newEntry.player1 integerValue]];
   _thisGame.player2 = [NSNumber numberWithInt:[_thisGame.player2 integerValue] + [newEntry.player2 integerValue]];
   _thisGame.player3 = [NSNumber numberWithInt:[_thisGame.player3 integerValue] + [newEntry.player3 integerValue]];
   _thisGame.player4 = [NSNumber numberWithInt:[_thisGame.player4 integerValue] + [newEntry.player4 integerValue]];
   _thisGame.player5 = [NSNumber numberWithInt:[_thisGame.player5 integerValue] + [newEntry.player5 integerValue]];
   NSMutableOrderedSet *currentRounds = [NSMutableOrderedSet orderedSetWithOrderedSet:_thisGame.rounds];
   [currentRounds addObject:newEntry];
   _thisGame.rounds = [NSOrderedSet orderedSetWithOrderedSet:currentRounds];
   
   NSError * error;
   if (![self.managedObjectContext save:&error])
   {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
      return;
   }
   NSLog(@"%lu round %lu players", (unsigned long)[_thisGame.rounds count], (unsigned long)[_thisGame.players count]);

   NSMutableArray *playerArray = [[NSMutableArray alloc] init];
   [playerArray addObject:_thisGame.player0];
   [playerArray addObject:_thisGame.player1];
   [playerArray addObject:_thisGame.player2];
   [playerArray addObject:_thisGame.player3];
   [playerArray addObject:_thisGame.player4];
   [playerArray addObject:_thisGame.player5];
   
   for (int i = 0; i < [_players count]; i++)
   {
      UILabel *playerLabel = (UILabel *)[self.view viewWithTag:300 + i];
      NSInteger gain = [[playerArray objectAtIndex:i] integerValue];
      [playerLabel setText:[NSString stringWithFormat:@"%ld", (long) gain]];
      if (gain < 0)
      {
         playerLabel.textColor = [UIColor redColor];
      }
      else if (gain == 0)
      {
         playerLabel.textColor = [UIColor blackColor];
      }
      else
      {
         playerLabel.textColor = [UIColor blueColor];
      }
   }
   
   for (NSInteger i = [_players count]; i < MaximumNumberOfPlayers; i++)
   {
      NSLog(@"%ld", (long)i);
      UILabel *playerLabel = (UILabel *)[self.view viewWithTag:400 + i];
      [playerLabel setText:@""];
   }
   
   [_roundTableViewController.tableView reloadData];
   [_trendGraphViewController reloadData];
   [self clearButtonAction: self];

}

#pragma mark - Setters
- (void) setNextScore: (NSInteger) nextScore
{
   [self.scoreLabel setText:[NSString stringWithFormat:@"%ld", (long)nextScore]];
   _nextScore = nextScore;
}

- (void) setNextGain: (NSInteger) nextGain
{
   [self.gainLabel setText:[NSString stringWithFormat:@"$ %ld", (long)nextGain]];
   _nextGain = nextGain;
}

#pragma mark - SCBGamePanelProtocol methods
- (void) updateScorePicking: (NSInteger) fulfilled
{
   NSLog(@"fulfilled --- %ld", (long)fulfilled);
   self.nextElements = fulfilled;
   self.nextScore = [self resolveScoreFromFulfilledElements:_nextElements];
   self.nextGain = [self resolveGainFromScore:_nextScore];
}

- (void) updateWinners:(NSMutableArray*) winners
{
   _nextWinners = winners;
   NSLog(@"Winners:");
   for (int i = 0; i < [_nextWinners count]; i++)
   {
      NSLog(@"%@", [(Player*)[_nextWinners objectAtIndex:i] name]);
   }
}

- (void) updateLosers:(NSMutableArray *) losers
{
   _nextLosers = losers;
   NSLog(@"Losers:");
   for (int i = 0; i < [_nextLosers count]; i++)
   {
      NSLog(@"%@", [(Player*)[_nextLosers objectAtIndex:i] name]);
   }
}

@end
