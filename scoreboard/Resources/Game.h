//
//  Game.h
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player, Round;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *rounds;
@property (nonatomic, retain) NSSet *players;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addRoundsObject:(Round *)value;
- (void)removeRoundsObject:(Round *)value;
- (void)addRounds:(NSSet *)values;
- (void)removeRounds:(NSSet *)values;

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
