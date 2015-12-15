//
//  PDWebServiceHelper.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDWebServiceHelper.h"

NSString * const PDBaseURL = @"http://54.243.211.163:8081/techassignment/index.php/user/";

@implementation PDWebServiceHelper
+ (NSString *)getUserListAPI
{
    return  [PDBaseURL stringByAppendingString:@"listUser/"];
}

+ (NSString *)getSaveUserAPI
{
    return [PDBaseURL stringByAppendingPathComponent:@"addUser/"];
}
@end
