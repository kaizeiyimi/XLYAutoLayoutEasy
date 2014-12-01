//
//  UIView+XLYAutoLayoutAddition.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "UIView+XLYAutoLayoutAddition.h"

#import <objc/runtime.h>
#import "XLAutoLayoutEasyPrivate.h"
#import "NSLayoutConstraint+XLYAutoLayoutAddition.h"

@implementation UIView (XLYAutoLayoutAddition)

- (XLYViewAttribute *(^)(NSLayoutAttribute))layoutAttribute {
    return ^XLYViewAttribute *(NSLayoutAttribute attr) {
        XLYViewAttribute *viewAttribute = [XLYViewAttribute new];
        viewAttribute.view = self;
        viewAttribute.ns_layoutAttribute = attr;
        return viewAttribute;
    };
}

- (XLYViewAttribute *)layoutTop {
    return self.layoutAttribute(NSLayoutAttributeTop);
}

- (XLYViewAttribute *)layoutLeft {
    return self.layoutAttribute(NSLayoutAttributeLeft);
}

- (XLYViewAttribute *)layoutRight {
    return self.layoutAttribute(NSLayoutAttributeRight);
}

- (XLYViewAttribute *)layoutBottom {
    return self.layoutAttribute(NSLayoutAttributeBottom);
}

- (XLYViewAttribute *)layoutLeading {
    return self.layoutAttribute(NSLayoutAttributeLeading);
}

- (XLYViewAttribute *)layoutTrailing {
    return self.layoutAttribute(NSLayoutAttributeTrailing);
}

- (XLYViewAttribute *)layoutHeight {
    return self.layoutAttribute(NSLayoutAttributeHeight);
}

- (XLYViewAttribute *)layoutWidth {
    return self.layoutAttribute(NSLayoutAttributeWidth);
}

- (XLYViewAttribute *)layoutCenterX {
    return self.layoutAttribute(NSLayoutAttributeCenterX);
}

- (XLYViewAttribute *)layoutCenterY {
    return self.layoutAttribute(NSLayoutAttributeCenterY);
}

- (XLYViewAttribute *)layoutBaseLine {
    return self.layoutAttribute(NSLayoutAttributeBaseline);
}

- (XLYViewAttribute *)layoutLastBaseLine {
    return self.layoutAttribute(NSLayoutAttributeLastBaseline);
}

- (XLYViewAttribute *)layoutFirstBaseLine {
    return self.layoutAttribute(NSLayoutAttributeFirstBaseline);
}

- (XLYViewAttribute *)layoutTopMargin {
    return self.layoutAttribute(NSLayoutAttributeTopMargin);
}

- (XLYViewAttribute *)layoutLeftMargin {
    return self.layoutAttribute(NSLayoutAttributeLeftMargin);
}

- (XLYViewAttribute *)layoutBottomMargin {
    return self.layoutAttribute(NSLayoutAttributeBottomMargin);
}

- (XLYViewAttribute *)layoutRightMargin {
    return self.layoutAttribute(NSLayoutAttributeRightMargin);
}

- (XLYViewAttribute *)layoutLeadingMargin {
    return self.layoutAttribute(NSLayoutAttributeLeadingMargin);
}

- (XLYViewAttribute *)layoutTrailingMargin {
    return self.layoutAttribute(NSLayoutAttributeTrailingMargin);
}

- (XLYViewAttribute *)layoutCenterXWithinMargins {
    return self.layoutAttribute(NSLayoutAttributeCenterXWithinMargins);
}

- (XLYViewAttribute *)layoutCenterYWithinMargins {
    return self.layoutAttribute(NSLayoutAttributeCenterYWithinMargins);
}

- (XLYViewAttribute *)layoutNone {
    return self.layoutAttribute(NSLayoutAttributeNotAnAttribute);
}

#pragma mark -
static BOOL __XLYShouldCountConstraint = NO;
+ (void)xly_addRawConstraint:(XLYConstraint *)constraint
{
    if (__XLYShouldCountConstraint) {
        [[self xly_constraintsToBeAdded] addObject:constraint];
    }
}

+ (NSMutableArray *)xly_constraintsToBeAdded
{
    static NSMutableArray *constraintsToBeAdded = nil;
    if (!constraintsToBeAdded) {
        constraintsToBeAdded = [NSMutableArray array];
    }
    return constraintsToBeAdded;
}

+ (NSArray *)makeConstraints:(dispatch_block_t)block
{
    NSMutableArray *constraints = [NSMutableArray array];
    if (block) {
        __XLYShouldCountConstraint = YES;
        block();
        for (XLYConstraint *xlyConstraint in [self xly_constraintsToBeAdded]) {
            NSLayoutConstraint *constraint = xlyConstraint.resultConstraint;
            [constraint xly_install];
            [constraints addObject:constraint];
        }
        [[self xly_constraintsToBeAdded] removeAllObjects];
        __XLYShouldCountConstraint = NO;
    }
    return constraints;
}

+ (NSArray *)updateConstraints:(dispatch_block_t)block
{
    NSMutableArray *constraints = [NSMutableArray array];
    if (block) {
        __XLYShouldCountConstraint = YES;
        block();
        for (XLYConstraint *xlyConstraint in [self xly_constraintsToBeAdded]) {
            NSLayoutConstraint *constraint = xlyConstraint.resultConstraint;
            EXLYConstraintSimilarState state;
            NSLayoutConstraint *similarContraint = [UIView xly_similarConstraintsWithConstraint:constraint similarState:&state];
            if (similarContraint) {
                if (state == EXLYConstraintSimilar) {
                    similarContraint.constant = constraint.constant;
                } else if (state == EXLYConstraintReverseSimilar) {
                    similarContraint.constant = -constraint.constant*similarContraint.multiplier;
                }
                [constraints addObject:similarContraint];
            } else {
                [constraint xly_install];
                [constraints addObject:constraint];
            }
        }
        [[self xly_constraintsToBeAdded] removeAllObjects];
        __XLYShouldCountConstraint = YES;
    }
    return constraints;
}

+ (NSArray *)remakeConstraints:(dispatch_block_t)block
{
    NSMutableArray *constraints = [NSMutableArray array];
    if (block) {
        __XLYShouldCountConstraint = YES;
        block();
        NSMutableSet *relatedViews = [NSMutableSet set];
        for (XLYConstraint *xlyConstraint in [self xly_constraintsToBeAdded]) {
            [relatedViews addObject:xlyConstraint.firstViewAttribute.view];
        }
        for (UIView *view in relatedViews) {
            for (NSLayoutConstraint *constraint in [view xly_associatedNormalConstraints]) {
                if (constraint.firstItem == view) {
                    [constraint xly_uninstall];   
                }
            }
        }
        for (XLYConstraint *xlyConstraint in [self xly_constraintsToBeAdded]) {
            NSLayoutConstraint *constraint = xlyConstraint.resultConstraint;
            [constraint xly_install];
            [constraints addObject:constraint];
        }
        [[self xly_constraintsToBeAdded] removeAllObjects];
        __XLYShouldCountConstraint = YES;
    }
    return constraints;
}

#pragma mark -
- (UIView *)xly_closestCommonSuperviewWithView:(UIView *)view
{
    if (!view) {
        return self;
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

+ (UIView *)xly_ClosestCommonSuperviewForView1:(UIView *)view1 view2:(UIView *)view2
{
    return [view1 xly_closestCommonSuperviewWithView:view2];
}

- (NSArray *)xly_associatedConstraints
{
    NSMutableArray *constraints = [NSMutableArray array];
    UIView *view = self;
    while (view) {
        for (NSLayoutConstraint *constraint in view.constraints) {
            if (constraint.firstItem == self || constraint.secondItem == self) {
                [constraints addObject:constraint];
            }
        }
        view = view.superview;
    }
    return constraints;
}

- (NSArray *)xly_associatedNormalConstraints
{
    return [[self xly_associatedConstraints] filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(NSLayoutConstraint *constraint, NSDictionary *bindings) {
        if ([NSStringFromClass(constraint.class) isEqualToString:@"NSContentSizeLayoutConstraint"]) {
            return NO;
        }
        return YES;
    }]];
}

+ (NSLayoutConstraint *)xly_similarConstraintsWithConstraint:(NSLayoutConstraint *)theConstraint similarState:(EXLYConstraintSimilarState *)stateRef
{
    UIView *commonSuperView = [self xly_ClosestCommonSuperviewForView1:theConstraint.firstItem view2:theConstraint.secondItem];
    while (commonSuperView) {
        for (NSLayoutConstraint *constraint in commonSuperView.constraints.reverseObjectEnumerator) {
            if ([NSStringFromClass(constraint.class) isEqualToString:@"NSContentSizeLayoutConstraint"]) continue;
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
