//
//  SCBTrendGraphViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 24/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CorePlot-CocoaTouch.h"
#import "SCBScatterPlot.h"

@interface SCBTrendGraphViewController : UIViewController<CPTPlotDataSource> {
   IBOutlet CPTGraphHostingView *_graphHostingView;
   SCBScatterPlot *_scatterPlot;
}

@property (nonatomic, retain) SCBScatterPlot *scatterPlot;

@end