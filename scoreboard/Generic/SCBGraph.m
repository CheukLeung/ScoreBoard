//
//  SCBGraph.m
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBGraph.h"
#import "Utility.h"


@implementation SCBGraph

@synthesize hostingView = _hostingView;
@synthesize graph = _graph;
@synthesize graphData = _graphData;
@synthesize plotList = _plotList;

-(id)initWithHostingView:(CPTGraphHostingView *)hostingView;
{
   self = [super init];
   
   if ( self != nil ) {
      self.hostingView = hostingView;
      self.graphData = nil;
      self.graph = nil;
      self.plotList = [[NSMutableArray alloc]init];
   }
   
   return self;
}

-(void)initialisePlot
{
   [self initialisePlotwithMinX:0
                           maxX:10
                           minY:20
                           maxY:-20];
}



// This does the actual work of creating the plot if we don't already have a graph object.
-(void)initialisePlotwithMinX:(int) minX maxX: (int) maxX minY: (int) minY maxY: (int) maxY;
{
   // Start with some simple sanity checks before we kick off
   if ( (self.hostingView == nil) ) {
      NSLog(@"SCBGraph: Cannot initialise plot without hosting view or data.");
      return;
   }
   
   if ( self.graph != nil ) {
      NSLog(@"SCBGraph: Graph object already exists.");
      return;
   }

   
   // Create a graph object which we will use to host just one scatter plot.
   CGRect frame = [self.hostingView bounds];
   self.graph = [[CPTXYGraph alloc] initWithFrame:frame];
   
   // Add some padding to the graph, with more at the bottom for axis labels.
   self.graph.plotAreaFrame.paddingTop = 20.0f;
   self.graph.plotAreaFrame.paddingRight = 10.0f;
   self.graph.plotAreaFrame.paddingBottom = 70.0f;
   self.graph.plotAreaFrame.paddingLeft = 40.0f;
   
   // Tie the graph we've created with the hosting view.
   self.hostingView.hostedGraph = self.graph;
   
   // If you want to use one of the default themes - apply that here.
   //[self.graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
   
   // Create a line style that we will apply to the axis and data line.
   CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
   lineStyle.lineColor = [CPTColor blackColor];
   lineStyle.lineWidth = 2.0f;
   
   // Create a text style that we will use for the axis labels.
   CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
   textStyle.fontName = @"Helvetica";
   textStyle.fontSize = 11;
   textStyle.color = [CPTColor blackColor];
   
   // Create the plot symbol we're going to use.
   CPTPlotSymbol *plotSymbol = [CPTPlotSymbol crossPlotSymbol];
   plotSymbol.lineStyle = lineStyle;
   plotSymbol.size = CGSizeMake(8.0, 8.0);

   // We modify the graph's plot space to setup the axis' min / max values.
   CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
   
   plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(minX) length:CPTDecimalFromFloat(maxX - minX + 1 )] ;
   plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(minY-2) length:CPTDecimalFromFloat(maxY - minY + 4 )];

   
   // Modify the graph's axis with a label, line style, etc.
   CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
   

   axisSet.xAxis.title = @"";
   axisSet.xAxis.titleTextStyle = textStyle;
   axisSet.xAxis.titleOffset = 30.0f;
   axisSet.xAxis.axisLineStyle = lineStyle;
   axisSet.xAxis.majorTickLineStyle = lineStyle;
   axisSet.xAxis.minorTickLineStyle = lineStyle;
   axisSet.xAxis.labelTextStyle = textStyle;
   axisSet.xAxis.labelOffset = 3.0f;
   axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(2.0);
   axisSet.xAxis.minorTicksPerInterval = 1;
   axisSet.xAxis.minorTickLength = 1;
   axisSet.xAxis.majorTickLength = 7.0f;
   axisSet.yAxis.preferredNumberOfMajorTicks = 10;
   
   axisSet.yAxis.title = @"";
   axisSet.yAxis.titleTextStyle = textStyle;
   axisSet.yAxis.titleOffset = 30.0f;
   axisSet.yAxis.axisLineStyle = lineStyle;
   axisSet.yAxis.majorTickLineStyle = lineStyle;
   axisSet.yAxis.minorTickLineStyle = lineStyle;
   axisSet.yAxis.labelTextStyle = textStyle;
   axisSet.yAxis.labelOffset = 3.0f;
   axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(10.0f);
   axisSet.yAxis.minorTicksPerInterval = 1;
   axisSet.yAxis.minorTickLength = 5.0f;
   axisSet.yAxis.majorTickLength = 7.0f;
   axisSet.yAxis.preferredNumberOfMajorTicks = 4;
   
   
}
-(void)addPlot:(SCBScatterPlot *)scatterPlot
{
   
   // Create a line style that we will apply to the axis and data line.
   CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
   
   lineStyle.lineColor = [Utility getCPTColorFromString: scatterPlot.identifier];
   
   lineStyle.lineWidth = 2.0f;
   
   // Create the plot symbol we're going to use.
   CPTPlotSymbol *plotSymbol = [CPTPlotSymbol crossPlotSymbol];
   plotSymbol.lineStyle = lineStyle;
   plotSymbol.size = CGSizeMake(8.0, 8.0);
   

   // Add a plot to our graph and axis. We give it an identifier so that we
   // could add multiple plots (data lines) to the same graph if necessary.
   CPTScatterPlot *plot = [[CPTScatterPlot alloc] init];
   plot.dataSource = scatterPlot;
   plot.identifier = scatterPlot.identifier;
   plot.dataLineStyle = lineStyle;
   plot.plotSymbol = plotSymbol;
   
   [_plotList addObject:plot];
   [self.graph addPlot:plot];
   NSLog(@"hello...");
   
}

// Delegate method that returns the number of points on the plot
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
      return [self.graphData count];
}


-(void) removeAllPlots
{
   for (int i = [_plotList count] ; i > 0; i--)
   {
      [self.graph removePlot:[_plotList objectAtIndex:i-1]];
   }
}

// Delegate method that returns a single X or Y value for a given plot.
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
      NSValue *value = [self.graphData objectAtIndex:index];
      CGPoint point = [value CGPointValue];
      
      // FieldEnum determines if we return an X or Y value.
      if ( fieldEnum == CPTScatterPlotFieldX )
      {
         return [NSNumber numberWithFloat:point.x];
      }
      else    // Y-Axis
      {
         return [NSNumber numberWithFloat:point.y];
      }

}

@end