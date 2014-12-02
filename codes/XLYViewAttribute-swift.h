//
//  XLYViewAttribute-swift.h
//
//  Created by 王凯 on 14/12/2.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "XLYViewAttribute.h"

@class XLYConstraint;

@interface XLYViewAttribute (XLYAutoLayoutEasySwiftSupport)

- (XLYConstraint *)equalTo:(id)attr;
- (XLYConstraint *)greaterThanOrEqualTo:(id)attr;
- (XLYConstraint *)lessThanOrEqualTo:(id)attr;

@end