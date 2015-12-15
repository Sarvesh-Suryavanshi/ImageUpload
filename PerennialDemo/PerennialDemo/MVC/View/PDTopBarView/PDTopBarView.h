//
//  PDTopBarView.h
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomizedView.h"

@protocol PDTopBarDelegate <NSObject>
- (void)didTapOnAddUser;
@end

@interface PDTopBarView : CustomizedView
- (void)setTitle:(NSString *)title;
- (void)setDelegate:(__weak id <PDTopBarDelegate>)delegate;
@end
