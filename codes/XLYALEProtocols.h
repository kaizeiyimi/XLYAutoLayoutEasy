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

@protocol XLYALEAttributeContainer <NSObject>

/// change the **constant** of result constraint.
- (id<XLYALEAttributeContainer>(^)(CGFloat))ale_c;

/// change the **multiplier** of result constraint.
- (id<XLYALEAttributeContainer>(^)(CGFloat))ale_m;

/// change the **priority** of result constraint.
- (id<XLYALEAttributeContainer>(^)(UILayoutPriority))ale_p;

/// generate **XAttributeX** to construct constraint.
- (id<XLYALEAttributeContainer>)ale_generateX;

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
