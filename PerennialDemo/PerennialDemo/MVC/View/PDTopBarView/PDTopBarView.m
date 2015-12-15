//
//  PDTopBarView.m
//  PerennialDemo
//
//  Created by Sarvesh Suryavanshi on 28/11/15.
//  Copyright © 2015 Sarvesh Suryavanshi. All rights reserved.
//

#import "PDTopBarView.h"

@interface PDTopBarView ()
{
    IBOutlet UILabel *_titleLabel;
    __weak id <PDTopBarDelegate> _delegate;
}
- (IBAction)onTapAddUser:(id)sender;
@end

@implementation PDTopBarView

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self updateView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self updateView];
    }
    return self;
}

#pragma mark - Helper Method

- (void)updateView
{}

#pragma mark - Setter Method

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setDelegate:(__weak id <PDTopBarDelegate>)delegate;
{
    _delegate = delegate;
}

#pragma mark - Action Methodsß

- (IBAction)onTapAddUser:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didTapOnAddUser)])
    {
        [_delegate didTapOnAddUser];
    }
}
@end
