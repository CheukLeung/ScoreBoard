//
//  SCBPlayersPickerViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBGamePanelProtocol.h"

@interface SCBPlayersPickerViewController : UICollectionViewController
{
   id<SCBGamePanelProtocol> delegate;
}

@property (readwrite, assign) id <SCBGamePanelProtocol> delegate;
@property NSMutableArray *selectedPlayers;
@property NSMutableArray *players;
-(void) clearSelection;
@end
