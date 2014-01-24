//
//  SCBTrendGraphViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBTrendGraphViewController.h"

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
   NSMutableArray *data = [NSMutableArray array];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(-10, 100)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(-8, 50)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(-6, 20)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(-4, 10)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(-2, 5)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(2, 4)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(4, 16)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(6, 36)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(8, 64)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(10, 100)]];
   
   self.scatterPlot = [[SCBScatterPlot alloc] initWithHostingView:_graphHostingView andData:data];
   [self.scatterPlot initialisePlot];
}

@end
