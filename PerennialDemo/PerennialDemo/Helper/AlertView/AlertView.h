//
//  AlertView.h
//  JioBeats
//
//  Created by Sarvesh Suryavanshi on 11/28/15.
//  Copyright (c) 2015 RJIL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^alertBlock)(NSInteger index);
@interface AlertView : UIAlertView

+ (BOOL)isNetworkAvailable;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg buttons:(NSArray *)arrayButtons completionBlock:(alertBlock)blk;
+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)msg buttons:(NSArray *)arrayButtons;
+ (void)showNoNetworkAlert;
+ (void)showAlertForError:(NSError *)err;
+ (void)showAlertForException:(NSException *)excp;
@end
