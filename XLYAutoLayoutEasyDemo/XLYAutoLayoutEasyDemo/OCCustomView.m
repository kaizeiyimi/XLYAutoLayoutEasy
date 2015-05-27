//
//  OCCustomView.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 15/5/17.
//  Copyright (c) 2015年 kaizei. All rights reserved.
//

#import "OCCustomView.h"
#import "XLYAutoLayoutEasy.h"

IB_DESIGNABLE
@interface OCCustomView ()

@property (nonatomic ,strong) UIView *leftView;
@property (nonatomic ,strong) UIView *rightView;

@end

@implementation OCCustomView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self xly_commonInit];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self xly_commonInit];
}

- (void)xly_commonInit {
  
  _leftView = [[UIView alloc] init];
  _leftView.backgroundColor = [UIColor redColor];
  _leftView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:_leftView];
  
  _rightView = [[UIView alloc] init];
  _rightView.backgroundColor = [UIColor greenColor];
  _rightView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:_rightView];
}

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

- (void)updateConstraints {
  const CGFloat margin = 8;
  
  // these codes show a recommended place to use updateConstraints.
  [NSLayoutConstraint xly_update:^{
    [_leftView.xly_edge equalToTop:@(margin) leading:@(margin) bottom:@(-margin) trailing:nil];
    [_leftView.xly_width equalTo:self.xly_width.multiplier(0.5).constant(-1.5 * margin)];

    [_rightView.xly_edge equalToTop:_leftView leading:_leftView.xly_trailing.constant(margin) bottom:_leftView trailing:@(-margin)];
  }];
  [super updateConstraints];
}

@end
