//
//  UIView+XLYAutoLayoutAddition.h
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XLYConstraint.h"
#import "XLYViewAttribute.h"

@interface UIView (XLYAutoLayoutAddition)

/*
 *  these property is shortcut for calling 'layoutAttribute(NSLayoutAttribute)'.
 *  'XLYViewAttribute' instance contains a pair of UIView(a layout item) and NSLayoutAttribute value.
 */

@property (nonatomic, strong, readonly) XLYViewAttribute *layoutTop;
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutLeft;
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutBottom;
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutRight;

@property (nonatomic, strong, readonly) XLYViewAttribute *layoutLeading;
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutTrailing;

@property (nonatomic, strong, readonly) XLYViewAttribute *layoutWidth;
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutHeight;

@property (nonatomic, strong, readonly) XLYViewAttribute *layoutCenterX;
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutCenterY;

@property (nonatomic, strong, readonly) XLYViewAttribute *layoutBaseLine ;
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutLastBaseLine;

//ios8
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutFirstBaseLine NS_ENUM_AVAILABLE_IOS(8_0);

@property (nonatomic, strong, readonly) XLYViewAttribute *layoutTopMargin NS_ENUM_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutLeftMargin NS_ENUM_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutBottomMargin NS_ENUM_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutRightMargin NS_ENUM_AVAILABLE_IOS(8_0);

@property (nonatomic, strong, readonly) XLYViewAttribute *layoutCenterXWithinMargins NS_ENUM_AVAILABLE_IOS(8_0);
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutCenterYWithinMargins NS_ENUM_AVAILABLE_IOS(8_0);

//NSLayoutAttributeNotAnAttribute
@property (nonatomic, strong, readonly) XLYViewAttribute *layoutNone NS_ENUM_AVAILABLE_IOS(6_0);

///full version for layout* properties.
- (XLYViewAttribute *(^)(NSLayoutAttribute))layoutAttribute;


/*  these three methods can help to perform create, update and remake constraints for you. you just create constraints in the block,
 *  everything will be done for you.
 *
 *  you can also create constraint without using these three methods. For example:
 *
 *  NSLayoutConstraint *constraint = view.layoutTop.equalTo(otherView.layoutBottom).offset(@50).resultConstraint;
 *
 *  in this way, you can just create a constraint which can be used latter.
 *
 *  it's important that you can operate multi views together in the block, it's really convenient.
 */


/*
 * IMPORTANT:
 *  you must set 'translatesAutoresizingMaskIntoConstraints' to NO yourself. see the demo for usage.
 */


/**
 *  make and active new constraints. the constraints you created in the block will active automaticly.
 */
+ (NSArray *)makeConstraints:(dispatch_block_t)block;

/**
 *  make new constraints and then seek for last added constraint which is similar to the newly created constraint.
 *  if a similar constraint is found then the constraint's constant will be changed to the newly created constraint's constant. priority change will not be concerned as update.
 *
 *  if no similar constraint found, the newly created constraint will active.
 *
 * apple says: priority property may only be modified as part of initial set up.  An exception will be thrown if it is set after a constraint has been added to a view. But it really can be modifed after added to a view as long as the priority is not requied. you can change priority from a to b where a and b are both less than 1000 and no exception is thrown. But  modify the priority here in my codes is not allowed.
 *
 *
 *  the 'NSContentSizeLayoutConstraint' is not included in similar constraints cause they are created by setting 'CompressionResistance' and 'hugging' priorities of view.
 */
+ (NSArray *)updateConstraints:(dispatch_block_t)block;

/**
 *  remake constraints of views. 
 *
 *  1. record the views which appears as firstItem in the block.
 *
 *  2. remove all constraints whose firstItem equals to the recorded view.
 *
 *  3. make and active newly created contraints.
 *
 *  you must notice that constraint will be removed only when its firstItem is the view who appears as firstItem in the block. 
 *  for example:
 *
 *  aView.layoutWidth.equalTo(bView); //constraint A, first item is aView.
 *  then you remake with: 
 *  aView.layoutWidth.equalTo(@100);
 *  A will be removed.
 *
 *  but if you create constraint as:
 *  bView.layoutWidth.equalTo(aView); //constraint B, first item is bView.
 *  then you remake with:
 *  aView.layoutWidth.equalTo(@100);
 *  B will not be removed.
 */
+ (NSArray *)remakeConstraints:(dispatch_block_t)block;

/** 
 *  find the closet common superview with another view.
 *  @return the closet common superview or 'self' if 'view' is nil.
 */
- (UIView *)xly_closestCommonSuperviewWithView:(UIView *)view;
+ (UIView *)xly_ClosestCommonSuperviewForView1:(UIView *)view1 view2:(UIView *)view2;

///find all associated constraints whose firstItem or secondItem is the reciever.
- (NSArray *)xly_associatedConstraints;

@end
