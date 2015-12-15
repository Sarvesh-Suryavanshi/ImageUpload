//
//  ReachabilityUtils.m
//  JioMediaBaseFramework
//
//  Created by Sarvesh Suryavanshi on 17/04/15.
//  Copyright (c) 2015 Reliance Jio. All rights reserved.
//

#import "ReachabilityUtils.h"
#import "Reachability.h"

@interface ReachabilityUtils ()
{
}
@end

@implementation ReachabilityUtils

+ (BOOL)isNetworkAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    BOOL isNetworkAvailable = NO;
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus)
    {
        case ReachableViaWWAN:
            isNetworkAvailable = ![reachability connectionRequired];
            break;
            
        case ReachableViaWiFi:
            isNetworkAvailable = YES;
            break;
            
        default:
            isNetworkAvailable = NO;
            break;
    }
    return isNetworkAvailable;
}

+ (int)getReachabilityStatus
{
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
}

@end
