//
//  SCBGraph.h
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"
#import "SCBScatterPlot.h"

@interface SCBGraph : NSObject <CPTPlotDataSource>{
   CPTGraphHostingView *_hostingView;
   CPTXYGraph *_graph;
   NSMutableArray *_graphData;
}

@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (nonatomic, retain) NSMutableArray *graphData;
@property (nonatomic, retain) NSMutableArray *plotList;

// Method to create this object and attach it to it's hosting view.
-(id)initWithHostingView:(CPTGraphHostingView *)hostingView;
-(void)addPlot:(SCBScatterPlot *)scatterPlot;
-(void)removeAllPlots;

// Specific code that creates the scatter plot.
-(void)initialisePlot;
-(void)initialisePlotwithMinX:(int) minX maxX: (int) maxX minY: (int) minY maxY: (int) maxY;

@end