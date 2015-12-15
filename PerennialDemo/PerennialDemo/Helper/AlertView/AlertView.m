//
//  AlertView.m
//  JioBeats
//
//  Created by Rishab Bokaria on 11/28/15.
//  Copyright (c) 2015 RJIL. All rights reserved.
//

#import "AlertView.h"
#import "ReachabilityUtils.h"
#import "AppDelegate.h"

#define REACHABILITY_HOST @"www.google.com"

@interface AlertView()
@property (nonatomic, copy) alertBlock completionBlock;
@end

@interface AlertView () <UIAlertViewDelegate>
@end

@implementation AlertView


+(BOOL) isNetworkAvailable
{
    return [ReachabilityUtils isNetworkAvailable];
}

+(void) showNetworkUnalailableAlertWithCompletionBlock:(alertBlock)blk
{
    [self showAlertWithTitle:@"Network Alert." message:@"No Network Available." buttons:[NSArray arrayWithObjects:AlertOK, nil] completionBlock:blk];
}
+(void) showAlertWithTitle:(NSString *)title message:(NSString *)msg buttons:(NSArray *)arrayButtons completionBlock:(alertBlock)blk
{
    AlertView *alertView = [[self alloc] init];
    alertView.completionBlock = blk;
    alertView.delegate = alertView;
    alertView.title = title;
    alertView.message = msg;
    for (NSString *btnTitle in arrayButtons) {
        [alertView addButtonWithTitle:btnTitle];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [alertView show];
    });
}

+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)msg buttons:(NSArray *)arrayButtons
{
    AlertView *alertView  = [[self alloc] init];
    alertView.title = title;
    alertView.message = msg;
    for (NSString *btnTitle in arrayButtons) {
        [alertView addButtonWithTitle:btnTitle];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [alertView show];
    });
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.completionBlock(buttonIndex);
}

+ (void)showNoNetworkAlert
{
   [AlertView showAlertWithTitle:@"" Message:AlertCheckNetworkMessage buttons:@[AlertOK]];
}

+(void) showAlertForError:(NSError *)err
{
    [self showAlertWithTitle:err.domain
                     message:err.localizedDescription
                     buttons:[NSArray arrayWithObject:AlertOK]
             completionBlock:^(NSInteger index) {
             }];
}

+(void) showAlertForException:(NSException *)excp
{
    NSError *err = [NSError errorWithDomain:excp.name code:-200 userInfo:excp.userInfo];
    [self showAlertWithTitle:err.domain
                     message:err.localizedDescription
                     buttons:[NSArray arrayWithObject:AlertOK]
             completionBlock:^(NSInteger index) {
             }];
}

@end
