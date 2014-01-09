//
//  SCBPlayersPickerViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBGamePanelViewController.h"

@interface SCBPlayersPickerViewController : UICollectionViewController
@property NSMutableArray *selectedPlayers;
@property NSMutableArray *players;
@end
