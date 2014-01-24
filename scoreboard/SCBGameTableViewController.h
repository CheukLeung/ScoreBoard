//
//  SCBGameTableViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 23/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBMainViewProtocol.h"
#import "Game.h"
@interface SCBGameTableViewController : UITableViewController
{
   id<SCBMainViewProtocol> mainDelegate;
}
@property NSInteger fulfilledElements;
@property (readwrite, assign) id <SCBMainViewProtocol> mainDelegate;

@property Game *selectedGame;
-(void) reloadData;
@end
