//
//  UIView+XLYAutoLayoutAddition.m
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "UIView+XLYAutoLayoutAddition.h"

#import <objc/runtime.h>
#import "XLYAutoLayoutEasyPrivate.h"

@implementation UIView (XLYAutoLayoutAddition)

- (void)setXly_debugName:(NSString *)debugName
{
  objc_setAssociatedObject(self, "XLYLayoutConstraintDebugName", debugName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)xly_debugName
{
  return objc_getAssociatedObject(self, "XLYLayoutConstraintDebugName");
}

- (XLYViewAttribute *)xly_layoutAttribute:(NSLayoutAttribute)attribute {
  XLYViewAttribute *viewAttribute = [XLYViewAttribute new];
  viewAttribute.view = self;
  viewAttribute.ns_layoutAttribute = attribute;
  return viewAttribute;
}

- (XLYViewAttribute *(^)(NSLayoutAttribute))xly_layoutAttribute {
  return ^XLYViewAttribute *(NSLayoutAttribute attr) {
    return [self xly_layoutAttribute:attr];
  };
}

- (XLYViewAttribute *)xly_top {
  return [self xly_layoutAttribute:NSLayoutAttributeTop];
}

- (XLYViewAttribute *)xly_left {
  return [self xly_layoutAttribute:NSLayoutAttributeLeft];
}

- (XLYViewAttribute *)xly_right {
  return [self xly_layoutAttribute:NSLayoutAttributeRight];
}

- (XLYViewAttribute *)xly_bottom {
  return [self xly_layoutAttribute:NSLayoutAttributeBottom];
}

- (XLYViewAttribute *)xly_leading {
  return [self xly_layoutAttribute:NSLayoutAttributeLeading];
}

- (XLYViewAttribute *)xly_trailing {
  return [self xly_layoutAttribute:NSLayoutAttributeTrailing];
}

- (XLYViewAttribute *)xly_height {
  return [self xly_layoutAttribute:NSLayoutAttributeHeight];
}

- (XLYViewAttribute *)xly_width {
  return [self xly_layoutAttribute:NSLayoutAttributeWidth];
}

- (XLYViewAttribute *)xly_centerX {
  return [self xly_layoutAttribute:NSLayoutAttributeCenterX];
}

- (XLYViewAttribute *)xly_centerY {
  return [self xly_layoutAttribute:NSLayoutAttributeCenterY];
}

- (XLYViewAttribute *)xly_baseLine {
  return [self xly_layoutAttribute:NSLayoutAttributeBaseline];
}

- (XLYViewAttribute *)xly_lastBaseLine {
  return [self xly_layoutAttribute:NSLayoutAttributeLastBaseline];
}

- (XLYViewAttribute *)xly_firstBaseLine {
  return [self xly_layoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (XLYViewAttribute *)xly_topMargin {
  return [self xly_layoutAttribute:NSLayoutAttributeTopMargin];
}

- (XLYViewAttribute *)xly_leftMargin {
  return [self xly_layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (XLYViewAttribute *)xly_bottomMargin {
  return [self xly_layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (XLYViewAttribute *)xly_rightMargin {
  return [self xly_layoutAttribute:NSLayoutAttributeRightMargin];
}

- (XLYViewAttribute *)xly_leadingMargin {
  return [self xly_layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (XLYViewAttribute *)xly_trailingMargin {
  return [self xly_layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (XLYViewAttribute *)xly_centerXWithinMargins {
  return [self xly_layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (XLYViewAttribute *)xly_centerYWithinMargins {
  return [self xly_layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

- (XLYViewAttribute *)xly_none {
  return [self xly_layoutAttribute:NSLayoutAttributeNotAnAttribute];
}

#pragma mark -
- (UIView *)xly_closestCommonSuperviewWithView:(UIView *)view {
  if (!view) {
    return nil;
  }
  UIView *view1 = self, *view2 = view;
  NSInteger count1 = 0, count2 = 0;
  while (view1.superview) {
    view1 = view1.superview;
    count1 ++;
  }
  while (view2.superview) {
    view2 = view2.superview;
    count2 ++;
  }
  if (view1 == view2) {
    view1 = self, view2 = view;
    for (int i = 0; i < count1 - count2; ++i) {
      view1 = view1.superview;
    }
    for (int i = 0; i < count2 - count1; ++i) {
      view2 = view2.superview;
    }
    for (int i = 0; i <= MIN(count1, count2); ++i) {
      if (view1 == view2) {
        return view1;
      }
      view1 = view1.superview;
      view2 = view2.superview;
    }
  }
  return nil;
}

+ (UIView *)xly_ClosestCommonSuperviewForView1:(UIView *)view1 view2:(UIView *)view2 {
  return [view1 xly_closestCommonSuperviewWithView:view2];
}

@end


#pragma mark - comosite support

@implementation UIView (XLYAutoLayoutAdditionSizeExtention)

- (XLYViewSizeAttribute *)xly_size {
  XLYViewSizeAttribute *attribute = [XLYViewSizeAttribute new];
  attribute.widthAttribute = self.xly_width;
  attribute.heightAttribute = self.xly_height;
  return attribute;
}

@end


@implementation UIView (XLYAutoLayoutAdditionCenterExtention)

- (XLYViewCenterAttribute *)xly_center {
  XLYViewCenterAttribute *attribute = [XLYViewCenterAttribute new];
  attribute.centerXAttribute = self.xly_centerX;
  attribute.centerYAttribute = self.xly_centerY;
  return attribute;
}

- (XLYViewCenterAttribute *)xly_centerWithinMargins {
  XLYViewCenterAttribute *attribute = [XLYViewCenterAttribute new];
  attribute.centerXAttribute = self.xly_centerXWithinMargins;
  attribute.centerYAttribute = self.xly_centerYWithinMargins;
  return attribute;
}

@end


@implementation UIView (XLYAutoLayoutAdditionEdgeExtention)

- (XLYViewEdgeAttribute *)xly_edge {
  XLYViewEdgeAttribute *attribute = [XLYViewEdgeAttribute new];
  attribute.topAttribute = self.xly_top;
  attribute.leadingAttribute = self.xly_leading;
  attribute.bottomAttribute = self.xly_bottom;
  attribute.trailingAttribute = self.xly_trailing;
  return attribute;
}

- (XLYViewEdgeAttribute *)xly_edgeWithMargin {
  XLYViewEdgeAttribute *attribute = [XLYViewEdgeAttribute new];
  attribute.topAttribute = self.xly_topMargin;
  attribute.leadingAttribute = self.xly_leadingMargin;
  attribute.bottomAttribute = self.xly_bottomMargin;
  attribute.trailingAttribute = self.xly_trailingMargin;
  return attribute;
}

@end
