//
//  UIImage+Helper.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)
+ (void) loadFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback;
@end
