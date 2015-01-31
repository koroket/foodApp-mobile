//
//  AppCommunication.h
//  SBHackathonMobile
//
//  Created by sloot on 1/31/15.
//  Copyright (c) 2015 sloot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCommunication : NSObject
+ (instancetype)sharedCommunicator;
-(void)postRequest:(NSDictionary*) input withCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion;
-(void)getRequestWithCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion;
@end