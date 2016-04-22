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
    return [[XLYALEAttributeX alloc] initWithItem:[self valueForKey:@"item"] attr:[[self valueForKey:@"attr"] integerValue]];
}

@end



@implementation NSNumber (XLYALERelationMakeableSupport)

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
    return [[XLYALEAttributeX alloc] initWithAttributeX:[[XLYALEAttributeX alloc] initWithItem:nil attr:NSLayoutAttributeNotAnAttribute]
                                               constant:self.floatValue];
}

@end



@implementation UIView (XLYALESupport)

- (id<XLYALERelationMakeable>(^)(NSLayoutAttribute attr))ale_layoutAttribute {
    return ^id<XLYALERelationMakeable>(NSLayoutAttribute attr) {
        return [[XLYALEAttribute alloc] initWithItem:self attr:attr];
    };
}

- (NSArray<XLYALERelationMakeable> *)ale_size {
    return (NSArray<XLYALERelationMakeable> *)@[self.ale_layoutAttribute(NSLayoutAttributeWidth),
                                                self.ale_layoutAttribute(NSLayoutAttributeHeight)];
}

- (NSArray<XLYALERelationMakeable> *)ale_center {
    return (NSArray<XLYALERelationMakeable> *)@[self.ale_layoutAttribute(NSLayoutAttributeCenterX),
                                                self.ale_layoutAttribute(NSLayoutAttributeCenterY)];
}

- (NSArray<XLYALERelationMakeable> *)ale_edge {
    return (NSArray<XLYALERelationMakeable> *)@[self.ale_layoutAttribute(NSLayoutAttributeTop),
                                                self.ale_layoutAttribute(NSLayoutAttributeLeading),
                                                self.ale_layoutAttribute(NSLayoutAttributeBottom),
                                                self.ale_layoutAttribute(NSLayoutAttributeTrailing)];
}

- (NSArray<XLYALERelationMakeable> *)ale_edgeLR {
    return (NSArray<XLYALERelationMakeable> *)@[self.ale_layoutAttribute(NSLayoutAttributeTop),
                                                self.ale_layoutAttribute(NSLayoutAttributeLeft),
                                                self.ale_layoutAttribute(NSLayoutAttributeBottom),
                                                self.ale_layoutAttribute(NSLayoutAttributeRight)];
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

- (id<XLYALERelationMakeable>)ale_top {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeTop];
}

- (id<XLYALERelationMakeable>)ale_bottom {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeBottom];
}

- (id<XLYALERelationMakeable>)ale_height {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeHeight];
}

@end



@implementation UIViewController (XLYALESupport)

- (id<XLYALELayoutGuideWrapper>)ale_topGuide {
    return [[XLYALELayoutGuideWrapper alloc] initWithGuide:self.topLayoutGuide];
}
- (id<XLYALELayoutGuideWrapper>)ale_bottomGuide {
    return [[XLYALELayoutGuideWrapper alloc] initWithGuide:self.bottomLayoutGuide];
}

@end