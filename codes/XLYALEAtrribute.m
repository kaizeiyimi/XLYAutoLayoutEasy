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


@implementation XLYALEAttribute (XLYALELeftItemSupport)

- (NSLayoutConstraint *(^)(id<XLYALERightItem>))ale_equal {
    return ^NSLayoutConstraint *(id<XLYALERightItem> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALERightItem>))ale_lessOrEqual {
    return ^NSLayoutConstraint *(id<XLYALERightItem> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationLessThanOrEqual second:other];
    };
}

- (NSLayoutConstraint *(^)(id<XLYALERightItem>))ale_greaterOrEqual {
    return ^NSLayoutConstraint *(id<XLYALERightItem> other) {
        return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationGreaterThanOrEqual second:other];
    };
}

- (NSLayoutConstraint *)ale_equal:(id<XLYALERightItem>)other {
    return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationEqual second:other];
}

- (NSLayoutConstraint *)ale_lessOrEqual:(id<XLYALERightItem>)other {
    return [XLYALEContext constraintWithFirst:self relation:NSLayoutRelationLessThanOrEqual second:other];
}

- (NSLayoutConstraint *)ale_greaterOrEqual:(id<XLYALERightItem>)other {
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

- (XLYALEAttribute *)ale_generate {
    return [[XLYALEAttribute alloc] initWithItem:self.item attr:self.attr];
}

- (XLYALEAttributeX *)ale_generateX {
    return [[XLYALEAttributeX alloc] initWithItem:self.item attr:self.attr];
}

@end


@implementation XLYALEAttributeX

- (instancetype)initWithLeftItem:(id<XLYALELeftItem>)leftItem {
    XLYALEAttribute *attribute = [leftItem ale_generate];
    return [self initWithItem: attribute.item attr: attribute.attr];
}

- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr {
    return [self initWithItem:item attr:attr constant:0 multiplier:1 priority:UILayoutPriorityRequired];
}

- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr constant:(CGFloat)constant {
    return [self initWithItem:item attr:attr constant:constant multiplier:1 priority:UILayoutPriorityRequired];
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


@implementation XLYALEAttributeX (XLYALERightItemSupport)

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
