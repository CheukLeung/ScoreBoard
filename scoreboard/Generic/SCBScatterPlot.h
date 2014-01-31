//
//  SCBScatterPlot.h
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

@interface SCBScatterPlot : NSObject <CPTPlotDataSource>{
   NSMutableArray *_graphData;
}

@property (nonatomic, retain) NSMutableArray *graphData;
@property NSString *identifier;
// Method to create this object and attach it to it's hosting view.
-(void)addData:(NSMutableArray *)data;
-(id)initWithIdentifier: (NSString *) identifier;

@end
