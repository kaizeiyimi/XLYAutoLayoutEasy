//
//  NSLayoutConstraint+XLYAutoLayoutAddition.m
//
//  Created by kaizei on 14/11/22.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "NSLayoutConstraint+XLYAutoLayoutAddition.h"

#import "XLAutoLayoutEasyPrivate.h"
#import "UIView+XLYAutoLayoutAddition.h"

@implementation NSLayoutConstraint (XLYAutoLayoutAddition)

- (void)xly_install
{
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

- (void)xly_uninstall
{
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

- (EXLYConstraintSimilarState)xly_similarStateWithConstraint:(NSLayoutConstraint *)theConstraint
{
    // apple says:  'priority' property may only be modified as part of initial set up.  An exception will be thrown if it is set after a constraint has been added to a view.
    // But it really can be modified after added to a view as long as the priority is not required. you can change priority from a to b where a and b are both less than 1000, and no exception will be throw.
    // but here we respect to the doc, modify the priority is not allowed in my codes. you can still modify priority out of my codes.

        if (self.firstItem == theConstraint.firstItem && self.secondItem == theConstraint.secondItem) {
            if (self.firstAttribute != theConstraint.firstAttribute) return EXLYConstraintNotSimilar;
            if (self.secondAttribute != theConstraint.secondAttribute) return EXLYConstraintNotSimilar;
            if (fabsf(self.multiplier - theConstraint.multiplier) > 1e-6) return EXLYConstraintNotSimilar;
            if (self.relation != theConstraint.relation) return EXLYConstraintNotSimilar;
            if (self.priority != theConstraint.priority) return EXLYConstraintNotSimilar;
            return EXLYConstraintSimilar;
        } else if (self.firstItem == theConstraint.secondItem && self.secondItem == theConstraint.firstItem) {
            if (self.firstAttribute != theConstraint.secondAttribute) return EXLYConstraintNotSimilar;
            if (self.secondAttribute != theConstraint.firstAttribute) return EXLYConstraintNotSimilar;
            if (fabsf(self.multiplier * theConstraint.multiplier - 1.0f) > 1e-6) return EXLYConstraintNotSimilar;
            if (self.priority != theConstraint.priority) return EXLYConstraintNotSimilar;
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

@end
