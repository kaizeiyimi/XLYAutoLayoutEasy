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
@end

@interface XLYALEAttributeX : NSObject
@end


@interface XLYALEAttribute (XLYALELeftItemSupport) <XLYALELeftItem>
@end


@interface XLYALEAttributeX (XLYALERightItemSupport) <XLYALERightItem>
@end

NS_ASSUME_NONNULL_END