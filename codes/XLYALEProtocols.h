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
- (XLYALEAttributeX *(^)(CGFloat))c;

/// change the **multiplier** of result constraint.
- (XLYALEAttributeX *(^)(CGFloat))m;

/// change the **priority** of result constraint.
- (XLYALEAttributeX *(^)(UILayoutPriority))p;

/// generate **XAttributeX** to construct constraint.
- (XLYALEAttributeX *)xly_generateX;

@end


@protocol XLYALERelationMakeable <NSObject, XLYALEAttributeContainer>

- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))equal;
- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))lessOrEqual;
- (NSLayoutConstraint *(^)(id<XLYALEAttributeContainer>))greaterOrEqual;

@end

NS_ASSUME_NONNULL_END

#endif /* XLYALEProtocols_h */
