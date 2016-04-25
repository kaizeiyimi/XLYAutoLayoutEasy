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

@protocol XLYALERightItem <NSObject>

/// change the **constant** of result constraint.
- (XLYALEAttributeX *(^)(CGFloat))ale_c;

/// change the **multiplier** of result constraint.
- (XLYALEAttributeX *(^)(CGFloat))ale_m;

/// change the **priority** of result constraint.
- (XLYALEAttributeX *(^)(UILayoutPriority))ale_p;

/// generate **XAttributeX** to construct constraint.
- (XLYALEAttributeX *)ale_generateX;

@end


@protocol XLYALELeftItem <NSObject, XLYALERightItem>

- (NSLayoutConstraint *(^)(id<XLYALERightItem>))ale_equal;
- (NSLayoutConstraint *(^)(id<XLYALERightItem>))ale_lessOrEqual;
- (NSLayoutConstraint *(^)(id<XLYALERightItem>))ale_greaterOrEqual;

- (NSLayoutConstraint *)ale_equal:(id<XLYALERightItem>)other;
- (NSLayoutConstraint *)ale_lessOrEqual:(id<XLYALERightItem>)other;
- (NSLayoutConstraint *)ale_greaterOrEqual:(id<XLYALERightItem>)other;

/// generate **XAttribute** to construct constraint.
- (XLYALEAttribute *)ale_generate;

@end

NS_ASSUME_NONNULL_END

#endif /* XLYALEProtocols_h */
