//
//  XLYALEAtrribute.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLYALEProtocols.h"


NS_ASSUME_NONNULL_BEGIN

@interface XLYALEAttribute : NSObject

@property(nonatomic, readonly, strong) id item;
@property(nonatomic, readonly, assign) NSLayoutAttribute attr;

- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr;

@end

@interface XLYALEAttributeX : NSObject

@property(nullable, nonatomic, readonly, strong) id item;
@property(nonatomic, readonly, assign) NSLayoutAttribute attr;

@property(nonatomic, readonly, assign) CGFloat constant;
@property(nonatomic, readonly, assign) CGFloat multiplier;
@property(nonatomic, readonly, assign) UILayoutPriority priority;

- (instancetype)initWithItem:(nullable id)item attr:(NSLayoutAttribute)attr;
- (instancetype)initWithItem:(nullable id)item
                        attr:(NSLayoutAttribute)attr
                    constant:(CGFloat)constant
                  multiplier:(CGFloat)multiplier
                    priority:(UILayoutPriority)priority;

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute;
- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute constant:(CGFloat)constant;
- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute multiplier:(CGFloat)multiplier;
- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute priority:(UILayoutPriority)priority;

@end


@interface XLYALEAttribute (XLYALERelationMakeableSupport) <XLYALERelationMakeable>
@end


@interface XLYALEAttributeX (XLYALEAttributeContainerSupport) <XLYALEAttributeContainer>
@end

NS_ASSUME_NONNULL_END