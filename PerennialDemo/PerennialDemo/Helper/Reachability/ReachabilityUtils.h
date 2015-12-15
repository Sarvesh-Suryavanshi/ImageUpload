//
//  ReachabilityUtils.h
//  JioMediaBaseFramework
//
//  Created by Sarvesh Suryavanshi on 17/04/15.
//  Copyright (c) 2015 Reliance Jio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachabilityUtils : NSObject

+ (BOOL)isNetworkAvailable;
+ (int)getReachabilityStatus;

@end
