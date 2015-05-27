//
//  XLYViewAttribute-swift.h
//
//  Created by 王凯 on 14/12/2.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYViewAttribute.h"
#import "XLYConstraint.h"

@interface XLYViewAttribute (XLYAutoLayoutEasySwiftSupport)

- (nonnull XLYEnhancedViewAttribute *)priority:(UILayoutPriority)priority;
- (nonnull XLYEnhancedViewAttribute *)multiplier:(CGFloat)multiplier;
- (nonnull XLYEnhancedViewAttribute *)constant:(CGFloat)constant;

@end


@interface XLYEnhancedViewAttribute (XLYAutoLayoutEasySwiftSupport)

- (nonnull XLYEnhancedViewAttribute *)priority:(UILayoutPriority)priority;
- (nonnull XLYEnhancedViewAttribute *)multiplier:(CGFloat)multiplier;
- (nonnull XLYEnhancedViewAttribute *)constant:(CGFloat)constant;

@end
