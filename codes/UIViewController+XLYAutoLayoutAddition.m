//
//  UIViewController+XLYAutoLayoutAddition.m
//  XLYAutoLayoutEasyDemo
//
//  Created by 王凯 on 14/11/28.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "UIViewController+XLYAutoLayoutAddition.h"

@implementation UIViewController (XLYAutoLayoutAddition)

- (UIView *)topLayoutGuideView
{
    return (UIView *)self.topLayoutGuide;
}

- (UIView *)bottomLayoutGuideView
{
    return (UIView *)self.bottomLayoutGuide;
}

@end
