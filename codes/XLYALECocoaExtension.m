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



@implementation UIView (XLYALESupport)

- (id<XLYALERelationMakeable>(^)(NSLayoutAttribute attr))ale_attribute {
    return ^id<XLYALERelationMakeable>(NSLayoutAttribute attr) {
        return ale_attribute(self, attr);
    };
}

- (NSArray<XLYALERelationMakeable> *)ale_size {
    return (NSArray<XLYALERelationMakeable> *)@[ale_attribute(self, NSLayoutAttributeWidth),
                                                ale_attribute(self, NSLayoutAttributeHeight)];
}

- (NSArray<XLYALERelationMakeable> *)ale_center {
    return (NSArray<XLYALERelationMakeable> *)@[ale_attribute(self, NSLayoutAttributeCenterX),
                                                ale_attribute(self, NSLayoutAttributeCenterY)];
}

- (NSArray<XLYALERelationMakeable> *)ale_edge {
    return (NSArray<XLYALERelationMakeable> *)@[ale_attribute(self, NSLayoutAttributeTop),
                                                ale_attribute(self, NSLayoutAttributeLeading),
                                                ale_attribute(self, NSLayoutAttributeBottom),
                                                ale_attribute(self, NSLayoutAttributeTrailing)];
}

- (NSArray<XLYALERelationMakeable> *)ale_edgeLR {
    return (NSArray<XLYALERelationMakeable> *)@[ale_attribute(self, NSLayoutAttributeTop),
                                                ale_attribute(self, NSLayoutAttributeLeft),
                                                ale_attribute(self, NSLayoutAttributeBottom),
                                                ale_attribute(self, NSLayoutAttributeRight)];
    
}

- (id<XLYALERelationMakeable>)ale_left {
    return ale_attribute(self, NSLayoutAttributeLeft);
}

- (id<XLYALERelationMakeable>)ale_right {
    return ale_attribute(self, NSLayoutAttributeRight);
}

- (id<XLYALERelationMakeable>)ale_top {
    return ale_attribute(self, NSLayoutAttributeTop);
}

- (id<XLYALERelationMakeable>)ale_bottom {
    return ale_attribute(self, NSLayoutAttributeBottom);
}

- (id<XLYALERelationMakeable>)ale_leading {
    return ale_attribute(self, NSLayoutAttributeLeading);
}

- (id<XLYALERelationMakeable>)ale_trailing {
    return ale_attribute(self, NSLayoutAttributeTrailing);
}

- (id<XLYALERelationMakeable>)ale_width {
    return ale_attribute(self, NSLayoutAttributeWidth);
}

- (id<XLYALERelationMakeable>)ale_height {
    return ale_attribute(self, NSLayoutAttributeHeight);
}

- (id<XLYALERelationMakeable>)ale_centerX {
    return ale_attribute(self, NSLayoutAttributeCenterX);
}

- (id<XLYALERelationMakeable>)ale_centerY {
    return ale_attribute(self, NSLayoutAttributeCenterY);
}

- (id<XLYALERelationMakeable>)ale_baseline {
    return ale_attribute(self, NSLayoutAttributeBaseline);
}

- (id<XLYALERelationMakeable>)ale_firstBaseline {
    return ale_attribute(self, NSLayoutAttributeFirstBaseline);
}

- (id<XLYALERelationMakeable>)ale_leftMargin {
    return ale_attribute(self, NSLayoutAttributeLeftMargin);
}

- (id<XLYALERelationMakeable>)ale_rightMargin {
    return ale_attribute(self, NSLayoutAttributeRightMargin);
}

- (id<XLYALERelationMakeable>)ale_topMargin {
    return ale_attribute(self, NSLayoutAttributeTopMargin);
}

- (id<XLYALERelationMakeable>)ale_bottomMargin {
    return ale_attribute(self, NSLayoutAttributeBottomMargin);
}

- (id<XLYALERelationMakeable>)ale_leadingMargin {
    return ale_attribute(self, NSLayoutAttributeLeadingMargin);
}

- (id<XLYALERelationMakeable>)ale_trailingMargin {
    return ale_attribute(self, NSLayoutAttributeTrailingMargin);
}

- (id<XLYALERelationMakeable>)ale_centerXWithinMargins {
    return ale_attribute(self, NSLayoutAttributeCenterXWithinMargins);
}

- (id<XLYALERelationMakeable>)ale_centerYWithinMargins {
    return ale_attribute(self, NSLayoutAttributeCenterYWithinMargins);
}

@end
