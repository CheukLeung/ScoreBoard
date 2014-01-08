//
//  Round.h
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Round : NSManagedObject

@property (nonatomic, retain) NSNumber * player0;
@property (nonatomic, retain) NSNumber * player1;
@property (nonatomic, retain) NSNumber * player2;
@property (nonatomic, retain) NSNumber * player3;
@property (nonatomic, retain) NSNumber * player5;
@property (nonatomic, retain) NSNumber * player4;
@property (nonatomic, retain) NSNumber * roundData;
@property (nonatomic, retain) Game *game;

@end
