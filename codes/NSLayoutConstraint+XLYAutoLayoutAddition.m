//
//  NSLayoutConstraint+XLYAutoLayoutAddition.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/22.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "NSLayoutConstraint+XLYAutoLayoutAddition.h"

#import "UIView+XLYAutoLayoutAddition.h"

@implementation NSLayoutConstraint (XLYAutoLayoutAddition)

- (void)xly_install
{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        self.active = YES;
    } else {
        if (self.secondItem) {
            UIView *commonSuperView = [UIView xly_ClosestCommonSuperviewForView1:self.firstItem view2:self.secondItem];
            [commonSuperView addConstraint:self];
        } else {
            [self.firstItem addConstraint:self];
        }
    }
}

- (void)xly_uninstall
{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        self.active = NO;
    } else {
        if (self.secondItem) {
            UIView *commonSuperView = [UIView xly_ClosestCommonSuperviewForView1:self.firstItem view2:self.secondItem];
            [commonSuperView removeConstraint:self];
        } else {
            [self.firstItem removeConstraint:self];
        }
    }
}

@end
