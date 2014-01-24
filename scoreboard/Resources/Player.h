//
//  Player.h
//  scoreboard
//
//  Created by Oscar Leung on 23/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSNumber * rounds;
@property (nonatomic, retain) NSNumber * wins;
@property (nonatomic, retain) NSOrderedSet *games;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)insertObject:(Game *)value inGamesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGamesAtIndex:(NSUInteger)idx;
- (void)insertGames:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGamesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGamesAtIndex:(NSUInteger)idx withObject:(Game *)value;
- (void)replaceGamesAtIndexes:(NSIndexSet *)indexes withGames:(NSArray *)values;
- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSOrderedSet *)values;
- (void)removeGames:(NSOrderedSet *)values;
@end
