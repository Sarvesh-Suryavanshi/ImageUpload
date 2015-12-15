//
//  WebServiceManager.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceResponseDelegate.h"
#import <UIKit/UIKit.h>

@protocol WebServiceManagerCallbackDelegate <NSObject>
- (void)webServiceSuccessForResponseVO:(id <WebServiceResponseDelegate>)responseVO;
- (void)webServiceFailureForResponseVO:(id <WebServiceResponseDelegate>)responseVO;
@optional
@end

@interface WebServiceManager : NSObject
+ (instancetype)sharedInstance;
- (void)callGetWebServiceWithAPIURL:(NSString *)apiURL responseVO:(id <WebServiceResponseDelegate>)responseVO andListener:(__weak id <WebServiceManagerCallbackDelegate>)listener;
- (void)uploadImage:(UIImage *)image withAPIUrl:(NSString *)apiURL parameters:(NSDictionary *)parameters responseVO:(id <WebServiceResponseDelegate>)responseVO andListener:(__weak id <WebServiceManagerCallbackDelegate>) listener;
@end
