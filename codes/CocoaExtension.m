//
//  CocoaExtension.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import "CocoaExtension.h"
#import "XLYALEGeneration.h"
#import "XLYALEAtrribute.h"


@implementation NSLayoutAnchor (XLYALERelationMakeableSupport)

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))equal {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))lessOrEqual {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationLessThanOrEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))greaterOrEqual {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationGreaterThanOrEqual second:other];
    };
}

- (XLYALEAttributeX *(^)(CGFloat))c {
    return ^XLYALEAttributeX *(CGFloat c) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self xly_generateX] constant:c];
    };
}

- (XLYALEAttributeX *(^)(CGFloat))m {
    return ^XLYALEAttributeX *(CGFloat m) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self xly_generateX] multiplier:m];
    };
}

- (XLYALEAttributeX *(^)(UILayoutPriority))p {
    return ^XLYALEAttributeX *(UILayoutPriority p) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self xly_generateX] priority:p];
    };
}

- (XLYALEAttributeX *)xly_generateX {
    return [[XLYALEAttributeX alloc] initWithItem:[self valueForKey:@"item"] attr:[[self valueForKey:@"attr"] integerValue]];
}


@end



@implementation NSNumber (XLYALERelationMakeableSupport)

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))equal {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))lessOrEqual {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationLessThanOrEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))greaterOrEqual {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationGreaterThanOrEqual second:other];
    };
}

- (XLYALEAttributeX *(^)(CGFloat))c {
    return ^XLYALEAttributeX *(CGFloat c) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self xly_generateX] constant:c];
    };
}

- (XLYALEAttributeX *(^)(CGFloat))m {
    return ^XLYALEAttributeX *(CGFloat m) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self xly_generateX] multiplier:m];
    };
}

- (XLYALEAttributeX *(^)(UILayoutPriority))p {
    return ^XLYALEAttributeX *(UILayoutPriority p) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self xly_generateX] priority:p];
    };
}

- (XLYALEAttributeX *)xly_generateX {
    return [[XLYALEAttributeX alloc] initWithAttributeX:[[XLYALEAttributeX alloc] initWithItem:nil attr:NSLayoutAttributeNotAnAttribute]
                                               constant:self.floatValue];
}

@end