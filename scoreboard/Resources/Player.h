//
//  Player.h
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSNumber * wins;
@property (nonatomic, retain) NSNumber * rounds;
@property (nonatomic, retain) Game *games;

@end
