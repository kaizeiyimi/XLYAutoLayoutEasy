//
//  XLYConstraint.m
//
//  Created by kaizei on 14/11/21.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYConstraint.h"

#import "XLYAutoLayoutEasyPrivate.h"

@interface XLYConstraint ()

@property (nonatomic, strong) NSLayoutConstraint *resultConstraint;

@end

@implementation XLYConstraint

@synthesize directionOption = _directionOption;

- (instancetype)init {
  if (self = [super init]) {
    self.layoutMultiplier = 1.0;
    self.layoutPriority = UILayoutPriorityRequired;
    self.layoutConstant = 0.0;
    self.directionOption = NSLayoutFormatDirectionLeadingToTrailing;
    [NSLayoutConstraint xly_addRawConstraint:self];
  }
  return self;
}

- (NSLayoutAttribute)adjustAttribute:(NSLayoutAttribute)attribute withLayoutDirection:(NSLayoutFormatOptions)directionOption {
  if (directionOption == NSLayoutFormatDirectionLeftToRight) {
    switch (attribute) {
      case NSLayoutAttributeLeading: { return NSLayoutAttributeLeft; } break;
      case NSLayoutAttributeLeadingMargin: { return NSLayoutAttributeLeftMargin; } break;
      case NSLayoutAttributeTrailing: { return NSLayoutAttributeRight; } break;
      case NSLayoutAttributeTrailingMargin: { return NSLayoutAttributeRightMargin; } break;
      default:
        return attribute;
        break;
    }
  } else if (directionOption == NSLayoutFormatDirectionRightToLeft) {
    switch (attribute) {
      case NSLayoutAttributeLeading: { return NSLayoutAttributeRight; } break;
      case NSLayoutAttributeLeadingMargin: { return NSLayoutAttributeRightMargin; } break;
      case NSLayoutAttributeTrailing: { return NSLayoutAttributeLeft; } break;
      case NSLayoutAttributeTrailingMargin: { return NSLayoutAttributeLeftMargin; } break;
      default:
        return attribute;
        break;
    }
  }
  return attribute;
}

- (NSLayoutConstraint *)resultConstraint {
  if (!_resultConstraint) {
    id firstItem = self.firstViewAttribute.view, secondItem = self.secondViewAttribute.view;
    NSLayoutAttribute firstAttribute = self.firstViewAttribute.ns_layoutAttribute;
    NSLayoutAttribute secondAttribute = self.secondViewAttribute.ns_layoutAttribute;

    firstAttribute = [self adjustAttribute:firstAttribute withLayoutDirection:self.directionOption];
    secondAttribute = [self adjustAttribute:secondAttribute withLayoutDirection:self.directionOption];
    
    CGFloat layoutConstant = self.layoutConstant;
    if (self.firstViewAttribute.ns_layoutAttribute != firstAttribute
        && self.directionOption == NSLayoutFormatDirectionRightToLeft) {
      layoutConstant = -layoutConstant;
    }
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:self.relation toItem:secondItem attribute:secondAttribute multiplier:self.layoutMultiplier constant:layoutConstant];
    constraint.priority = self.layoutPriority;
    _resultConstraint = constraint;
  }
  return _resultConstraint;
}

- (NSArray *)resultConstraints {
  return @[self.resultConstraint];
}

@end
