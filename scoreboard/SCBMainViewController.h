//
//  SCBMainViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 19/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBMainViewProtocol.h"
#import "Player.h"
@interface SCBMainViewController : UIViewController <SCBMainViewProtocol>


@property Player *currentPlayer;
- (void) reloadData;
@end
