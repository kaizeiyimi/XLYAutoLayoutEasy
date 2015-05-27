//
//  XLYConstraintPrivate.h
//
//  Created by kaizei on 14/11/22.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLYConstraint.h"
#import "XLYViewAttribute.h"

@protocol XLYConstraintsGenerationProtocol <NSObject>

@property (nonatomic, assign) NSLayoutFormatOptions directionOption;
- (NSArray *)resultConstraints;

@end


#pragma mark - XLYConstraint

@interface XLYViewAttribute ()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign) NSLayoutAttribute ns_layoutAttribute;

@end

@interface XLYEnhancedViewAttribute ()

@property (nonatomic, strong) XLYViewAttribute *viewAttribute;

@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) UILayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutConstant;

@end


@interface XLYConstraint () <XLYConstraintsGenerationProtocol>

@property (nonatomic, strong) XLYViewAttribute *firstViewAttribute;
@property (nonatomic, strong) XLYViewAttribute *secondViewAttribute;

@property (nonatomic, assign) NSLayoutRelation relation;

@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) UILayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutConstant;

@end


#pragma mark - composite constraints support

@interface XLYViewSizeAttribute ()

// should be XLYViewAttribute or XLYEnhancedViewAttribute
@property (nonatomic, strong) id widthAttribute;
@property (nonatomic, strong) id heightAttribute;

@end


@interface XLYSizeConstraint() <XLYConstraintsGenerationProtocol>

@property (nonatomic, strong) XLYViewSizeAttribute *firstAttribute;
@property (nonatomic, strong) XLYViewSizeAttribute *seconAttribute;

@end


@interface XLYViewCenterAttribute ()

@property (nonatomic, strong) id centerXAttribute;
@property (nonatomic, strong) id centerYAttribute;

@end


@interface XLYCenterConstraint() <XLYConstraintsGenerationProtocol>

@property (nonatomic, strong) XLYViewCenterAttribute *firstAttribute;
@property (nonatomic, strong) XLYViewCenterAttribute *seconAttribute;

@end


@interface XLYViewEdgeAttribute ()

@property (nonatomic, strong) id topAttribute;
@property (nonatomic, strong) id leadingAttribute;
@property (nonatomic, strong) id bottomAttribute;
@property (nonatomic, strong) id trailingAttribute;

@end

@interface XLYEdgeConstraint() <XLYConstraintsGenerationProtocol>

@property (nonatomic, strong) XLYViewEdgeAttribute *firstAttribute;
@property (nonatomic, strong) XLYViewEdgeAttribute *secondAttribute;

@end

#pragma mark - view addition
@interface UIView (XLAutoLayoutAdditionPrivate)

- (XLYViewAttribute *)xly_layoutAttribute:(NSLayoutAttribute)attribute;

/**
 *  find the closet common superview with another view.
 *  @return the closet common superview or 'nil' if 'view' is nil.
 */
- (UIView *)xly_closestCommonSuperviewWithView:(UIView *)view;
+ (UIView *)xly_ClosestCommonSuperviewForView1:(UIView *)view1 view2:(UIView *)view2;

@end


#pragma mark - NSLayoutConstraint addition
@interface NSLayoutConstraint (XLAutoLayoutAdditionPrivate)

/// add the raw constraint to current helper
+ (void)xly_addRawConstraint:(id<XLYConstraintsGenerationProtocol>)constraint;

+ (NSArray *)xly_makeWithDirection:(NSLayoutFormatOptions)directionOption
                        autoActive:(BOOL)autoActive
                       constraints:(dispatch_block_t)block;

@end
