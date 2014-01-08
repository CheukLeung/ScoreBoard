//
//  SCBStartNewGameViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 07/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBGamePanelViewController.h"

@interface SCBStartNewGameViewController : UIViewController
{
   @public SCBGamePanelViewController *gamePanelViewController;
}
@property NSMutableArray *players;
@end
