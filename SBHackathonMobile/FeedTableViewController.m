//
//  FeedTableViewController.m
//  SBHackathonMobile
//
//  Created by sloot on 1/31/15.
//  Copyright (c) 2015 sloot. All rights reserved.
//

#import "FeedTableViewController.h"
#import "AppCommunication.h"
#import "Feed.h"
#import <Firebase/Firebase.h>
@interface FeedTableViewController ()
@property (nonatomic, strong) NSMutableArray* feeds;

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feeds = [NSMutableArray array];
    [self retrieveFeed];
    [AppCommunication sharedCommunicator].firebase = [[Firebase alloc] initWithUrl:@"https://sbhacks2015.firebaseio.com/"];
    [[AppCommunication sharedCommunicator].firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)goBackToTable:(UIStoryboardSegue*)goBackSegue
{
    [self retrieveFeed];
}

-(void)retrieveFeed
{
    [[AppCommunication sharedCommunicator] getRequestWithCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSInteger responseStatusCode = [httpResponse statusCode];
            
            if (responseStatusCode == 200)
            {
                // do something with this data
                // if you want to update UI, do it on main queue
                self.feeds = [NSMutableArray array];
                
                NSArray *fetchedData = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:nil];
                for(int i = 0; i < fetchedData.count; i++)
                {
                    NSDictionary* dictionary = [fetchedData objectAtIndex:i];
                    
                    Feed* newFeed  = [[Feed alloc] init];
                    newFeed.place = [dictionary objectForKey:@"Restaurant"];
                    newFeed.to = [dictionary objectForKey:@"MyLocation"];
                    newFeed.fee = [dictionary objectForKey:@"DeliveryFee"];
                    newFeed.when = [dictionary objectForKey:@"TimeRange"];
                    newFeed.what = [dictionary objectForKey:@"Food"];
                    
                    [self.feeds addObject:newFeed];
                }
                
                [self.tableView reloadData];
            }
            else
            {
                // error handling
                NSLog(@"ERROR SEND NOTIFICATION");
            }
            
        });
        
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.feeds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.alpha = 0.0;
    // Configure the cell...
    ((UILabel*)[cell viewWithTag:1]).text = [NSString stringWithFormat:@"From: %@",((Feed*)self.feeds[indexPath.row]).place];
    ((UILabel*)[cell viewWithTag:2]).text = [NSString stringWithFormat:@"To: %@",((Feed*)self.feeds[indexPath.row]).to];
    ((UILabel*)[cell viewWithTag:3]).text = [NSString stringWithFormat:@"Pay: %@",((Feed*)self.feeds[indexPath.row]).fee];
    ((UILabel*)[cell viewWithTag:4]).text = [NSString stringWithFormat:@"Time: %@",((Feed*)self.feeds[indexPath.row]).when];
    ((UILabel*)[cell viewWithTag:5]).text = [NSString stringWithFormat:@"Item: %@",((Feed*)self.feeds[indexPath.row]).what];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
