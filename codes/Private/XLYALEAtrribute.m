//
//  XLYALEAttribute.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import "XLYALEAtrribute.h"
#import "XLYALEPrivate.h"
#import "XLYALEGeneration.h"


@implementation XLYALEAttribute

- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr {
    if (self == [super init]) {
        self.item = item;
        self.attr = attr;
    }
    return self;
}

@end


@implementation XLYALEAttribute (XLYALERelationMakeableSupport)

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))ale_equal {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))ale_lessOrEqual {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationLessThanOrEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))ale_greaterOrEqual {
    return ^NSLayoutConstraint *(id<XLYALEAttributeContainer> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationGreaterThanOrEqual second:other];
    };
}

- (NSLayoutConstraint *)ale_equal:(id<XLYALEAttributeContainer>)other {
    return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationEqual second:other];
}

- (NSLayoutConstraint *)ale_lessOrEqual:(id<XLYALEAttributeContainer>)other {
    return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationLessThanOrEqual second:other];
}

- (NSLayoutConstraint *)ale_greaterOrEqual:(id<XLYALEAttributeContainer>)other {
    return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationGreaterThanOrEqual second:other];
}

- (XLYALEAttributeX *(^)(CGFloat))ale_c {
    return ^XLYALEAttributeX *(CGFloat c) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self ale_generateX] constant:c];
    };
}

- (XLYALEAttributeX *(^)(CGFloat))ale_m {
    return ^XLYALEAttributeX *(CGFloat m) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self ale_generateX] multiplier:m];
    };
}

- (XLYALEAttributeX *(^)(UILayoutPriority))ale_p {
    return ^XLYALEAttributeX *(UILayoutPriority p) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:[self ale_generateX] priority:p];
    };
}

- (XLYALEAttributeX *)ale_generateX {
    return [[XLYALEAttributeX alloc] initWithItem:self.item attr:self.attr];
}

@end


@implementation XLYALEAttributeX

- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr {
    return [self initWithItem:item attr:attr constant:0 multiplier:1 priority:UILayoutPriorityRequired];
}

- (instancetype)initWithItem:(id)item
                        attr:(NSLayoutAttribute)attr
                    constant:(CGFloat)constant
                  multiplier:(CGFloat)multiplier
                    priority:(UILayoutPriority)priority {
    if (self = [super init]) {
        self.item = item;
        self.attr = attr;
        self.constant = constant;
        self.multiplier = multiplier;
        self.priority = priority;
    }
    return self;
}

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute {
    return [self initWithItem:attribute.item attr:attribute.attr constant:attribute.constant multiplier:attribute.multiplier priority:attribute.priority];
}

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute constant:(CGFloat)constant {
    return [self initWithItem:attribute.item attr:attribute.attr constant:constant multiplier:attribute.multiplier priority:attribute.priority];
}

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute multiplier:(CGFloat)multiplier {
    return [self initWithItem:attribute.item attr:attribute.attr constant:attribute.constant multiplier:multiplier priority:attribute.priority];
}

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute priority:(UILayoutPriority)priority {
    return [self initWithItem:attribute.item attr:attribute.attr constant:attribute.constant multiplier:attribute.multiplier priority:priority];
}

@end


@implementation XLYALEAttributeX (XLYALEAttributeContainerSupport)

- (XLYALEAttributeX *(^)(CGFloat))ale_c {
    return ^XLYALEAttributeX *(CGFloat c) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:self constant:c];
    };
}

- (XLYALEAttributeX *(^)(CGFloat))ale_m {
    return ^XLYALEAttributeX *(CGFloat m) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:self multiplier:m];
    };
}

- (XLYALEAttributeX *(^)(UILayoutPriority))ale_p {
    return ^XLYALEAttributeX *(UILayoutPriority p) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:self priority:p];
    };
}

- (XLYALEAttributeX *)ale_generateX {
    return [[XLYALEAttributeX alloc] initWithAttributeX:self constant:self.constant];
}

@end
