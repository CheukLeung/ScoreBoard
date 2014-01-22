//
//  SCBScorePickerViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 08/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBGamePanelProtocol.h"
@interface SCBScorePickerViewController : UICollectionViewController 
{
   id<SCBGamePanelProtocol> delegate;
}
@property NSInteger fulfilledElements;
@property (readwrite, assign) id <SCBGamePanelProtocol> delegate;
-(void) clearSelection;
@end
