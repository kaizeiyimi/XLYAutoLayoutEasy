//
//  XLYConstraint.h
//
//  Created by kaizei on 14/11/21.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLYConstraint : NSObject

@property (nonatomic, strong, readonly, nonnull) NSLayoutConstraint *resultConstraint;

@property (nonatomic, strong, readonly, nonnull) NSArray *resultConstraints;

@end


#pragma mark - composite support

@interface XLYSizeConstraint : NSObject

@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *widthConstraint;
@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *heightConstraint;

@property (nonatomic, strong, readonly, nullable) NSArray *resultConstraints;

@end


@interface XLYCenterConstraint : NSObject

@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *centerXConstraint;
@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *centerYConstraint;

@property (nonatomic, strong, readonly, nullable) NSArray *resultConstraints;

@end


@interface XLYEdgeConstraint : NSObject

@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *leadingConstraint;
@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong, readonly, nullable) NSLayoutConstraint *trailingConstraint;

@property (nonatomic, strong, readonly, nullable) NSArray *resultConstraints;

@end
