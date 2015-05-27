//
//  XLYViewAttribute-OC.h
//
//  Created by 王凯 on 14/12/2.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYViewAttribute.h"
#import "XLYConstraint.h"

@interface XLYViewAttribute (XLYAutoLayoutEasyOCSupport)

- (XLYConstraint *)equalToConstant:(CGFloat)constant;
- (XLYConstraint *)greaterThanOrEqualToConstant:(CGFloat)constant;
- (XLYConstraint *)lessThanOrEqualToConstant:(CGFloat)constant;

- (XLYEnhancedViewAttribute *(^)(UILayoutPriority priority))priority;
- (XLYEnhancedViewAttribute *(^)(CGFloat multiplier))multiplier;
- (XLYEnhancedViewAttribute *(^)(CGFloat constant))constant;

@end


@interface XLYEnhancedViewAttribute (XLYAutoLayoutEasyOCSupport)

- (XLYEnhancedViewAttribute *(^)(UILayoutPriority priority))priority;
- (XLYEnhancedViewAttribute *(^)(CGFloat multiplier))multiplier;
- (XLYEnhancedViewAttribute *(^)(CGFloat constant))constant;

@end
