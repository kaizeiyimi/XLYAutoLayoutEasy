//
//  NSLayoutConstraint+XLYAutoLayoutAddition.m
//
//  Created by kaizei on 14/11/22.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "NSLayoutConstraint+XLYAutoLayoutAddition.h"

#import <objc/runtime.h>
#import "XLYAutoLayoutEasyPrivate.h"
#import "UIView+XLYAutoLayoutAddition.h"

#pragma mark - helper
@interface XLYLayoutConstraintsHelper : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *rawConstraints;
@property (nonatomic, assign, readonly) NSLayoutFormatOptions directionOption;

+ (instancetype)appendNewHelperWithDirection:(NSLayoutFormatOptions)directOption;
+ (instancetype)currentHelper;
+ (void)removeLastHelper;

- (void)addRawConstraint:(id<XLYConstraintsGenerationProtocol>)rawConstraint;

@end


#pragma mark - constraint similiar state enum
typedef NS_ENUM(NSInteger, EXLYConstraintSimilarState) {
  EXLYConstraintNotSimilar,
  EXLYConstraintSimilar,
  EXLYConstraintReverseSimilar
};


#pragma mark - NSLayoutConstraint - XLYAutoLayoutAddition
@implementation NSLayoutConstraint (XLYAutoLayoutAddition)

+ (void)xly_setReplaceDescription {
  static BOOL changed = NO;
  if (changed) {
    return;
  }
  Method method = class_getInstanceMethod([NSLayoutConstraint class], @selector(xly_description));
  Method originMethod = class_getInstanceMethod([NSLayoutConstraint class], @selector(description));
  method_exchangeImplementations(method, originMethod);
  changed = YES;
}

- (NSString *)xly_description {
  
  if (![self isMemberOfClass:[NSLayoutConstraint class]]) {
    return [self xly_description];
  }
  
  static NSDictionary *attributeMap = nil;
  static NSDictionary *relationMap = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    attributeMap = @{
                     @(NSLayoutAttributeLeft):@"left",
                     @(NSLayoutAttributeRight):@"right",
                     @(NSLayoutAttributeTop):@"top",
                     @(NSLayoutAttributeBottom):@"bottom",
                     @(NSLayoutAttributeLeading):@"leading",
                     @(NSLayoutAttributeTrailing):@"trailing",
                     @(NSLayoutAttributeWidth):@"width",
                     @(NSLayoutAttributeHeight):@"height",
                     @(NSLayoutAttributeCenterX):@"centerX",
                     @(NSLayoutAttributeCenterY):@"centerY",
                     @(NSLayoutAttributeBaseline):@"baseline",
                     
                     @(NSLayoutAttributeFirstBaseline):@"firstBaseline",
                     @(NSLayoutAttributeLeftMargin):@"leftMargin",
                     @(NSLayoutAttributeRightMargin):@"rightMargin",
                     @(NSLayoutAttributeTopMargin):@"topMargin",
                     @(NSLayoutAttributeBottomMargin):@"bottomMargin",
                     @(NSLayoutAttributeLeadingMargin):@"leadingMargin",
                     @(NSLayoutAttributeTrailingMargin):@"trailingMargin",
                     @(NSLayoutAttributeCenterXWithinMargins):@"centerXWithinMargins",
                     @(NSLayoutAttributeCenterYWithinMargins):@"centerYWithinMargins",
                     };
    relationMap = @{
                    @(NSLayoutRelationEqual):@"==",
                    @(NSLayoutRelationLessThanOrEqual):@"<=",
                    @(NSLayoutRelationGreaterThanOrEqual):@">=",
                    };
  });
  
  NSMutableString *description = [[NSMutableString alloc] init];
  [description appendFormat:@"<%@:%p ", NSStringFromClass([self class]), self];
  // first item
  [description appendFormat:@"[%@", NSStringFromClass([self.firstItem class])];
  if ([self.firstItem xly_debugName]) {
    [description appendFormat:@"(%@)", [self.firstItem xly_debugName]];
  }
  [description appendFormat:@":%p]", self.firstItem];
  [description appendFormat:@".%@", attributeMap[@(self.firstAttribute)]];
  
  // relation
  [description appendFormat:@" %@ ", relationMap[@(self.relation)]];
  
  // multiplier
  if (self.multiplier != 1) {
    [description appendFormat:@"%g * ", self.multiplier];
  }
  
  //second item
  if (self.secondItem) {
    [description appendFormat:@"[%@", NSStringFromClass([self.secondItem class])];
    if ([self.secondItem xly_debugName]) {
      [description appendFormat:@"(%@)", [self.secondItem xly_debugName]];
    }
    [description appendFormat:@":%p]", self.secondItem];
    [description appendFormat:@".%@", attributeMap[@(self.secondAttribute)]];
  }
  
  // constant
  if (self.constant != 0) {
    if (self.secondItem) {
      [description appendString: self.constant > 0 ? @" + " : @" - "];
    }
    [description appendFormat:@"%g", fabs(self.constant)];
  } else {
    if (!self.secondItem) {
      [description appendString:@"0"];
    }
  }
  
  // priority
  if (self.priority < UILayoutPriorityRequired) {
    [description appendFormat:@", priority:%g", self.priority];
  }
  [description appendString:@">"];
  //TODO: not finish yet
  return description;
}

- (void)xly_install {
  if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
    self.active = YES;
  } else {
    UIView *commonSuperView = self.firstItem;
    if (self.secondItem) {
      commonSuperView = [UIView xly_ClosestCommonSuperviewForView1:self.firstItem view2:self.secondItem];
      NSAssert(commonSuperView, @"must have a common superview of %@ and %@ to add the constraint %@.", self.firstItem, self.secondItem, self);
    }
    [commonSuperView addConstraint:self];
  }
}

- (void)xly_uninstall {
  if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
    self.active = NO;
  } else {
    UIView *commonSuperView = self.firstItem;
    if (self.secondItem) {
      commonSuperView = [UIView xly_ClosestCommonSuperviewForView1:self.firstItem view2:self.secondItem];
    }
    while (commonSuperView) {
      if ([commonSuperView.constraints containsObject:self]) {
        [commonSuperView removeConstraint:self];
        break;
      } else {
        commonSuperView = commonSuperView.superview;
      }
    }
  }
}

#pragma mark -

- (EXLYConstraintSimilarState)xly_similarStateWithConstraint:(NSLayoutConstraint *)theConstraint {
  if (self.firstItem == theConstraint.firstItem && self.secondItem == theConstraint.secondItem) {
    if (self.firstAttribute != theConstraint.firstAttribute) return EXLYConstraintNotSimilar;
    if (self.secondAttribute != theConstraint.secondAttribute) return EXLYConstraintNotSimilar;
    if (self.relation != theConstraint.relation) return EXLYConstraintNotSimilar;
//    if (fabs(self.multiplier - theConstraint.multiplier) > 1e-6) return EXLYConstraintNotSimilar;
//    if (self.priority != theConstraint.priority) return EXLYConstraintNotSimilar;
    return EXLYConstraintSimilar;
  } else if (self.firstItem == theConstraint.secondItem && self.secondItem == theConstraint.firstItem) {
    if (self.firstAttribute != theConstraint.secondAttribute) return EXLYConstraintNotSimilar;
    if (self.secondAttribute != theConstraint.firstAttribute) return EXLYConstraintNotSimilar;
//    if (fabs(self.multiplier * theConstraint.multiplier - 1.0f) > 1e-6) return EXLYConstraintNotSimilar;
//    if (self.priority != theConstraint.priority) return EXLYConstraintNotSimilar;
    //relation
    if (self.relation == NSLayoutRelationEqual) {
      if (theConstraint.relation != NSLayoutRelationEqual) {
        return EXLYConstraintNotSimilar;
      }
    } else if (self.relation == NSLayoutRelationGreaterThanOrEqual) {
      if (theConstraint.relation != NSLayoutRelationLessThanOrEqual) {
        return EXLYConstraintNotSimilar;
      }
    } else if (self.relation == NSLayoutRelationLessThanOrEqual) {
      if (theConstraint.relation != NSLayoutRelationGreaterThanOrEqual) {
        return EXLYConstraintNotSimilar;
      }
    }
    return EXLYConstraintReverseSimilar;
  }
  return EXLYConstraintNotSimilar;
}

#pragma mark -
+ (void)xly_addRawConstraint:(id<XLYConstraintsGenerationProtocol>)constraint {
  [[XLYLayoutConstraintsHelper currentHelper] addRawConstraint:constraint];
}

#pragma mark - make and update

+ (NSArray *)xly_make:(dispatch_block_t)block {
  return [self xly_makeWithDirection:NSLayoutFormatDirectionLeadingToTrailing
                                    constraints:block];
}

+ (NSArray *)xly_makeWithDirection:(NSLayoutFormatOptions)directionOption
                       constraints:(dispatch_block_t)block {
  return [self xly_makeWithDirection:directionOption autoActive:YES constraints:block];
}

+ (NSArray *)xly_makeWithDirection:(NSLayoutFormatOptions)directionOption
                        autoActive:(BOOL)autoActive
                       constraints:(dispatch_block_t)block {
  NSMutableArray *constrains = [[NSMutableArray alloc] init];
  if (block) {
    XLYLayoutConstraintsHelper *helper = [XLYLayoutConstraintsHelper appendNewHelperWithDirection:directionOption];
    block();
    for (id<XLYConstraintsGenerationProtocol> constraintsGenerator in helper.rawConstraints) {
      for ( NSLayoutConstraint *constraint in [constraintsGenerator resultConstraints]) {
        if (autoActive) {
          [constraint xly_install];
        }
        [constrains addObject:constraint];
      }
    }
    [XLYLayoutConstraintsHelper removeLastHelper];
  }
  return constrains;
}

+ (NSArray *)xly_update:(dispatch_block_t)block {
  return [self xly_updateWithDirection:NSLayoutFormatDirectionLeadingToTrailing
                                      constraints:block];
}

+ (NSArray *)xly_updateWithDirection:(NSLayoutFormatOptions)directionOption
                         constraints:(dispatch_block_t)block {
  NSMutableArray *constraints = [[NSMutableArray alloc] init];
  if (block) {
    XLYLayoutConstraintsHelper *helper = [XLYLayoutConstraintsHelper appendNewHelperWithDirection:directionOption];
    block();
    for (id<XLYConstraintsGenerationProtocol> constraintsGenerator in helper.rawConstraints) {
      for ( NSLayoutConstraint *constraint in [constraintsGenerator resultConstraints]) {
        EXLYConstraintSimilarState state;   // not really used yet
        NSLayoutConstraint *similarConstraint = [self xly_similarConstraintsWithConstraint:constraint similarState:&state];
        // replace the old one
        if (similarConstraint) {
          [similarConstraint xly_uninstall];
        }
        [constraint xly_install];
        [constraints addObject:constraint];
      }
    }
    [XLYLayoutConstraintsHelper removeLastHelper];
  }
  return constraints;
}

+ (NSLayoutConstraint *)xly_similarConstraintsWithConstraint:(NSLayoutConstraint *)theConstraint
                                                similarState:(EXLYConstraintSimilarState *)stateRef {
  UIView *commonSuperView = theConstraint.firstItem;
  if (theConstraint.secondItem) {
    commonSuperView = [UIView xly_ClosestCommonSuperviewForView1:theConstraint.firstItem view2:theConstraint.secondItem];
  }
  while (commonSuperView) {
    for (NSLayoutConstraint *constraint in commonSuperView.constraints.reverseObjectEnumerator) {
      EXLYConstraintSimilarState state = [theConstraint xly_similarStateWithConstraint:constraint];
      if (state != EXLYConstraintNotSimilar) {
        if (stateRef) {
          *stateRef = state;
        }
        return constraint;
      }
    }
    commonSuperView = commonSuperView.superview;
  }
  return nil;
}

@end


#pragma mark - XLYLayoutConstraintsHelper implementation

@implementation XLYLayoutConstraintsHelper

static NSMutableArray * __helpers = nil;

- (instancetype)initWithDirectionOption:(NSLayoutFormatOptions)directiOption {
  if (self = [super init]) {
    _rawConstraints = [NSMutableArray array];
    _directionOption = directiOption;
  }
  return self;
}

+ (instancetype)appendNewHelperWithDirection:(NSLayoutFormatOptions)directOption {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    __helpers = [NSMutableArray array];
  });
  XLYLayoutConstraintsHelper *helper = [[XLYLayoutConstraintsHelper alloc] initWithDirectionOption:directOption];
  [__helpers addObject:helper];
  return helper;
}

+ (instancetype)currentHelper {
  return __helpers.lastObject;
}

+ (void)removeLastHelper {
  [__helpers removeLastObject];
}

- (void)addRawConstraint:(id<XLYConstraintsGenerationProtocol>)rawConstraint {
  rawConstraint.directionOption = self.directionOption;
  [self.rawConstraints addObject:rawConstraint];
}

@end
