//
//  SCBGamePanelProtocol.h
//  scoreboard
//
//  Created by Oscar Leung on 09/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCBGamePanelProtocol <NSObject>
- (void) updateScorePicking: (NSInteger) fulfilled;

@end
