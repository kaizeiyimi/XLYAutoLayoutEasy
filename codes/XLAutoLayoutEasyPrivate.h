//
//  XLYConstraintPrivate.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/22.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLYConstraint.h"
#import "XLYViewAttribute.h"

#pragma mark - XLYConstraint
@interface XLYConstraint ()

@property (nonatomic, strong) XLYViewAttribute *firstViewAttribute;
@property (nonatomic, strong) id secondAttribute;

@property (nonatomic, assign) NSLayoutRelation relation;

@end

#pragma mark - XLYViewAttribute
@interface XLYViewAttribute ()

@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign) NSLayoutAttribute ns_layoutAttribute;

@end


@interface UIView (XLAutoLayoutAdditionPrivate)

+ (void)xly_addRawConstraint:(XLYConstraint *)constraint;

@end