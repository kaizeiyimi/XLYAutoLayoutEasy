//
//  XLYConstraint.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/21.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLYConstraint : NSObject

@property (nonatomic, strong, readonly) NSLayoutConstraint *resultConstraint;

#pragma mark -
- (XLYConstraint *(^)(float priority))priority;
- (XLYConstraint *(^)(CGFloat multiplier))multipliedBy;
- (XLYConstraint *(^)(id constant))offset;

#pragma mark -
- (XLYConstraint *)priority:(float)priority;
- (XLYConstraint *)multipliedBy:(CGFloat)multiplier;
- (XLYConstraint *)offset:(id)offset;

@end
