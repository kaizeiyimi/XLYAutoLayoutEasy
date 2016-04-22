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

+ (NSArray<NSLayoutConstraint *> *)xly_make:(dispatch_block_t)block;
+ (NSArray<NSLayoutConstraint *> *)xly_makeWithDirection:(NSLayoutFormatOptions)direction construction:(dispatch_block_t)block;
+ (NSArray<NSLayoutConstraint *> *)xly_makeWithDirection:(NSLayoutFormatOptions)direction
                                              autoActive:(BOOL)autoActive
                                            construction:(dispatch_block_t)block;

@end


@interface NSArray (XLYALECompositeEqualSupport)

- (NSArray<NSLayoutConstraint *> *(^)(NSArray *))xly_compositeEqual;

@end


NS_ASSUME_NONNULL_END