//
//  NewPostViewController.m
//  SBHackathonMobile
//
//  Created by sloot on 1/31/15.
//  Copyright (c) 2015 sloot. All rights reserved.
//

#import "NewPostViewController.h"
#import "AppCommunication.h"
#import <Firebase/Firebase.h>
@interface NewPostViewController ()
@property (strong, nonatomic) IBOutlet UITextField *place;
@property (strong, nonatomic) IBOutlet UITextField *what;
@property (strong, nonatomic) IBOutlet UITextField *when;
@property (strong, nonatomic) IBOutlet UITextField *to;
@property (strong, nonatomic) IBOutlet UITextField *fee;

@end

@implementation NewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)donePressed:(id)sender {
    [self postRequest];
}
-(void)postRequest
{
    NSDictionary* input = [NSDictionary dictionaryWithObjectsAndKeys:self.place.text,@"Restaurant",self.what.text,@"Food",self.when.text,@"TimeRange",self.to.text,@"MyLocation",self.fee.text,@"DeliveryFee", nil];
    [[AppCommunication sharedCommunicator] postRequest:@"/post" withInput:input withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSInteger responseStatusCode = [httpResponse statusCode];
            
            if (responseStatusCode == 200)
            {
               
               [self performSegueWithIdentifier:@"Done" sender:self];
            }
            else
            {
                // error handling
                NSLog(@"ERROR SEND NOTIFICATION");
            }
            
        });

        
    }];
}
@end
