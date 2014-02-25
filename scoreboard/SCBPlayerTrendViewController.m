//
//  SCBPlayerTrendViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 31/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBPlayerTrendViewController.h"
#import "Game.h"
#import "Round.h"
#import "SCBAppDelegate.h"

@interface SCBPlayerTrendViewController ()
@property CPTGraphHostingView* trendGraphView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation SCBPlayerTrendViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger) numberOfRecordsForPlot:	(CPTPlot *) plot
{
   return 1;
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];

   if (!_player)
   {
      return;
   }
   NSLog(@"Graph of %@", _player.name);
   
   NSInteger yMax, yMin;
   yMax = 0;
   yMin = 0;
   
   NSMutableArray *games = [[NSMutableArray alloc] initWithArray: [_player.games array]];
   
   NSInteger tempSum = 0;
   NSMutableArray *data = [NSMutableArray array];
   
   _scatterPlot = [[SCBScatterPlot alloc] initWithIdentifier:_player.name];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
   
   for (int i = 0; i < [games count]; i++)
   {
      Game *game = [games objectAtIndex:i];
      NSMutableArray *gamePlayers = [[NSMutableArray alloc] initWithArray: [game.players array]];
      NSInteger index = [gamePlayers indexOfObject:_player];
      
      switch (index) {
         case 0:
            tempSum += [game.player0 integerValue];
            break;
         case 1:
            tempSum += [game.player1 integerValue];
            break;
         case 2:
            tempSum += [game.player2 integerValue];
            break;
         case 3:
            tempSum += [game.player3 integerValue];
            break;
         case 4:
            tempSum += [game.player4 integerValue];
            break;
         case 5:
            tempSum += [game.player5 integerValue];
            break;
         default:
            break;
      }
      if (tempSum > yMax) yMax = tempSum;
      if (tempSum < yMin) yMin = tempSum;
      NSLog(@"%d", tempSum);
      [data addObject:[NSValue valueWithCGPoint:CGPointMake(i+1, tempSum)]];
      
   }
   [_scatterPlot addData:data];
   self.graph = [[SCBGraph alloc] initWithHostingView:_graphHostingView];

   [self.graph initialisePlotwithMinX:0
                                 maxX:[games count]
                                 minY:yMin
                                 maxY:yMax];
   [self.graph addPlot:_scatterPlot];
}

- (void)reloadData
{
   [self viewWillAppear:YES];
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
