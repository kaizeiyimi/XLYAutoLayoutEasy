//
//  XLYALECocoaExtension.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import "XLYALECocoaExtension.h"
#import "XLYALEGeneration.h"
#import "XLYALEPrivate.h"


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



@implementation UIView (XLYALESupport)

- (id<XLYALERelationMakeable>(^)(NSLayoutAttribute attr))xly_layoutAttribute {
    return ^id<XLYALERelationMakeable>(NSLayoutAttribute attr) {
        return [[XLYALEAttribute alloc] initWithItem:self attr:attr];
    };
}

- (NSArray<XLYALERelationMakeable> *)xly_size {
    return (NSArray<XLYALERelationMakeable> *)@[self.xly_layoutAttribute(NSLayoutAttributeWidth),
                                                self.xly_layoutAttribute(NSLayoutAttributeHeight)];
}

- (NSArray<XLYALERelationMakeable> *)xly_center {
    return (NSArray<XLYALERelationMakeable> *)@[self.xly_layoutAttribute(NSLayoutAttributeCenterX),
                                                self.xly_layoutAttribute(NSLayoutAttributeCenterY)];
}

- (NSArray<XLYALERelationMakeable> *)xly_edge {
    return (NSArray<XLYALERelationMakeable> *)@[self.xly_layoutAttribute(NSLayoutAttributeTop),
                                                self.xly_layoutAttribute(NSLayoutAttributeLeading),
                                                self.xly_layoutAttribute(NSLayoutAttributeBottom),
                                                self.xly_layoutAttribute(NSLayoutAttributeTrailing)];
}

- (NSArray<XLYALERelationMakeable> *)xly_edgeLR {
    return (NSArray<XLYALERelationMakeable> *)@[self.xly_layoutAttribute(NSLayoutAttributeTop),
                                                self.xly_layoutAttribute(NSLayoutAttributeLeft),
                                                self.xly_layoutAttribute(NSLayoutAttributeBottom),
                                                self.xly_layoutAttribute(NSLayoutAttributeRight)];
}

@end



@interface XLYALELayoutGuideWrapper : NSObject <XLYALELayoutGuideWrapper>

@property (nonatomic, strong) id<UILayoutSupport> guide;

@end

@implementation XLYALELayoutGuideWrapper

- (instancetype)initWithGuide:(id<UILayoutSupport>)guide {
    if (self = [super init]) {
        self.guide = guide;
    }
    return self;
}

- (id<XLYALERelationMakeable>)xly_top {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeTop];
}

- (id<XLYALERelationMakeable>)xly_bottom {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeBottom];
}

- (id<XLYALERelationMakeable>)xly_height {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeHeight];
}

@end



@implementation UIViewController (XLYALESupport)

- (id<XLYALELayoutGuideWrapper>)xly_topGuide {
    return [[XLYALELayoutGuideWrapper alloc] initWithGuide:self.topLayoutGuide];
}
- (id<XLYALELayoutGuideWrapper>)xly_bottomGuide {
    return [[XLYALELayoutGuideWrapper alloc] initWithGuide:self.bottomLayoutGuide];
}

@end