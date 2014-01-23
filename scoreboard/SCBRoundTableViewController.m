//
//  SCBRoundTableViewController.m
//  scoreboard
//
//  Created by Oscar Leung on 22/01/14.
//  Copyright (c) 2014 Cheuk Leung. All rights reserved.
//

#import "SCBRoundTableViewController.h"
#import "Round.h"
#import "Constants.h"

@interface SCBRoundTableViewController ()

@end

@implementation SCBRoundTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // Return the number of sections.
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [_thisGame.rounds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"RoundCell";
   UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                forIndexPath:indexPath];
   NSLog(@"plaers: %d", [_thisGame.players count]);
   NSMutableArray *roundArray = [NSMutableArray arrayWithArray:[_thisGame.rounds array]];
   NSMutableArray *playerArray = [[NSMutableArray alloc] init];
   Round *roundItem;
   roundItem = [roundArray objectAtIndex:[_thisGame.rounds count] - indexPath.row - 1];
   [playerArray addObject:roundItem.player0];
   [playerArray addObject:roundItem.player1];
   [playerArray addObject:roundItem.player2];
   [playerArray addObject:roundItem.player3];
   [playerArray addObject:roundItem.player4];
   [playerArray addObject:roundItem.player5];
   
   UILabel *roundLabel = (UILabel *)[cell viewWithTag:100];
   
   [roundLabel setText:[NSString stringWithFormat:@"%d", [_thisGame.rounds count] - indexPath.row]];
   for (int i = 0; i < [[_thisGame.players array] count]; i++)
   {
      UILabel *playerLabel = (UILabel *)[cell viewWithTag:200 + i];
      NSInteger gain = [[playerArray objectAtIndex:i] integerValue];
      [playerLabel setText:[NSString stringWithFormat:@"%ld", (long) gain]];
      if (gain < 0)
      {
         playerLabel.textColor = [UIColor redColor];
      }
      else if (gain == 0)
      {
         playerLabel.textColor = [UIColor blackColor];
      }
      else
      {
         playerLabel.textColor = [UIColor blueColor];
      }
   }
   
   for (int i = [[_thisGame.players array] count]; i < MaximumNumberOfPlayers; i++)
   {
      NSLog(@"%d", i);
      UILabel *playerLabel = (UILabel *)[cell viewWithTag:200 + i];
      [playerLabel setText:@""];
      playerLabel.textColor = [UIColor blackColor];
   }
   
   return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
