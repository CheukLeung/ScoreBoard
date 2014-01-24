//
//  SCBAppDelegate.h
//  scoreboard
//
//  Created by Oscar Leung on 08/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// Core data
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSArray*)getAllPlayersRecords;
-(NSArray*)getAllGamesRecords;

@end
