//
//  Game.h
//  scoreboard
//
//  Created by Oscar Leung on 22/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player, Round;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * player0;
@property (nonatomic, retain) NSNumber * player2;
@property (nonatomic, retain) NSNumber * player1;
@property (nonatomic, retain) NSNumber * player3;
@property (nonatomic, retain) NSNumber * player4;
@property (nonatomic, retain) NSNumber * player5;
@property (nonatomic, retain) NSOrderedSet *players;
@property (nonatomic, retain) NSOrderedSet *rounds;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(Player *)value inPlayersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlayersAtIndex:(NSUInteger)idx;
- (void)insertPlayers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlayersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlayersAtIndex:(NSUInteger)idx withObject:(Player *)value;
- (void)replacePlayersAtIndexes:(NSIndexSet *)indexes withPlayers:(NSArray *)values;
- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSOrderedSet *)values;
- (void)removePlayers:(NSOrderedSet *)values;
- (void)insertObject:(Round *)value inRoundsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoundsAtIndex:(NSUInteger)idx;
- (void)insertRounds:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoundsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoundsAtIndex:(NSUInteger)idx withObject:(Round *)value;
- (void)replaceRoundsAtIndexes:(NSIndexSet *)indexes withRounds:(NSArray *)values;
- (void)addRoundsObject:(Round *)value;
- (void)removeRoundsObject:(Round *)value;
- (void)addRounds:(NSOrderedSet *)values;
- (void)removeRounds:(NSOrderedSet *)values;
@end
