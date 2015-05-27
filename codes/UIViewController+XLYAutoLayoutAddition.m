//
//  UIViewController+XLYAutoLayoutAddition.m
//
//  Created by 王凯 on 14/11/28.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "UIViewController+XLYAutoLayoutAddition.h"

@implementation UIViewController (XLYAutoLayoutAddition)

- (UIView *)xly_topGuideView {
  return (UIView *)self.topLayoutGuide;
}

- (UIView *)xly_bottomGuideView {
  return (UIView *)self.bottomLayoutGuide;
}

@end
