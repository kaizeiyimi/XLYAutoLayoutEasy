//
//  XLYConstraint-OC.h
//
//  Created by 王凯 on 14/12/2.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYConstraint.h"

@interface XLYConstraint (XLYAutoLayoutEasyOCSupport)

- (XLYConstraint *(^)(float priority))priority;
- (XLYConstraint *(^)(CGFloat multiplier))multipliedBy;
- (XLYConstraint *(^)(CGFloat constant))constant;

@end
