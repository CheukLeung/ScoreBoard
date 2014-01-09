//
//  Utility.m
//  scoreboard
//
//  Created by Oscar Leung on 09/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+ (UIColor*) getColorFromString: (NSString *)inputString
{
   NSInteger hash = [inputString hash];
   hash = hash % 0xFFFFFF;
   UIColor *mappedColor = [UIColor colorWithRed: (double)((hash & 0xFF0000) >> 16) / 0xFF
                                          green: (double)((hash & 0x00FF00) >> 8) / 0xFF
                                           blue: (double)((hash & 0x0000FF)) / 0xFF
                                          alpha: 1];
   return mappedColor;
}
@end
