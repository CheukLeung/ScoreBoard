//
//  Utility.h
//  scoreboard
//
//  Created by Oscar Leung on 09/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"

@interface Utility : NSObject
+ (UIColor*) getColorFromString: (NSString *)inputString;
+ (CPTColor*) getCPTColorFromString: (NSString *)inputString;
@end
