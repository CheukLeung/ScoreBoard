//
//  SCBMainViewProtocol.h
//  scoreboard
//
//  Created by Oscar Leung on 09/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
@protocol SCBMainViewProtocol <NSObject>
- (void) startGame: (Game *) game;
@end
