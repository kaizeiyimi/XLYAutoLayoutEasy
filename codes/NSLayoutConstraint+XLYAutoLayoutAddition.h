//
//  NSLayoutConstraint+XLYAutoLayoutAddition.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/22.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (XLYAutoLayoutAddition)

///like set active to YES in ios8. the commonSuperview of firstItem and secondItem will add the constraint.
- (void)xly_install;

///like set active to NO in ios8. the commonSuperview of firstItem and secondItem will remove the constraint.
- (void)xly_uninstall;

@end
