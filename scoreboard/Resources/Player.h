//
//  Player.h
//  scoreboard
//
//  Created by Oscar Leung on 14/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSNumber * wins;
@property (nonatomic, retain) NSNumber * rounds;

@end
