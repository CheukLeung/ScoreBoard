//
//  SCBTrendGraphViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBTrendGraphViewController.h"
#import "Player.h"
#import "Round.h"

@interface SCBTrendGraphViewController ()
@property CPTGraphHostingView* trendGraphView;
@end

@implementation SCBTrendGraphViewController

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

- (NSUInteger) numberOfRecordsForPlot:	(CPTPlot *) plot
{
   return 1;
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   NSInteger yMax, yMin;
   yMax = 0;
   yMin = 0;
   _scatterPlots = [[NSMutableArray alloc] init];

   for (int i = 0; i < [_thisGame.players count]; i++)
   {
      Player *player = [_thisGame.players objectAtIndex:i];
      SCBScatterPlot *thisPlot = [[SCBScatterPlot alloc] initWithIdentifier:player.name];
      NSLog(@"%@", player.name);
      NSMutableArray *data = [NSMutableArray array];
      NSInteger tempSum = 0;
      self.scatterPlot = [[SCBScatterPlot alloc] initWithIdentifier:[NSString stringWithFormat:@"%@", player.name]];
      [data addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
      for (int j = 0; j < [_thisGame.rounds count]; j++)
      {
         Round *round = [_thisGame.rounds objectAtIndex:j];
         if (i == 0) tempSum += [round.player0 integerValue];
         if (i == 1) tempSum += [round.player1 integerValue];
         if (i == 2) tempSum += [round.player2 integerValue];
         if (i == 3) tempSum += [round.player3 integerValue];
         if (i == 4) tempSum += [round.player4 integerValue];
         if (i == 5) tempSum += [round.player5 integerValue];
         if (tempSum > yMax) yMax = tempSum;
         if (tempSum < yMin) yMin = tempSum;
         
         [data addObject:[NSValue valueWithCGPoint:CGPointMake(j+1, tempSum)]];

      }
      [thisPlot addData:data];
      [_scatterPlots addObject:thisPlot];
   }

   self.graph = [[SCBGraph alloc] initWithHostingView:_graphHostingView];

   [self.graph initialisePlotwithMinX:0
                                 maxX:[_thisGame.rounds count]
                                 minY:yMin
                                 maxY:yMax];

   for (int i = 0; i < [_scatterPlots count]; i++)
   {
      [self.graph addPlot:[_scatterPlots objectAtIndex:i]];
   }
}

- (void)reloadData
{
   [self viewWillAppear:YES];
}

@end
