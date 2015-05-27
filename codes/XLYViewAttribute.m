//
//  XLYViewAttribute.m
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYViewAttribute.h"

#import "XLYAutoLayoutEasyPrivate.h"

@implementation XLYViewAttribute

- (instancetype)init
{
  if (self = [super init]) {
    self.view = nil;
    self.ns_layoutAttribute = NSLayoutAttributeNotAnAttribute;
  }
  return self;
}

- (XLYConstraint *(^)(CGFloat))equalToConstant {
  return ^XLYConstraint *(CGFloat attr) {
    return [self equalTo:@(attr)];
  };
}

- (XLYConstraint *(^)(CGFloat))greaterThanOrEqualToConstant {
  return ^XLYConstraint *(CGFloat attr) {
    return [self greaterThanOrEqualTo:@(attr)];
  };
}

- (XLYConstraint *(^)(CGFloat))lessThanOrEqualToConstant {
  return ^XLYConstraint *(CGFloat attr) {
    return [self lessThanOrEqualTo:@(attr)];
  };
}

- (XLYEnhancedViewAttribute *(^)(UILayoutPriority))priority {
  return ^XLYEnhancedViewAttribute *(UILayoutPriority priority) {
    return [self priority:priority];
  };
}

- (XLYEnhancedViewAttribute *(^)(CGFloat))multiplier {
  return ^XLYEnhancedViewAttribute *(CGFloat multiplier) {
    return [self multiplier:multiplier];
  };
}

- (XLYEnhancedViewAttribute *(^)(CGFloat))constant {
  return ^XLYEnhancedViewAttribute *(CGFloat constant) {
    return [self constant:constant];
  };
}

- (XLYConstraint *)equalToConstant:(CGFloat)constant {
  return [self equalTo:@(constant)];
}

- (XLYConstraint *)greaterThanOrEqualToConstant:(CGFloat)constant {
  return [self greaterThanOrEqualTo:@(constant)];
}

- (XLYConstraint *)lessThanOrEqualToConstant:(CGFloat)constant {
  return [self lessThanOrEqualTo:@(constant)];
}

- (XLYEnhancedViewAttribute *)priority:(UILayoutPriority)priority {
  XLYEnhancedViewAttribute *attr = [XLYEnhancedViewAttribute new];
  attr.viewAttribute = self;
  attr.layoutPriority = priority;
  return attr;
}

- (XLYEnhancedViewAttribute *)multiplier:(CGFloat)multiplier {
  XLYEnhancedViewAttribute *attr = [XLYEnhancedViewAttribute new];
  attr.viewAttribute = self;
  attr.layoutMultiplier = multiplier;
  return attr;
}

- (XLYEnhancedViewAttribute *)constant:(CGFloat)constant {
  XLYEnhancedViewAttribute *attr = [XLYEnhancedViewAttribute new];
  attr.viewAttribute = self;
  attr.layoutConstant = constant;
  return attr;
}

- (XLYConstraint *)equalTo:(id)attr {
  return [self makeRelation:NSLayoutRelationEqual toOther:attr];
}

- (XLYConstraint *)greaterThanOrEqualTo:(id)attr {
  return [self makeRelation:NSLayoutRelationGreaterThanOrEqual toOther:attr];
}

- (XLYConstraint *)lessThanOrEqualTo:(id)attr {
  return [self makeRelation:NSLayoutRelationLessThanOrEqual toOther:attr];
}

- (XLYConstraint *)makeRelation:(NSLayoutRelation)relation toOther:(id)other {
  XLYConstraint *xlyConstraint = [XLYConstraint new];
  
  XLYViewAttribute *secondViewAttribute = nil;
  if ([other isKindOfClass:XLYViewAttribute.class]) { // XLYViewAttribute
    secondViewAttribute = other;
  } else if ([other isKindOfClass:XLYEnhancedViewAttribute.class]) {  // XLYenhancedViewAttribute
    XLYEnhancedViewAttribute *attr = (XLYEnhancedViewAttribute *)other;
    xlyConstraint.layoutMultiplier = attr.layoutMultiplier;
    xlyConstraint.layoutPriority = attr.layoutPriority;
    xlyConstraint.layoutConstant = attr.layoutConstant;
    secondViewAttribute = attr.viewAttribute;
  } else if ([other isKindOfClass:UIView.class]) {  // UIView
    XLYViewAttribute *attr = [XLYViewAttribute new];
    attr.view = other;
    attr.ns_layoutAttribute = self.ns_layoutAttribute;
    secondViewAttribute = attr;
  } else if ([other isKindOfClass:NSNumber.class]) {  // Number
    XLYViewAttribute *attr = [XLYViewAttribute new];
    if(self.ns_layoutAttribute == NSLayoutAttributeWidth || self.ns_layoutAttribute == NSLayoutAttributeHeight) {
      xlyConstraint.layoutConstant = [other floatValue];
    } else {
      NSAssert(self.view.superview, @"must have a superview!");
      attr.view = self.view.superview;
      attr.ns_layoutAttribute = self.ns_layoutAttribute;
      xlyConstraint.layoutConstant = [other floatValue];
    }
    secondViewAttribute = attr;
  }
  NSAssert(secondViewAttribute, @"XLYConstraint's secondAttribute must be of 'XLYViewAttribute', 'XLYEnhancedViewAttribute', 'UIView' or 'number'.");
  
  xlyConstraint.firstViewAttribute = self;
  xlyConstraint.relation = relation;
  xlyConstraint.secondViewAttribute = secondViewAttribute;
  return xlyConstraint;
}

@end


@implementation XLYEnhancedViewAttribute

- (instancetype)init {
  if (self = [super init]) {
    self.layoutPriority = UILayoutPriorityRequired;
    self.layoutMultiplier = 1.0;
    self.layoutConstant = 0;
  }
  return self;
}

- (XLYEnhancedViewAttribute *(^)(UILayoutPriority))priority {
  return ^XLYEnhancedViewAttribute *(UILayoutPriority priority) {
    return [self priority:priority];
  };
}

- (XLYEnhancedViewAttribute *(^)(CGFloat))multiplier {
  return ^XLYEnhancedViewAttribute *(CGFloat multiplier) {
    return [self multiplier:multiplier];
  };
}

- (XLYEnhancedViewAttribute *(^)(CGFloat))constant {
  return ^XLYEnhancedViewAttribute *(CGFloat constant) {
    return [self constant:constant];
  };
}

- (XLYEnhancedViewAttribute *)priority:(UILayoutPriority)priority {
  self.layoutPriority = priority;
  return self;
}

- (XLYEnhancedViewAttribute *)multiplier:(CGFloat)multiplier {
  self.layoutMultiplier = multiplier;
  return self;
}

- (XLYEnhancedViewAttribute *)constant:(CGFloat)constant {
  self.layoutConstant = constant;
  return self;
}

@end
