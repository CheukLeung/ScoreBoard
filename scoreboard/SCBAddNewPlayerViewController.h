//
//  SCBAddNewPlayerViewController.h
//  scoreboard
//
//  Created by Oscar Leung on 13/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface SCBAddNewPlayerViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate >

@property NSString *name;
@property NSData *photo;

@end
