//
//  XLYViewAttribute.h
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLYConstraint.h"

/*
 * params that except 'id' can be according 'ViewAttribute'(XLYViewAttribute, XLYEnhancedViewAttribute or other composite attribute like size, center and edge), 'View' or 'Number'.
 *
 * for example:
 * using XLYViewAttribute will be '[a.xly_xxx equalTo:b.xly_mmm]'.
 * using View will be '[a.xly_xxx equalTo:b]', and it is short for '[a.xly_xxx equalTo:b.xly_xxx]'.
 * using Number will be '[a.xly_xxx equalTo:@(value)]' or '[a.xly_xxx equalToConstaint:value]', and it is short for '[a.xly_xxx equalTo:b.xly_xxx.constant(value)]'.
 *
 * second item can be configured with multiplier, constant and priority. if you want to configure any of these properties you must write the full format to do so and you will get an instance of 'XLYEnhancedViewAttribute' containing view, NSLayoutAttribute, priority, multiplier and constant.
 * full format: b.xly_leading.constant(10).multiplier(0.5).priority(1000). You can config the ones your care about, leave others default.
 * like this: b.xly_leading.constant(10). The default value of constant is 0, multiplier is 1.0 and priority is 1000.
 *
 * NOTICE: these three properties CAN have any order. Composite ViewAttribute CANNOT be configured with priority, multiplier or constant because they are actually combined by normal XLYViewAttribute or XLYEnhancedViewAttribute. And only 'equal' is supported because there is no proper defination of 'greaterThanOrEqualTo' or 'lessThanOrEqualTo' for composite attribute.
 *
 */

@interface XLYViewAttribute : NSObject

/// accept 'XLYViewAttribute', 'UIView' or 'Number'.
- (nonnull XLYConstraint *)equalTo:(nonnull id)attr;
/// accept 'XLYViewAttribute', 'UIView' or 'Number'.
- (nonnull XLYConstraint *)greaterThanOrEqualTo:(nonnull id)attr;
/// accept 'XLYViewAttribute', 'UIView' or 'Number'.
- (nonnull XLYConstraint *)lessThanOrEqualTo:(nonnull id)attr;

@end


@interface XLYEnhancedViewAttribute : NSObject
@end


@interface XLYViewSizeAttribute : NSObject

/// 'attr' accept 'XLYViewSizeAttribute' or 'UIView'.
- (nonnull XLYSizeConstraint *)equalTo:(nonnull id)attr;
/// 'attr' accept 'XLYViewSizeAttribute' or 'UIView'.
- (nonnull XLYSizeConstraint *)equalTo:(nonnull id)attr offset:(UIOffset)offset;

- (nonnull XLYSizeConstraint *)equalToCGSize:(CGSize)size;

/// accept 'XLYViewAttribute', 'UIView' or 'number'. nil means do not create constraints.
- (nonnull XLYSizeConstraint *)equalToWidth:(nullable id)secondWidth
                                     height:(nullable id)secondHeight;

@end


@interface XLYViewCenterAttribute : NSObject

/// 'attr' accept 'XLYViewCenterAttribute' or 'UIView'.
- (nonnull XLYCenterConstraint *)equalTo:(nonnull id)attr;
/// 'attr' accept 'XLYViewCenterAttribute' or 'UIView'.
- (nonnull XLYCenterConstraint *)equalTo:(nonnull id)attr offset:(UIOffset)offset;

/// accept 'XLYViewAttribute', 'UIView' or 'number'. nil means do not create constraints.
- (nonnull XLYCenterConstraint *)equalToCenterX:(nullable id)secondCenterX
                                        centerY:(nullable id)secondCenterY;

@end


@interface XLYViewEdgeAttribute : NSObject

/// 'attr' accept 'XLYViewEdgeAttribute' or 'UIView'.
- (nonnull XLYEdgeConstraint *)equalTo:(nonnull id)attr;
/// 'attr' accept 'XLYViewEdgeAttribute' or 'UIView'.
- (nonnull XLYEdgeConstraint *)equalTo:(nonnull id)attr insets:(UIEdgeInsets)insets;

/// accept 'XLYViewAttribute', 'UIView' or 'number'. nil means do not create constraints.
- (nonnull XLYEdgeConstraint *)equalToTop:(nullable id)secondTop
                                  leading:(nullable id)secondLeading
                                   bottom:(nullable id)secondBottom
                                 trailing:(nullable id)secondTrailing;

@end
