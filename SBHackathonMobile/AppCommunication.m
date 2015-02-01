//
//  AppCommunication.m
//  SBHackathonMobile
//
//  Created by sloot on 1/31/15.
//  Copyright (c) 2015 sloot. All rights reserved.
//

#import "AppCommunication.h"

@implementation AppCommunication

static NSString *const ROOTURL= @"http://sb2015.herokuapp.com";
+ (instancetype)sharedCommunicator
{
    static AppCommunication *sharedCommunicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedCommunicator = [[AppCommunication alloc] init];
                  });
    return sharedCommunicator;
}
-(void)postRequest:(NSString*)latterPart withInput:(NSDictionary *)input withCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion
{

    NSString *fixedUrl = [NSString stringWithFormat:@"%@%@",ROOTURL,latterPart];
    
    NSURL *url = [NSURL URLWithString:fixedUrl];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:input options:kNilOptions error:&error];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:completion];
    [uploadTask resume];
    
}
-(void)getRequest:(NSString*)latterPart withCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion
{
//    NSString *latterPart = @"/newsfeed";
    NSString *fixedUrl = [NSString stringWithFormat:@"%@%@",ROOTURL,latterPart];
    
    NSURL *url = [NSURL URLWithString:fixedUrl];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:completion];
    [sessionTask resume];
    
}

@end
