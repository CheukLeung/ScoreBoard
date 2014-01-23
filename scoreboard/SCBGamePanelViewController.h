//
//  SCBGamePanelViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols/SCBGamePanelProtocol.h"
#import "Game.h"

@interface SCBGamePanelViewController : UIViewController <SCBGamePanelProtocol>
@property (nonatomic, strong) NSMutableArray *players;
@property Game *thisGame;
@end
