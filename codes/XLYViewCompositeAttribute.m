//
//  XLYViewCompositeAttribute.m
//
//  Created by kaizei on 15/5/17.
//  Copyright (c) 2015年 kaizei. All rights reserved.
//

#import "XLYViewAttribute.h"

#import "XLYAutoLayoutEasyPrivate.h"
#import "XLYViewAttribute-OC.h"

#pragma mark - size support

@implementation XLYViewSizeAttribute

- (XLYSizeConstraint *)equalToCGSize:(CGSize)size {
  return [self equalToWidth:@(size.width) height:@(size.height)];
}

- (XLYSizeConstraint *)equalTo:(id)attr {
  return [self equalTo:attr offset:UIOffsetZero];
}

- (XLYSizeConstraint *)equalTo:(id)attr offset:(UIOffset)offset {
  if ([attr isKindOfClass:UIView.class]) {
    UIView *view = attr;
    return [self equalToWidth:[view xly_layoutAttribute:[self.widthAttribute ns_layoutAttribute]].constant(offset.horizontal)
                       height:[view xly_layoutAttribute:[self.heightAttribute ns_layoutAttribute]].constant(offset.vertical)];
  } else if ([attr isKindOfClass:XLYViewSizeAttribute.class]) {
    XLYViewSizeAttribute *size = attr;
    return [self equalToWidth:((XLYViewAttribute *)size.widthAttribute).constant(offset.horizontal)
                       height:((XLYViewAttribute *)size.heightAttribute).constant(offset.vertical)];
  } else {
    NSAssert(NO, @"'attr' must be of 'UIView' or 'XLYViewSizeAttribute'.");
  }
  return nil;
}

- (XLYSizeConstraint *)equalToWidth:(id)secondWidth
                             height:(id)secondHeight {
  XLYViewSizeAttribute *secondAttribute = [XLYViewSizeAttribute new];
  secondAttribute.widthAttribute = secondWidth;
  secondAttribute.heightAttribute = secondHeight;
  
  XLYSizeConstraint *constraint = [XLYSizeConstraint new];
  constraint.firstAttribute = self;
  constraint.seconAttribute = secondAttribute;
  
  return constraint;
}

@end


#pragma mark - center support

@implementation XLYViewCenterAttribute

- (XLYCenterConstraint *)equalTo:(id)attr {
  return [self equalTo:attr offset:UIOffsetZero];
}

- (XLYCenterConstraint *)equalTo:(id)attr offset:(UIOffset)offset {
  if ([attr isKindOfClass:UIView.class]) {
    UIView *view = attr;
    return [self equalToCenterX:[view xly_layoutAttribute:[self.centerXAttribute ns_layoutAttribute]].constant(offset.horizontal)
                        centerY:[view xly_layoutAttribute:[self.centerYAttribute ns_layoutAttribute]].constant(offset.vertical)];
  } else if ([attr isKindOfClass:XLYViewCenterAttribute.class]) {
    XLYViewCenterAttribute *center = attr;
    return [self equalToCenterX:((XLYViewAttribute *)center.centerXAttribute).constant(offset.horizontal)
                        centerY:((XLYViewAttribute *)center.centerYAttribute).constant(offset.vertical)];
  } else {
    NSAssert(NO, @"'attr' must be of 'UIView' or 'XLYViewCenterAttribute'.");
  }
  return nil;
}

- (XLYCenterConstraint *)equalToCenterX:(id)secondCenterX
                                centerY:(id)secondCenterY {
  XLYViewCenterAttribute *secondAttribute = [XLYViewCenterAttribute new];
  secondAttribute.centerXAttribute = secondCenterX;
  secondAttribute.centerYAttribute = secondCenterY;
  
  XLYCenterConstraint *constraint = [XLYCenterConstraint new];
  constraint.firstAttribute = self;
  constraint.seconAttribute = secondAttribute;
  
  return constraint;
}

@end


#pragma mark - edge support

@implementation XLYViewEdgeAttribute

- (XLYEdgeConstraint *)equalTo:(id)attr {
  return [self equalTo:attr insets:UIEdgeInsetsZero];
}

- (XLYEdgeConstraint *)equalTo:(id)attr insets:(UIEdgeInsets)insets {
  if ([attr isKindOfClass:UIView.class]) {
    UIView *view = attr;
    return [self equalToTop:[view xly_layoutAttribute:[self.topAttribute ns_layoutAttribute]].constant(insets.top)
                    leading:[view xly_layoutAttribute:[self.leadingAttribute ns_layoutAttribute]].constant(insets.left)
                     bottom:[view xly_layoutAttribute:[self.bottomAttribute ns_layoutAttribute]].constant(-insets.bottom)
                   trailing:[view xly_layoutAttribute:[self.trailingAttribute ns_layoutAttribute]].constant(-insets.right)];
  } else if ([attr isKindOfClass:XLYViewEdgeAttribute.class]) {
    XLYViewEdgeAttribute *edge = attr;
    return [self equalToTop:((XLYViewAttribute *)edge.topAttribute).constant(insets.top)
                    leading:((XLYViewAttribute *)edge.leadingAttribute).constant(insets.left)
                     bottom:((XLYViewAttribute *)edge.bottomAttribute).constant(-insets.bottom)
                   trailing:((XLYViewAttribute *)edge.trailingAttribute).constant(-insets.right)];
  } else {
    NSAssert(NO, @"'attr' must be of 'UIView' or 'XLYViewEdgeAttribute'.");
  }
  return nil;
}

- (XLYEdgeConstraint *)equalToTop:(id)secondTop
                          leading:(id)secondLeading
                           bottom:(id)secondBottom
                         trailing:(id)secondTrailing {
  XLYViewEdgeAttribute *secondAttribute = [XLYViewEdgeAttribute new];
  secondAttribute.topAttribute = secondTop;
  secondAttribute.leadingAttribute = secondLeading;
  secondAttribute.bottomAttribute = secondBottom;
  secondAttribute.trailingAttribute = secondTrailing;
  
  XLYEdgeConstraint *constraint = [XLYEdgeConstraint new];
  constraint.firstAttribute = self;
  constraint.secondAttribute = secondAttribute;
  
  return constraint;
}

@end
