//
//  PDThemeAndAlertConstant.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 29/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDThemeAndAlertConstant.h"

NSInteger const MainThemeR = 62.0f;
NSInteger const MainThemeG = 66.0f;
NSInteger const MainThemeB = 104.0f;

NSString * const AlertOK    =   @"OK";
NSString * const AlertCheckNetworkMessage = @"Please check your internet connection";
NSString * const AlertEmptyFields = @"Fields should not be empty";
NSString * const AlertUserAdded = @"User added successfully";
NSString * const AlertUserAddingFailed = @"Failed to add user";

@implementation PDThemeAndAlertConstant

+ (UIColor *)getMainthemeColour
{
    return [UIColor colorWithRed:MainThemeR/255.0f green:MainThemeG/255.0f blue:MainThemeB/255.0f alpha:1.0f];
}
@end
