//
//  XLYALEPrivate.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#ifndef XLYALEPrivate_h
#define XLYALEPrivate_h

#import "XLYALEProtocols.h"
#import "XLYALEAtrribute.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLYALEAttribute ()

@property(nonatomic, strong) id item;
@property(nonatomic, assign) NSLayoutAttribute attr;

- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr;

@end


@interface XLYALEAttributeX ()

@property(nullable, nonatomic, strong) id item;
@property(nonatomic, assign) NSLayoutAttribute attr;

@property(nonatomic, assign) CGFloat constant;
@property(nonatomic, assign) CGFloat multiplier;
@property(nonatomic, assign) UILayoutPriority priority;

- (instancetype)initWithLeftItem:(id<XLYALELeftItem>)leftItem;
- (instancetype)initWithItem:(nullable id)item attr:(NSLayoutAttribute)attr;
- (instancetype)initWithItem:(id)item attr:(NSLayoutAttribute)attr constant:(CGFloat)constant;

- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute;
- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute constant:(CGFloat)constant;
- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute multiplier:(CGFloat)multiplier;
- (instancetype)initWithAttributeX:(XLYALEAttributeX *)attribute priority:(UILayoutPriority)priority;

- (instancetype)initWithItem:(nullable id)item
                        attr:(NSLayoutAttribute)attr
                    constant:(CGFloat)constant
                  multiplier:(CGFloat)multiplier
                    priority:(UILayoutPriority)priority;

@end


@interface XLYALEContext: NSObject

+ (NSLayoutConstraint *)constraintWithFirst:(id<XLYALELeftItem>)first
                                   relation:(NSLayoutRelation)relation
                                     second:(id<XLYALERightItem>)second;

@end

NS_ASSUME_NONNULL_END

#endif /* XLYALEPrivate_h */
