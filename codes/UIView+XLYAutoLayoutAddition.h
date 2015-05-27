//
//  UIView+XLYAutoLayoutAddition.h
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLYConstraint.h"
#import "XLYViewAttribute.h"

@interface UIView (XLYAutoLayoutAddition)

/*
 *  'XLYViewAttribute' instance contains a pair of UIView(a layout item) and NSLayoutAttribute value.
 */

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_top;
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_left;
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_bottom;
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_right;

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_leading;
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_trailing;

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_width;
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_height;

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_centerX;
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_centerY;

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_baseLine ;
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_lastBaseLine;

//ios8
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_firstBaseLine NS_AVAILABLE_IOS(8_0);

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_topMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_leftMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_bottomMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_rightMargin NS_AVAILABLE_IOS(8_0);

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_leadingMargin NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_trailingMargin NS_AVAILABLE_IOS(8_0);

@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_centerXWithinMargins NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_centerYWithinMargins NS_AVAILABLE_IOS(8_0);

//NSLayoutAttributeNotAnAttribute
@property (nonatomic, strong, readonly, nonnull) XLYViewAttribute *xly_none NS_AVAILABLE_IOS(6_0);

/// used for debug info in console, if you called '+[NSLayoutConstraint xly_setReplaceDescription]'.
@property (nonatomic, copy, nullable) NSString *xly_debugName;

@end


#pragma mark - composite support

@interface UIView (XLYAutoLayoutAdditionSizeExtention)

@property (nonatomic, strong, readonly, nonnull) XLYViewSizeAttribute *xly_size;

@end


@interface UIView (XLYAutoLayoutAdditionCenterExtention)

@property (nonatomic, strong, readonly, nonnull) XLYViewCenterAttribute *xly_center;
@property (nonatomic, strong, readonly, nonnull) XLYViewCenterAttribute *xly_centerWithinMargins;

@end


@interface UIView (XLYAutoLayoutAdditionEdgeExtention)

@property (nonatomic, strong, readonly, nonnull) XLYViewEdgeAttribute *xly_edge;
@property (nonatomic, strong, readonly, nonnull) XLYViewEdgeAttribute *xly_edgeWithMargin;

@end
