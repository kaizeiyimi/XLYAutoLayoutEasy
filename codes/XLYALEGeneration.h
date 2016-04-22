//
//  XLYALEGeneration.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/21.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLYALEProtocols.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (XLYALEGeneration)

+ (NSArray<NSLayoutConstraint *> *)ale_make:(dispatch_block_t)block;
+ (NSArray<NSLayoutConstraint *> *)ale_makeWithDirection:(NSLayoutFormatOptions)direction construction:(dispatch_block_t)block;
+ (NSArray<NSLayoutConstraint *> *)ale_makeWithDirection:(NSLayoutFormatOptions)direction
                                              autoActive:(BOOL)autoActive
                                            construction:(dispatch_block_t)block;

@end


@interface NSArray (XLYALECompositeEqualSupport)

- (NSArray<NSLayoutConstraint *> *(^)(NSArray *))ale_equal;
- (NSArray<NSLayoutConstraint *> *)ale_equal:(NSArray *)other;

@end


id<XLYALERelationMakeable> ale_attribute(id item, NSLayoutAttribute attr);


NS_ASSUME_NONNULL_END