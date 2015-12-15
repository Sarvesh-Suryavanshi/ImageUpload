//
//  CustomizedView.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "CustomizedView.h"

@interface CustomizedView ()
{
    UIView *_nibView;
}
@end

@implementation CustomizedView

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self processCustomView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self processCustomView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self processCustomView];
    }
    return self;
}

#pragma mark - Helper Method

- (void)processCustomView
{
    _nibView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    _nibView.frame = self.bounds;
    [self addSubview:_nibView];
    _nibView.backgroundColor = self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Getter Method

- (UIView *)getNib
{
    return _nibView;
}
@end
