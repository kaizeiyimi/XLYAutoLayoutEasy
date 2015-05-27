//
//  NSLayoutConstraint+XLYAutoLayoutAddition.h
//
//  Created by kaizei on 14/11/22.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (XLYAutoLayoutAddition)

/*  these three methods can help to perform create, update and remake constraints for you. you just create constraints in the block,
 *  everything will be done for you.
 *
 *  you can also create constraint without using these three methods. For example:
 *
 *  NSLayoutConstraint *constraint = view.xly_top.equalTo(otherView.xly_bottom).constaint(50).resultConstraint;
 *
 *  in this way, you can just create a constraint which can be used latter.
 *
 *  it's important that you can operate multi views together in the block, it's really convenient.
 */


/*
 * IMPORTANT:
 * 1. you must set 'translatesAutoresizingMaskIntoConstraints' to NO yourself. see the demo for usage.
 *
 * 2. direction should be 'NSLayoutFormatDirectionLeadingToTrailing'(default) or 'NSLayoutFormatDirectionLeftToRight' or 'NSLayoutFormatDirectionRightToLeft'.
 */


/**
* make and active new constraints. the constraints you created in the block will active automatically.
*
* direction is LeadingToTrailing.
*/
+ (nonnull NSArray *)xly_make:(nonnull dispatch_block_t)block;

/**
 * make and active new constraints. the constraints you created in the block will active automatically.
 */
+ (nonnull NSArray *)xly_makeWithDirection:(NSLayoutFormatOptions)directionOption
                               constraints:(nonnull dispatch_block_t)block;

/**
 *  make new constraints and then seek for last added constraint which is similar to the newly created constraint.
 *
 *  if a similar constraint is found then the old constraint will be replaced by the new one.
 *
 *  if no similar constraint found, the newly created constraint will active.
 *
 *  similar means two constaints' items and layout attributes are the same or reversed same, NOT concern about multiplier, priority or constant.
 *
 *
 * IMPORTANT:
 *
 * I treat change of multiplier, priority and constant all as update. I just remove the old one and active the new one, NOT modify the old one, so no exception will be thrown.
 * 
 * So, please make sure you know what 'xly_update' means when you use it. The recommended place to use it in '-[UIVIew updateConstraints]'.
 */
+ (nonnull NSArray *)xly_update:(nonnull dispatch_block_t)block;

/**
 * make and active new constraints and disable the latest similiar constraint if can be found. the constraints you created in the block will active automatically.
 */
+ (nonnull NSArray *)xly_updateWithDirection:(NSLayoutFormatOptions)directionOption
                                 constraints:(nonnull dispatch_block_t)block;


// Swift will not use 'debugDescription' method, so I have to replace 'description' method.
/// set to use XLY lib's description in console.
+ (void)xly_setReplaceDescription;

///like set active to YES in ios8.
- (void)xly_install;

///like set active to NO in ios8.
- (void)xly_uninstall;

@end
