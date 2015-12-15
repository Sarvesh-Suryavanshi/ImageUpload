//
//  PDThemeAndAlertConstant.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 29/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSInteger const MainThemeR;
extern NSInteger const MainThemeG;
extern NSInteger const MainThemeB;

extern NSString * const AlertOK;
extern NSString * const AlertCheckNetworkMessage;
extern NSString * const AlertEmptyFields;
extern NSString * const AlertUserAdded;
extern NSString * const AlertUserAddingFailed;

@interface PDThemeAndAlertConstant : NSObject
+ (UIColor *)getMainthemeColour;
@end
