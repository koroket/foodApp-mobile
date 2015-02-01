//
//  DetailedViewController.m
//  SBHackathonMobile
//
//  Created by sloot on 1/31/15.
//  Copyright (c) 2015 sloot. All rights reserved.
//

#import "DetailedViewController.h"
#import "AppCommunication.h"
#import "Feed.h"
@interface DetailedViewController ()
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *item;
@property (strong, nonatomic) IBOutlet UILabel *when;
@property (strong, nonatomic) IBOutlet UITextField *time;
@property (strong, nonatomic) IBOutlet UILabel *place;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.price.text = ((Feed*)[AppCommunication sharedCommunicator].feeds[[AppCommunication sharedCommunicator].selectedIndex]).fee;
    self.location.text = ((Feed*)[AppCommunication sharedCommunicator].feeds[[AppCommunication sharedCommunicator].selectedIndex]).to;
    self.item.text = ((Feed*)[AppCommunication sharedCommunicator].feeds[[AppCommunication sharedCommunicator].selectedIndex]).what;
    self.when.text = ((Feed*)[AppCommunication sharedCommunicator].feeds[[AppCommunication sharedCommunicator].selectedIndex]).when;
    self.place.text = ((Feed*)[AppCommunication sharedCommunicator].feeds[[AppCommunication sharedCommunicator].selectedIndex]).place;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)submitPressed:(id)sender {
    NSLog(@"%@",self.time.text);
    NSDictionary* first = [NSDictionary dictionaryWithObjectsAndKeys:[AppCommunication sharedCommunicator].fbid, @"fbid",[AppCommunication sharedCommunicator].fbname, @"fbname",self.time.text,@"time", @"noidyet",@"ownerid", nil];
    [[AppCommunication sharedCommunicator].firebase setValue:first];
}

@end
