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

@end


@interface XLYALEAttributeX ()

@property(nullable, nonatomic, strong) id item;
@property(nonatomic, assign) NSLayoutAttribute attr;

@property(nonatomic, assign) CGFloat constant;
@property(nonatomic, assign) CGFloat multiplier;
@property(nonatomic, assign) UILayoutPriority priority;

@end


@interface XLYALEContext: NSObject

+ (NSLayoutConstraint *)constraintWithFirst:(id<XLYALERelationMakeable>)first
                                   relation:(NSLayoutRelation)relation
                                     second:(id<XLYALEAttributeContainer>)second;

@end

NS_ASSUME_NONNULL_END

#endif /* XLYALEPrivate_h */
