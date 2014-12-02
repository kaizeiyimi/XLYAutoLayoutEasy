//
//  XLYViewAttribute.m
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYViewAttribute.h"

#import "XLAutoLayoutEasyPrivate.h"

@implementation XLYViewAttribute

- (XLYConstraint *(^)(id))equalTo {
    return ^XLYConstraint *(id attr) {
        return [self equalTo:attr];
    };
}

- (XLYConstraint *(^)(id))greaterThanOrEqualTo {
    return ^XLYConstraint *(id attr) {
        return [self greaterThanOrEqualTo:attr];
    };
}

- (XLYConstraint *(^)(id))lessThanOrEqualTo {
    return ^XLYConstraint *(id attr) {
        return [self lessThanOrEqualTo:attr];
    };
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

- (XLYConstraint *)equalTo:(id)attr
{
    return [self makeRelation:NSLayoutRelationEqual toOther:attr];
}

- (XLYConstraint *)greaterThanOrEqualTo:(id)attr
{
    return [self makeRelation:NSLayoutRelationGreaterThanOrEqual toOther:attr];
}

- (XLYConstraint *)lessThanOrEqualTo:(id)attr
{
    return [self makeRelation:NSLayoutRelationLessThanOrEqual toOther:attr];
}

- (XLYConstraint *)equalToConstant:(CGFloat)constant
{
    return [self equalTo:@(constant)];
}

- (XLYConstraint *)greaterThanOrEqualToConstant:(CGFloat)constant
{
    return [self greaterThanOrEqualTo:@(constant)];
}

- (XLYConstraint *)lessThanOrEqualToConstant:(CGFloat)constant
{
    return [self lessThanOrEqualTo:@(constant)];
}

- (XLYConstraint *)makeRelation:(NSLayoutRelation)relation toOther:(id)other
{
    XLYConstraint *xlyConstraint = [XLYConstraint new];
    xlyConstraint.firstViewAttribute = self;
    xlyConstraint.relation = relation;
    xlyConstraint.secondAttribute = other;
    [UIView xly_addRawConstraint:xlyConstraint];
    return xlyConstraint;
}

@end
