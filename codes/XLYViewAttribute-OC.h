//
//  XLYViewAttribute-OC.h
//
//  Created by 王凯 on 14/12/2.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYViewAttribute.h"

@class XLYConstraint;

@interface XLYViewAttribute (XLYAutoLayoutEasyOCSupport)

- (XLYConstraint *(^)(id attr))equalTo;
- (XLYConstraint *(^)(id attr))greaterThanOrEqualTo;
- (XLYConstraint *(^)(id attr))lessThanOrEqualTo;

//for constant only constraints
- (XLYConstraint *(^)(CGFloat attr))equalToConstant;
- (XLYConstraint *(^)(CGFloat attr))greaterThanOrEqualToConstant;
- (XLYConstraint *(^)(CGFloat attr))lessThanOrEqualToConstant;

@end