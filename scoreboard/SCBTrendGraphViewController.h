//
//  SCBTrendGraphViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

#import "CorePlot-CocoaTouch.h"
#import "SCBGraph.h"
#import "SCBScatterPlot.h"

@interface SCBTrendGraphViewController : UIViewController<CPTPlotDataSource> {
   IBOutlet CPTGraphHostingView *_graphHostingView;
   SCBScatterPlot *_scatterPlot;
   SCBScatterPlot *_scatterPlot2;
   
   SCBGraph *_graph;
   NSMutableArray *_scatterPlots;
}

@property (nonatomic, retain) SCBGraph *graph;
@property (nonatomic, retain) SCBScatterPlot *scatterPlot;
@property (nonatomic, retain) SCBScatterPlot *scatterPlot2;
@property (nonatomic, retain) NSMutableArray *scatterPlots;
@property Game *thisGame;
-(void) reloadData;
@end