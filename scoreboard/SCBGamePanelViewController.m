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
#import "Round.h"

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

@property SCBPlayersPickerViewController *winnersViewController;
@property SCBPlayersPickerViewController *losersViewController;
@property SCBScorePickerViewController *scorePickerViewController;

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
   [self setDefaultView];
   
   _scorePickerViewController = [self.childViewControllers objectAtIndex:0];
   _winnersViewController = [self.childViewControllers objectAtIndex:2];
   _losersViewController = [self.childViewControllers objectAtIndex:3];

   _scorePickerViewController.delegate = self;
   _winnersViewController.delegate = self;
   _losersViewController.delegate = self;
   
   _winnersViewController.players=_players;
   _losersViewController.players=_players;
}

- (void) setDefaultView
{
   for (NSUInteger i = 0; i < [_players count]; i++)
   {
      Player *playerItem = [_players objectAtIndex:i];
      UILabel *playerLable = (UILabel *)[self.view viewWithTag:100+i];
      UIImageView *playerImage = (UIImageView *)[self.view viewWithTag:200+i];
      UILabel *playerScore = (UILabel *)[self.view viewWithTag:300+i];
      [playerLable setText:[playerItem name]];
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
   NSLog(@"%d get: %d", index, netGain);
   return netGain;
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

- (void) addRoundWithGain: (NSInteger) nextGain
                  winners: (NSMutableArray *) nextWinners
                   losers: (NSMutableArray *) nextLosers
                    score: (NSInteger) nextScore
                 elements: (NSInteger) nextElements
{
   if ([nextWinners count] == 0 || [nextLosers count] == 0 )
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
   
   [self clearButtonAction: self];
   /*
   NSError * error;
   if (![self.managedObjectContext save:&error]) {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
      return;
   }
   */
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
