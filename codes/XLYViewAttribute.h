//
//  XLYViewAttribute.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLYConstraint.h"

@interface XLYViewAttribute : NSObject

#pragma mark relation
- (XLYConstraint *(^)(id attr))equalTo;
- (XLYConstraint *(^)(id attr))greaterThanOrEqualTo;
- (XLYConstraint *(^)(id attr))lessThanOrEqualTo;

#pragma mark - for swift
- (XLYConstraint *)equalTo:(id)attr;
- (XLYConstraint *)greaterThanOrEqualTo:(id)attr;
- (XLYConstraint *)lessThanOrEqualTo:(id)attr;

@end
