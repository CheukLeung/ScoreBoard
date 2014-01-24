//
//  SCBImagePickerViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 14/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import "SCBImagePickerViewController.h"

@interface SCBImagePickerViewController ()

@end

@implementation SCBImagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations{
   return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orient {
   return (orient == UIInterfaceOrientationLandscapeLeft) | (orient == UIInterfaceOrientationLandscapeRight);
}


@end
