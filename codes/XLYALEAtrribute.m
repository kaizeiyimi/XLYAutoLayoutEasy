//
//  XLYALEAttribute.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import "XLYALEAtrribute.h"
#import "XLYALEPrivate.h"


@implementation XLYALEAttribute

- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr {
    if (self == [super init]) {
        self.item = item;
        self.attr = attr;
    }
    return self;
}

@end

@implementation XLYALEAttribute (XLYALEAttributeContainerSupport)

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
    return [[XLYALEAttributeX alloc] initWithItem:self.item attr:self.attr];
}

@end


//@implementation XLYALEAttribute (XLYALERelationMakeableSupport)
//
//
//
//
//@end


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

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute constant:(CGFloat)constant {
    return [self initWithItem:attribute.item attr:attribute.attr constant:constant multiplier:1 priority:UILayoutPriorityRequired];
}

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute multiplier:(CGFloat)multiplier {
    return [self initWithItem:attribute.item attr:attribute.attr constant:0 multiplier:multiplier priority:UILayoutPriorityRequired];
}

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute priority:(UILayoutPriority)priority {
    return [self initWithItem:attribute.item attr:attribute.attr constant:0 multiplier:1 priority:priority];
}

@end


@implementation XLYALEAttributeX (XLYALEAttributeContainerSupport)

- (XLYALEAttributeX *(^)(CGFloat))c {
    return ^XLYALEAttributeX *(CGFloat c) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:self constant:c];
    };
}

- (XLYALEAttributeX *(^)(CGFloat))m {
    return ^XLYALEAttributeX *(CGFloat m) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:self multiplier:m];
    };
}

- (XLYALEAttributeX *(^)(UILayoutPriority))p {
    return ^XLYALEAttributeX *(UILayoutPriority p) {
        return [[XLYALEAttributeX alloc] initWithAttributeX:self priority:p];
    };
}

- (XLYALEAttributeX *)xly_generateX {
    return self;
}

@end
