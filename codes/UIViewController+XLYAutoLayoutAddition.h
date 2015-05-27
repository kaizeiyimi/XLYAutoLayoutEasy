//
//  UIViewController+XLYAutoLayoutAddition.h
//
//  Created by 王凯 on 14/11/28.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XLYAutoLayoutAddition)

///wrap the topLayoutGuide
@property (nonatomic, strong, readonly, nonnull) UIView *xly_topGuideView NS_AVAILABLE_IOS(7_0);
///wrap the bottomLayoutGuide
@property (nonatomic, strong, readonly, nonnull) UIView *xly_bottomGuideView NS_AVAILABLE_IOS(7_0);

@end
