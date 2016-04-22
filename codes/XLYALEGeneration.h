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

- (NSArray<NSLayoutConstraint *> *(^)(NSArray *))ale_compositeEqual;
- (NSArray<NSLayoutConstraint *> *)ale_compositeEqual:(NSArray *)other;

@end


NS_ASSUME_NONNULL_END