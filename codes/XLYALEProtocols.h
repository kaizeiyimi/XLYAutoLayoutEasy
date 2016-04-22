//
//  XLYALEProtocols.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#ifndef XLYALEProtocols_h
#define XLYALEProtocols_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XLYALEAttribute, XLYALEAttributeX;

@protocol XLYALEAttributeContainer <NSObject>

/// change the **constant** of result constraint.
- (XLYALEAttributeX *(^)(CGFloat))ale_c;

/// change the **multiplier** of result constraint.
- (XLYALEAttributeX *(^)(CGFloat))ale_m;

/// change the **priority** of result constraint.
- (XLYALEAttributeX *(^)(UILayoutPriority))ale_p;

/// generate **XAttributeX** to construct constraint.
- (XLYALEAttributeX *)ale_generateX;

@end


@protocol XLYALERelationMakeable <NSObject, XLYALEAttributeContainer>

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))ale_equal;
- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))ale_lessOrEqual;
- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))ale_greaterOrEqual;

- (NSLayoutConstraint *)ale_equal:(id<XLYALEAttributeContainer>)other;
- (NSLayoutConstraint *)ale_lessOrEqual:(id<XLYALEAttributeContainer>)other;
- (NSLayoutConstraint *)ale_greaterOrEqual:(id<XLYALEAttributeContainer>)other;

@end

NS_ASSUME_NONNULL_END

#endif /* XLYALEProtocols_h */
