//
//  XLYConstraint.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/21.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYConstraint.h"
#import "XLAutoLayoutEasyPrivate.h"

@interface XLYConstraint ()

@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) float layoutPriority;
@property (nonatomic, assign) CGFloat constant;

@property (nonatomic, strong) NSLayoutConstraint *constraint;

@end

@implementation XLYConstraint

- (instancetype)init
{
    if (self = [super init]) {
        self.layoutMultiplier = 1.0;
        self.layoutPriority = UILayoutPriorityRequired;
        self.constant = 0.0;
    }
    return self;
}

- (XLYConstraint *(^)(float))priority {
    return ^XLYConstraint *(float thePriority) {
        return [self priority:thePriority];
    };
}

- (XLYConstraint *(^)(CGFloat))multipliedBy {
    return ^XLYConstraint *(CGFloat multiplier) {
        return [self multipliedBy:multiplier];
    };
}

- (XLYConstraint *(^)(id))offset {
    return ^XLYConstraint *(id attr) {
        return [self offset:attr];
    };
}

- (XLYConstraint *)priority:(float)priority
{
    self.layoutPriority = priority;
    return self;
}

- (XLYConstraint *)multipliedBy:(CGFloat)multiplier
{
    self.layoutMultiplier = multiplier;
    return self;
}

- (XLYConstraint *)offset:(id)offset
{
    NSAssert([offset isKindOfClass:NSNumber.class], @"offset must be 'NSNumber' value");
    self.constant = [offset doubleValue];
    return self;
}


- (NSLayoutConstraint *)resultConstraint
{
    if (!_constraint) {
        id firstItem = nil, secondItem = nil;
        NSLayoutAttribute firstAttribute = NSLayoutAttributeNotAnAttribute, secondAttribute = NSLayoutAttributeNotAnAttribute;
        
        firstItem = self.firstViewAttribute.view;
        firstAttribute = self.firstViewAttribute.ns_layoutAttribute;
        
        if ([self.secondAttribute isKindOfClass:XLYViewAttribute.class]) {
            secondItem = [self.secondAttribute view];
            secondAttribute = [self.secondAttribute ns_layoutAttribute];
        } else if ([self.secondAttribute isKindOfClass:UIView.class]) { //layoutGuide目前实现为UIVIew
            secondItem = self.secondAttribute;
            secondAttribute = firstAttribute;
        } else if ([self.secondAttribute isKindOfClass:NSNumber.class]) { //其他数值类型
            if (firstAttribute == NSLayoutAttributeWidth || firstAttribute == NSLayoutAttributeHeight) {
                self.constant = [self.secondAttribute doubleValue];
            } else {
                secondItem = [firstItem superview];
                secondAttribute = firstAttribute;
                self.constant = [self.secondAttribute doubleValue];
            }
        }
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:self.relation toItem:secondItem attribute:secondAttribute multiplier:self.layoutMultiplier constant:self.constant];
        constraint.priority = self.layoutPriority;
        _constraint = constraint;
    }
    return _constraint;
}

@end
