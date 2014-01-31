//
//  SCBScatterPlot.m
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBScatterPlot.h"

@implementation SCBScatterPlot
@synthesize graphData = _graphData;

// Initialise the scatter plot in the provided hosting view with the provided data.
// The data array should contain NSValue objects each representing a CGPoint.
-(id)initWithIdentifier: (NSString *) identifier
{
   self = [super init];
   
   if ( self != nil ) {
      self.graphData = nil;
      self.identifier = identifier;
   }
   
   return self;
}


-(void)addData:(NSMutableArray *)data
{
   // Add a plot to our graph and axis. We give it an identifier so that we
   // could add multiple plots (data lines) to the same graph if necessary.
   self.graphData = data;
   
}

// Delegate method that returns the number of points on the plot
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
   if ( [plot.identifier isEqual:_identifier] )
   {
      return [self.graphData count];
   }
   
   return 0;
}

// Delegate method that returns a single X or Y value for a given plot.
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
   if ( [plot.identifier isEqual:_identifier] )
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
   
   return [NSNumber numberWithFloat:0];
}

@end