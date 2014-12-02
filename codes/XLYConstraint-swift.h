//
//  XLYConstraint-swift.h
//
//  Created by 王凯 on 14/12/2.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYConstraint.h"

@interface XLYConstraint (XLYAutoLayoutEasySwiftSupport)

- (XLYConstraint *)priority:(float)priority;
- (XLYConstraint *)multipliedBy:(CGFloat)multiplier;
- (XLYConstraint *)constant:(CGFloat)constant;

@end