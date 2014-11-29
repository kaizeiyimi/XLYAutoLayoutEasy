//
//  UIViewController+XLYAutoLayoutAddition.h
//  XLYAutoLayoutEasyDemo
//
//  Created by 王凯 on 14/11/28.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XLYAutoLayoutAddition)

///wrap the topLayoutGuide
@property (nonatomic, strong, readonly) UIView *topLayoutGuideView NS_AVAILABLE_IOS(7_0);
///wrap the bottomLayoutGuide
@property (nonatomic, strong, readonly) UIView *bottomLayoutGuideView NS_AVAILABLE_IOS(7_0);

@end
