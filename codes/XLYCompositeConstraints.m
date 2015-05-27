//
//  XLYCompositeConstraints.m
//
//  Created by kaizei on 15/5/17.
//  Copyright (c) 2015年 kaizei. All rights reserved.
//

#import "XLYConstraint.h"

#import "XLYAutoLayoutEasyPrivate.h"

#pragma mark - size support

@interface XLYSizeConstraint()

@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation XLYSizeConstraint

@synthesize directionOption = _directionOption;

- (instancetype)init {
  if (self = [super init]) {
    self.directionOption = NSLayoutFormatDirectionLeadingToTrailing;
    [NSLayoutConstraint xly_addRawConstraint:self];
  }
  return self;
}

- (NSLayoutConstraint *)widthConstraint {
  if (!_widthConstraint && self.seconAttribute.widthAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = self.firstAttribute.widthAttribute;
      _widthConstraint = [attr equalTo:self.seconAttribute.widthAttribute].resultConstraint;
    }];
  }
  return _widthConstraint;
}

- (NSLayoutConstraint *)heightConstraint {
  if (!_heightConstraint && self.seconAttribute.heightAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = self.firstAttribute.heightAttribute;
      _heightConstraint = [attr equalTo:self.seconAttribute.heightAttribute].resultConstraint;
    }];
  }
  return _heightConstraint;
}

- (NSArray *)resultConstraints {
  NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
  self.widthConstraint ? [constraints addObject:_widthConstraint] : nil;
  self.heightConstraint ? [constraints addObject:_heightConstraint] : nil;
  return constraints.count ? constraints : nil;
}

@end



#pragma mark - center support

@interface XLYCenterConstraint()

@property (nonatomic, strong) NSLayoutConstraint *centerXConstraint;
@property (nonatomic, strong) NSLayoutConstraint *centerYConstraint;

@end

@implementation XLYCenterConstraint

@synthesize directionOption = _directionOption;

- (instancetype)init {
  if (self = [super init]) {
    self.directionOption = NSLayoutFormatDirectionLeadingToTrailing;
    [NSLayoutConstraint xly_addRawConstraint:self];
  }
  return self;
}

- (NSLayoutConstraint *)centerXConstraint {
  if (!_centerXConstraint && self.seconAttribute.centerXAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = (XLYViewAttribute *)self.firstAttribute.centerXAttribute;
      _centerXConstraint = [attr equalTo:self.seconAttribute.centerXAttribute].resultConstraint;
    }];
  }
  return _centerXConstraint;
}

- (NSLayoutConstraint *)centerYConstraint {
  if (!_centerYConstraint && self.seconAttribute.centerYAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = (XLYViewAttribute *)self.firstAttribute.centerYAttribute;
      _centerYConstraint = [attr equalTo:self.seconAttribute.centerYAttribute].resultConstraint;
    }];
  }
  return _centerYConstraint;
}

- (NSArray *)resultConstraints {
  NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:2];
  self.centerXConstraint ? [constraints addObject:_centerXConstraint] : nil;
  self.centerYConstraint ? [constraints addObject:_centerYConstraint] : nil;
  return constraints.count ? constraints : nil;
}

@end


#pragma mark - edge support

@interface XLYEdgeConstraint ()

@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *leadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *trailingConstraint;

@end

@implementation XLYEdgeConstraint

@synthesize directionOption = _directionOption;

- (instancetype)init {
  if (self = [super init]) {
    self.directionOption = NSLayoutFormatDirectionLeadingToTrailing;
    [NSLayoutConstraint xly_addRawConstraint:self];
  }
  return self;
}

- (NSLayoutConstraint *)topConstraint {
  if (!_topConstraint && self.secondAttribute.topAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = (XLYViewAttribute *)self.firstAttribute.topAttribute;
      _topConstraint = [attr equalTo:self.secondAttribute.topAttribute].resultConstraint;
    }];
  }
  return _topConstraint;
}

- (NSLayoutConstraint *)leadingConstraint {
  if (!_leadingConstraint && self.secondAttribute.leadingAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = (XLYViewAttribute *)self.firstAttribute.leadingAttribute;
      _leadingConstraint = [attr equalTo:self.secondAttribute.leadingAttribute].resultConstraint;
    }];
  }
  return _leadingConstraint;
}

- (NSLayoutConstraint *)bottomConstraint {
  if (!_bottomConstraint && self.secondAttribute.bottomAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = (XLYViewAttribute *)self.firstAttribute.bottomAttribute;
      _bottomConstraint = [attr equalTo:self.secondAttribute.bottomAttribute].resultConstraint;
    }];
  }
  return _bottomConstraint;
}

- (NSLayoutConstraint *)trailingConstraint {
  if (!_trailingConstraint && self.secondAttribute.trailingAttribute) {
    [NSLayoutConstraint xly_makeWithDirection:self.directionOption autoActive:NO constraints:^{
      XLYViewAttribute *attr = (XLYViewAttribute *)self.firstAttribute.trailingAttribute;
      _trailingConstraint = [attr equalTo:self.secondAttribute.trailingAttribute].resultConstraint;
    }];
  }
  return _trailingConstraint;
}

- (NSArray *)resultConstraints {
  NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
  self.topConstraint ? [constraints addObject:_topConstraint] : nil;
  self.leadingConstraint ? [constraints addObject:_leadingConstraint] : nil;
  self.bottomConstraint ? [constraints addObject:_bottomConstraint] : nil;
  self.trailingConstraint ? [constraints addObject:_trailingConstraint] : nil;
  return constraints.count ? constraints : nil;
}

@end
