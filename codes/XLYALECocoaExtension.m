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


@implementation NSLayoutAnchor (XLYALELeftItemSupport)

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
    return [[XLYALEAttribute alloc] initWithItem:[self valueForKey:@"item"] attr:[[self valueForKey:@"attr"] integerValue]];
}

- (XLYALEAttributeX *)ale_generateX {
    return [[XLYALEAttributeX alloc] initWithItem:[self valueForKey:@"item"] attr:[[self valueForKey:@"attr"] integerValue]];
}

@end



@implementation NSNumber (XLYALELeftItemSupport)

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

- (id<XLYALELeftItem>)ale_top {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeTop];
}

- (id<XLYALELeftItem>)ale_bottom {
    return [[XLYALEAttribute alloc] initWithItem:self.guide attr:NSLayoutAttributeBottom];
}

- (id<XLYALELeftItem>)ale_height {
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

- (NSArray<XLYALELeftItem> *)ale_size {
    return (NSArray<XLYALELeftItem> *)@[[[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeWidth],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeHeight]];
}

- (NSArray<XLYALELeftItem> *)ale_center {
    return (NSArray<XLYALELeftItem> *)@[[[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeCenterX],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeCenterY]];
}

- (NSArray<XLYALELeftItem> *)ale_edge {
    return (NSArray<XLYALELeftItem> *)@[[[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeTop],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeLeading],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeBottom],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeTrailing]];
}

- (NSArray<XLYALELeftItem> *)ale_edgeLR {
    return (NSArray<XLYALELeftItem> *)@[[[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeTop],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeLeft],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeBottom],
                                        [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeRight]];
    
}

- (id<XLYALELeftItem>)ale_left {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeLeft];
}

- (id<XLYALELeftItem>)ale_right {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeRight];
}

- (id<XLYALELeftItem>)ale_top {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeTop];
}

- (id<XLYALELeftItem>)ale_bottom {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeBottom];
}

- (id<XLYALELeftItem>)ale_leading {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeLeading];
}

- (id<XLYALELeftItem>)ale_trailing {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeTrailing];
}

- (id<XLYALELeftItem>)ale_width {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeWidth];
}

- (id<XLYALELeftItem>)ale_height {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeHeight];
}

- (id<XLYALELeftItem>)ale_centerX {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeCenterX];
}

- (id<XLYALELeftItem>)ale_centerY {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeCenterY];
}

- (id<XLYALELeftItem>)ale_baseline {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeBaseline];
}

- (id<XLYALELeftItem>)ale_firstBaseline {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeFirstBaseline];
}

- (id<XLYALELeftItem>)ale_leftMargin {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeLeftMargin];
}

- (id<XLYALELeftItem>)ale_rightMargin {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeRightMargin];
}

- (id<XLYALELeftItem>)ale_topMargin {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeTopMargin];
}

- (id<XLYALELeftItem>)ale_bottomMargin {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeBottomMargin];
}

- (id<XLYALELeftItem>)ale_leadingMargin {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeLeadingMargin];
}

- (id<XLYALELeftItem>)ale_trailingMargin {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeTrailingMargin];
}

- (id<XLYALELeftItem>)ale_centerXWithinMargins {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeCenterXWithinMargins];
}

- (id<XLYALELeftItem>)ale_centerYWithinMargins {
    return [[XLYALEAttribute alloc] initWithItem:self attr:NSLayoutAttributeCenterYWithinMargins];
}

@end
