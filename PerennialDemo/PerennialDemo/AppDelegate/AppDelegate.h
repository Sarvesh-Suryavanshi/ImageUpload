//
//  AppDelegate.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityAlert.h"
#import "AlertView.h"
#import "PDThemeAndAlertConstant.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)getInstance;
+ (UIStoryboard *)getStoryBoard;
@end

