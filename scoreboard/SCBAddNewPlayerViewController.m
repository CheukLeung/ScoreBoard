//
//  SCBAddNewPlayerViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 13/12/13.
//  Copyright (c) 2013 Cheuk Leung. All rights reserved.
//

#import "SCBAddNewPlayerViewController.h"
#import "SCBImagePickerViewController.h"


@interface SCBAddNewPlayerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *playerName;

@end

@implementation SCBAddNewPlayerViewController

- (void)imagePickerController:(UIImagePickerController *)imagePicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[imagePicker dismissViewControllerAnimated:YES completion:NULL];
	[self.addPhotoButton setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]
                        forState:UIControlStateNormal];
}

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

#pragma mark - Interaction
- (IBAction)addPhotoButtonAction:(UIButton *)sender {
   SCBImagePickerViewController *imagePicker = [[SCBImagePickerViewController alloc]init];
   [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
   imagePicker.delegate = self;
   [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (IBAction)cameraButtonAction:(UIButton *)sender {
   SCBImagePickerViewController *imagePicker = [[SCBImagePickerViewController alloc]init];
   [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
   imagePicker.delegate = self;
   [self presentViewController:imagePicker animated:YES completion:NULL];
}

#pragma mark - Navigation
- (void) prepareForSegue :(UIStoryboardSegue *)segue sender:(id)sender{
   if (sender != self.saveButton) return;
   if (self.playerName.text != nil){
      self.name = self.playerName.text;
      self.photo = UIImagePNGRepresentation(self.addPhotoButton.currentImage);
      
      // Dismissing the keyboard.
      [self.view endEditing:YES];
   };
}



@end
