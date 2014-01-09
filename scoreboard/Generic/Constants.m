//
//  Constants.m
//  scoreboard
//
//  Created by Oscar Leung on 07/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "Constants.h"
static NSMutableArray *_ElementNames = nil;
static NSMutableArray *_ElementScores = nil;

@implementation Constants

NSInteger const MaximumNumberOfPlayers = 6;

+(NSMutableArray *) ElementNames
{
   if (!_ElementNames)
   {
      _ElementNames = [[NSMutableArray alloc] init];
      _ElementNames = [NSMutableArray arrayWithObjects:
                       @"小三元",
                       @"大四喜",
                       @"平糊",
                       @"對對糊",
                       @"清一色",
                       @"混一色",
                       @"正花",
                       @"正花",
                       @"一台花",
                       @"花糊",
                       @"十三么",
                       @"槓上自摸",
                       @"大三元",
                       @"小四喜",
                       @"海底撈月",
                       @"天糊",
                       @"自摸",
                       nil];
   }
   return _ElementNames;
}

+(NSMutableArray *) ElementScores
{
   if (!_ElementScores)
   {
      _ElementScores = [[NSMutableArray alloc] init];
      _ElementScores = [NSMutableArray arrayWithObjects:
                        [NSNumber numberWithInt:1], // 小三元
                        [NSNumber numberWithInt:13], // 大四喜
                        [NSNumber numberWithInt:1], // 平糊
                        [NSNumber numberWithInt:3], // 對對糊
                        [NSNumber numberWithInt:7], // 清一色
                        [NSNumber numberWithInt:3], // 混一色
                        [NSNumber numberWithInt:1], // 正花
                        [NSNumber numberWithInt:1], // 正花
                        [NSNumber numberWithInt:1], // 一台花
                        [NSNumber numberWithInt:3], // 花糊
                        [NSNumber numberWithInt:13], // 十三么
                        [NSNumber numberWithInt:2], // 槓上自摸
                        [NSNumber numberWithInt:13], // 大三元
                        [NSNumber numberWithInt:13], // 小四喜
                        [NSNumber numberWithInt:13], // 海底撈月
                        [NSNumber numberWithInt:13], // 天糊
                        [NSNumber numberWithInt:1], // 自摸
                        nil];
   }
   return _ElementScores;
}



@end
